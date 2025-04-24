#!/usr/bin/env bash
# picasher_installer.sh - User-friendly CLI script to install or uninstall passive earning apps via Docker
# Requires whiptail for interactive CLI interface and Docker for containers
# Use -d or --debug to run in verbose mode

set -e

# Debug mode
DEBUG=false
if [[ "$1" == "-d" || "$1" == "--debug" ]]; then
  DEBUG=true
  set -x
  echo "Debug mode enabled" >&2
fi

# Check for whiptail and install if missing
if ! command -v whiptail >/dev/null 2>&1; then
  echo "Installing whiptail..."
  sudo apt-get update
  sudo apt-get install -y whiptail
fi

# Check for Docker and install if missing
if ! command -v docker >/dev/null 2>&1; then
  if whiptail --title "Docker Installation" --yesno \
      "Docker is not installed. Install now?" 8 60; then
    sudo curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
    sudo chmod +x /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh
    sudo usermod -aG docker $USER
    whiptail --title "Docker Installed" --msgbox \
      "Docker installed. Please reboot the Pi and run this script again." 10 60
    exit 0
  else
    whiptail --title "Error" --msgbox \
      "Docker is required. Exiting." 8 60
    exit 1
  fi
fi

# Display prerequisites message
town() {
  whiptail --title "Picasher Installer" --msgbox "This script installs or uninstalls the following apps via Docker containers:\n
- EarnApp\n- Honeygain\n- Pawns\n- Traffmonetizer\n- Bitping\n- PacketStream\n
You will need active accounts and credentials for each service." 20 80
}
town

# Banner function
title_banner() { echo -e "\n*** $1 ***\n"; }

# Installation functions
install_earnapp() {
  title_banner "Install EarnApp"
  whiptail --title "EarnApp" --msgbox "An active EarnApp account is required. If you don't have one, register using:\nhttps://earnapp.com/i/rBezkcsv" 10 70
  wget -qO- https://brightdata.com/static/earnapp/install.sh > /tmp/earnapp.sh
  sudo bash /tmp/earnapp.sh
  echo "After installation, copy the link shown and open it in a browser to register the device."
  read -p "Press Enter once completed..."
}

install_honeygain() {
  title_banner "Install Honeygain"
  whiptail --title "Honeygain" --msgbox "An active Honeygain account is required. If you don't have one, register using:\nhttps://r.honeygain.me/RAVAT518F5" 10 70
  EMAIL=$(whiptail --inputbox "Honeygain Email:" 8 60 3>&1 1>&2)
  PWD=$(whiptail --passwordbox "Honeygain Password:" 8 60 3>&1 1>&2)
  DEVICE=$(whiptail --inputbox "Device Name (e.g. raspzero001):" 8 60 "raspzero001" 3>&1 1>&2)
  docker run -d --name honeygain_$DEVICE --restart=unless-stopped \
    honeygain/honeygain -tou-accept -email "$EMAIL" -pass "$PWD" -device "$DEVICE"
}

install_pawns() {
  title_banner "Install Pawns"
  whiptail --title "Pawns" --msgbox "An active Pawns account is required. If you don't have one, register using:\nhttps://pawns.app/?r=picasher" 10 70
  EMAIL=$(whiptail --inputbox "Pawns Email:" 8 60 3>&1 1>&2)
  PWD=$(whiptail --passwordbox "Pawns Password:" 8 60 3>&1 1>&2)
  DEVICE=$(whiptail --inputbox "Device Name (e.g. raspzero001):" 8 60 "raspzero001" 3>&1 1>&2)
  docker run -d --name pawns_$DEVICE --restart=unless-stopped \
    iproyal/pawns-cli:latest -email="$EMAIL" -password="$PWD" -device-name="$DEVICE" -device-id="$DEVICE" -accept-tos
}

install_traffmonetizer() {
  title_banner "Install Traffmonetizer"
  whiptail --title "Traffmonetizer" --msgbox "An active Traffmonetizer account is required." 10 70
  TOKEN=$(whiptail --inputbox "Traffmonetizer Token:" 8 60 3>&1 1>&2)
  docker run -d --name traffmzn --restart=unless-stopped \
    traffmonetizer/cli_v2:arm64v8 start accept --token "$TOKEN"
}

install_bitping() {
  title_banner "Install Bitping"
  whiptail --title "Bitping" --msgbox "An active Bitping account is required." 10 70
  EMAIL=$(whiptail --inputbox "Bitping Email:" 8 60 3>&1 1>&2)
  PWD=$(whiptail --passwordbox "Bitping Password:" 8 60 3>&1 1>&2)
  docker run -d --name bitpingd --restart=unless-stopped \
    -e BITPING_EMAIL="$EMAIL" -e BITPING_PASSWORD="$PWD" \
    --mount type=volume,source="bitpingd-volume",target=/root/.bitpingd \
    bitping/bitpingd:latest
}

install_packetstream() {
  title_banner "Install PacketStream"
  whiptail --title "PacketStream" --msgbox "An active PacketStream account is required. Retrieve your CID from the dashboard." 10 70
  CID=$(whiptail --inputbox "PacketStream CID:" 8 60 3>&1 1>&2)
  docker stop watchtower psclient || true
  docker rm watchtower psclient || true
  docker rmi containrrr/watchtower packetstream/psclient || true
  docker run -d --name psclient --restart=unless-stopped -e CID="$CID" packetstream/psclient:latest
  docker run -d --name watchtower --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower \
    --cleanup --include-stopped --revive-stopped --interval 60 psclient
}

# Uninstallation functions
uninstall_earnapp() {
  title_banner "Uninstall EarnApp"
  sudo earnapp uninstall || echo "No uninstall script; remove manually."
}

uninstall_honeygain() {
  title_banner "Uninstall Honeygain"
  docker ps --filter ancestor=honeygain/honeygain -q | xargs -r docker stop | xargs -r docker rm
}

uninstall_pawns() {
  title_banner "Uninstall Pawns"
  docker ps --filter ancestor=iproyal/pawns-cli -q | xargs -r docker stop | xargs -r docker rm
}

uninstall_traffmonetizer() {
  title_banner "Uninstall Traffmonetizer"
  docker stop traffmzn || true; docker rm traffmzn || true
}

uninstall_bitping() {
  title_banner "Uninstall Bitping"
  docker stop bitpingd || true; docker rm bitpingd || true; docker volume rm bitpingd-volume || true
}

uninstall_packetstream() {
  title_banner "Uninstall PacketStream"
  docker stop psclient watchtower || true; docker rm psclient watchtower || true; docker rmi packetstream/psclient containrrr/watchtower || true
}

# Main menu: install or uninstall
ACTION=$(whiptail --title "Picasher Installer" --menu "Choose action:" 15 60 2 \
  install "Install apps" \
  uninstall "Uninstall apps" 3>&1 1>&2 2>&3)

# Select apps
CHOICES=$(whiptail --title "Select Apps" --checklist "Select apps:" 20 78 8 \
  EARNAPP "EarnApp" OFF \
  HONEYGAIN "Honeygain" OFF \
  PAWNS "Pawns Miner" OFF \
  TRAFF "Traffmonetizer" OFF \
  PACKETSTREAM "PacketStream" OFF \
  BITPING "Bitping Monitor" OFF 3>&1 1>&2 2>&3)

# Remove quotes from choices
CHOICES=$(echo $CHOICES | tr -d '"')

# If no selection, exit
if [ -z "$CHOICES" ]; then
  whiptail --title "No selection" --msgbox "No apps selected, exiting." 8 60
  exit 0
fi

# Execute based on action and choice
for choice in $CHOICES; do
  case "${ACTION}:${choice}" in
    install:EARNAPP)      install_earnapp ;;  
    install:HONEYGAIN)    install_honeygain ;;  
    install:PAWNS)        install_pawns ;;  
    install:TRAFF)        install_traffmonetizer ;;  
    install:PACKETSTREAM) install_packetstream ;;  
    install:BITPING)      install_bitping ;;  
    uninstall:EARNAPP)    uninstall_earnapp ;;  
    uninstall:HONEYGAIN)  uninstall_honeygain ;;  
    uninstall:PAWNS)      uninstall_pawns ;;  
    uninstall:TRAFF)      uninstall_traffmonetizer ;;  
    uninstall:PACKETSTREAM)uninstall_packetstream ;;  
    uninstall:BITPING)    uninstall_bitping ;;  
  esac
done

whiptail --title "Done" --msgbox "Operation completed!" 8 40

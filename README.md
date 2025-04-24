# PiCasher

**PiCasher** is a lightweight Bash installer/uninstaller for deploying popular passive‑income applications on Raspberry Pi devices via Docker containers.

---

## Supported Applications

This script can install or remove the following services:

- **Honeygain**
- **EarnApp**
- **Pawns.app** (formerly IPRoyal Pawns)
- **PacketStream**
- **Traffmonetizer**
- **BitPing**

> ⚙️ Most of them run in Docker; no manual dependency management required.

## Compatibility

Especially designed for: 

- Raspberry Pi Zero 2 W

But it can run on every 64‑bit Raspberry Pi OS (aarch64) as:

- Raspberry Pi 3 B+
- Raspberry Pi 4 (any memory variant)
- Raspberry Pi 5 (any memory variant)

## Prerequisites

Before running PiCasher, ensure you have:

1. A 64‑bit Raspberry Pi with Docker installed (the script can auto‑install Docker).
2. An active account and credentials for each service you plan to install:
   - [EarnApp](https://earnapp.com/i/rBezkcsv)
   - [Honeygain](https://r.honeygain.me/RAVAT518F5)
   - [Pawns.app](https://pawns.app/?r=13391648)
   - [PacketStream](https://packetstream.io/?psr=75qO)
   - [Traffmonetizer](https://traffmonetizer.com/?aff=1880125)
   - [BitPing](https://app.bitping.com?r=3TGus9GO)

> 💡 These are affiliate links; using them helps support ongoing development.

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/montfalcon/picasher-installer.git
cd picasher-installer

# 2. Make the script executable
chmod +x picasher_installer.sh

# 3. Run the installer (or use -d for debug)
./picasher_installer.sh
# or
./picasher_installer.sh --debug
```

Follow the interactive prompts to install or uninstall selected apps.

## Usage Notes

- *(Optional)* Attach a monitor, keyboard, and mouse for initial setup, or use SSH.
- Ensure a stable internet connection throughout the installation.
- To modify DNS settings (e.g., if using ad‑blocking DNS), update your connection:
  ```bash
  nmcli connection show               # find YOUR_CONN_NAME
  sudo nmcli connection modify "YOUR_CONN_NAME" ipv4.ignore-auto-dns yes
  sudo nmcli connection modify "YOUR_CONN_NAME" ipv4.dns "1.1.1.1 8.8.8.8"
  ```

## Roadmap / To‑Do

-  Option to set a "less-writing-mode" for being faster and preserve the Sd Card
-  Option to set a daily auto reboot
-  Translation in other languages
-  More specific versions for other Raspberry Pi including more apps
-  Telegram script for remote monitoring 


## Known Issues

- Using ad‑blocking DNS (e.g., AdGuard) may prevent downloads. Adjust DNS as shown above.

---

© 2025 PiCasher Contributors. Licensed under the MIT License.






# PiCasher

A lightweight Bash script for installing many "passive" income applications, built for a Raspberry Pi.

Currenlty installed programs are:
- [x] Honeygain
- [x] EarnApp 
- [x] Pawns.app (IPRoyal Pawns)
- [x] PacketStream
- [x] Traffmonetizer
- [x] BitPing


Raspberry Pi's running 64 bit OS's are supported (Zero 2W, 3b+, 4, 5) aarch64
---


You will need an account at each of these sites
- [Register Earnapp](https://earnapp.com/i/rBezkcsv)
- [Register Honeygain](https://r.honeygain.me/RAVAT518F5)
- [Register Pawns.app(Formerly IPRoyal Pawns)](https://pawns.app/?r=13391648)
- [Register Packetstream](https://packetstream.io/?psr=75qO)
- [Register Traffmonetizer](https://traffmonetizer.com/?aff=1880125)
- [Register BitPing](https://app.bitping.com?r=3TGus9GO) *Crypto payout


**These are affiliate links, please use them to support development





---
<br>
<br>

# Quick start
You will need:
- a 64 bit Raspberry Pi
- a MicroSD car with Raspian Full or Lite for Zero 2W
- a power supply
- access to the command prompt through SSH or Bash
- an internet connection

Opyional:
- a monitor, a keyboard and a mouse just for the setup and depending on your configuration 





---
### TO-DO:


- [ ] translation in other languages
- [ ] a specific version for other Raspberry Pi including more apps
- [ ] Telegram script for remote monitoring




# Notes & Known Issues
If your net is seti with "ad free" DNS like AdGuard DNS the script could not work.
Solution is to use a specific DNS setting just for your Raspbeery Pi with the commands:

Use:

nmcli connection show

to get "YOUR_NETWORK_NAME" and run:

sudo nmcli connection modify "YOUR_NETWORK_NAME" ipv4.ignore-auto-dns yes && sudo nmcli connection modify "YOUR_NETWORK_NAME" ipv4.dns "1.1.1.1 8.8.8.8"


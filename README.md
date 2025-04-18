# PiCasher

A lightweight Bash script for installing many "passive" income applications, built for a Raspberry Pi.

Currenlty installed programs are:
- [x] Honeygain
- [x] EarnApp 
- [x] Pawns.app (IPRoyal Pawns)
- [x] PacketStream
- [x] Traffmonetizer (x86_64 broke)
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
- facoltative: a monitor, a keyboard and a mouse just for the setup and depending on your configuration 





---
### TO-DO:

- [ ] make a one-liner build and install for supported OS's
- [ ] add support for Presearch


---
<br><br>
# Earnapp
Register for an account. Set `USE_EARNAPP` to `y` in the `settings.conf` file.

The container will give you a link that you need to paste into your browser to "link" the worker to your account. <b>This needs to be repeated per container instance!</b>
<br><br><br>
To get this code you can execute command below .

``` 
docker exec -ti picash earnapp register | grep -Eo 'https.+'
```

<br><br>Example
```
# Earnapp
USE_EARNAPP=y
```
<br><br>
# Honeygain

Register for an account.
In the settings file, add your email to `HG_EMAIL` and password to `HG_PASSWORD` and set the `USE_HONEYGAIN` to `y`.
<br><br>Example
```
# Honeygain
USE_HONEYGAIN=y
HG_EMAIL=example@example.com
HG_PASSWORD=MyP@$$W0rd
```
<br><br><br>
# Packet Stream
Register for an account. In the settings file set `USE_PACKET_STREAM` to `y` and `PS_ID` to your CID. You can find your CID by navigating to the [Download page](https://packetstream.io/dashboard/download) and scrolling the bottom where it give you "Linux" instructions. Inside that blob of text you will find your CID, below is a picture of where it can be found.

![cid](https://github.com/chashtag/PiCash/blob/images/images/packetstream.png?raw=true)
<br><br>Example
```
# Packet Stream
USE_PACKET_STREAM=y
PS_ID=abc123
```
<br><br><br>

<br><br><br>

# Pawns.app(IPPawns)
Register for an account. In the settings file, add your email to `PA_EMAIL` and password to `PA_PASSWORD` and set the `USE_PAWNSAPP` to `y`.

<br><br>Example
```
# Pawns.app(IPPawns)
USE_PAWNSAPP=y
PA_EMAIL=example@example.com
PA_PASSWORD=MyP@$$W0rd
```
<br><br><br>

# Traffmonetizer
Register for an account. In the settings file, add your `Application Token` to `TRAFF_TOKEN` and set the `USE_TRAFFMONETIZER` to `y`.

You can find the `Application Token` on your [dashboard](https://app.traffmonetizer.com/dashboard).

<br><br>Example
```
# Traffmonetizer
USE_TRAFFMONETIZER=y
TRAFF_TOKEN=ZXhhbXBsZUVYQU1QTEVleGFtcGxlRVhBTVBMRQo=
```

<br><br><br>
# Bitping
Register for an account. In the settings file, add your email to `BP_EMAIL` and password to `BP_PASSWORD` and set the `USE_BITPING` to `y`.

<br><br>Example
```
# BitPing
USE_BITPING=y
BP_EMAIL=example@example.com
BP_PASSWORD=MyP@$$W0rd
```

<br>
<br>
<br>
<br>


# Other stuff
EarnApp should be the only one requiring persistent storage, adding a mount point to `<local_path>/earnapp/:/etc/earnapp/` will make it so you do not have to keep registering the host.
<br>
<br>
All logs should be going to /var/log/picash/

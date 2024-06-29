# WiFi HackMode Bash Script

This repository contains a bash script to automate the process of setting a wireless interface into monitor mode for ethical hacking purposes and reverting it back to managed mode. This script is useful for tools like Bettercap, Aircrack-ng, and other WiFi pentesting utilities.

## Features

- Automatically set a wireless interface to monitor mode.
- Automatically revert a wireless interface to managed mode.
- Handle conflicting processes and reset the interface.
- Run custom commands after setting the interface to monitor mode.

## Prerequisites

- A Linux system with `iw`, `sudo`, and `bash` installed.
- A compatible wireless network adapter that supports monitor mode.
- Tools like `NetworkManager`, `airmon-ng`, and any other wireless utilities you might use.

## Usage

### Starting Hack Mode

To start hack mode and set the interface to monitor mode, use the following command:

```bash
wifi_hackmode_start <interface> <command> [options]
```

For example:

```bash
wifi_hackmode_start wlan0 bettercap -iface wlan0
```

### Stopping Hack Mode

To stop hack mode and revert the interface back to managed mode, use the following command:

```bash
wifi_hackmode_stop <interface>
```

For example:

```bash
wifi_hackmode_stop wlan0
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Please feel free to submit issues, fork the repository and send pull requests!

## Aknowledgements

- [Bettercap](https://www.bettercap.org/)
- [Aircrack-ng](https://www.aircrack-ng.org/)
- NetworkManager

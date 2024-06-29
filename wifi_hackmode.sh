#!/bin/bash

function wifi_hackmode_status() {
    local interface=$1
    local mode=$(iw $interface info | grep type | awk '{print $2}')
    echo $mode
}

function wifi_hackmode_start() {
    local interface=$1
    shift
    local command=$@

    if [[ -z "$interface" || -z "$command" ]]; then
        echo "Usage: wifi_hackmode_start <interface> <command> [options]"
        return 1
    fi

    echo "Checking interface mode for $interface..."
    mode=$(check_interface_mode $interface)
    echo "$interface is currently in $mode mode."

    if [[ $mode == "monitor" ]]; then
        echo "$interface is already in monitor mode. Resetting it first..."
        sudo ip link set $interface down
        sudo iw dev $interface set type managed
        sudo ip link set $interface up
        sleep 2  # Adding a small delay to ensure changes take effect
    fi

    echo "Stopping conflicting processes..."
    sudo systemctl stop NetworkManager
    sudo airmon-ng check kill

    echo "Resetting the interface $interface..."
    sudo ip link set $interface down
    sudo iw dev $interface set type managed
    sudo ip link set $interface up

    echo "Enabling monitor mode for $interface..."
    sudo ip link set $interface down
    sudo iw dev $interface set type monitor
    sudo ip link set $interface up

    echo "Verifying interface mode..."
    mode=$(wifi_hackmode_status $interface)
    echo "$interface is now in $mode mode."

    echo "Running command: $command"
    sudo bash -c "$command"
}

function wifi_hackmode_stop() {
    local interface=$1

    if [[ -z "$interface" ]]; then
        echo "Usage: wifi_hackmode_stop <interface>"
        return 1
    fi

    echo "Stopping any running processes..."
    sudo pkill -f "$interface"

    echo "Resetting the interface $interface to managed mode..."
    sudo ip link set $interface down
    sudo iw dev $interface set type managed
    sudo ip link set $interface up

    echo "Restarting NetworkManager and related services..."
    sudo systemctl start NetworkManager
    sudo airmon-ng check

    echo "Verifying interface mode..."
    iw $interface info

    echo "$interface should now be back to managed mode."
}

# Example usage:
# wifi_hackmode_start wlan0 "bettercap -iface wlan0"
# wifi_hackmode_stop wlan0

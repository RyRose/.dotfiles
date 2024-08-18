#!/usr/bin/env bash

# Initialize log directory if it doesn't exist.
mkdir -p ~/.logs

# Print out time of boot.
who -b

# Print out boot time latency data once available.
sleep 10
systemd-analyze

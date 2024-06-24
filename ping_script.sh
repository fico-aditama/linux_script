#!/bin/bash

# Check if an IP address is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

# Extract the IP address from the command-line argument
ip_address="$1"

# Ping the specified IP address and capture the result
ping_result=$(ping -c 4 -q "$ip_address")

# Check the exit status of the ping command
if [ $? -eq 0 ]; then
  # If the exit status is 0, the ping was successful
  echo "Ping to $ip_address was successful."
  echo "Ping Result:"
  echo "$ping_result"
else
  # If the exit status is not 0, the ping failed
  echo "Ping to $ip_address failed."
fi

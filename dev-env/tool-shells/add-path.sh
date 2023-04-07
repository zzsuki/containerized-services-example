#!/bin/bash

set -x

# check if script is run as root
if [ $# -ne 1 ]; then
  echo "ERROR: Invalid number of arguments"
  echo "Usage: $0 <dir_path>"
  exit 1
fi

dir_path=$1

echo "INFO: Adding \`$dir_path\` to PATH"

# check if directory exists
if [ ! -d "$dir_path" ]; then
  echo "ERROR: Directory does not exist"
  exit 1
fi

# check if /etc/profile exists
if ! grep -q "export PATH=" /etc/profile; then
  echo "INFO: No PATH configuration in /etc/profile, will add it"
  echo "export PATH=\$PATH:$dir_path" >> /etc/profile
  echo "INFO: \`$dir_path\` has been added to PATH"
  exit 0
fi

# check if directory is already in PATH or in export PATH=... expression
if echo $PATH | grep -q "$dir_path"; then
  echo "WARN: Directory already in PATH environment variable"
  exit 1
elif grep -q "export PATH=.*$dir_path" /etc/profile; then
  echo "WARN: Directory already in PATH expression"
  exit 1
else
  # add directory to PATH 
  sed -i 's|export PATH=\(.*\)|export PATH=\1:'"$dir_path"'|' /etc/profile
fi
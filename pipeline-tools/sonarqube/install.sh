#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run script with sudo"
  exit
fi

sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536

# Move to server location
mkdir -p /srv/sonarcube/data /srv/sonarcube/logs /srv/sonarcube/extensions
cp docker-compose.yml /srv/sonarcube/docker-compose.yml

# Install the service script
cp sonarcube.service /etc/systemd/system/sonarcube.service
systemctl enable sonarcube
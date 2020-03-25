#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run script with sudo"
  exit
fi

sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536

# Move to server location
mkdir -p /srv/sonarqube/data /srv/sonarqube/logs /srv/sonarqube/extensions
cp docker-compose.yml /srv/sonarqube/docker-compose.yml
chown 999:999 /srv/sonarqube/data /srv/sonarqube/logs /srv/sonarqube/extensions
chmod 770 /srv/sonarqube/data /srv/sonarqube/logs /srv/sonarqube/extensions

# Install the service script
cp sonarqube.service /etc/systemd/system/sonarqube.service
systemctl enable sonarqube
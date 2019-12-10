#!/bin/bash
mkdir /opt/heplify
cd /opt/heplify
wget https://github.com/sipcapture/heplify/releases/download/1.53/heplify
chmod +x heplify
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/ishbuldin/hello-world/master/heplify.service
sed -i "s/{HOSTNAME}/${HOSTNAME}/g" heplify.service
systemctl daemon-reload
systemctl start heplify
systemctl enable heplify

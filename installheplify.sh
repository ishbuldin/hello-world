#!/bin/bash
mkdir /opt/heplify
cd /opt/heplify
wget https://github.com/sipcapture/heplify/releases/download/1.53/heplify
cd /etc/systemd/system/
wget https://github.com/ishbuldin/hello-world/blob/master/heplify.service
systemctl daemon-reload
systemctl start heplify
systemctl enable heplify

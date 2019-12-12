#!/bin/bash

DIST=$(cat /etc/redhat-release | sed -e 's/[^0-9]//g' | cut -c 1)

mkdir /opt/heplify
cd /opt/heplify
wget https://github.com/sipcapture/heplify/releases/download/1.53/heplify
chmod +x heplify

if [[ $DIST == "5" ]]; then
  echo "centos 5"
elif [[ $DIST == "6" ]]; then
  echo "centos 6"
  mkdir /tmp/glibc_install
  cd /tmp/glibc_install 
  wget https://ftp.gnu.org/gnu/glibc/glibc-2.15.tar.gz
  tar zxvf glibc-2.15.tar.gz
  cd glibc-2.15
  mkdir build
  cd build
  ../configure --prefix=/opt/glibc-2.15
  make -j4
  make install
  cd /etc/init.d/
  wget https://raw.githubusercontent.com/ishbuldin/hello-world/master/heplify
  chmod +x heplify
  service heplify start
  service heplify status
elif [[ $DIST == "7" ]]; then
  echo "centos 7"
  cd /etc/systemd/system/
  wget https://raw.githubusercontent.com/ishbuldin/hello-world/master/heplify.service
  chmod +x heplify.service
  sed -i "s/{HOSTNAME}/${HOSTNAME}/g" heplify.service
  systemctl daemon-reload
  systemctl start heplify
  systemctl enable heplify
  systemctl status heplify
else
  echo "Release does not 5, 6 or 7"
exit 1
fi

 #!/bin/bash

DIST=$(cat /etc/redhat-release | sed -e 's/[^0-9]//g' | cut -c 1)
RELEASE=18.2

if [[ $DIST == "5" ]]; then
DIST=RHEL_5
RELEASE=17.2
elif [[ $DIST == "6" ]]; then
DIST=CentOS_6
rpm -Uhv https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
elif [[ $DIST == "7" ]]; then
DIST=CentOS_7
else
echo "Release does not 5, 6 or 7"
exit 1
fi

echo $RELEASE
echo $DIST

wget -O /etc/yum.repos.d/bareos.repo http://download.bareos.org/bareos/release/$RELEASE/$DIST/bareos.repo
yum remove bacula-client -y
yum remove bacula-common -y
yum install bareos-client -y
PASSWORD=$(grep Password /etc/bacula/bacula-fd.conf.rpmsave | grep -v '#' | cut -f2 -d'"')
NAME=$(sed -n '/FileDaemon/,/FDport/p' /etc/bacula/bacula-fd.conf.rpmsave | grep Name | cut -f5 -d' ')

echo $PASSWORD
echo $NAME

sed -i "s/.*Name = .*/  Name = $NAME/g" /etc/bareos/bareos-fd.d/client/myself.conf
sed -i "s/.*Password.*/  Password = $PASSWORD/g" /etc/bareos/bareos-fd.d/director/bareos-dir.conf
service bareos-fd start
service bareos-fd status

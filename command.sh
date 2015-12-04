#!/bin/sh
#cp /etc/nagios/nrpe.cfg /tmp/old_nrpe.cfg
#sed -i -- 's/172.16.16.209/172.20.154.24/g' /etc/nagios/nrpe.cfg
cd /tmp
yum install git -y
rm -rf /tmp/nagios_plugins
git clone https://github.com/infomentum/nagios_plugins.git /tmp/nagios_plugins
rm -rf /usr/lib64/nagios/plugins/*
mv /tmp/nagios_plugins/* /usr/lib64/nagios/plugins/
wget -O /tmp/ptnrpe https://www.dropbox.com/s/btdbye1b1w2pmpb/ptnrpe?dl=1
rm -rf /etc/nagios/nrpe.cfg_old
mv /etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg_old
mv /tmp/ptnrpe /etc/nagios/nrpe.cfg
restorecon -R /etc/nagios/nrpe.cfg
restorecon -R /usr/lib64/nagios/plugins/
service nrpe restart


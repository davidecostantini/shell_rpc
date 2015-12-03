#!/bin/sh
cp /etc/nagios/nrpe.cfg /tmp/old_nrpe.cfg
sed -i -- 's/172.16.16.209/172.20.154.24/g' /etc/nagios/nrpe.cfg
service nrpe restart
echo "Change NRPE done `date -u`" 

#!/bin/bash
# IPADDRESS=$(/sbin/ifconfig eth0|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}')
# echo "ipadress: $IPADDRESS"
# echo "export TAIGA_HOSTNAME=$IPADDRESS" >> /home/taiga/.get_ip_address
# echo "source /home/taiga/.get_ip_address" >> /home/taiga/.bashrc
echo "export LC_ALL=en_US.UTF-8" >> /home/taiga/.bashrc
echo "export LANG=en_US.UTF-8" >> /home/taiga/.bashrc
echo "export LC_TYPE=en_US.UTF-8" >> /home/taiga/.bashrc

service nginx start
sudo -H -u taiga /bin/bash /usr/local/docker/scripts/main.sh

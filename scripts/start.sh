#!/bin/bash
echo "start nginx..."
service nginx start
echo "start taiga..."
sudo -E -H -u taiga /bin/bash /usr/local/docker/scripts/main.sh

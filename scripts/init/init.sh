#!/bin/bash

cd /home/taiga
git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git taiga-back
cd taiga-back
echo "creating virtualenv..."
pew ls 2>/dev/null
pew rm taiga
pew new -p /usr/bin/python3.4 taiga -d
pew ls
echo "install requirements..."
pew in taiga pip install -r requirements.txt

echo "copying configuration file..."
cp -f /usr/local/docker/config/local.py ~/taiga-back/settings/local.py
env
echo "install demo data..."
pew in taiga python manage.py migrate --noinput
pew in taiga python manage.py loaddata initial_user
pew in taiga python manage.py loaddata initial_project_templates
pew in taiga python manage.py loaddata initial_role
pew in taiga python manage.py compilemessages
pew in taiga python manage.py collectstatic --noinput

pew in taiga python manage.py sample_data

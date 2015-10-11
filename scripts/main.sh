#!/bin/bash

NOREADY="/home/taiga/.noready"

if [[ -e "$NOREADY" ]]; then
  echo "install demo data..."
  python /home/taiga/taiga-back/manage.py migrate --noinput
  python /home/taiga/taiga-back/manage.py loaddata initial_user
  python /home/taiga/taiga-back/manage.py loaddata initial_project_templates
  python /home/taiga/taiga-back/manage.py loaddata initial_role
  python /home/taiga/taiga-back/manage.py compilemessages
  python /home/taiga/taiga-back/manage.py collectstatic --noinput
  python /home/taiga/taiga-back/manage.py sample_data
  rm -f $NOREADY
fi
source /home/taiga/.bashrc
python /home/taiga/taiga-back/manage.py runserver

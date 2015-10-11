#!/bin/bash

NOREADY="/home/taiga/.noready"
cd /home/taiga/taiga-back/
if [[ -e "$NOREADY" ]]; then
  echo "initialize..."
  python /home/taiga/taiga-back/manage.py migrate --noinput
  python /home/taiga/taiga-back/manage.py loaddata initial_user
  python /home/taiga/taiga-back/manage.py loaddata initial_project_templates
  python /home/taiga/taiga-back/manage.py loaddata initial_role
  python /home/taiga/taiga-back/manage.py compilemessages
  python /home/taiga/taiga-back/manage.py collectstatic --noinput
  if [[ "$TAIGA_SAMPLE_DATA" == 1 ]]; then
    echo "install demo data..."
    python /home/taiga/taiga-back/manage.py sample_data
  fi
  rm -f $NOREADY
fi
echo 'configure taiga host on frontend...'
sed -i "s/localhost/$TAIGA_HOSTNAME/g" /home/taiga/taiga-front-dist/dist/js/conf.json
python /home/taiga/taiga-back/manage.py runserver

#! /bin/bash

cd `dirname $0`

echo $HOSTNAME

if [[ "$HOSTNAME" == isucon1 ]]; then
  INSTANCE_NUM="1"
elif [[ "$HOSTNAME" == isucon2 ]]; then
  INSTANCE_NUM="2"
elif [[ "$HOSTNAME" == isucon3 ]]; then
  INSTANCE_NUM="3"
else
  echo "Invalid host"
  exit 1
fi

set -ex

git pull

sudo systemctl daemon-reload

# toriaezu
if [[ "$INSTANCE_NUM" == 1 || "$INSTANCE_NUM" == 3 ]]; then
  sudo install -o root -g root -m 644 ./conf/nginx/sites-available/isuports.conf /etc/nginx/sites-available/isuports.conf
  sudo install -o root -g root -m 644 ./conf/nginx/nginx.conf /etc/nginx/nginx.conf

  sudo systemctl restart nginx
  sudo systemctl enable nginx
  
  sudo systemctl restart isuports.service
  sudo systemctl enable isuports.service
  
  sleep 2
  
  sudo systemctl status isuports.service
fi


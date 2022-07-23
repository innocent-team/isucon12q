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

# NGINX

if [[ "$INSTANCE_NUM" == 1 ]]; then
  sudo install -o root -g root -m 644 ./conf/nginx/sites-available/isuports.conf /etc/nginx/sites-available/isuports.conf
  sudo install -o root -g root -m 644 ./conf/nginx/nginx.conf /etc/nginx/nginx.conf
  sudo nginx -t

  sudo systemctl restart nginx
  sudo systemctl enable nginx
fi

if [[ "$INSTANCE_NUM" == 2 || "$INSTANCE_NUM" == 3 ]]; then
  sudo systemctl stop nginx.service
  sudo systemctl disable nginx.service
fi

# APP
if [[ "$INSTANCE_NUM" == 1 ]]; then
  sudo systemctl restart isuports.service
  sudo systemctl enable isuports.service
  
  sleep 2
  
  sudo systemctl status isuports.service --no-pager
fi

if [[ "$INSTANCE_NUM" == 2 || "$INSTANCE_NUM" == 3 ]]; then
  sudo systemctl stop isuports.service
  sudo systemctl disable isuports.service
fi

# MYSQL
if [[ "$INSTANCE_NUM" == 1 ]]; then
  sudo systemctl stop mysql.service
  sudo systemctl disable mysql.service
fi

if [[ "$INSTANCE_NUM" == 2 || "$INSTANCE_NUM" == 3 ]]; then
  sudo install -o root -g root -m 644 ./conf/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

  echo "MySQL restart したいなら手動でやってね"
#  sudo systemctl restart mysql
  sudo systemctl enable mysql
fi


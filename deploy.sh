#! /bin/bash

cd `dirname $0`

set -ex

git pull

sudo install -o root -g root -m 644 ./conf/nginx/sites-available/isuports.conf /etc/nginx/sites-available/isuports.conf
sudo systemctl restart nginx
sudo systemctl enable nginx

sudo systemctl restart isuports.service
sudo systemctl enable isuports.service

sleep 3

sudo systemctl status isuports.service

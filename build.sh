#!/bin/bash

# Go to tmp dir and clone
cd /var/www/tmp
if [ -d "openstack" ]; then
  cd openstack
  git pull
  composer update --no-interaction
else
  git clone https://github.com/php-opencloud/openstack
  cd openstack
  composer install --no-interaction
fi

# Build docs
./vendor/bin/sami.php update --force ./doc/api-docs/config.php

# Shift tmp dir to prod
rm -rf /var/www/html/*
mv ./doc/api-docs/build /var/www/html

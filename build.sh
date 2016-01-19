#!/bin/bash

# Go to tmp dir and clone
cd /var/www/tmp
if [ -d "openstack" ]; then
  cd openstack
  git pull
  composer update --prefer-source --no-interaction
else
  git clone https://github.com/php-opencloud/openstack
  cd openstack
  composer install --prefer-source --no-interaction
fi

# Build docs
rm -rf ./doc/api-docs/cache
./vendor/bin/sami.php update ./doc/api-docs/config.php

# Shift tmp dir to prod
rm -rf /var/www/html/build
mv ./doc/api-docs/build /var/www/html

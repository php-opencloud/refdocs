FROM php:5.6-apache

# Installation
RUN apt-get update && apt-get install -y git-core zlib1g-dev
RUN docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 

# Copy Apache config
COPY default.conf /etc/apache2/sites-enabled/default.conf

# Move listeners to dir
RUN mkdir -p /usr/src/listener
COPY webhook.php /usr/src/listener/ 
COPY build.sh /usr/src

# Build docs
RUN mkdir -p /var/www/tmp
RUN chown -R www-data /var/www/tmp /var/www/html
RUN su -c "bash /usr/src/build.sh" -s /bin/sh www-data

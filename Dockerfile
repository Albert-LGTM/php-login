FROM php:7.3-apache

RUN apt-get update && apt-get install -y libzip-dev zip unzip \
    && docker-php-ext-install pdo pdo_mysql \
    && a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /var/www/html/php-login

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && echo "display_errors=On" > /usr/local/etc/php/conf.d/docker-php-errors.ini \
    && echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/docker-php-errors.ini \
    && echo "<?php header('Location: /php-login/'); exit; ?>" > /var/www/html/index.php

ADD ./src /var/www/html/php-login
RUN chown -R www-data:www-data /var/www

EXPOSE 80

# Use the PHP 8.1 Apache image as the base
FROM php:8.1.19-apache

# Update apt and install required packages
RUN apt-get update && apt-get install -y default-mysql-client

# Install MySQLi extension and other required extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli

# Install other PHP extensions
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd xdebug imagick exif zip intl

# Install cURL and other dependencies
RUN apt-get update && apt-get install -y gcc curl libcurl4-openssl-dev
RUN docker-php-ext-install curl && docker-php-ext-enable curl

# Enable Apache mod_rewrite (often required for WordPress permalinks)
RUN a2enmod rewrite

# Copy the custom ports.conf and 000-default.conf
COPY ./apache2/ports.conf /etc/apache2/ports.conf
COPY ./apache2/000-default.conf /etc/apache2/sites-available/000-default.conf

# Set working directory
WORKDIR /var/www/html

# Expose both ports
EXPOSE 80 8080
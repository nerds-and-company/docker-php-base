FROM php:5.6-apache
MAINTAINER Bob Olde Hampsink <b.oldehampsink@itmundi.nl>

# Set env
ENV COMPOSER_VERSION 1.0.0-alpha10

# Update apt
RUN apt-get update

# Install curl and git
RUN apt-get install -y curl git

# Install mcrypt
RUN apt-get install -y libmcrypt4 libmcrypt-dev \
 && docker-php-ext-install mcrypt

RUN pecl install xdebug

# Some default php configuration
WORKDIR /usr/local/etc/php/conf.d
COPY php-conf.d .
RUN echo 'date.timezone = Europe/Amsterdam' >> date.ini
ENV DBGP_IDEKEY XDEBUG

# Install gd
RUN apt-get install -y libfreetype6-dev libjpeg-dev libpng12-dev --no-install-recommends \
 && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
 && docker-php-ext-install gd

# Install other needed extensions
RUN docker-php-ext-install mbstring pdo_mysql zip

# Enable mod_rewrite
RUN a2enmod rewrite

# Install mysql client
RUN apt-get install -y mysql-client

# Install redis tools
RUN apt-get install -y redis-tools

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# Change PATH to include composer bin files
ENV PATH vendor/bin:$PATH

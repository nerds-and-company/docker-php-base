FROM php:7.3-apache

# Set env
ENV COMPOSER_VERSION 1.8.6

# Update apt
RUN apt-get update

# Install curl, git, and all locales
RUN apt-get install -y curl git locales
RUN sed -i -E "s/# (.*)_(.*)/\1_\2/" /etc/locale.gen
RUN locale-gen

RUN pecl install xdebug

# Some default php configuration
WORKDIR /usr/local/etc/php/conf.d
COPY php-conf.d .
ENV DBGP_IDEKEY XDEBUG

# Install gd
RUN apt-get install -y libfreetype6-dev libjpeg-dev libzip-dev --no-install-recommends \
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

# Set work dir to the webroot (not sure why, but that's where I did end up first when I opened a connection)
WORKDIR /var/www/html

CMD /usr/sbin/apache2ctl -D FOREGROUND

# itmundi/php
Itmundi PHP image for Docker

## Contains

### OS
 - Based on the debian:jessie image

### Services
 - Apache 2.4
 - PHP 5.6
 - Xdebug 2.3

* Derived from [docker-libary/php](https://github.com/docker-library/php/tree/master/5.6/apache)

### PHP Extensions
 - mcrypt
 - mbstring
 - gd
 - pdo_mysql
 - zip

### Other
 - Contains git
 - Contains curl
 - Contains a MySQL client
 - Contains Redis CLI Tools
 - Contains composer

## Xdebug usage

If you want to be able to step through your code using Xdebug, your container needs to expose port `9000`.
This is probably not desired in production environments. If you use `docker-compose`, you can use another
configuration file for prodcution where this port is not exposed.

## License
[MIT](LICENSE)

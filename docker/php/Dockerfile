FROM php:8.3-apache

RUN docker-php-ext-install pdo_mysql \
    && a2enmod rewrite \
    && printf '%s\n' \
       'ServerTokens Prod' \
       'ServerSignature Off' \
       > /etc/apache2/conf-available/orbe-security.conf \
    && a2enconf orbe-security

WORKDIR /var/www/html

COPY core/ /var/www/core/
COPY database/webfarm_orbe/migrations/ /var/www/database/migrations/
COPY app/public/ /var/www/html/

EXPOSE 80
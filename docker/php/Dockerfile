FROM php:8.3-apache

RUN a2enmod rewrite \
    && printf '%s\n' \
       'ServerTokens Prod' \
       'ServerSignature Off' \
       > /etc/apache2/conf-available/orbe-security.conf \
    && a2enconf orbe-security

WORKDIR /var/www/html

COPY app/public/ /var/www/html/

EXPOSE 80
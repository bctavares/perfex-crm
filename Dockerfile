﻿FROM php:8.2.27-apache

EXPOSE 80

RUN apt-get update -y && \
    apt-get install -y apt-utils tree htop libpng-dev libc-client-dev libkrb5-dev libzip-dev zip --no-install-recommends 

# Installing php Dependencies 
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli gd zip

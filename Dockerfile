FROM php:8.2.27-apache

EXPOSE 80

# Atualizar pacotes e instalar dependências
RUN apt-get update -y && \
    apt-get install -y apt-utils tree htop libpng-dev libc-client-dev libkrb5-dev libzip-dev zip --no-install-recommends 

# Configurar e instalar extensões PHP
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli gd zip

# Habilitar o módulo Rewrite do Apache
RUN a2enmod rewrite

# Definir permissões para pastas e arquivos
RUN mkdir -p /var/www/html/uploads/proposals && \
    mkdir -p /var/www/html/uploads/estimates && \
    mkdir -p /var/www/html/uploads/ticket_attachments && \
    mkdir -p /var/www/html/uploads/tasks && \
    mkdir -p /var/www/html/uploads/staff_profile_images && \
    mkdir -p /var/www/html/uploads/projects && \
    mkdir -p /var/www/html/uploads/newsfeed && \
    mkdir -p /var/www/html/uploads/leads && \
    mkdir -p /var/www/html/uploads/invoices && \
    mkdir -p /var/www/html/uploads/expenses && \
    mkdir -p /var/www/html/uploads/discussions && \
    mkdir -p /var/www/html/uploads/contracts && \
    mkdir -p /var/www/html/uploads/company && \
    mkdir -p /var/www/html/uploads/clients && \
    mkdir -p /var/www/html/uploads/client_profile_images && \
    mkdir -p /var/www/html/application/config && \
    mkdir -p /var/www/html/temp && \
    chmod -R 0755 /var/www/html/uploads && \
    chmod -R 0755 /var/www/html/application/config && \
    chmod -R 0755 /var/www/html/temp && \
    touch /var/www/html/application/config/config.php && \
    touch /var/www/html/application/config/app-config-sample.php && \
    chmod 0644 /var/www/html/application/config/config.php && \
    chmod 0644 /var/www/html/application/config/app-config-sample.php

# Definir o proprietário dos arquivos
RUN chown -R www-data:www-data /var/www/html

# Limpar cache do APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Iniciar o Apache
CMD ["apachectl", "-D", "FOREGROUND"]

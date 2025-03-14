FROM php:8.2.27-apache

EXPOSE 80

RUN apt-get update -y && \
    apt-get install -y apt-utils tree htop libpng-dev libc-client-dev libkrb5-dev libzip-dev zip --no-install-recommends 

# Installing php Dependencies 
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli gd zip

# Definir permissões para pastas (0755)
RUN chmod 0755 "/uploads/proposals"
chmod 0755 "/uploads/estimates"
chmod 0755 "/uploads/ticket_attachments"
chmod 0755 "/uploads/tasks"
chmod 0755 "/uploads/staff_profile_images"
chmod 0755 "/uploads/projects"
chmod 0755 "/uploads/newsfeed"
chmod 0755 "/uploads/leads"
chmod 0755 "/uploads/invoices"
chmod 0755 "/uploads/expenses"
chmod 0755 "/uploads/discussions"
chmod 0755 "/uploads/contracts"
chmod 0755 "/uploads/company"
chmod 0755 "/uploads/clients"
chmod 0755 "/uploads/client_profile_images"
chmod 0755 "/application/config"
chmod 0755 "/temp"

# Definir permissões para arquivos específicos
chmod 0644 "/application/config/config.php"
chmod 0644 "/application/config/app-config-sample.php"

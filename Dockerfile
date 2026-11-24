FROM php:8.5-fpm AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev libpq5 libpng-dev libzip-dev libonig-dev libxml2-dev unzip \
    && docker-php-ext-install pdo pdo_pgsql pgsql gd zip bcmath \
    && docker-php-ext-enable pdo pdo_pgsql pgsql \
    && pecl install redis-6.3.0 \
    && docker-php-ext-enable redis \
    && apt-get purge -y --auto-remove libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

RUN curl -fsSL https://bun.sh/install | bash

WORKDIR /var/www

CMD ["php-fpm"]

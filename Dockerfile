FROM webdevops/php-nginx:8.2

WORKDIR /app

COPY . /app

RUN composer install --no-dev --prefer-dist --optimize-autoloader

RUN php artisan key:generate

EXPOSE 80

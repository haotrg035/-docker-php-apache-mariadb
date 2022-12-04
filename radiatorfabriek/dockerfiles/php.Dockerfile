FROM php:7.4-apache
RUN apt-get update -y && \ 
	apt-get install -y --no-install-recommends \
                libfreetype6-dev \
                libjpeg-dev \
                libmagickwand-dev \
                libpng-dev \
                libwebp-dev \
                libzip-dev \
        ; \
        docker-php-ext-configure gd \
                --with-freetype \
                --with-jpeg \
                --with-webp \
        ; \
        docker-php-ext-install bcmath \
		exif \
                gd \
                mysqli \
                zip \
                mysqli \
                pdo \
                pdo_mysql \
                mbstring \
                intl \
                soap \
                opcache \
                xml \
        ; \
	docker-php-ext-enable mysqli mbstring zip xml pdo pdo_mysql gd intl soap; \
	pecl install imagick-3.5.0; \
        docker-php-ext-enable imagick; \
        rm -r /tmp/pear; \
RUN set -eux; \
        docker-php-ext-enable opcache; \
        { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=2'; \
                echo 'opcache.fast_shutdown=1'; \
        } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite
WORKDIR /var/www/html
CMD ["apache2-foreground"]

FROM php:7.4-fpm

ARG USER_ID=1000
ARG GROUP_ID=1000

WORKDIR /tmp

COPY dle.zip ./

ENV DLE_VERSION 14.3

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    libonig-dev unzip zlib1g-dev libxslt-dev curl libxml2-dev  libcurl4 libcurl4-openssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip mbstring xsl pdo_mysql curl xml zip sockets bcmath

RUN curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions xdebug opencensus


RUN usermod -u ${USER_ID} www-data; \
    groupmod -g ${GROUP_ID} www-data; 
    


ADD composer.json ./


COPY docker-entrypoint.sh ./

RUN chmod +x ./docker-entrypoint.sh 


ENTRYPOINT ["./docker-entrypoint.sh"]
EXPOSE 9000  
CMD ["php-fpm"]
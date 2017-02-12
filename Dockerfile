FROM php:7-fpm-alpine

RUN docker-php-source extract \
    && apk --no-cache add --virtual .phpize-deps-configure $PHPIZE_DEPS \
    && pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && apk del .phpize-deps-configure \
    && docker-php-source delete

ADD ./docker/php/php.ini /usr/local/etc/php/

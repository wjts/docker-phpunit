FROM php:7.1-cli-alpine

LABEL maintainer="wojtas@wojtas.net.pl"

ENV TZ=Europe/Warsaw

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer global require phpunit/phpunit:7
RUN ln -s /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "'${TZ}'"\n' > /usr/local/etc/php/conf.d/tzone.ini

RUN apk add --no-cache $PHPIZE_DEPS \
	&& pecl install xdebug-2.5.0 \
	&& docker-php-ext-enable xdebug

WORKDIR /app

ENTRYPOINT [ "/usr/local/bin/phpunit" ]

CMD [ "--help" ]

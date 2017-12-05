FROM php:7-fpm

ARG HOST

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget \
    libfontconfig1 \
    libxrender1 \
    libzip-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli zip

RUN apt-get update && mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/3.0.0.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug \
  && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
  && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# install newrelic
RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - &&\
    sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list'

# Setup environment variables for initializing New Relic
ENV NR_INSTALL_SILENT 1
ENV NR_INSTALL_KEY 10d38a5560e7d966f25b7c9b3142c4bc67be9e1f
RUN apt-get update && \
    apt-get install -yq newrelic-php5 && \
    newrelic-install install

# Set alias
RUN echo 'alias sf3="php bin/console"' >> ~/.bashrc

# Add user 1000
RUN useradd -u 1000 dummy

WORKDIR /var/www/${HOST}

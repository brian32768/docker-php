FROM php:8.1.3RC1-apache-buster

ENV ACCEPT_EULA=Y 

RUN apt-get update && \
    apt-get install -y gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc > /tmp/microsoft.asc
RUN apt-key add /tmp/microsoft.asc
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && \
    apt-get install -y msodbcsql17 && \
    apt-get install -y unixodbc-dev

RUN pecl install sqlsrv && \
    pecl install pdo_sqlsrv

RUN curl https://xdebug.org/files/xdebug-3.1.3.tgz | tar xzvf - && \
    cd xdebug-3.1.3 && \
    phpize && \
    ./configure && \
    make && \
    cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902

# optional: for bcp and sqlcmd
#sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
#echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#source ~/.bashrc

WORKDIR /var/www/html
COPY index.php .

COPY php-extensions.ini /usr/local/etc/php/conf.d/

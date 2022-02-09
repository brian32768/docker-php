FROM php:8.1.3RC1-apache-buster

RUN apt-get update && \
    apt-get install -y iputils-ping unixodbc-dev gnupg

ENV ACCEPT_EULA=Y 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | \
    apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && \
    apt-get install -y msodbcsql17 && \
    pecl install sqlsrv && \
    pecl install pdo_sqlsrv

WORKDIR /usr/local/etc/php
RUN cp php.ini-development php.ini

RUN curl https://xdebug.org/files/xdebug-3.1.3.tgz | tar xzvf - && \
    cd xdebug-3.1.3 && \
    phpize && \
    ./configure && \
    make && \
    cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/
# optional: for bcp and sqlcmd
#sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
#echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#source ~/.bashrc

COPY 99-sqlsrv.ini ./conf.d/
COPY 99-xdebug.ini ./conf.d/

ENV XDEBUG_CONFIG="client_host=10.10.4.68 log=/tmp/xdebug.log"
ENV XDEBUG_SESSION=1

WORKDIR /var/www/html
COPY landingpage.html index.html
COPY phpinfo.php .
COPY xdebug.php .


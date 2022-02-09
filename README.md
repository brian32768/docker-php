# docker-php
PHP + Apache running on Debian Buster

Includes extensions for SQL Server and XDEBUG

## Build

    docker build -t php .

## Run

    docker run -d --name php -p 80:80 php


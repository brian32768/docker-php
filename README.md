# docker-php
PHP + Apache running on Debian Buster

Includes extensions for SQL Server access and XDEBUG

## Configure

Set your desktop ip address in the Dockerfile XDEBUG_CONFIG settings.

## Build

Build the server image

    docker build -t php-linux .

## Run

Start the server

    docker run -d --name=php-linux -p 80:80 php-server
    
Now visit http://localhost which is a small HTML landing page
with links to the PHP and XDEBUG info pages.

You should be able to set up VSCode with the PHP Debug extension,
then put this in your launch.json file "configurations" section,

        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003
        },

and tell it to listen on port 9003 by starting a debug session.

In the xdebug.php page, you should be able to see that it found and connected to your running copy of VSCode.

Under the section "Step Debugging", it should say "Debugger Active" and "Connected Client" with the IP address of your VSCode instance.

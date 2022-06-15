#!/bin/bash

set -euo pipefail

# directory is empty
if [ -z "$(ls -A /var/www/html)" ]; then

  # extracting
  unzip dle.zip upload/*
  mv upload/* /var/www/html

  # clearing
  rm dle.zip
  rm -rf upload

  # define owner
  chown -R www-data:www-data /var/www/html
fi
if [ -z "$(ls -A /var/www/html/vendor)" ]; then 
  mv composer.json /var/www/html 
  cd /var/www/html \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && php composer.phar install; 
  chown -R www-data:www-data /var/www/html
fi 
exec "$@"

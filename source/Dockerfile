FROM 3slab/vdm-library-base:latest

RUN wget https://get.symfony.com/cli/installer -O - | bash

COPY ./source /var/www/html
COPY ./VdmLibraryBundle /var/www/VdmLibraryBundle
RUN rm /var/www/html/Dockerfile

RUN cd /var/www/html \
  && composer install --no-scripts -n \
  && composer clearcache -n

CMD bin/console messenger:consume consumer -vv

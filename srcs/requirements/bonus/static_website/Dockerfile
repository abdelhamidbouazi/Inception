# base image
FROM debian:buster

RUN apt update && apt install -y apache2
RUN mkdir -p /var/www/html/wp && chown -R www-data:www-data /var/www/html/wp

COPY ./tools/wp /var/www/html/wp

COPY ./conf/000-default.conf /etc/apache2/sites-available/000-default.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

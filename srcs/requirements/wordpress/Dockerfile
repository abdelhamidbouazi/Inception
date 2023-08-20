FROM debian:buster

RUN apt-get update -y
RUN apt-get install php7.3-fpm php-mysql -y
RUN apt-get install curl -y

COPY ./tools/script.sh /

RUN chmod +x ./script.sh

EXPOSE 9000

CMD ["/script.sh"]

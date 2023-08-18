FROM debian:buster

RUN apt-get update -y
RUN apt-get install php7.3-fpm php-mysql -y
RUN apt-get install curl -y

EXPOSE 9000

COPY ./tools/script.sh /

RUN chmod +x ./script.sh

CMD ["/script.sh"]

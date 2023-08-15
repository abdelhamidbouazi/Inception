FROM debian:buster

RUN apt-get update -y && apt-get install wget -y
RUN apt-get install php php-mysql -y

COPY ./tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 8080

ENTRYPOINT [ "/script.sh" ]

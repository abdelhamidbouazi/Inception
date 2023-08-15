FROM debian:buster

RUN apt-get update -y
RUN apt-get install  mariadb-server -y

COPY ./tools/script.sh /

RUN chmod +x /script.sh

EXPOSE 3306
ENTRYPOINT [ "/script.sh" ]


CMD ["mysqld"]

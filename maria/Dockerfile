FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

COPY ./tools/script.sh /

RUN chmod +x /script.sh

ENTRYPOINT [ "/script.sh" ]

EXPOSE 3306

CMD ["mysqld"]

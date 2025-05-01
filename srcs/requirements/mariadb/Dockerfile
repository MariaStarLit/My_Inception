FROM debian:12

RUN apt-get update && apt-get upgrade -y && apt-get install netcat-openbsd -y mariadb-server -y

COPY ./conf/maria-script.sh /maria-script.sh

RUN chmod +x /maria-script.sh

ENTRYPOINT ["./maria-script.sh"]
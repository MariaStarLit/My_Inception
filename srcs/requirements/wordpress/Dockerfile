FROM debian:12

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    netcat-openbsd \
    curl


COPY ./conf/wordpress-script.sh /wordpress-script.sh
RUN chmod +x /wordpress-script.sh

ENTRYPOINT ["/wordpress-script.sh"]
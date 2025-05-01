FROM debian:12

RUN apt-get update && apt-get install -y nginx openssl

# Create SSL cert
RUN mkdir -p /etc/nginx/ssl /var/www/wordpress && \
	chown -R www-data:www-data /var/www/wordpress

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=PT/ST=Lis/L=Lis/O=42/OU=42/CN=mde-avel.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Clean up
RUN apt-get clean

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y openssl

RUN mkdir -p /etc/nginx/ssl
RUN    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/uaupetit.crt \
       -keyout /etc/nginx/ssl/uaupetit.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=uaupetit/CN=uaupetit/"

RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
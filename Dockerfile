#Download base image ubuntu 16.04
FROM ubuntu:16.04
# Update Ubuntu Software repository
RUN echo "Updating Ubuntu Software repository..."
RUN apt-get update -y
RUN echo "Installing VIM..."
RUN apt-get install vim -y
RUN echo "Installing curl..."
RUN apt-get install curl -y
# Install Apache server
RUN echo "Installing NGINX..."
RUN apt-get install nginx -y

COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY conf/ssl/nginx-selfsigned.key /etc/ssl/private/
COPY conf/ssl/nginx-selfsigned.crt /etc/ssl/certs/
COPY conf/ssl/dhparam.pem /etc/ssl/certs/

RUN service nginx start


# To generate the SSL Self-Signed Certificate 
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
# openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
# To find out ServerName openssl x509 -in server.crt -noout -subject

EXPOSE 80 443


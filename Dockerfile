FROM jonasal/nginx-certbot:latest

COPY h5bp-server-configs-nginx/. /etc/nginx/

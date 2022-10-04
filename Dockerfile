FROM jonasal/nginx-certbot:3

COPY h5bp-server-configs-nginx/. /etc/nginx/

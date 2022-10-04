all: build

build:
	docker build -t secondfry/nginx-certbot-h5bp .

test:
	mkdir -p user_conf.d
	docker run -d -it -p 80:80 -p 443:443 \
		--env CERTBOT_EMAIL=$$CERTBOT_EMAIL \
		-v ${PWD}/nginx_secrets:/etc/letsencrypt \
		-v ${PWD}/user_conf.d:/etc/nginx/user_conf.d:ro \
		-e STAGING=1 -e DEBUG=1 \
		--name nginx-certbot-h5bp-test \
		secondfry/nginx-certbot-h5bp

FROM nevivurn/base:latest

ARG HUGO_VERSION=0.53

WORKDIR /tmp/build
RUN set -ex \
	&& apk add --no-cache nginx \
	&& wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" -O hugo.tar.gz \
	&& tar -C /usr/local/bin -xzf hugo.tar.gz hugo \
	&& cd .. && rm -rf /tmp/build

ENV HUGO_BASEURL=https://www.nevivur.net/

COPY . /site

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/mime.types /etc/nginx/mime.types
COPY docker/service/ /docker/service/

WORKDIR /docker
EXPOSE 80

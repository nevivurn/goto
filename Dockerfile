FROM alpine:3.8 AS build

ARG HUGO_VERSION=0.53

WORKDIR /tmp/build
RUN set -ex \
	&& wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" -O hugo.tar.gz \
	&& tar xzf hugo.tar.gz hugo \
	&& mv hugo /hugo

ARG HUGO_BASEURI=https://www.nevivur.net/

COPY . /site
WORKDIR /site
RUN /hugo -b $HUGO_BASEURI

FROM nginx:1.15
COPY --from=build /site/public /site
COPY docker/nginx.conf /etc/nginx/nginx.conf

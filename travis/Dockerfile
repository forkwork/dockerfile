FROM	ruby:alpine
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN	apk add --no-cache \
	ca-certificates \
	git

RUN	set -x \
	&& apk add --no-cache --virtual .build-deps \
	build-base \
	&& gem install travis --no-document \
	&& apk del .build-deps

ENTRYPOINT	["travis"]

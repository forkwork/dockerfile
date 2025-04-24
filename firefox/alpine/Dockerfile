FROM alpine:latest

LABEL maintainer "Md Sulaiman <dev.sulaiman@icloud.com>"

RUN apk add --no-cache \
	alsa-lib \
	ca-certificates \
	firefox-esr \
	hicolor-icon-theme \
	mesa-dri-intel \
	mesa-gl \
	ttf-dejavu

ENTRYPOINT ["/usr/bin/firefox"]

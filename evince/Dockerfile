# Evince in a container
#
# docker run -it \
#	-v $HOME/documents/:/root/documents/ \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	-e DISPLAY=$DISPLAY \
#	evince
#

FROM alpine:latest
LABEL maintainer "Md Sulaiman <dev.sulaiman@icloud.com>"

RUN apk --no-cache add \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
	evince \
	ttf-opensans

CMD ["/usr/bin/evince"]

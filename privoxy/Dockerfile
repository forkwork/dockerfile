# run a privoxy in a container and link to a tor socks proxy container
#
# docker run -d \
#	--restart always \
# 	# the link inside the container must be named "torproxy"
# 	# see: https://github.com/khulnasoft/dockerfile/blob/master/privoxy/privoxy.conf#L1317
#	--link torproxy:torproxy \
#	-v /etc/localtime:/etc/localtime:ro \
#	-p 8118:8118 \
# 	--name privoxy \
# 	jess/privoxy
#
FROM alpine:latest
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN apk --no-cache add \
	privoxy

# expose http port
EXPOSE 8118

# copy in our privoxy config file
COPY privoxy.conf /etc/privoxy/config

# make sure files are owned by privoxy user
RUN chown -R privoxy /etc/privoxy

USER privoxy

ENTRYPOINT [ "privoxy", "--no-daemon" ]
CMD [ "/etc/privoxy/config" ]

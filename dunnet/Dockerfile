# DESCRIPTION:	  Run text-based game dunnet in a container
# AUTHOR:		  KhulnaSoft DevOps <info@khulnasoft.com>
# COMMENTS:
#	This file describes how to build dunnet in a container with all
#	dependencies installed.
#	Tested on Debian Jessie
# USAGE:
#	# Download dunnet Dockerfile
#	wget https://raw.githubusercontent.com/khulnasoft/dockerfile/master/dunnet/Dockerfile
#
#	# Build dunnet image
#	docker build -t dunnet .
#
#	docker run -it dunnet
#

# Base docker image
FROM alpine:latest
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

# Install emacs:
# Note: Emacs is only in community repo -> https://pkgs.alpinelinux.org/packages?package=emacs&repo=all&arch=x86_64
RUN apk --no-cache add \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	emacs

# Autorun dunnet
CMD ["/usr/bin/emacs", "-batch", "-l", "dunnet"]

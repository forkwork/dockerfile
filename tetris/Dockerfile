# DESCRIPTION:	  Run text-based emacs tetris in a container
# AUTHOR:		  KhulnaSoft DevOps <info@khulnasoft.com>
# COMMENTS:
#	This file describes how to build tetris in a container with all
#	dependencies installed.
#	Tested on Debian Jessie
# USAGE:
#	# Download tetris Dockerfile
#	wget https://raw.githubusercontent.com/khulnasoft/dockerfile/master/tetris/Dockerfile
#
#	# Build tetris image
#	docker build -t tetris .
#
#	docker run -it tetris
#

# Base docker image
FROM alpine:latest
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

# Install emacs:
# Note: Emacs is only in community repo -> https://pkgs.alpinelinux.org/packages?package=emacs&repo=all&arch=x86_64
RUN apk --no-cache add \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	emacs

# Autorun tetris
CMD ["/usr/bin/emacs", "-f", "tetris"]

# DESCRIPTION:	  Run text-based emacs doctor in a container
# AUTHOR:		  KhulnaSoft DevOps <info@khulnasoft.com>
# COMMENTS:
#	This file describes how to build doctor in a container with all
#	dependencies installed.
#	Tested on Debian Jessie
# USAGE:
#	# Download doctor Dockerfile
#	wget https://raw.githubusercontent.com/khulnasoft/dockerfile/master/doctor/Dockerfile
#
#	# Build doctor image
#	docker build -t doctor .
#
#	docker run -it jess/doctor
#

# Base docker image
FROM alpine:latest
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

# Install emacs:
# Note: Emacs is only community repo -> https://pkgs.alpinelinux.org/packages?package=emacs&repo=all&arch=x86_64
RUN apk --no-cache add \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
	emacs

# Autorun doctor
CMD ["/usr/bin/emacs", "-f", "doctor"]

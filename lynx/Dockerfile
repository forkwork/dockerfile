# Run Lynx in a conatiner
#
# docker run --rm -it \
#	--name lynx \
#	jess/lynx github.com/khulnasoft
#
FROM debian:bullseye-slim
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN apt-get update && apt-get install -y \
	lynx \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "lynx" ]

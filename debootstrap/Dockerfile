FROM debian:bullseye-slim
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	debootstrap \
	git \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "debootstrap" ]

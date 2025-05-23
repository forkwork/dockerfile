# Usage:
#
# This uses a custom installs a kernel module hence the mounts

# docker run --rm -it \
# 	--name wireguard \
# 	-v /lib/modules:/lib/modules \
# 	-v /usr/src:/usr/src:ro \
# 	khulnasoft/wireguard:install
#
FROM debian:sid-slim
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN apt update && apt -y install \
	build-essential \
	ca-certificates \
	git \
	kmod \
	libelf-dev \
	libmnl-dev \
	pkg-config \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# https://git.zx2c4.com/wireguard-linux-compat/
ENV WIREGUARD_VERSION v1.0.20200520
# https://git.zx2c4.com/wireguard-tools
ENV WIREGUARD_TOOLS_VERSION v1.0.20200513

RUN set -x \
	&& git clone --depth 1 --branch "${WIREGUARD_VERSION}" https://git.zx2c4.com/wireguard-linux-compat.git /wireguard \
	&& git clone --depth 1 --branch "${WIREGUARD_TOOLS_VERSION}" https://git.zx2c4.com/wireguard-tools.git /wireguard-tools \
	&& ( \
		cd /wireguard-tools/src \
		&& make -j$(nproc) \
		&& make install \
		&& make clean \
	)

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "wg", "--help" ]

FROM debian:sid-slim
LABEL maintainer "KhulnaSoft DevOps <info@khulnasoft.com>"

RUN apt-get update && apt-get install -y \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	virt-viewer \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["virt-viewer", "-c", "qemu:///system"]

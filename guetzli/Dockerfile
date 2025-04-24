# guetzli
#
# docker run --rm -it \
# 	-v ${PWD}:/tmp \
# 	khulnasoft/guetzli:latest \
# 	--verbose /tmp/example.jpg /tmp/example.compressed.jpg

FROM alpine:latest
LABEL maintainer "Md Sulaiman <dev.sulaiman@icloud.com>"

RUN apk --no-cache add \
		libpng \
		libstdc++ \
		libgcc

ENV GUETZLI_VERSION v1.0.1
ENV APPDIR /usr/src/guetzli

RUN buildDeps=' \
    	g++ \
		git \
		libpng-dev \
		make \
	' \
	set -x \
	&& apk --no-cache add $buildDeps \
	&& git clone --depth 1 --branch "${GUETZLI_VERSION}" "https://github.com/google/guetzli.git" "${APPDIR}" \
	&& ( \
		cd "${APPDIR}" \
		&& make \
		&& mv "${APPDIR}/bin/Release/guetzli" /usr/local/bin/guetzli \
	) \
	&& apk del $buildDeps \
	&& rm -rf "${APPDIR}" \
	&& echo "Build complete."

ENTRYPOINT [ "/usr/local/bin/guetzli" ]

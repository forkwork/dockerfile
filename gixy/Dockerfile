# Run gixy command line tool for static nginx analysis:
# https://github.com/yandex/gixy
#
# Usage:
# 	docker run --rm -it \
# 		-v /etc/nginx:/etc/nginx \
#		khulnasoft/gixy /etc/nginx/nginx.conf
#
FROM python:2-alpine

RUN pip install gixy

ENTRYPOINT ["gixy"]

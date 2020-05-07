#squidfunk/mkdocs-material:5.1.0
FROM python:3.6.10-alpine3.11

COPY action.sh /action.sh
COPY rucio.cfg /opt/rucio/etc/rucio.cfg

RUN apk add --no-cache \
      bash \
      git \
      git-fast-import \
      libffi-dev \
      make \
      python3-dev \
      openssl \
      libressl-dev \
      libxml2-dev \
      libxslt-dev \
    && apk add --no-cache --virtual .build gcc musl-dev \
    && chmod +x /action.sh

ENTRYPOINT ["/action.sh"]

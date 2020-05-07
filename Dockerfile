#squidfunk/mkdocs-material:5.1.0
FROM python:3.6.10-alpine3.11

COPY action.sh /action.sh

RUN apk add --no-cache \
      bash \
      git \
      libffi-dev \
      make \
      python3-dev \
      openssl \
      libssl-dev \
    && apk add --no-cache --virtual .build gcc musl-dev \
    && chmod +x /action.sh

ENTRYPOINT ["/action.sh"]

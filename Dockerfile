#squidfunk/mkdocs-material:5.1.0
FROM python:3.6.10-alpine3.11

COPY action.sh /action.sh

RUN apk add --no-cache \
      bash \
      git \
    && chmod +x /action.sh

ENTRYPOINT ["/action.sh"]

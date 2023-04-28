FROM alpine:edge

WORKDIR /app

COPY script.sh .

LABEL org.opencontainers.image.source https://github.com/val7117/vkr-project

CMD ["sh", "script.sh"]
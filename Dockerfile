FROM alpine:edge

WORKDIR /app

COPY app.sh .

LABEL org.opencontainers.image.source https://github.com/val7117/vkr-project

CMD ["sh", "app.sh"]
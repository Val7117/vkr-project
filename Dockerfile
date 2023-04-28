FROM python:3.11-slim-buster

WORKDIR /app

COPY app.py .

LABEL org.opencontainers.image.source https://github.com/val7117/vkr-project

CMD ["python", "app.py"]
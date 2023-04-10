FROM alpine:edge

RUN echo "Hello, " >> /etc/world.txt
RUN echo "ITMO!" >> /etc/world.txt

# Add label for Git Hub container registry
LABEL org.opencontainers.image.source https://github.com/val7117/vkr-project.git
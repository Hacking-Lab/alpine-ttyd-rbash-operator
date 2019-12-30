FROM hackinglab/alpine-base:latest
MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>

RUN apk add --update ttyd && \
    rm -rf /var/cache/apk/* && \
    ln -s /bin/bash /bin/rbash

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 7681

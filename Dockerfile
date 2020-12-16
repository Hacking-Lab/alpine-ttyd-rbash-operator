FROM tsl0922/musl-cross as ttydbuild
RUN git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && env BUILD_TARGET=x86_64 WITH_SSL=false ./scripts/cross-build.sh


FROM alpine:latest as libwebsocketsbuild
RUN apk add --no-cache sudo
ENV PACKAGER="Robot <robot@mailinator.com" \
  USERNAME="packager"

RUN apk update && apk --no-cache add \
  alpine-sdk

RUN adduser -g abuild --disabled-password $USERNAME
RUN echo "$USERNAME:$USERNAME" | chpasswd
RUN echo "$USERNAME     ALL=(ALL) ALL" > /etc/sudoers
RUN echo 'PACKAGER="$PACKAGER"' > /etc/abuild.conf

RUN addgroup $USERNAME abuild

RUN mkdir -p /var/cache/distfiles
RUN chmod a+w /var/cache/distfiles
RUN chgrp abuild /var/cache/distfiles
RUN chmod g+w /var/cache/distfiles
RUN chmod 777 /home/packager

COPY app /app
RUN chown $USERNAME -R /app

WORKDIR /app
USER $USERNAME
RUN abuild-keygen -a -i
RUN abuild -r


FROM hackinglab/alpine-base:3.2
MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>

COPY --from=ttydbuild /ttyd/build/ttyd /usr/bin/ttyd

# Installing ttyd
# RUN apk add --update openssl ttyd && \
# rm -rf /var/cache/apk/*

COPY --from=libwebsocketsbuild /home/packager/packages/x86_64 /src
RUN apk add --allow-untrusted /src/libwebsockets-4.0.20-r0.apk

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 7681



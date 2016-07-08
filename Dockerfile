FROM alpine:latest

RUN apk -Uuv add curl bash python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

COPY startup.sh /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]
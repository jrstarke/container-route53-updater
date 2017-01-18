FROM alpine:latest

ENV META_DATA_HOST="169.254.169.254"
ENV PUBLIC_IP_HOSTED_ZONE=""
ENV PUBLIC_IP_DOMAIN=""
ENV LOCAL_IP_HOSTED_ZONE=""
ENV LOCAL_IP_DOMAIN=""

RUN apk -Uuv add curl bash python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

COPY startup.sh /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]
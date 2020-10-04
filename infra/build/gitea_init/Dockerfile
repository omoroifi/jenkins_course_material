FROM alpine:3.7
RUN apk update && apk add curl bash jq

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

FROM alpine:3.9
RUN apk add --no-cache curl jq bash
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

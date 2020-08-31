FROM alpine:latest
RUN apk update && \
    apk add build-base && \
    apk add bash bzip2 gawk git && \
    apk add perl rsync && \
    apk add ncurses-dev && \
    apk add python2 python3
RUN addgroup -g 1000 app && \
    adduser -D -G app -s /sbin/nologin -u 1000 app
USER app

ENTRYPOINT ["/bin/sh", "/src/entry.sh"]

FROM alpine:latest
RUN apk update && \
    apk add build-base && \
    apk add bash bzip2 gawk git && \
    apk add perl rsync && \
    apk add ncurses-dev && \
    apk add python3

WORKDIR /src

ENTRYPOINT ["/bin/sh", "entry.sh"]

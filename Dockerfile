FROM alpine:latest

# Required for goeap-tools
# Build dependency: Please install GNU 'tar'
# Build dependency: Please install GNU 'find'
# Build dependency: Please install 'xargs' that supports '-r/--no-run-if-empty'
# Build dependency: Please install GNU diffutils
# Build dependency: Please install GNU 'grep'
# Build dependency: Please install GNU 'grep'
# Build dependency: Please install 'gzip'
# Build dependency: Please install 'unzip'
# Build dependency: Please install GNU 'wget'
# Build dependency: Please install GNU 'install'
# Build dependency: Missing argp.h Please install the argp-standalone package if musl libc
# Build dependency: Missing fts.h Please install the musl-fts-dev package if musl libc
# Build dependency: Missing obstack.h Please install the musl-obstack-dev package if musl libc
# Build dependency: Missing libintl.h Please install the musl-libintl package if musl libc

RUN apk update && \
    apk add tar findutils diffutils grep gzip unzip wget coreutils argp-standalone musl-fts-dev musl-obstack-dev musl-libintl && \
    apk add build-base && \
    apk add bash bzip2 xz gawk git && \
    apk add perl rsync && \
    apk add ncurses-dev && \
    apk add python3

WORKDIR /src

ENTRYPOINT ["/bin/sh", "entry.sh"]

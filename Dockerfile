FROM openjdk:8-jdk-slim

ENV DRILL_DIR=/opt/drill \
    DRILL_CONF=/opt/drill/conf

# Create a new unprivileged user "drill", neccessary dirs and own them
RUN set -eux; \
    groupadd -r drill --gid=1000; \
    useradd -r -g drill --uid=1000 drill; \
    mkdir -p "$DRILL_DIR" "$DRILL_CONF";

# Install required packages
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dirmngr \
        gosu \
        gnupg \
        netcat \
        procps \
        wget; \
    rm -rf /var/lib/apt/lists/*; \
    gosu nobody true

ARG APP_NAME=drill-1.15.0
ARG GPG_KEY=0E0520282BF328B128358DB6477CA01DF573D4A6

# Download .tar.gz and verify its gpg signature before extracting it
RUN set -eux; \
    wget "https://www.apache.org/dist/drill/$APP_NAME/apache-$APP_NAME.tar.gz"; \
    wget -q "https://www.apache.org/dist/drill/$APP_NAME/apache-$APP_NAME.tar.gz.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-key "$GPG_KEY" || \
    gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEY"; \
    gpg --batch --verify "apache-$APP_NAME.tar.gz.asc" "apache-$APP_NAME.tar.gz"; \
    tar -xzf "apache-$APP_NAME.tar.gz"; \
    mv "/apache-$APP_NAME/"* "$DRILL_DIR"; \
    rm -rf "$GNUPGHOME" "apache-$APP_NAME.tar.gz";

WORKDIR $DRILL_DIR

VOLUME ["$DRILL_DIR"]

EXPOSE 8047 31010 31011 31012

ENV PATH=$PATH:$DRILL_DIR/bin

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY start.sh "$DRILL_DIR/bin/"
COPY drill-override.conf "$DRILL_DIR/conf/"

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["sh", "-c", "${DRILL_DIR}/bin/start.sh start"]
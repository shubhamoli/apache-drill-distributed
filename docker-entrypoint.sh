#!/bin/bash

set -eux;

# Allow the container to be started with `--user`
if [[ "$(id -u)" = '0' ]]; then
    chown -R drill:drill "$DRILL_DIR"
    #exec gosu drill "$0" "$@"
    chmod +x "$DRILL_DIR/bin/start.sh"
fi

CLUSTER_ID=${CLUSTER_ID:-"my-drillbits"}
ZK_SERVERS=${ZK_SERVERS:-""}

sed -i "s/{{CLUSTER_ID}}/$CLUSTER_ID/g" "$DRILL_DIR/conf/drill-override.conf"
sed -i "s/{{ZK_SERVERS}}/$ZK_SERVERS/g" "$DRILL_DIR/conf/drill-override.conf"

exec "$@"
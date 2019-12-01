#!/bin/bash

set -eux;

# Allow the container to be started with drill user
if [[ "$(id -u)" = '0' ]]; then
    exec gosu drill "$0" "$@"
fi

chmod +x "$DRILL_HOME/bin/start.sh"

CLUSTER_ID=${CLUSTER_ID:-"my-drillbits"}
ZK_SERVERS=${ZK_SERVERS:-""}

sed -i "s/{{CLUSTER_ID}}/$CLUSTER_ID/g" "$DRILL_HOME/conf/drill-override.conf"
sed -i "s/{{ZK_SERVERS}}/$ZK_SERVERS/g" "$DRILL_HOME/conf/drill-override.conf"

exec "$@"

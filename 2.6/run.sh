#!/bin/bash
set -m

mongodb_cmd="mongod"
cmd="$mongodb_cmd"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$REPLSET" != "" ]; then
    cmd="$cmd --replSet $REPLSET"
    else
    cmd="$cmd --master"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

if [ "$AUTH" == "yes" ]; then
if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
    fi
fi

if [ "$EXTCMD" != "" ]; then
    $EXTCMD
fi

fg

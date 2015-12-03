#!/bin/bash
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done
echo "=> Seting up replica"
addcmd = "rs.add"
if [ "$ISARB" == "yes" ]; then
    addcmd="$addcmdArb"
fi
mongo $MONGOHOST --eval "if (rs.conf() == null){rs.initiate();} else {$addcmd('$HOSTNAME:27017');}"
echo "=> Done!"
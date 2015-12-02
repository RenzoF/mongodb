#!/bin/bash
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done
echo "=> Seting up replica"
mongo $MONGOHOST --eval "if (rs.conf() == null){rs.initiate();}"
echo "=> Done!"

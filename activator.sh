#!/bin/bash

KEY_DIR=/keys

activate() {
    DIR=$1
    if [ "$(ls -A ${DIR} 2> /dev/null)" != "" ]; then
        eval `ssh-agent`
        chmod 700 ${DIR}
        chmod 400 ${DIR}/*
        ssh-add ${DIR}/*
    fi
    return $?
}

activate ${KEY_DIR}

$@

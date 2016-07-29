#!/bin/sh
. /etc/conf.d/psd

if [ -z $RUNTIME_DIR ]; then 
    echo '$RUNTIME_DIR is empty'
    echo 'Please check /etc/conf.d/psd file'
    return 1
fi

USER_NAME=$USER 
USER_ID=$UID

eval export XDG_RUNTIME_DIR=${RUNTIME_DIR}

if ! [ -d ${XDG_RUNTIME_DIR} ]; then
    mkdir -m 0700 ${XDG_RUNTIME_DIR} 
fi

/usr/bin/profile-sync-daemon $@


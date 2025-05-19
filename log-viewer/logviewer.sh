#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# default password: changeme
export PASSWORD_MD5="${PASSWORD_MD5:-4cb9c8a8048fd02294477fcb1a41191a}"

envsubst '$PASSWORD_MD5' < $SCRIPT_DIR/config.conf > $SCRIPT_DIR/config-new.conf

java -ea \
   -Dlog-viewer.config-file=$SCRIPT_DIR/config-new.conf \
   -jar $SCRIPT_DIR/lib/log-viewer-cli-1.0.11.jar startup

#!/usr/bin/env bash

cd $HOME/theia

$NVM_DIR/versions/node/v$NODE_VERSION/bin/yarn start $HOME/workspace --hostname 0.0.0.0 --port 8080
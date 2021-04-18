#!/bin/bash

version=$1
echo "upgrade to $version"

cd $HOME/git

cd cardano-node

git fetch --all --recurse-submodules --tags

git checkout tags/$version

cabal build cardano-cli cardano-node

sudo systemctl stop cardano-node.service

sudo cp $HOME/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-cli-$version/x/cardano-cli/build/cardano-cli/cardano-cli /usr/local/bin/cardano-cli

sudo cp $HOME/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-node-$version/x/cardano-node/build/cardano-node/cardano-node /usr/local/bin/cardano-node

echo "Version check : $version"

cardano-node version
cardano-cli version

sudo systemctl start cardano-node.service

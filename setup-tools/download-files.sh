#!/usr/bin/env bash

source ~/global-utils.sh

# install util

downloadFileToFolder ${baseUrlSetup}/install-shadowsocks.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/install-spdy.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/install-node.sh ${freeServerRootTmp}
downloadFileToFolder ${baseUrlSetup}/init.sh ${freeServerRootTmp}

# runtime util
downloadFileToFolder ${baseUrlBin}/createuser.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/createuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/deleteuser-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-shadowsocks.sh ${utilDir}
downloadFileToFolder ${baseUrlBin}/restart-spdy.sh ${utilDir}

# set executable for all shell scripts
cd ${utilDir}
chmod -R +x *.sh
cd ${freeServerRootTmp}
chmod -R +x *.sh


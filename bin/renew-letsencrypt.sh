#!/bin/bash

source /opt/.global-utils.sh


if [[ -z $freeServerName ]]; then
    echoS "freeServerName is empty. Stop renewing Let's Encrypt Cert." "stderr"
    exit 1
fi


if [[ ! -f $letsEncryptCertPath ]]; then
    echoS "[Let's Encrypt] $letsEncryptCertPath is not a file" "stderr"
    exit 1
fi

if [[ ! -f $letsEncryptKeyPath ]]; then
    echoS "[Let's Encrypt] $letsEncryptKeyPath is not a file" "stderr"
    exit 1
fi


if [[ ! -f $letsencryptAutoPath ]]; then
    echoS "[Let's Encrypt] $letsencryptAutoPath is not a file" "stderr"
    exit 1
fi

echoS "Start to Renew Let's Encrypt Cert."

prepareLetEncryptEnv

certLog=$(eval "$letsencryptAutoPath renew --agree-tos")
echo $certLog
certDone=$(echo $certLog | grep "The following certs have been renewed")

if [[ ! -z $certDone ]]
then
        killall nghttpx
        /opt/free-server/restart-spdy-nghttpx-squid
fi

afterLetEncryptEnv


exit 0
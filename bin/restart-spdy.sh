#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0"

  exit 0
fi

if [ ! -f $1 ];then
        echo "Usage: ./start.sh config.txt"
        exit
fi

if [[ ! -f ${SPDYSSLKeyFile} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit"
  exit 0
fi


if [[ ! -f ${SPDYSSLCertFile} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit"
  exit 0
fi

for i in $(cat "${SPDYConfig}"); do

  echo "Process $i"

  username=$(echo "$i" | gawk 'BEGIN { FS = "," } ; {print $1}')
  password=$(echo "$i" | gawk 'BEGIN { FS = "," } ; {print $2}')
  port=$(echo "$i" | gawk 'BEGIN { FS = "," } ; {print $3}')

  if [[ -z ${username} || -z ${password} || -z ${port} ]]; then
    echo -e "username, password and port are all mandatory \n\
    username: ${username} \n\
    password: ${password} \n\
    port: ${port} \n"
  else
    wall -n "Restart spdyproxy with ${username}"
    spdyproxy -k ${SPDYSSLKeyFile} -c ${SPDYSSLCertFile} -p $port -U $username -P $password >/dev/null 2>&1  &
  fi

done



#!/bin/bash

# Start NGiNX reverse proxy
/usr/sbin/nginx

# Clean-up old log file
rm -f /opt/mirthconnect/logs/mirth.log

# Start Mirth Connect
./mcservice start

# Make sure that the service has actually started
while [ ! -f /opt/mirthconnect/logs/mirth.log ]
do
  sleep 0.1
done

# Don't spin wait if the service is dead
./mcservice status
if [[ `./mcservice status` != "The daemon is running." ]]; then
    echo "The daemon is not running"
    exit 1
fi

while ! echo exit | nc localhost 8443; do sleep 0.1; done

pids=$(pgrep java)
echo $pids

java -jar mirth-cli-launcher.jar -a https://localhost:8443 -u admin -p admin -v 0.0.0 -s mirthconnect-cli.txt

tail -f /opt/mirthconnect/logs/mirth.log --pid=$pids

service nginx stop

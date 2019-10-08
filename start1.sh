#!/bin/bash

/usr/sbin/sshd -D  >> /dockerstartup/ssh.log &
/dockerstartup/vnc_startup.sh "$@"

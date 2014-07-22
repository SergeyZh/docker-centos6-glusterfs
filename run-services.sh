#!/bin/sh


touch /var/log/glusterfs/glustershd.log

/sbin/service sshd start
/sbin/service glusterd start

shutdown_gluster()
{
    /sbin/service sshd stop
    /sbin/service glusterd stop
    exit $?
}

trap shutdown_gluster SIGINT

tail -F /var/log/glusterfs/glustershd.log &

wait



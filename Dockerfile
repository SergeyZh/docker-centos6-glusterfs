FROM sergeyzh/centos6-epel

MAINTAINER Sergey Zhukov, sergey@jetbrains.com

ADD glusterfs-epel.repo /etc/yum.repos.d/

RUN yum -y install glusterfs-server

CMD /bin/bash

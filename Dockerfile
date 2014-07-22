FROM sergeyzh/centos6-epel

MAINTAINER Sergey Zhukov, sergey@jetbrains.com

ADD glusterfs-epel.repo /etc/yum.repos.d/

RUN yum -y install glusterfs-server openssh-server sudo

RUN mkdir -p /export/brick1 /mnt/storage

VOLUME ["/mnt/storage"]

# Fix the problem with SSH login to container
RUN sed -i "/pam_loginuid.so/ s/\(.*\)/#\1/" /etc/pam.d/sshd

RUN groupadd --system  sshusers ; echo "AllowGroups sshusers" >> /etc/ssh/sshd_config
RUN echo "%wheel    ALL=(ALL)    ALL" > /etc/sudoers.d/0_wheel

# Configure SSHd to listen on port 2222
RUN sed -i '/#Port 22/ a \Port 2222' /etc/ssh/sshd_config

RUN /usr/sbin/adduser -p '$1$RLX1qyZP$5EfZJ124X1Ewh7YRfzPVp0' gluster-ssh; usermod --append --groups sshusers,wheel gluster-ssh

ADD run-services.sh /

RUN chmod a+x /run-services.sh

CMD /run-services.sh

EXPOSE 2222 24007 24008 49152

# base images
FROM consol/centos-xfce-vnc
MAINTAINER panzhen "panzhen@aizhixin.com"
ENV REFRESHED_AT 2019-09-13
LABEL io.azx.description="Headless VNC Container with Xfce window manager, firefox and chromium, SSH" \
      io.azx.display-name="Headless VNC Container based on Centos" \
      io.azx.expose-services="5901:xvnc" \
      io.azx.tags="vnc, centos, xfce, ssh" \
      io.azx.non-scalable=true

USER 0

RUN yum install -y openssh-server \
    && yum install -y openssh-clients \
    && yum install -y which \
    && yum clean all \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
    && ssh-keygen -t rsa -f /root/.ssh/id_rsa -P '' \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod a+x /root/.ssh/authorized_keys \
    && echo -e "Host localhost\n  StrictHostKeyChecking no\n\nHost 0.0.0.0\n  StrictHostKeyChecking no\n\nHost master*\n   StrictHostKeyChecking no\n   UserKnownHostsFile=/dev/null\n\nHost slave*\n   StrictHostKeyChecking no\n   UserKnownHostsFile=/dev/null" >> /root/.ssh/config



ADD vnc_startup.sh $STARTUPDIR/vnc_startup.sh
RUN chmod a+x $STARTUPDIR/vnc_startup.sh

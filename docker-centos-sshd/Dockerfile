FROM centos:7

RUN yum -y install openssh openssh-clients openssh-server sudo
EXPOSE 22

COPY entrypoint.sh /
COPY sshd_config /etc/ssh/sshd_config

RUN adduser jumpuser && \
    usermod -aG wheel jumpuser && \
    echo "jumpuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jumpuser && \
    mkdir -p /home/jumpuser/.ssh && \ 
    echo " export HISTFILE=/dev/null" >> /home/jumpuser/.bashrc && \
    echo " export HISTFILE=/dev/null" >> /root/.bashrc

CMD ["/entrypoint.sh"]

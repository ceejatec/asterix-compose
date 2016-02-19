FROM centos:7.2.1511

USER root
RUN yum clean all && \
    yum install --setopt=keepcache=0 -y openssh-server openssh-clients sudo deltarpm unzip

# Set up for SSH daemon
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# JDK.
RUN mkdir /tmp/deploy && \
    curl -L --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.rpm -o jdk.rpm && \
    yum localinstall -y jdk.rpm && \
    cd /tmp && rm -rf deploy

# Create couchbase user with password-less sudo privs, and give
# ownership of /opt/couchbase
RUN groupadd -g1000 couchbase && \
    useradd couchbase -g couchbase -u1000 -G wheel -m -s /bin/bash && \
    echo 'couchbase:couchbase' | chpasswd && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/wheel_group && \
    echo 'Defaults:%wheel !requiretty' >> /etc/sudoers.d/wheel_group && \
    chmod 440 /etc/sudoers.d/wheel_group

# Configure password-less ssh for user couchbase.
USER couchbase
RUN ssh-keygen -q -t rsa -P "" < /dev/zero && \
    cat /home/couchbase/.ssh/id_rsa.pub >> /home/couchbase/.ssh/authorized_keys && \
    chmod 600 /home/couchbase/.ssh/authorized_keys

USER root
COPY config /home/couchbase/.ssh/config
RUN chown couchbase:couchbase /home/couchbase/.ssh/config
COPY startup.sh /usr/sbin/
ENTRYPOINT [ "/usr/sbin/startup.sh" ]
CMD [ "default" ]


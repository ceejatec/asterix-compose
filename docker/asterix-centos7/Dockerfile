FROM centos:7.2.1511

USER root
COPY docker.repo /etc/yum.repos.d/docker.repo
RUN yum clean all && \
    yum install --setopt=keepcache=0 -y openssh-server openssh-clients sudo deltarpm unzip docker-engine git which && \
    curl -L https://github.com/docker/compose/releases/download/1.6.2/run.sh > /usr/local/bin/docker-compose && \
    chmod 755 /usr/local/bin/docker-compose

# Set up for SSH daemon
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# JDK.
RUN mkdir /tmp/deploy && \
    cd /tmp/deploy && \
    curl -L --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm -o jdk.rpm && \
    yum localinstall -y jdk.rpm && \
    cd /tmp && rm -rf deploy
ENV JAVA_HOME=/usr/java/latest

# Maven (since this image also serves as the Jenkins slave).
RUN mkdir /tmp/deploy && \
    cd /tmp/deploy && \
    curl -L http://mirror.cogentco.com/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
       -o maven.tar.gz && \
    cd /usr/local && \
    tar xzf /tmp/deploy/maven.tar.gz && \
    ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/local/bin/mvn && \
    rm -rf /tmp/deploy

# Repo.
RUN curl https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo

# Create couchbase user with password-less sudo privs. Also join the "Docker"
# group, which is 999 on the Ubuntu host
RUN groupadd -g1000 couchbase && \
    useradd couchbase -g couchbase -u1000 -G wheel,999 -m -s /bin/bash && \
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
COPY startup.sh sshconfigbase /usr/sbin/
ENTRYPOINT [ "/usr/sbin/startup.sh" ]
CMD [ "default" ]


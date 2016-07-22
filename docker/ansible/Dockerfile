FROM ceejatec/asterix-centos7

# GCC and python-devel (necessary for pip)
RUN yum install -y gcc python-devel libffi-devel openssl-devel

# Install pip and ansible
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py" && \
    python /tmp/get-pip.py && \
    pip install ansible && \
    rm /tmp/get-pip.py


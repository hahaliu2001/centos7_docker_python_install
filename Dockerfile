# builder
FROM centos:7.9.2009 AS builder

WORKDIR /root/

RUN yum -y install epel-release \
    && yum update -y \
    && yum install -y iproute \
    && yum install -y sudo \
    && echo -e "root\nroot" | passwd root \
    && yum install -y openssh-server \
    # install build tools
    && yum install -y wget make cmake gcc bzip2-devel libffi-devel zlib-devel \
    && yum groupinstall -y "Development Tools" \
    # download, build and install openssl1.1.1
    && wget https://www.openssl.org/source/openssl-1.1.1t.tar.gz \
    && tar xvf openssl-1.1.1t.tar.gz \
    && rm openssl-1.1.1t.tar.gz \
    && cd openssl-1.1.1t \
    && ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf openssl-1.1.1t \
    && ldconfig \
    && echo "export PATH=/usr/local/openssl/bin:\$PATH" > /etc/profile.d/openssl.sh \
    && echo "export LD_LIBRARY_PATH=/usr/local/openssl/lib:\$LD_LIBRARY_PATH" >> /etc/profile.d/openssl.sh \
    && source /etc/profile.d/openssl.sh \
    # download, build and install python
    && wget https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz \
    && tar xvf Python-3.11.2.tgz \
    && rm Python-3.11.2.tgz \
    && cd Python-3.11*/ \
    && LDFLAGS="${LDFLAGS} -Wl,-rpath=/usr/local/openssl/lib" ./configure --with-openssl=/usr/local/openssl \
    && make \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.11* \
    #set python3 alias to python3.11
    && echo "alias python3='/usr/local/bin/python3.11' " >> .bashrc \
    && yum autoremove -y \
    && yum clean all -y \

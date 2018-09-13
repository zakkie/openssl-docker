FROM ubuntu:18.04

WORKDIR /var/tmp/openssl

ADD deb-ubuntu18.04/ /var/tmp/deb/
RUN dpkg -i /var/tmp/deb/*.deb

ENV source_url=https://www.openssl.org/source \
    openssl_ver=1.1.1

RUN wget ${source_url}/openssl-${openssl_ver}.tar.gz && \
    echo "$(wget -O - ${source_url}/openssl-${openssl_ver}.tar.gz.sha1)  openssl-${openssl_ver}.tar.gz" | \
    sha1sum -c - && \
    tar zxf openssl-${openssl_ver}.tar.gz && \
    cd openssl-${openssl_ver} && \
    ./config --prefix=/usr/local/ --openssldir=/usr/local/ shared && \
    make && \
    make install && \
    cd .. && \
    rm -rf openssl-${openssl_ver}

RUN dpkg -r openssl ca-certificates

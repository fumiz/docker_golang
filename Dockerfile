FROM ubuntu:15.04

RUN apt-get update && \
     apt-get upgrade -y && \
     apt-get install -y gcc && \
     apt-get install -y git mercurial bzr&& \
     apt-get clean && \
     rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# make GOROOT
ADD https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz /tmp/go1.4.2.linux-amd64.tar.gz
RUN cd /tmp && \
    echo "5020af94b52b65cc9b6f11d50a67e4bae07b0aff go1.4.2.linux-amd64.tar.gz" > go1.4.2.linux-amd64.tar.gz.sha1 && \
    sha1sum -c go1.4.2.linux-amd64.tar.gz.sha1 && \
    rm go1.4.2.linux-amd64.tar.gz.sha1
RUN cd /tmp && \
    tar zxf go1.4.2.linux-amd64.tar.gz && \
    mv go / && \
    rm go1.4.2.linux-amd64.tar.gz
ENV GOROOT /go
ENV PATH /go/bin:$PATH

RUN cd $(go env GOROOT)/src && \
    GOOS=linux   GOARCH=386   ./make.bash && \
    GOOS=linux   GOARCH=arm   ./make.bash && \
    GOOS=linux   GOARCH=amd64 ./make.bash && \
    GOOS=darwin  GOARCH=amd64 ./make.bash && \
    GOOS=windows GOARCH=amd64 ./make.bash

RUN mkdir /gopath && \
    mkdir /gopath/bin && \
    mkdir /gopath/pkg &&\
    mkdir /gopath/src
ENV GOPATH /gopath

COPY activator.sh /usr/local/bin/activator.sh
RUN chmod 700 /usr/local/bin/activator.sh
RUN mkdir /keys

WORKDIR /gopath
ENTRYPOINT ["/usr/local/bin/activator.sh"]

FROM ubuntu:15.04

RUN apt-get update && \
     apt-get upgrade -y && \
     apt-get install -y gcc && \
     apt-get install -y git mercurial bzr&& \
     apt-get clean && \
     rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# make GOROOT
ADD https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz /tmp/go1.5.1.linux-amd64.tar.gz
RUN cd /tmp && \
    echo "46eecd290d8803887dec718c691cc243f2175fe0 go1.5.1.linux-amd64.tar.gz" > go1.5.1.linux-amd64.tar.gz.sha1 && \
    sha1sum -c go1.5.1.linux-amd64.tar.gz.sha1 && \
    rm go1.5.1.linux-amd64.tar.gz.sha1
RUN cd /tmp && \
    tar zxf go1.5.1.linux-amd64.tar.gz && \
    mv go / && \
    rm go1.5.1.linux-amd64.tar.gz
ENV GOROOT /go
ENV PATH /go/bin:$PATH

RUN cd $(go env GOROOT)/src && \
    GOOS=linux   GOARCH=386   go install std && \
    GOOS=linux   GOARCH=arm   go install std && \
    GOOS=linux   GOARCH=amd64 go install std && \
    GOOS=darwin  GOARCH=amd64 go install std && \
    GOOS=windows GOARCH=amd64 go install std

RUN mkdir /gopath && \
    mkdir /gopath/bin && \
    mkdir /gopath/pkg &&\
    mkdir /gopath/src
ENV GOPATH /gopath

COPY activator.sh /usr/local/bin/activator.sh
RUN chmod 700 /usr/local/bin/activator.sh
RUN mkdir /keys

WORKDIR /gopath

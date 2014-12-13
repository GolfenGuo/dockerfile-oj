#
# GoOnlineJudge Dockerfile
#
# Github
# https://github.com/JinweiClarkChao/dockerfile-oj
#
# Docker Hub
# https://registry.hub.docker.com/u/clarkzjw/go-onlinejudge/
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER clarkzjw <clarkzjw@gmail.com>

# Install Ubuntu.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y git vim wget flex && \
  mkdir -p /home/acm/go && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Install Go
RUN \
  mkdir -p /goroot && \
  wget https://storage.googleapis.com/golang/go1.4.src.tar.gz && \
  tar xvzf go1.4.src.tar.gz && \
  cp -r go1.4.src/* /goroot/

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /home/acm/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Get OJ Source Code
RUN \
mkdir $GOPATH/src/ProblemData && \
mkdir $GOPATH/src/run

# RUN go get gopkg.in/mgo.v2

# RUN \
#  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge && \
#  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
#  git clone https://github.com/sakeven/restweb.git $GOPATH/src/restweb

# Compile OJ
# RUN \
#  cd $GOPATH/src/GoOnlineJudge && \
#  git checkout master && \
#  go build && \
#  cd ../RunServer && \
#  ./make.sh

RUN \
  echo && \
  echo ---------- && \
  echo installed. && \
  echo ---------- && \
  echo

# Define working directory.
# WORKDIR $GOPATH/src

# Define default command.
CMD ["bash"]

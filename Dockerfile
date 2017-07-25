FROM ubuntu:14.04.2
RUN apt-get -yqq update
RUN apt-get -yqq install curl lsb-release
RUN curl -L https://getchef.com/chef/install.sh | bash -s -- -v 12.19.36 && \
    curl -o helm.tar.gz https://kubernetes-helm.storage.googleapis.com/helm-v2.2.2-linux-amd64.tar.gz && \
    tar -zxvf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/ && \
    rm -rf linux-amd64 && \
    rm -f helm.tar.gz 


RUN apt-get -yqq clean

# Make Chef available as a volume
VOLUME /opt/chef
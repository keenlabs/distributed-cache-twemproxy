FROM ubuntu:16.04
MAINTAINER Devin Ekins <devops@keen.io>

# Setup the dependencies
RUN apt-get update && apt-get install -y \
    apt-utils \
    automake \
    libtool \
    make

# Copy local repo into the container
ADD . /twemproxy
WORKDIR /twemproxy

# Install Twemproxy
RUN autoreconf -fvi && \
    ./configure --enable-debug=full && \
    make

# Expose Twemproxy Ports
EXPOSE 22122 22222

# Start Twemproxy
# Use default configuration file location/name.
# Use mbufsize from ansible commandline variable.
ENTRYPOINT [ "src/nutcracker" ]

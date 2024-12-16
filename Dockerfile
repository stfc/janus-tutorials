FROM ubuntu:22.04
# Disable optional install (saves image size).
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
# Install minimal dependencies.
#   python3-dev (i.e. headers), gcc, g++, and ninja-build for phonopy.
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3-dev python3 git ninja-build python3-pip gcc g++
# Clean up package list.
RUN rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install git+https://github.com/stfc/janus-core.git

RUN useradd -ms /bin/bash pika
USER pika

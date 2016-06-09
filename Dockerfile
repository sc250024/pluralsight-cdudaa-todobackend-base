FROM ubuntu:xenial
MAINTAINER Scott Crooks <scott.crooks@gmail.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to PDX
RUN sed -i "s/archive.ubuntu.com/mirrors.cat.pdx.edu/g" /etc/apt/sources.list

# Install Python runtime
RUN apt-get install && \
	apt-get install -y \
	-o APT::Install-Recommend=false -o APT::Install-Suggests=false \
	python python-virtualenv
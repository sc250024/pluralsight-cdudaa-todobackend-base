FROM ubuntu:trusty
MAINTAINER Scott Crooks <scott.crooks@gmail.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to PDX
RUN sed -i "s/archive.ubuntu.com/mirror.pnl.gov/g" /etc/apt/sources.list

# Update mirrors
RUN apt-get -y update

# Install Python runtime
RUN apt-get install && \
	apt-get install -y \
	-o APT::Install-Recommend=false -o APT::Install-Suggests=false \
	python python-virtualenv libpython2.7 python-mysqldb

# Create virtual environment
# Upgrade PIP in virtual environment to latest version
RUN virtualenv /appenv && \
	. /appenv/bin/activate && \
	pip install pip --upgrade

RUN rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/archives/*.deb && rm -f /var/cache/apt/*cache.bin

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend

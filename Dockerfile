FROM phusion/baseimage:0.9.11
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN apt-get update -q

# Install Dependencies
RUN apt-get install -qy python python-cheetah ca-certificates wget

# Install SickBeard 3a70a6effe (2014-06-22)
RUN mkdir /opt/sickbeard
RUN wget https://github.com/midgetspy/Sick-Beard/tarball/0e81fe9baf54d3e4084837eab5a16a47cc2a4f39 -O /tmp/midgetspy-SickBeard-0e81fe9baf.tar.gz
RUN tar -C /opt/sickbeard -xvf /tmp/midgetspy-SickBeard-0e81fe9baf.tar.gz --strip-components 1
RUN chown nobody:users /opt/sickbeard

EXPOSE 8081

# SickBeard Configuration
VOLUME /config

# Downloads directory
VOLUME /downloads

# TV directory
VOLUME /tv

# Add edge.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD edge.sh /etc/my_init.d/edge.sh
RUN chmod +x /etc/my_init.d/edge.sh

# Add Sickbeard to runit
RUN mkdir /etc/service/sickbeard
ADD sickbeard.sh /etc/service/sickbeard/run
RUN chmod +x /etc/service/sickbeard/run

FROM ubuntu:14.04
MAINTAINER Tim Sogard <docker@timsogard.com>

RUN apt-get update
RUN apt-get install wget libcurl3 libcurl3-gnutls -y

# Install game from warsow.net
RUN wget "http://www.warsow.net/download?dl=warsow151" -O warsow.tar.gz
RUN tar -xzf warsow.tar.gz -C /opt/
RUN mv /opt/warsow* /opt/Warsow
RUN chmod +x /opt/Warsow/wsw_server*

# Setup user
RUN useradd -m -s /bin/bash warsow
RUN chown -R warsow:warsow /opt/Warsow

# Setup server
ADD cfg/dedicated_autoexec.cfg /opt/Warsow/basewsw/dedicated_autoexec.cfg
WORKDIR /opt/Warsow
USER warsow
EXPOSE 44401/udp

CMD ./wsw_server +set fs_usehomedir 0 +set fs_basepath /opt/Warsow +set dedicated 1

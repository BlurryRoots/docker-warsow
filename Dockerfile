FROM ubuntu:13.10
MAINTAINER Tim Sogard <docker@timsogard.com>

ADD cfg /opt/wsw_cfg/
RUN apt-get update
RUN apt-get install wget libcurl3 libcurl3-gnutls -y

# Install game from warsow.net
RUN wget -O warsow.tar.gz http://www.warsow.net/download?dl=linux151
RUN tar zxvf warsow.tar.gz -C /opt/
RUN mv /opt/warsow* /opt/Warsow
RUN chmod +x /opt/Warsow/wsw_server*

# Setup user
RUN useradd -m -s /bin/bash warsow
RUN chown -R warsow:warsow /opt/Warsow

# Setup server
WORKDIR /opt/Warsow
USER warsow
EXPOSE 44401/udp

CMD ./wsw_server +set fs_usehomedir 0 +set fs_basepath /opt/warsow_1.02/ +set dedicated 1

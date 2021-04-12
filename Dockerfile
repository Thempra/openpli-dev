FROM ubuntu:18.04
LABEL maintainer="thempra@overxet.com"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install cpio locales psmisc autoconf automake bison bzip2 curl cvs diffstat flex g++ gawk gcc gettext git gzip help2man ncurses-bin libncurses5-dev libc6-dev libtool make texinfo patch perl pkg-config subversion tar texi2html wget zlib1g-dev chrpath libxml2-utils xsltproc libglib2.0-dev python-setuptools zip info coreutils diffstat chrpath libproc-processtable-perl libperl4-corelibs-perl sshpass default-jre default-jre-headless java-common libserf-dev qemu quilt libssl-dev bc kmod cython

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf

RUN adduser --disabled-password --gecos "" openpli
RUN mkdir /openpli

WORKDIR /openpli

ADD idle.sh /tmp/idle.sh
RUN chmod +x /tmp/idle.sh
ENTRYPOINT ["/tmp/idle.sh"]
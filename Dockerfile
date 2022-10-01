FROM ubuntu:20.04
LABEL maintainer="thempra@overxet.com"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install autoconf automake bison locales bzip2 chrpath coreutils cpio curl cvs debianutils default-jre default-jre-headless diffstat flex g++ gawk gcc gcc-8 gcc-multilib g++-multilib gettext git git-core gzip help2man info iputils-ping java-common libc6-dev libegl1-mesa libglib2.0-dev libncurses5-dev libperl4-corelibs-perl libproc-processtable-perl libsdl1.2-dev libserf-dev libtool libxml2-utils make ncurses-bin patch perl pkg-config psmisc python3 python3-git python3-jinja2 python3-pexpect python3-pip python-setuptools qemu quilt socat sshpass subversion tar texi2html texinfo unzip wget xsltproc xterm xz-utils zip zlib1g-dev zstd fakeroot lz4 bc kmod

RUN  update-alternatives --install /usr/bin/python python /usr/bin/python2 1
RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3 2

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf

RUN adduser --disabled-password --gecos "" openpli
#RUN ln -s /usr/bin/cython3 /usr/local/bin/cython3
RUN mkdir /openpli

WORKDIR /openpli

ADD idle.sh /tmp/idle.sh
RUN chmod +x /tmp/idle.sh
ENTRYPOINT ["/tmp/idle.sh"]

FROM focal
LABEL maintainer="cedric.bouron@ynov.com" 
LABEL version="0.1" 
LABEL description="dockerfile"


ARG CTNG_UID=1000
ARG CTNG_GID=1000

ARG CONFIG_FILE

RUN groupadd -g $CTNG_GID ctng
RUN useradd -d /home/ctng -m -g $CTNG_GID -u $CTNG_UID -s /bin/bash ctng

RUN apt-get -y install software-properties-common
RUN add-apt-repository universe

RUN apt-get -y update && apt-get -y upgrade 

RUN apt-get install -y gcc g++ bison flex texinfo install-info info make \
libncurses5-dev  python3-dev autoconf automake libtool libtool-bin gawk wget  bzip2 xz-utils patch libstdc++6 rsync git unzip help2man

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
echo "057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945  /usr/local/bin/dumb-init" | sha256sum -c - && \
chmod 755 /usr/local/bin/dumb-init
RUN echo 'export PATH=/opt/ctng/bin:$PATH' >> /etc/profile
ENTRYPOINT [ "/usr/local/bin/dumb-init", "--" ]


USER ctng
WORKDIR /home/ctng

RUN git clone -b master --single-branch --depth 1 \
    https://github.com/crosstool-ng/crosstool-ng.git ct-ng
WORKDIR /home/ctng/ct-ng
RUN ./bootstrap
ENV PATH=/home/ctng/.local/bin:$PATH
COPY ${CONFIG_FILE} config

RUN ./configure --prefix=/home/ctng/.local
RUN make 
RUN make install

ENV TOOLCHAIN_PATH=/home/dev/x-tools/${CONFIG_FILE}
ENV PATH=${TOOLCHAIN_PATH}/bin:$PATH

CMD ["bash"]

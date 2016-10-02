FROM node:6

MAINTAINER Risto Stevcev

ENV PURESCRIPT_DOWNLOAD_SHA1 6fc98db5f7d58c4d2d7d80a73cefcad8c0189358

RUN npm install -g bower pulp@9.0.1

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.10.0-rc.1/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser

RUN mkdir tmp && cd tmp && pulp init

CMD cd tmp && pulp psci

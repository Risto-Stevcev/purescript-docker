FROM node:6

MAINTAINER Risto Stevcev

ENV PURESCRIPT_DOWNLOAD_SHA1 9c0dbbf7f7ccc56ace7192bcab51452618c8e2ed

RUN npm install -g bower pulp@9.0.1

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.9.3/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser

RUN mkdir tmp && cd tmp && pulp init

CMD cd tmp && pulp psci

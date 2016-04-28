FROM ubuntu:16.04
MAINTAINER Makoto Kato <m_kato@ga2.so-net.ne.jp>

ADD sources.list /etc/apt/
RUN mkdir /mozilla
RUN mkdir /root/.mozbuild
ADD mozconfig.sample /mozilla/
RUN dpkg --add-architecture arm64
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
  autoconf2.13 \
  build-essential \
  ccache \
  g++ \
  g++-aarch64-linux-gnu \
  mercurial \
  python \
  unzip \
  zip && \
    apt-get install -y --no-install-recommends \
  libasound2-dev:arm64 \
  libdbus-glib-1-dev:arm64 \
  libgconf2-dev:arm64 \
  libpulse-dev:arm64 \
  libxt-dev:arm64 \
  libgtk2.0-dev:arm64 \
  libgtk-3-dev:arm64 \
  mesa-common-dev:arm64 && \
   apt-get clean

ENV SHELL=/bin/bash
ENV NO_MERCURIAL_SETUP_CHECK=1

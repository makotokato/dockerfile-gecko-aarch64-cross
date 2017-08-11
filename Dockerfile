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
  curl \
  g++ \
  g++-aarch64-linux-gnu \
  llvm-3.9 \
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

RUN curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o rustup-init
RUN chmod +x rustup-init
RUN rustup-init -y
RUN ./rustup-init
ENV PATH=$PATH:/root/.cargo/bin
RUN /root/.cargo/bin/rustup target add aarch64-unknown-linux-gnu

#RUN adduser --ingroup users --disabled-password  --gecos '' builder
ENV SHELL=/bin/bash
ENV NO_MERCURIAL_SETUP_CHECK=1

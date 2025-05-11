ARG MAME_VERSION=0.269
ARG MAME_TARBALL_SHA256=05df2e82ff1d157282a5a667a67aa6eb331c55a64138afad0e8ac223553088ca
ARG MAME_BUILD_PARALLELISM=2

ARG PATCHELF_VERSION=0.18.0
ARG PATCHELF_TARBALL_SHA256=1451d01ee3a21100340aed867d0b799f46f0b1749680028d38c3f5d0128fb8a7

FROM public.ecr.aws/docker/library/debian:stable-20240904 AS base

RUN apt-get update
RUN apt-get install -y \
    curl \
    git \
    build-essential \
    python3 \
    libsdl2-dev \
    libsdl2-ttf-dev \
    libfontconfig-dev \
    libpulse-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
    qtchooser \
    qt5-qmake \
    autoconf

FROM base AS build-patchelf

ARG PATCHELF_VERSION
ARG PATCHELF_TARBALL_SHA256

WORKDIR /root/patchelf-${PATCHELF_VERSION}

RUN curl -sSLfo "patchelf-${PATCHELF_VERSION}.tar.gz" "https://github.com/NixOS/patchelf/archive/refs/tags/${PATCHELF_VERSION}.tar.gz" \
 && echo "${PATCHELF_TARBALL_SHA256}  patchelf-${PATCHELF_VERSION}.tar.gz" > patchelf-${PATCHELF_VERSION}.tar.gz.sha256 \
 && sha256sum -c "patchelf-${PATCHELF_VERSION}.tar.gz.sha256" \
 && rm patchelf-${PATCHELF_VERSION}.tar.gz.sha256 \
 && tar --strip-components=1 -xzf patchelf-${PATCHELF_VERSION}.tar.gz \
 && rm patchelf-${PATCHELF_VERSION}.tar.gz \
 && ./bootstrap.sh \
 && ./configure \
 && make \
 && make check

FROM base AS build-mame

ARG MAME_VERSION
ARG MAME_TARBALL_SHA256
ARG MAME_BUILD_PARALLELISM

WORKDIR /root/mame-${MAME_VERSION}

RUN curl -sSLfo "mame-${MAME_VERSION}.tar.gz" "https://github.com/mamedev/mame/archive/refs/tags/mame$(echo "${MAME_VERSION}" | tr --delete .).tar.gz" \
 && echo "${MAME_TARBALL_SHA256}  mame-${MAME_VERSION}.tar.gz" > mame-${MAME_VERSION}.tar.gz.sha256 \
 && sha256sum -c "mame-${MAME_VERSION}.tar.gz.sha256" \
 && rm mame-${MAME_VERSION}.tar.gz.sha256 \
 && tar --strip-components=1 -xzf mame-${MAME_VERSION}.tar.gz \
 && rm mame-${MAME_VERSION}.tar.gz

RUN make REGENIE=1 TOOLS=1 IGNORE_GIT=1 -j${MAME_BUILD_PARALLELISM}

FROM base AS patch

ARG MAME_VERSION
ARG PATCHELF_VERSION

COPY --from=build-patchelf /root/patchelf-${PATCHELF_VERSION}/src/patchelf /usr/local/bin/patchelf
COPY --from=build-mame /root/mame-${MAME_VERSION}/mame /root/portable-mame/mame

COPY bin /usr/local/bin

WORKDIR /root/portable-mame

RUN copy-libraries.sh mame libs
RUN patchelf --set-rpath '$ORIGIN/libs' ./mame
RUN patch-libs.sh ./libs
RUN rm ./libs/libGL.so.1
RUN rm ./libs/libGLdispatch.so.0
RUN rm ./libs/libGLX.so.0
RUN strip mame

FROM scratch

COPY --from=patch /root/portable-mame /portable-mame

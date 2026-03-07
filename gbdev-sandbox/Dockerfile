################################################################################
FROM public.ecr.aws/docker/library/debian:trixie-20260223 AS base
################################################################################


################################################################################
FROM base AS rgbds-source

RUN apt-get update
RUN apt-get install -y \
    curl

COPY ./bin /usr/local/bin

RUN mkdir /download \
 && fetch-github-source.sh \
      gbdev \
      rgbds \
      tag \
      v1.0.1 \
      193469d38229a653bb33a25ebb73fd0ae33da4be80191d83bce8d427d23b7704 \
      /download \
      /rgbds-source \
 && rm -rf /download
################################################################################


################################################################################
FROM base AS build-rgbds

RUN apt-get update
RUN apt-get install -y \
    gcc \
    g++ \
    libc6-dev \
    make \
    pkgconf \
    bison \
    libpng-dev

COPY --from=rgbds-source /rgbds-source /rgbds-source

WORKDIR /rgbds-source

RUN make Q= PREFIX=/rgbds-out \
 && make install Q= PREFIX=/rgbds-out
################################################################################


################################################################################
FROM base AS dev-shell

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN groupadd --gid ${USER_GID} ${USERNAME}
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}"

COPY --from=build-rgbds /rgbds-out /rgbds-out

ENV PATH=/rgbds-out/bin:$PATH
################################################################################

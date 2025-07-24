ARG USERNAME
ARG USER_UID
ARG USER_GID
ARG LIBXAU_VERSION=1.0.12
ARG LIBXAU_SHA512=4bbe8796f4a14340499d5f75046955905531ea2948944dfc3d6069f8b86c1710042bfc7918d459320557883e6631359d48e6173c69c62ff572314e864ff97c5e

################################################################################
FROM public.ecr.aws/docker/library/alpine:20250108 AS base

################################################################################
FROM base AS build-libxau

ARG LIBXAU_VERSION
ARG LIBXAU_SHA512

RUN apk add --no-cache \
  meson \
  gcc \
  musl-dev \
  xorgproto

WORKDIR /libxau

RUN wget "https://www.x.org/releases/individual/lib/libXau-${LIBXAU_VERSION}.tar.xz"
RUN echo "${LIBXAU_SHA512}  libXau-${LIBXAU_VERSION}.tar.xz" \
    > "libXau-${LIBXAU_VERSION}.tar.xz.sha512"
RUN sha512sum -c "libXau-${LIBXAU_VERSION}.tar.xz.sha512"
RUN tar xf "libXau-${LIBXAU_VERSION}.tar.xz"
RUN cd "libXau-${LIBXAU_VERSION}" \
 && meson setup --default-library both output \
 && meson compile -C output

################################################################################
FROM base AS dev-env

ARG USERNAME
ARG USER_UID
ARG USER_GID
ARG LIBXAU_VERSION

RUN apk add --no-cache \
  clang-extra-tools \
  coreutils \
  gcc \
  musl-dev \
  libx11-static \
  libx11-dev \
  libxcb-static \
  bash \
  make

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" \
    --home "/home/${USERNAME}" "${USERNAME}"

COPY --from=build-libxau \
     /libxau/libXau-${LIBXAU_VERSION}/output/libXau.a \
     /usr/lib/libXau.a

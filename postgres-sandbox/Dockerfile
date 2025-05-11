FROM public.ecr.aws/docker/library/debian:bookworm-20250407

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apt-get update
RUN apt-get install -y \
    gcc \
    libc6-dev \
    make \
    pkgconf \
    libicu-dev \
    bison \
    flex \
    libreadline-dev \
    libz-dev \
    git

RUN groupadd --gid ${USER_GID} ${USERNAME}
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}"

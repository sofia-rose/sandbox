FROM public.ecr.aws/docker/library/debian:trixie-20251020

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apt-get update
RUN apt-get install -y \
    gcc \
    make

RUN groupadd --gid ${USER_GID} ${USERNAME}
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}"

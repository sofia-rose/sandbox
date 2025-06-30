FROM nvidia/cuda:12.2.2-devel-ubuntu22.04

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

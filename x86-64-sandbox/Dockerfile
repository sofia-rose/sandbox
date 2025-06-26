FROM public.ecr.aws/docker/library/alpine:20250108

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apk add --no-cache bash nasm vim make binutils

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

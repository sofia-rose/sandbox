FROM public.ecr.aws/docker/library/golang:1.24.5

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

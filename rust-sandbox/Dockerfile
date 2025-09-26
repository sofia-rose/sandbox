FROM public.ecr.aws/docker/library/rust:1.90-bullseye

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apt-get update
RUN apt-get install -y bash bash-completion vim make

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

FROM public.ecr.aws/docker/library/rust:1.94-trixie

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apt-get update
RUN apt-get install -y bash bash-completion vim make

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

FROM public.ecr.aws/docker/library/maven:3.9.11-amazoncorretto-25

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN yum update
RUN yum install -y shadow-utils

RUN groupadd --gid "${USER_GID}" "${USERNAME}"
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}"

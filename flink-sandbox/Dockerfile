ARG JAVA_VERSION=17.0.15
FROM public.ecr.aws/docker/library/amazoncorretto:${JAVA_VERSION}

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN yum -y install shadow-utils git

RUN groupadd --gid ${USER_GID} ${USERNAME}
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home "${USERNAME}"

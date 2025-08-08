FROM public.ecr.aws/docker/library/node:22.18.0-alpine3.21

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apk add --no-cache bash make

# fail if the node user doesn't match the host user
# TODO: create a new user if node user does not match
RUN ["bash", "-c", "[ $(id -u node) == ${USER_UID} ]"]
RUN ["bash", "-c", "[ $(id -g node) == ${USER_GID} ]"]
RUN npm install standard --global

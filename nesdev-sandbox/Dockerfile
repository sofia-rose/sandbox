FROM public.ecr.aws/docker/library/alpine:20250108 AS build

ARG CC65_COMMIT_SHA=e5cebeda7628471d03ae49de319197866685bfde
ARG CC65_URL=https://github.com/cc65/cc65/archive/${CC65_COMMIT_SHA}.tar.gz

ARG CC65_SHA256SUM=f03a1f7dadb4d3effb30c345e89ec2fc31d089a1017d063792e7b7e3cca07ba3

RUN apk add --no-cache curl bash vim make build-base

WORKDIR /cc65

RUN curl -sSLo cc65.tar.gz "${CC65_URL}" \
 && echo "${CC65_SHA256SUM}  cc65.tar.gz" > cc65.tar.gz.sha256 \
 && sha256sum -c cc65.tar.gz.sha256 \
 && tar xzf cc65.tar.gz \
 && mv "cc65-${CC65_COMMIT_SHA}" cc65

RUN cd cc65 && make

FROM public.ecr.aws/docker/library/alpine:20250108

ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apk add --no-cache bash make git

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

COPY --from=build /cc65/cc65/asminc /cc65/asminc
COPY --from=build /cc65/cc65/bin /cc65/bin
COPY --from=build /cc65/cc65/cfg /cc65/cfg
COPY --from=build /cc65/cc65/include /cc65/include
COPY --from=build /cc65/cc65/lib /cc65/lib
COPY --from=build /cc65/cc65/samples /cc65/samples
COPY --from=build /cc65/cc65/target /cc65/target

ENV PATH="/cc65/bin:${PATH}"

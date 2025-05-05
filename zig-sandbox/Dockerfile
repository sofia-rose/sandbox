FROM public.ecr.aws/docker/library/alpine:20250108

ARG ZIG_BUNDLE=zig-linux-x86_64-0.15.0-dev.375+8f8f37fb0.tar.xz
ARG ZIG_PUBLIC_KEY=RWSGOq2NVecA2UPNdBUZykf1CCb147pkmdtYxgb3Ti+JO/wCYvhbAb/U
ARG USERNAME
ARG USER_UID
ARG USER_GID

RUN apk add --no-cache curl bash minisign vim make

WORKDIR /zig

COPY ${ZIG_BUNDLE}.minisig /zig/

RUN curl -sSLO "https://ziglang.org/builds/${ZIG_BUNDLE}" \
 && minisign -V -m "${ZIG_BUNDLE}" -P "${ZIG_PUBLIC_KEY}" \
 && tar -xf "${ZIG_BUNDLE}" \
 && mv "${ZIG_BUNDLE%.tar.xz}"/* . \
 && rmdir "${ZIG_BUNDLE%.tar.xz}" \
 && rm "${ZIG_BUNDLE}" \
 && rm "${ZIG_BUNDLE}.minisig"

ENV PATH="/zig:${PATH}"

RUN addgroup --gid "${USER_GID}" "${USERNAME}"
RUN adduser --disabled-password --uid "${USER_UID}" --ingroup "${USERNAME}" --home "/home/${USERNAME}" "${USERNAME}"

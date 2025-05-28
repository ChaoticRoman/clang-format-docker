ARG ALPINE_TAG=latest

FROM alpine:${ALPINE_TAG} AS builder

ARG VERSION
ARG BRANCH=release/${VERSION}.x

RUN set -x \
    && apk update \
    && apk add --no-cache git cmake ninja g++ python3 \
    && git clone --depth 1 --branch $BRANCH https://github.com/llvm/llvm-project.git /src \
    && ln -s ../../clang /src/llvm/tools/ \
    && mkdir /src/llvm/_build \
    && cd /src/llvm/_build \
    && cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-static-libgcc" -DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++" \
    && ninja clang-format \
    && strip bin/clang-format


FROM alpine:latest

RUN apk add --no-cache python3 git

COPY --from=builder /src/llvm/_build/bin/clang-format /usr/bin/
COPY --from=builder /src/clang/tools/clang-format/clang-format-diff.py /usr/bin/clang-format-diff

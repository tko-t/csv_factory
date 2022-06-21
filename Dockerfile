FROM ruby:3.1-alpine

ARG APP_NAME
ARG WORKDIR
ARG USER_NAME=$APP_NAME
ARG USER_ID=1000
ARG GROUP_NAME=$APP_NAME
ARG GROUP_ID=1000

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ENV PATH=${WORKDIR}:${PATH}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        g++ \
        gcc \
        git \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        mysql-client \
        mysql-dev \
        nodejs \
        tzdata && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev && \
    apk del build-packs

WORKDIR $WORKDIR

COPY ./Gemfile* $WORKDIR/

# ローカル環境のIDと合わせたらいいと思う
RUN addgroup -S -g $GROUP_ID $GROUP_NAME && \
    adduser -u $USER_ID -G $USER_NAME -D $USER_NAME

RUN chown -R $USER_NAME:$GROUP_NAME $WORKDIR/*

USER $USER_NAME

RUN bundle install

COPY ./ $WORKDIR

# docker-composeで使う前提なのでCMDなし

FROM ruby:2.4.1-slim
MAINTAINER Talkdesk DevOps <devops@talkdesk.com>

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ARG BUNDLE_GITHUB__COM

RUN set -x \
    && BUILD_DEPENDENCIES='build-essential git' \
    && RUNTIME_DEPENDENCIES='curl' \
    && NPROC=$(nproc --all) \
    && apt-get update \
    && apt-get install -y --force-yes ${BUILD_DEPENDENCIES} ${RUNTIME_DEPENDENCIES} \
    && gem install bundler \
    && bundle install -j${NPROC} \
    && apt-get purge -y --force-yes ${BUILD_DEPENDENCIES} \
    && apt-get autoremove -y --force-yes \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp Gemfile.lock Gemfile.lock.tmp

COPY . $APP_HOME

RUN cp Gemfile.lock.tmp Gemfile.lock

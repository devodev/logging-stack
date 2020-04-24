FROM fluent/fluentd:v1.10-debian-1 AS build

ARG FLUENTD_PLUGINS=
ENV BUILD_DEPS sudo make gcc g++ libc-dev

# Use root account to use apt
USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends $BUILD_DEPS
RUN test -z "$FLUENTD_PLUGINS" || sudo gem install $FLUENTD_PLUGINS

FROM fluent/fluentd:v1.10-debian-1
COPY --from=build /usr/local/lib/ruby/gems/2.6.0 /usr/local/lib/ruby/gems/2.6.0

ARG FLUENTD_VERSION="latest"
FROM fluent/fluentd:${FLUENTD_VERSION} AS build

ARG FLUENTD_PLUGINS=
ENV BUILD_DEPS sudo make gcc g++ libc-dev

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends $BUILD_DEPS \
 && test -z "$FLUENTD_PLUGINS" || sudo gem install $FLUENTD_PLUGINS

FROM fluent/fluentd:${FLUENTD_VERSION}
COPY --from=build /usr/local/lib/ruby/gems/2.6.0 /usr/local/lib/ruby/gems/2.6.0

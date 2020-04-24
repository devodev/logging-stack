FROM my-base-fluentd:latest

COPY ./fluentd/conf/fluent.conf /fluentd/etc/

USER fluent

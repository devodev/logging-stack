# logging-stack

## Content

### Kafka Stack

- zookeeper X2
- kafka broker X3
- kafka manager
  - [UI - localhost:9000](http://localhost:9000)
- kafka-schema-registry
- kafka-rest
- kafka-topics-ui
  - [UI - localhost:8000](http://localhost:8000)
- kafka-exporter
  - prometheus metrics: true

### Fluentd Stack

- fluentd
  - prometheus metrics: true

### Monitoring Stack

- prometheus
  - [UI - localhost:9090](http://localhost:9090)
  - prometheus metrics: true
  - targets:
    - prometheus (itself)
    - grafana
    - loki
    - promtail
    - kafka (kafka-exporter)
    - fluentd
- loki
  - prometheus metrics: true
- promtail
  - [UI - localhost:9080](http://localhost:9080)
  - prometheus metrics: true
  - targets:
    - system (varlogs)
- grafana
  - [UI - localhost:3000](http://localhost:3000)
  - prometheus metrics: true
  - datasources:
    - Prometheus
    - Loki
  - dashboards:
    - Grafana metrics
    - Kafka Exporter Overview
    - Prometheus Stats
    - Prometheus 2.0 Stats

## Usage

### Start

Start all containers in the correct order

```bash
for stack in stack-*; do pushd $stack; docker-compose up -d --build; popd; done
```

### Stop

Stop all containers in reverse order

```bash
for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose stop; popd; done
```

### Stop and Clean

> To delete volumes, add the --volumes flag to the down command

Same as above, but also remove:

- Containers for services defined in the Compose file
- Networks defined in the `networks` section of the Compose file
- The default network, if one is used

```bash
for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose down --remove-orphans; popd; done
```

## Docker Compose General Usage

Start cluster in detached mode

```bash
docker-compose up -d
```

Inspect to see if all is well

```bash
docker ps -a
```

Follow the logging output of a running service, for example the kafka-rest service

```bash
docker logs $(docker ps -q -f name=kafka-rest|head -n1) -f
```

Restart a service after a config update, for example the kafka-topics-ui service.

> All dependent service will also be restarted if their config changed

```bash
docker-compose up -d kafka-topics-ui
```

Send signal to running service instance, for example reload on fluentd instance:

```bash
docker kill -s USR2 $(docker ps -q -f name=logging-stack_fluentd)
```

Stop the cluster containers

```bash
docker-compose stop
```

Remove containers, network and volume declare by the docker-compose file.

> Use --remove-orphans when removing/updating config service name

```bash
docker-compose down [--remove-orphans]
```

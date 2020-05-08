# logging-stack

## Content
### Kafka Stack
- zookeeper
- kafka broker
- kafka manager
- kafka-schema-registry
- kafka-rest
- kafka-topics-ui
  - interface: http://localhost:8000/#/
- kafka-exporter

### Fluentd Stack
- fluentd
### Monitoring Stack
- prometheus
  - interface: http://localhost:9090/graph
- loki
- promtail
- grafana
  - interface: http://localhost:3000
#### Configured datasources
- Prometheus
- loki

## Usage
### Start
Start all containers in the correct order
```
$ for stack in stack-*; do pushd $stack; docker-compose up -d --build; popd; done
```

### Stop
Stop all containers in reverse order
```
$ for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose stop; popd; done
```
### Stop and Clean
> To delete volumes, add the --volumes flag to the down command

Same as above, but also remove:
- Containers for services defined in the Compose file
- Networks defined in the `networks` section of the Compose file
- The default network, if one is used
```
$ for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose down --remove-orphans; popd; done
```

## Docker Compose General Usage
Start cluster in detached mode
```
$ docker-compose up -d
```

Inspect to see if all is well
```
$ docker ps -a
```

Follow the logging output of a running service, for example the kafka-rest service
```
$ docker logs $(docker ps -q -f name=kafka-rest|head -n1) -f
```

Restart a service after a config update, for example the kafka-topics-ui service.

> All dependent service will also be restarted if their config changed

```
$ docker-compose up -d kafka-topics-ui
```

Send signal to running service instance, for example reload on fluentd instance:
```
$ docker kill -s USR2 $(docker ps -q -f name=logging-stack_fluentd)
```

Stop the cluster containers
```
$ docker-compose stop
```

Remove containers, network and volume declare by the docker-compose file.

> Use --remove-orphans when removing/updating config service name

```
$ docker-compose down [--remove-orphans]
```

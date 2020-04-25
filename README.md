# logging-stack

## Content
### Kafka Stack
- zookeeper
- kafka broker
- kafka manager
- kafka-schema-registry
- kafka-rest
- kafka-topics-ui
- kafka-exporter
### Fluentd Stack
- fluentd
### Monitoring Stack
- prometheus
- grafana
#### Configured datasources
- Prometheus
- Grafana
- Kafka broker

## Usage
### Start
- Start all containers in the correct order to correctly handle dependencies
  ```
  $ for stack in stack-*; do pushd $stack; docker-compose up -d; popd; done
  ```
- Navigate to localhost:3000</br>
- Add prometheus datasource</br>
- On home, click on `Create a data source`</br>
- Select Prometheus from the list</br>
- Under the settings tab, fill the form using the following and save</br>
  ```
  Name: Prometheus
  URL:  http://prometheus:9090
  ```
- Click on the dashboard tab and import all listed dashboard

### Stop
Stop all containers in reverse order to make sure dependencies arre correctly handled
```
$ for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose stop; popd; done
```
### Stop and Clean
> DANGER: All data saved in volumes will be lost

Same as above, but also remove all containers, volumes and networks declared
```
$ for stack in $(ls -d stack-* | tac); do pushd $stack; docker-compose down; popd; done
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

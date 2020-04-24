# logging-stack

## Development

### Docker Compose Usage
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

> All dependent service will also be restarted if their config has also changed.

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

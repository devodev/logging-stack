# logging-stack

## Development

### Docker Compose Usage
Start local docker registry
```
$ docker run -d \
             -p 5000:5000 \
             --restart=always \
             --name local \
             registry:2
```

Build fluentd image and push to local registry
```
$ docker build -t my-base-fluentd:latest -f ./Dockerfile.base ./
$ docker build -t my-fluentd:latest -f ./Dockerfile.dev ./
$ docker tag my-fluentd:latest localhost:5000/my-fluentd:latest
$ docker push localhost:5000/my-fluentd:latest
```

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

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

Send signal to running service instance, for example reload on fluentd instance:
```
$ docker kill -s USR2 $(docker ps -q -f name=logging-stack_fluentd)
```

Remove compose containers
```
$ docker rm $(docker ps -a -q -f name=logging-stack)
```

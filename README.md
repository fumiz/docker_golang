```
docker run -v /path/to/private/key:/keys/key -v /path/to/repository:/gopath/src/example.com/hello fumiz/golang:1.5.1 /bin/sh -c "go get ./... && cd /gopath/src/example.com/hello go build -o hello.exe ./*.go"
```

if your repository is in private, you can add keys to ssh-agent.

```
-v /path/to/private/key:/keys/key
```

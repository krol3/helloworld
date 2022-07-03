# helloworld

## Setting project

### Golang
go get k8s.io/client-go@v0.23.8
>> See versions: https://github.com/kubernetes/client-go/tags

go mod tidy

>> Sample k8s client: https://github.com/kubernetes/client-go/tree/master/examples
### Kubernetes

kind create cluster --name k8s-local --image kindest/node:v1.24.0
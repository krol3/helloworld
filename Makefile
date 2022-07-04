VERSION := $(shell git describe --tags --always)
LDFLAGS := -ldflags "-s -w -X=main.version=$(VERSION)"

GOPATH := $(shell go env GOPATH)
GOBIN := $(GOPATH)/bin
GOSRC := $(GOPATH)/src

.PHONY: build
build:
	go build -o app $(LDFLAGS) ./

image:
	docker build -t krol/go-helloworld .

sbom-image:
	trivy sbom --artifact-type image --sbom-format cyclonedx --output ./outputs/sbom-image.json krol/go-helloworld

cis-ssc:
	docker run aquasec/chain-bench scan -v --repository-url https://github.com/krolval/helloworld --access-token xxx

trivy-sbom-gh:
	trivy image --output ./outputs/sbom-image-gh.json --format  github krol/go-helloworld

push-sbom-gh:
	curl \
	-X POST \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: token ghp_xxxx" \
	https://api.github.com/repos/krol3/helloworld/dependency-graph/snapshots \
	-d @outputs/sbom-image-gh-edit.json
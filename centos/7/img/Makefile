all: push

PWD = $(shell cd ../; pwd)
DIR = $(notdir $(PWD))
TAG = $(DIR)

PREFIX = k8s-registry.zeusis.com:32000/zs/centos

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

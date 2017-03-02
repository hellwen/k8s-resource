all: push

APP_PWD = $(shell cd ../../; pwd)
APP = $(notdir $(APP_PWD))
TAG_PWD = $(shell cd ../; pwd)
TAG = $(notdir $(TAG_PWD))

PREFIX = k8s-registry.zeusis.com:32000/zs/$(APP)

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

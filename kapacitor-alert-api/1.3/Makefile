all: push

TAG = 1.3
PREFIX = k8s-registry.zeusis.com:32000/zs/kapacitor-alert-api

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

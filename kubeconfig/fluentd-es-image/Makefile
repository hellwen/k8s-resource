all: push

TAG = latest

PREFIX = k8s-registry.zeusis.com:32000/zs/fluentd-es

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

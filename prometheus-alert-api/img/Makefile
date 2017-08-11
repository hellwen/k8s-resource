all: push

TAG = v1.3.10
PREFIX = k8s-registry.zeusis.com:32000/zs/prometheus-alert-api

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

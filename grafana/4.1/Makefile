all: push

TAG = 4.1.001
PREFIX = k8s-registry.zeusis.com:32000/grafana

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

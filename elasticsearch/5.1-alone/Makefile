all: push

TAG = 5.1-alone.001
PREFIX = k8s-registry.zeusis.com:32000/elasticsearch

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

all: push

TAG = 1.2-pseudo.001
PREFIX = k8s-registry.zeusis.com:32000/hbase

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

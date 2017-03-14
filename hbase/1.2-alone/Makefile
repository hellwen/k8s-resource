all: push

TAG = 1.2-alone
PREFIX = k8s-registry.zeusis.com:32000/zs/hbase

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

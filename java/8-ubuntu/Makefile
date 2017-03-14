all: push

TAG = 8-ubuntu
PREFIX = k8s-registry.zeusis.com:32000/zs/java

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

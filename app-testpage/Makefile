all: push

TAG = 0.1
PREFIX = k8s-registry.zeusis.com:32000/testpage

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

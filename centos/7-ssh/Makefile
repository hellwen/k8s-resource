all: push

TAG = 7-ssh.001
PREFIX = k8s-registry.zeusis.com:32000/centos

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

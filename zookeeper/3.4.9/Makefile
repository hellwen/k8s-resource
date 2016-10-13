all: push

TAG = 3.4.9.001
PREFIX = 10.0.12.203:32000/zookeeper

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

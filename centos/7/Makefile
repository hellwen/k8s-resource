all: push

TAG = 7.002
PREFIX = 119.29.43.190:32000/centos

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

all: push

TAG = 1.2.001
PREFIX = 10.0.12.203:32000/hbase

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

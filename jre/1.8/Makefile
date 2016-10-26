all: push

TAG = 1.8.001
PREFIX = 10.0.12.207:32000/jre

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

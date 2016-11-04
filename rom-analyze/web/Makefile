all: push

TAG = 1.0.001
PREFIX = 10.0.12.207:32000/rom-web

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

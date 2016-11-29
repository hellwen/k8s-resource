all: push

TAG = 9.6.001
PREFIX = 10.0.12.207:32000/postgres

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

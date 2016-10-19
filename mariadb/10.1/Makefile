all: push

TAG = 10.1.001
PREFIX = 10.0.12.203:32000/mariadb

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)

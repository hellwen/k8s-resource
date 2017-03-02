all: pull

ifdef IMG
	echo "pulling image: $(IMG)"
endif

pull:
	docker pull $(IMG)
	docker tag $(IMG) k8s-registry.zeusis.com:32000/$(IMG)
	docker push k8s-registry.zeusis.com:32000/$(IMG)

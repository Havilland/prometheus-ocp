SHELL := /bin/bash

build:
	docker build . -t prometheus-ocp

run:
	docker run --network="host" --dns="$(shell resolvectl | grep 'Current DNS' | awk '{print $$4}')" -v $$HOME/.kube:/root/.kube prometheus-ocp
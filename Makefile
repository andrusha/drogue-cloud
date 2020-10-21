all: build push

CONTAINER_REGISTRY=quay.io/use-your-own


clean:
	cargo clean


build:
	cargo build --release
	docker build . -f http-endpoint/Dockerfile -t $(CONTAINER_REGISTRY)/http-endpoint:latest
	docker build . -f mqtt-endpoint/Dockerfile -t $(CONTAINER_REGISTRY)/mqtt-endpoint:latest
	docker build . -f influxdb-pusher/Dockerfile -t $(CONTAINER_REGISTRY)/influxdb-pusher:latest
	docker build . -f console-backend/Dockerfile -t $(CONTAINER_REGISTRY)/console-backend:latest
	docker build console-frontend/. -f console-frontend/Dockerfile -t $(CONTAINER_REGISTRY)/console-frontend:latest


push:
	docker push $(CONTAINER_REGISTRY)/http-endpoint:latest
	docker push $(CONTAINER_REGISTRY)/mqtt-endpoint:latest
	docker push $(CONTAINER_REGISTRY)/influxdb-pusher:latest
	docker push $(CONTAINER_REGISTRY)/console-backend:latest
	docker push $(CONTAINER_REGISTRY)/console-frontend:latest


.PHONY: all clean build push

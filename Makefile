IMAGE_TAG := local/amazonlinux-glue3
CONTAINER_NAME := "glue-dev"
PROJECT_DIR := $(realpath ./notebooks)
DATA_DIR := $(realpath ./data)

.PHONY: build

build:
	echo "Building container image ${IMAGE_TAG}" && \
	DOCKER_BUILDKIT=0 docker build --progress plain -t ${IMAGE_TAG} -f docker/Dockerfile docker/src

create:
	@docker create \
		--name ${CONTAINER_NAME} \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		-p 8888:8888 \
		-p 4040:4040 \
		${IMAGE_TAG} /app/start_jupyter.sh

start:
	@docker start ${CONTAINER_NAME}

stop:
	@docker stop ${CONTAINER_NAME}

# Start a shell without activating the virtual environment
root-shell:
	@docker exec -it -u root ${CONTAINER_NAME} sh

# Start a user shell without activating the Python virtual environment
shell:
	docker exec -it ${CONTAINER_NAME} sh

# Start a Python REPL
python:
	docker exec -it ${CONTAINER_NAME} /app/start_python.sh

# Start a PySpark REPL
pyspark:
	docker exec -it ${CONTAINER_NAME} /app/start_pyspark.sh

clean: clean-images

clean-images: clean-instances
	@echo "Deleting container image ${IMAGE_TAG}"
	@docker image ls -q ${IMAGE_TAG} | xargs docker image rm

clean-instances:
	@echo "Cleaning container instances"
	@docker ps -q -f ancestor=${IMAGE_TAG} | xargs docker stop
	@docker ps -aq -f ancestor=${IMAGE_TAG} | xargs docker rm

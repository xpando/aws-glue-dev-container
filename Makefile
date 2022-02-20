DOCKER_IMAGE_NAME := local/amazonlinux-glue3
PROJECT_DIR := $(realpath ./notebooks)
DATA_DIR := $(realpath ./data)

root:
	@docker run --rm -it \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		-u root \
		-e NO_ACTIVATE_VENV=true ${DOCKER_IMAGE_NAME} bash

# Start a shell without activating the virtual environment
shell:
	@docker run --rm -it \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		-e NO_ACTIVATE_VENV=true ${DOCKER_IMAGE_NAME} bash

# Start a shell with the virtual environment activated
venv:
	@docker run --rm -it \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		${DOCKER_IMAGE_NAME} bash

# Start a Python REPL
python:
	@docker run --rm -it \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		${DOCKER_IMAGE_NAME} python

# Start a PySpark REPL
pyspark:
	@docker run --rm -it \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		-p 4040:4040 \
		${DOCKER_IMAGE_NAME} pyspark

# Start the Jupyter notebook server
jupyter:
	@docker run --rm -d \
		--name dw-dev \
		--mount type=bind,source=${PROJECT_DIR},target=/project \
		--mount type=bind,source=${DATA_DIR},target=/data \
		-p 4040:4040 \
		-p 8080:80 \
		-e PYSPARK_DRIVER_PYTHON=jupyter \
		-e PYSPARK_DRIVER_PYTHON_OPTS="lab --config /app/jupyter/jupyter_lab_config.py" \
		${DOCKER_IMAGE_NAME} pyspark

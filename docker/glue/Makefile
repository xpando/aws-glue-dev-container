DEFAULT_GOAL := image

image:
	@docker build -t local/amazonlinux-glue3 .

# Lauch a Jupyter notebook server
jupyter:
	@docker run --rm -d \
		--name glue-dev \
		-p 8080:80 \
		-p 4040:4040 \
		-e PYSPARK_DRIVER_PYTHON=jupyter \
		-e PYSPARK_DRIVER_PYTHON_OPTS="lab --config /app/jupyter/jupyter_lab_config.py" \
		local/amazonlinux-glue3 pyspark

# Start a shell without activating the virtual environment
root:
	@docker run --rm -it -u root -e NO_ACTIVATE_VENV=true local/amazonlinux-glue3 bash

# Start a user shell without activating the Python virtual environment
shell:
	@docker run --rm -it -e NO_ACTIVATE_VENV=true local/amazonlinux-glue3 bash

# Start a shell with the virtual environment activated
venv:
	@docker run --rm -it local/amazonlinux-glue3 bash

# Start a Python REPL
python:
	@docker run --rm -it local/amazonlinux-glue3 python

# Start a PySpark REPL
pyspark:
	@docker run --rm -it -p 4040:4040 local/amazonlinux-glue3 pyspark

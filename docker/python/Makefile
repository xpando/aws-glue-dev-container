DEFAULT_GOAL := image

image:
	@docker build -t local/amazonlinux-python37 .

# Start a shell without activating the virtual environment
shell:
	@docker run --rm -it -e NO_ACTIVATE_VENV=true local/amazonlinux-python37 bash

# Start a shell with the virtual environment activated
venv:
	@docker run --rm -it local/amazonlinux-python37 bash

# Start a Python REPL
python:
	@docker run --rm -it local/amazonlinux-python37 python

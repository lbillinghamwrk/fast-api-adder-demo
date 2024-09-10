IMAGE_NAME=fast-api-adder-demo-img
CONTAINER_NAME=fast_api_adder_demo

PHONY: install-local
install-local:
	poetry install --only main

.PHONY: install-dev
install-dev:
	poetry install --with dev

.PHONY: lint
lint:
	poetry run black --diff --check fast_api_adder_demo tests
	poetry run ruff check fast_api_adder_demo tests

.PHONY: format
format:
	poetry run black fast_api_adder_demo tests
	poetry run ruff check --fix fast_api_adder_demo tests

.PHONY: test
test:
	poetry run pytest

.PHONY: run-local-dev
run-local-dev:
	poetry run fastapi dev "fast_api_adder_demo/main.py" --port "8181"

.PHONY: build-image
build-image:
	docker image build -t $(IMAGE_NAME) --platform linux/amd64 .

.PHONY: run-in-container
run-in-container:
	docker container rm -f $(CONTAINER_NAME)
	docker run --platform linux/amd64 -p 8181:80 --name $(CONTAINER_NAME) $(IMAGE_NAME)

PHONY: shell-into-container
shell-into-container:
	docker container rm -f $(CONTAINER_NAME)
	docker run -a stdin -a stdout --platform linux/amd64 --name $(CONTAINER_NAME) -i -t --entrypoint /bin/bash $(IMAGE_NAME)

.PHONY: help

IMAGE?=codeserver-notebook
SHELL:=bash
PACKAGE:=jupyter_codeserver_proxy

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@echo "code-server proxy"
	@echo "================="
	@echo
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: build-package build-image ## build the package and the image

build-package: ## build the python package
	python setup.py bdist_wheel

build-image: DARGS?=
build-image: ## build the latest image
	docker build $(DARGS) --rm --force-rm -t $(IMAGE):latest .
	@echo -n "Built image size: "
	@docker images $(IMAGE):latest --format "{{.Size}}"

clean: ## remove python package target dirs
	rm -rf ./build
	rm -rf ./dist
	rm -rf "./$(PACKAGE).egg-info"

dev: ARGS?=
dev: DARGS?=
dev: PORT?=8888
dev: ## run a foreground container
	docker run -it --rm -p $(PORT):8888 -e JUPYTER_ENABLE_LAB=yes $(DARGS) $(IMAGE) $(ARGS)

run: DARGS?=
run: ## run a bash in interactive mode in the stack
	docker run -it --rm $(DARGS) $(IMAGE) $(SHELL)

run-sudo: DARGS?=
run-sudo: ## run a bash in interactive mode as root in the stack
	docker run -it --rm -u root $(DARGS) $(IMAGE) $(SHELL)

upload: ## upload the package
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*
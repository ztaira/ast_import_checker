# simple makefile for a simple project

.PHONY: help docs
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## List Makefile targets
	$(info Makefile documentation)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

lint: ## Run lint
	reorder-python-imports import_checker/*.py import_checker/*/*.py
	black import_checker
	pylint import_checker
	mypy import_checker --ignore-missing-imports

publish: ## Publish new package version to pypi
	poetry publish --build --username $PYPI_USERNAME --password $PYPI_PASSWORD
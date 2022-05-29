# simple makefile for a simple project

.PHONY: help docs
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## List Makefile targets
	$(info Makefile documentation)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

lint: ## Run lint. Assumes you're running from a venv.
	# Note: this should really be put into tox, but that's overkill for now.
	reorder-python-imports ast_import_checker/*.py ast_import_checker/*/*.py
	black ast_import_checker
	pylint ast_import_checker
	mypy ast_import_checker --ignore-missing-imports

publish: ## Publish new package version to pypi
	# poetry publish --build --username $$PYPI_USERNAME --password $$PYPI_PASSWORD

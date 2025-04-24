.SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

# Variables
REGISTRY ?= docker.io
BUILD_SCRIPT := $(CURDIR)/build-all.sh
LATEST_SCRIPT := $(CURDIR)/latest-versions.sh
RUN_SCRIPT := $(CURDIR)/run.sh
ERRORS_FILE := $(CURDIR)/errors

# List of all phony targets
.PHONY: help build latest-versions run image clean test

## Show help for each target
help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
	  awk 'BEGIN {FS = ":.*?## "} {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

## Builds all Dockerfiles in the repository.
build:
	@$(BUILD_SCRIPT)

## Checks all the latest versions of the Dockerfile contents.
latest-versions:
	@$(LATEST_SCRIPT)

# Helper for required variables
check_defined = \
	$(strip $(foreach 1,$1, \
	$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
	$(if $(value $1),, \
	$(error Undefined $1$(if $2, ($2))$(if $(value @), \
	required by target `$@')))

## Run a Dockerfile from the command at the top of the file (ex. DIR=telnet).
run:
	@:$(call check_defined, DIR, directory of the Dockerfile)
	@$(RUN_SCRIPT) "$(DIR)"

## Build a Dockerfile (ex. DIR=telnet).
image:
	@:$(call check_defined, DIR, directory of the Dockerfile)
	docker build --rm --force-rm -t $(REGISTRY)/$(subst /,:,$(patsubst %/,%,$(DIR))) ./$(DIR)

## Clean up build artifacts and error files.
clean:
	@rm -f $(ERRORS_FILE)
	@echo "Cleaned up error files."

## Placeholder for test target.
test:
	@echo "No tests defined yet."
test: dockerfile shellcheck ## Runs the tests on the repository.

.PHONY: dockerfile
dockerfile: ## Tests the changes to the dockerfile build.
	@$(CURDIR)/test.sh

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		khulnasoft/shellcheck ./shellcheck.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

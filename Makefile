SHELL := /bin/bash
.PHONY: all java java_test java_build java_check rust
all: java rust

java: java_test

java_test:
	cd legacy && ./gradlew test

java_build:
	cd legacy && ./gradlew build

java_check:
	cd legacy && ./gradlew check

java_coverage_report:
	cd legacy && ./gradlew jacocoRootReport

rust:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_check_all:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_fmt:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_fmt_check:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_clippy_check_locked:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_clippy_check:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_cargo_sort_check:
	echo "This command is deprecated. Use ./risedev check instead."
	exit 1

rust_test:
	echo "This command is deprecated. Use ./risedev test instead."
	exit 1

rust_test_no_run:
	echo "This command is deprecated. Use ./risedev test instead."
	exit 1

# Note: "--skip-clean" must be used along with "CARGO_TARGET_DIR=..."
# See also https://github.com/xd009642/tarpaulin/issues/777
rust_test_with_coverage:
	echo "This command is deprecated. Use ./risedev test-cov instead."
	exit 1

rust_build:
	cd src && cargo build

rust_clean:
	cd src && cargo clean

rust_clean_build:
	cd src && cargo clean && cargo build

rust_doc:
	echo "This command is deprecated. Use ./risedev docs instead."
	exit 1

# state store bench
ss_bench_build:
	cd src && cargo build --workspace --bin ss-bench

sqllogictest:
	cargo install --git https://github.com/risinglightdb/sqllogictest-rs --features bin

export DOCKER_GROUP_NAME ?= risingwave
export DOCKER_IMAGE_TAG ?= latest
export DOCKER_COMPONENT_BACKEND_NAME ?= backend
export DOCKER_COMPONENT_FRONTEND_NAME ?= frontend

docker: docker_frontend docker_frontend_legacy docker_backend

docker_frontend_legacy:
	docker build -f docker/frontend-legacy/Dockerfile -t ${DOCKER_GROUP_NAME}/${DOCKER_COMPONENT_FRONTEND_NAME}:${DOCKER_IMAGE_TAG} .

docker_frontend:
	docker build -f docker/frontend/Dockerfile -t ${DOCKER_GROUP_NAME}/${DOCKER_COMPONENT_FRONTEND_NAME}:${DOCKER_IMAGE_TAG} .

docker_backend:
	docker build -f docker/backend/Dockerfile -t ${DOCKER_GROUP_NAME}/${DOCKER_COMPONENT_BACKEND_NAME}:${DOCKER_IMAGE_TAG} .

docker-compose:
	docker-compose -f docker/docker-compose.yml --project-directory . up

.PHONY: release
release: check
	cargo build --release

.PHONY: run
run:
	cargo run

.PHONY: check
check:
	cargo check

.PHONY: build
build: check
	cargo build

.PHONY: clean
clean:
	rm -rf target

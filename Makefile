.PHONY: $(MAKECMDGOALS)

CC=clang-13
RUSTFLAGS="-Clinker-plugin-lto -Clinker=clang-13 -Clink-arg=-fuse-ld=lld-13"

build:
	CC=${CC} RUSTFLAGS=${RUSTFLAGS} \
		cargo +nightly build --release
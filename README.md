# About

This project shows how to inline a call to C function from Rust.

# HOWTO

Build with cargo:

```bash
CC=clang-10 RUSTFLAGS="-Clinker-plugin-lto -Clinker=clang-10 -Clink-arg=-fuse-ld=lld-10" cargo build --release
# binary: ./target/release/xlanglto
```

Or build without cargo:

```bash
clang-10 mul.c -flto=thin -c -O2
ar crs libmul.a mul.o
rustc -Clinker-plugin-lto -L. -Copt-level=2 -Clinker=clang-10 -Clink-arg=-fuse-ld=lld-10 src/main.rs -o xlanglto
# binary: ./xlanglto
```

# Result

[Cross-language LTO](http://blog.llvm.org/2019/09/closing-gap-cross-language-lto-between.html) will result in an inline call to C function:

```bash
$ objdump -d ./target/release/xlanglto | grep "<multiply>:" -A3
000000000002eda0 <multiply>:
   2eda0:	89 f8                	mov    %edi,%eax
   2eda2:	0f af c6             	imul   %esi,%eax
   2eda5:	c3                   	retq
```

# Tested Dependencies

See more in github actions.

## 1.46.0
- `clang-10`
- `lld-10`
- `rustc 1.46.0`

## 1.58 
- `clang-13`
- `lld-13`
- `rustc 1.58.0`

https://doc.rust-lang.org/nightly/rustc/linker-plugin-lto.html
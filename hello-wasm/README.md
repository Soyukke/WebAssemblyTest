# Rust

### setup

これを参考とする
https://depth-first.com/articles/2020/06/29/compiling-rust-to-webassembly-a-simple-example/

### Build

```bash
cargo build --target wasm32-unknown-unknown --release
```

## setup これは試していない

https://developer.mozilla.org/ja/docs/WebAssembly/Rust_to_wasm


これが必要かもしれない
```bash
sudo apt-get install pkg-config libssl-dev
```

https://www.rust-lang.org/tools/install

```bash
cargo install wasm-pack
```

build
```bash
wasm-pack build
```

## 備考

Cargo.tomlはビルド設定のファイルでnpmにおける`package.json`的なファイル
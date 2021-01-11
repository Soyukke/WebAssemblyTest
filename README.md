# WebAssemblyのテスト

## watのコンパイル

### wabtをインストールする
https://github.com/WebAssembly/wabt


### コンパイル

```bash
wat2wasm test.wat -o test.wasm
```

## Serve

サーバーを立てないと，`application/wasm`を開くことができない．
そのため，PythonでServeする

```python
python serve.py
```

or

```julia
julia serve.jl
```

## ブラウザからのアクセス

localhost:8080/simple-wat/index.html
へアクセスする

開発者コンソールを確認すると`42`と表示されている
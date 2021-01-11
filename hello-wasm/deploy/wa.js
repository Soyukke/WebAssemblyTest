var importObject = {
  console: {
    log: function (arg) {
      console.log(arg);
    }
  }
};

WebAssembly.instantiateStreaming(
  fetch(
    '/hello-wasm/target/wasm32-unknown-unknown/release/hello_wasm.wasm'
  ),
  importObject
)
  .then(obj => {
    console.log(obj.instance.exports.add_one(15));
  });
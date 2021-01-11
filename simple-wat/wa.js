var importObject = {
  console: {
    log: function (arg) {
      console.log(arg);
    }
  }
};

WebAssembly.instantiateStreaming(fetch('/simple-wat/test.wasm'), importObject)
  .then(obj => {
    obj.instance.exports.exported_func();
  });
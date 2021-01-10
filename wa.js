var importObject = {
  console: {
    log: function (arg) {
      console.log(arg);
    }
  }
};

WebAssembly.instantiateStreaming(fetch('./test.wasm'), importObject)
  .then(obj => {
    obj.instance.exports.exported_func();
  });
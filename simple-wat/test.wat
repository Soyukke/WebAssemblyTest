(module
  ;; i32: 32bit整数 console.log で引数が i32のやつを $log
  (import "console" "log" (func $log (param i32)))
  (func (export "exported_func")
    i32.const 42
    call $log
  )
)
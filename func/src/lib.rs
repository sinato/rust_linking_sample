#[link(name = "func", kind = "static")]
// #[link(wasm_import_module = "func_lib")]
extern "C" {
    pub fn func_lib() -> i32;
}

#[no_mangle]
pub extern "C" fn func_lib2() -> i32 {
    unsafe { func_lib() }
}

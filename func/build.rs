fn main() {
    println!("cargo:rustc-link-search=/project/staticlib_cdylib_sample/c_static");
    // println!("cargo:rustc-env=LD_LIBRARY_PATH=/project/staticlib_sample/func/target/debug");
}
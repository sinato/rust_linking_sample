fn main() {
    println!("cargo:rustc-link-search=/project/staticlib_cdylib_sample/func/target/debug");
    println!("cargo:rustc-env=LD_LIBRARY_PATH=/project/staticlib_cdylib_sample/func/target/debug");
}
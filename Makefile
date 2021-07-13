target_dir = ./c_static

libfunc.ll: $(target_dir)/func.c
	@echo === source file =====================
	cat $(target_dir)/func.c
	@echo =====================================
	clang -S -emit-llvm $(target_dir)/func.c -o $(target_dir)/libfunc.ll

libfunc.bc: libfunc.ll
	llvm-as $(target_dir)/libfunc.ll

# It is also possible to create .bc from .c
# func.bc: $(target_dir)/func.c
# 	clang $(target_dir)/func.c -emit-llvm -c

libfunc.o: libfunc.bc
	llc -filetype=obj $(target_dir)/libfunc.bc

libfunc.a: libfunc.o
	ar rcs $(target_dir)/libfunc.a $(target_dir)/libfunc.o
	@echo === check symbols ===================
	nm $(target_dir)/libfunc.a
	@echo =====================================

.PHONY: clean
clean:
	rm -f \
	$(target_dir)/libfunc.ll \
	$(target_dir)/libfunc.bc \
	$(target_dir)/libfunc.o \
	$(target_dir)/libfunc.a
	cargo clean --manifest-path func/Cargo.toml
	cargo clean --manifest-path call/Cargo.toml


.PHONY: build-lib clean-lib
build-lib: libfunc.a
	cargo build --manifest-path func/Cargo.toml

clean-lib:
	cargo clean --manifest-path func/Cargo.toml

.PHONY: run
run: clean-lib build-lib
	cargo run --manifest-path call/Cargo.toml
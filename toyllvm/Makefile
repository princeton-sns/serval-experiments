LLVM_ROSETTE ?= ../llvm-rosette/llvm-rosette

all: test.ll.rkt

$(LLVM_ROSETTE):
	make -C ../llvm-rosette

test.ll: test.c
	clang -O3 -S -emit-llvm test.c

test.ll.rkt: test.ll $(LLVM_ROSETTE)
	$(LLVM_ROSETTE) $< > $@

verify: test.ll.rkt
	raco test spec.rkt

.PHONY: clean
clean:
	rm -rf test.ll test.ll.rkt

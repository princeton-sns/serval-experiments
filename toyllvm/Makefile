test.ll: test.c
	clang -c -S -emit-llvm test.c

verify: # test.ll.rkt // currently assembly is just hardcoded
	raco test spec.rkt

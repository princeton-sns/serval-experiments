LLVM_ROSETTE ?= racket $(shell ./find-serval.rkt)/serval/bin/serval-llvm.rkt

all: test.ll.rkt

test.ll: test.c
	clang -O3 -S -emit-llvm test.c

test.elf: test.c
	clang -g -nostartfiles -o $@ $<

test.map: test.elf
	nm --print-size --numeric-sort $< > $@

test.map.rkt: test.map
	echo "#lang reader serval/lang/nm" > $@ && \
		cat $< >> $@

test.globals.rkt: test.elf
	echo "#lang reader serval/lang/dwarf" > $@
	objdump --dwarf=info $< >> $@

test.ll.rkt: test.ll
	$(LLVM_ROSETTE) < $< > $@

verify: test.ll.rkt test.globals.rkt test.map.rkt
	raco test spec.rkt

.PHONY: clean
clean:
	rm -rf test.ll test.ll.rkt test.elf test.map test.map.rkt test.globals.rkt

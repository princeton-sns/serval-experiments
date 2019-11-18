LLVM_ROSETTE ?= racket $(shell ./find-serval.rkt)/serval/bin/serval-llvm.rkt

all: toyrust.ll.rkt

toyrust: src/main.rs
	rustc --edition=2018 --crate-name toyrust $< --crate-type bin -C opt-level=3 -C panic=abort -C debuginfo=2 -Clink-arg=-nostartfiles --emit=link

toyrust.ll: src/main.rs
	rustc --edition=2018 --crate-name toyrust $< --crate-type bin -C opt-level=3 -C panic=abort -C debuginfo=0 -Clink-arg=-nostartfiles --emit=llvm-ir

toyrust.map: toyrust
	nm --print-size --numeric-sort $< > $@

toyrust.map.rkt: toyrust.map
	echo "#lang reader serval/lang/nm" > $@ && \
		cat $< >> $@

toyrust.globals.rkt: toyrust
	echo "#lang reader serval/lang/dwarf" > $@
	objdump --dwarf=info $< >> $@

toyrust.ll.rkt: toyrust.ll
	$(LLVM_ROSETTE) < $< > $@

verify: toyrust.ll.rkt toyrust.globals.rkt toyrust.map.rkt
	raco test spec.rkt

.PHONY: clean
clean:
	rm -rf toyrust.ll toyrust.ll.rkt toyrust.elf toyrust.map toyrust.map.rkt toyrust.globals.rkt

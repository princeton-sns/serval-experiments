LLVM_ROSETTE ?= racket $(shell ./find-serval.rkt)/serval/bin/serval-llvm.rkt

all: toyrust.ll.rkt

toyrust.o: src/main.rs
	rustc --edition=2018 --crate-name toyrust $< --crate-type lib -C opt-level=3 -C panic=abort -C debuginfo=1 --emit=obj -C relocation-model=static -C link-dead-code

toyrust.ll: src/main.rs
	rustc --edition=2018 --crate-name toyrust $< --crate-type lib -C opt-level=3 -C panic=abort -C debuginfo=0 -Clink-arg=-nostartfiles --emit=llvm-ir -C relocation-model=static -C link-dead-code

toyrust.map: toyrust.o
	nm --print-size --numeric-sort $< > $@

toyrust.map.rkt: toyrust.map
	echo "#lang reader serval/lang/nm" > $@ && \
		cat $< >> $@

toyrust.globals.rkt: toyrust.o
	echo "#lang reader serval/lang/dwarf" > $@
	objdump --dwarf=info $< >> $@

toyrust.ll.rkt: toyrust.ll
	$(LLVM_ROSETTE) < $< > $@

verify: toyrust.ll.rkt toyrust.globals.rkt toyrust.map.rkt
	raco test spec.rkt

.PHONY: clean
clean:
	rm -rf toyrust.ll toyrust.ll.rkt toyrust.o toyrust.map toyrust.map.rkt toyrust.globals.rkt

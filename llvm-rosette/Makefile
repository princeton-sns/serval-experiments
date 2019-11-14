all: llvm-rosette

llvm-rosette: main.cc RosetteEmitter.cc RosetteEmitter.h
	clang++ `llvm-config --libs --system-libs --cxxflags` RosetteEmitter.cc main.cc -o $@

clean:
	rm -rf llvm-rosette

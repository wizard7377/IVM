cg ?= chez
idris-llvm ?= "https://github.com/wizard7377/LLVM.git"
deps: 
	pack install llvm
build: deps
	idris2 --cg $(cg) --build LLVMVM.ipkg

install: build
	idris2 --cg $(cg) --install LLVMVM.ipkg

test: install
	@echo "Building and running LLVM tests..."
	idris2 --build test.ipkg
	@echo "Running test executable..."
	./build/exec/llvm-test

clean-test:
	@echo "Cleaning test build artifacts..."
	rm -rf build/exec/llvm-test
	idris2 --clean test.ipkg
clean:
	pack clean

docs: install
	idris2 --mkdoc llvm.ipkg
.PHONY: build install test clean-test clean deps
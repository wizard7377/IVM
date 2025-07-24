cg ?= chez
idris-llvm ?= "https://github.com/wizard7377/LLVM.git"
deps: clean-deps
	git clone $(idris-llvm)
	@mv ./LLVM ./depends

clean-deps: 
	@echo "Cleaning dependencies..."
	@rm -rf depends 
	@rm -rf LLVM
	@mkdir depends
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

docs: install
	idris2 --mkdoc llvm.ipkg
.PHONY: build install test clean-test deps
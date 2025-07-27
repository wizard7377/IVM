cg ?= chez
idris-llvm ?= "https://github.com/wizard7377/LLVM.git"
sources = $(wildcard src/*.idr)
loglevel ?= 0
deps: 
	pack install llvm
build: $(sources)
	idris2 --cg $(cg) --build LLVMVM.ipkg

#./idrisvm-llvm --log $(loglevel) --dumpvmcode samples/$@.vm --cg llvmvm $<

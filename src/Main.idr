module Main

import Core.Context
import Compiler.Common
import Idris.Driver
import Idris.Syntax
import Data.String
import VM.Run
compile :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (tmpDir : String) -> (execDir : String) ->
  ClosedTerm -> (outfile : String) -> Core (Maybe String)
compile = compileInternal

execute :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (execDir : String) -> ClosedTerm -> Core ()
execute = executeInternal

llvmvmCg : Codegen
llvmvmCg = llvmvmCgInternal

main : IO ()
main = mainInternal

module Main

import Core.Context
import Compiler.Common
import Idris.Driver
import Idris.Syntax
import Data.String
compile :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (tmpDir : String) -> (execDir : String) ->
  ClosedTerm -> (outfile : String) -> Core (Maybe String)
compile syn defs tmp dir term file
  = coreLift $ putStrLn "Hello, world!" >> pure Nothing

execute :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (execDir : String) -> ClosedTerm -> Core ()
execute defs syn dir term = coreLift $ putStrLn "Not implemented yet."

llvmvmCg : Codegen
llvmvmCg = MkCG compile execute Nothing Nothing

main : IO ()
main = mainWithCodegens [("llvmvm", llvmvmCg)]

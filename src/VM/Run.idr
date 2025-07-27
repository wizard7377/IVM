module VM.Run

import Core.Context
import Compiler.Common
import Idris.Driver
import Idris.Syntax
import Data.String
import Compiler.VMCode
import Data.LLVM
import System
import VM.Translate
%hide Data.LLVM.Core.Name
public export
buildInternal : Ref Ctxt Defs --TODO add option to build only the .lua file
     -> String
     -> ClosedTerm
     -> String {-relative-}
     -> Core Bytecode 
buildInternal defs tmpDir tm file = do
    compileData <- getCompileData {c=defs} False VMCode tm
    let vc : List (Name, VMDef) = compileData.vmcode
    let vmDefs : List VMDef = snd <$> vc
    throw (InternalError $ ("This works too?" ++ (concat $ show <$> vmDefs)))
    pure bytecode
public export
compileInternal :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (tmpDir : String) -> (execDir : String) ->
  ClosedTerm -> (outfile : String) -> Core (Maybe String)
compileInternal defs syn tmp dir term file
  = do 
    compileData <- getCompileData {c=defs} False VMCode term
    let vc : List (Name, VMDef) = compileData.vmcode
    let vmDefs : List VMDef = snd <$> vc
    throw (InternalError $ concat $ show <$> vmDefs)
    pure Nothing

public export
executeInternal :
  Ref Ctxt Defs -> Ref Syn SyntaxInfo ->
  (execDir : String) -> ClosedTerm -> Core ()
executeInternal defs syn dir term = do
    mod <- buildInternal defs dir term "main"
    let lm : List (LModule) = snd <$> mod.modules
    let ll : List (VString) = encode <$> lm
    let m : IO _ = putStrLn ("echo" ++ show ll)
    _ <- coreLift m
    pure ()

public export
llvmvmCgInternal : Codegen
llvmvmCgInternal = MkCG compileInternal executeInternal Nothing Nothing

public export
mainInternal : IO ()
mainInternal = mainWithCodegens [("ivm-vm", llvmvmCgInternal)]
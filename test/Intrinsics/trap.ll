; RUN: %llvmas %s -o=%t.bc
; RUN: rm -rf %t.klee-out
; RUN: %klee -exit-on-error --output-dir=%t.klee-out -disable-opt %t.bc
; ModuleID = 'atomics.cpp'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %args) #0 {
entry:
  %a = alloca i32, align 4
  store i32 12, i32* %a
  %0 = load i32, i32* %a
  %cond = icmp eq i32 %0, 12
  br i1 %cond, label %assert.cont, label %assert.block
assert.cont:
  ret i32 0
assert.block:
  call void @llvm.trap()
  unreachable
}

declare void @llvm.trap() noreturn nounwind

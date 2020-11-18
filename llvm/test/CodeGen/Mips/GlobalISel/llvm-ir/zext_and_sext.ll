; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

define i64 @zext(i32 %x) {
; MIPS32-LABEL: zext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    move $2, $4
; MIPS32-NEXT:    ori $3, $zero, 0
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %conv = zext i32 %x to i64
  ret i64 %conv
}

define i64 @sext(i32 %x) {
; MIPS32-LABEL: sext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    move $2, $4
; MIPS32-NEXT:    sra $3, $2, 31
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %conv = sext i32 %x to i64
  ret i64 %conv
}

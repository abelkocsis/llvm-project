; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; XFAIL: *
; RUN: opt -S -dse -enable-dse-memoryssa < %s | FileCheck %s

declare void @llvm.memcpy.p0i8.p0i8.i8(i8* nocapture, i8* nocapture, i8, i1) nounwind
declare void @llvm.memmove.p0i8.p0i8.i8(i8* nocapture, i8* nocapture, i8, i1) nounwind
declare void @llvm.memset.p0i8.i8(i8* nocapture, i8, i8, i1) nounwind

define void @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret void
;
  %A = alloca i8
  %B = alloca i8

  store i8 0, i8* %A  ;; Written to by memcpy

  call void @llvm.memcpy.p0i8.p0i8.i8(i8* %A, i8* %B, i8 -1, i1 false)

  ret void
}

define void @test2() {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret void
;
  %A = alloca i8
  %B = alloca i8

  store i8 0, i8* %A  ;; Written to by memmove

  call void @llvm.memmove.p0i8.p0i8.i8(i8* %A, i8* %B, i8 -1, i1 false)

  ret void
}

define void @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    ret void
;
  %A = alloca i8
  %B = alloca i8

  store i8 0, i8* %A  ;; Written to by memset

  call void @llvm.memset.p0i8.i8(i8* %A, i8 0, i8 -1, i1 false)

  ret void
}

declare void @llvm.memcpy.element.unordered.atomic.p0i16.p0i16.i16(i16* nocapture, i16* nocapture, i16, i32) nounwind
declare void @llvm.memmove.element.unordered.atomic.p0i16.p0i16.i16(i16* nocapture, i16* nocapture, i16, i32) nounwind
declare void @llvm.memset.element.unordered.atomic.p0i16.i16(i16* nocapture, i8, i16, i32) nounwind


define void @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    ret void
;
  %A = alloca i16, i16 1024, align 2
  %B = alloca i16, i16 1024, align 2

  store atomic i16 0, i16* %A unordered, align 2 ;; Written to by memcpy
  store atomic i16 0, i16* %B unordered, align 2 ;; Read by memcpy

  call void @llvm.memcpy.element.unordered.atomic.p0i16.p0i16.i16(i16* align 2 %A, i16* align 2 %B, i16 1024, i32 2)

  ret void
}

define void @test5() {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    ret void
;
  %A = alloca i16, i16 1024, align 2
  %B = alloca i16, i16 1024, align 2

  store atomic i16 0, i16* %A unordered, align 2 ;; Written to by memmove
  store atomic i16 0, i16* %B unordered, align 2 ;; Read by memmove

  call void @llvm.memmove.element.unordered.atomic.p0i16.p0i16.i16(i16* align 2 %A, i16* align 2 %B, i16 1024, i32 2)

  ret void
}

define void @test6() {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret void
;
  %A = alloca i16, i16 1024, align 2
  %B = alloca i16, i16 1024, align 2

  store atomic i16 0, i16* %A unordered, align 2 ;; Written to by memset

  call void @llvm.memset.element.unordered.atomic.p0i16.i16(i16* align 2 %A, i8 0, i16 1024, i32 2)

  ret void
}

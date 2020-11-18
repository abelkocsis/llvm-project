; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -mtriple=x86_64-unknown-unknown -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

;
; DemandedBits - MOVMSK zeros the upper bits of the result.
;

define i32 @test_upper_x86_mmx_pmovmskb(x86_mmx %a0) {
; CHECK-LABEL: @test_upper_x86_mmx_pmovmskb(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx [[A0:%.*]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx %a0)
  %2 = and i32 %1, 255
  ret i32 %2
}

define i32 @test_upper_x86_sse_movmsk_ps(<4 x float> %a0) {
; CHECK-LABEL: @test_upper_x86_sse_movmsk_ps(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x float> [[A0:%.*]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <4 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i1> [[TMP2]] to i4
; CHECK-NEXT:    [[TMP4:%.*]] = zext i4 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %1 = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %a0)
  %2 = and i32 %1, 15
  ret i32 %2
}

define i32 @test_upper_x86_sse2_movmsk_pd(<2 x double> %a0) {
; CHECK-LABEL: @test_upper_x86_sse2_movmsk_pd(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x double> [[A0:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <2 x i64> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <2 x i1> [[TMP2]] to i2
; CHECK-NEXT:    [[TMP4:%.*]] = zext i2 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %1 = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> %a0)
  %2 = and i32 %1, 3
  ret i32 %2
}

define i32 @test_upper_x86_sse2_pmovmskb_128(<16 x i8> %a0) {
; CHECK-LABEL: @test_upper_x86_sse2_pmovmskb_128(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt <16 x i8> [[A0:%.*]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <16 x i1> [[TMP1]] to i16
; CHECK-NEXT:    [[TMP3:%.*]] = zext i16 [[TMP2]] to i32
; CHECK-NEXT:    ret i32 [[TMP3]]
;
  %1 = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> %a0)
  %2 = and i32 %1, 65535
  ret i32 %2
}

define i32 @test_upper_x86_avx_movmsk_ps_256(<8 x float> %a0) {
; CHECK-LABEL: @test_upper_x86_avx_movmsk_ps_256(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x float> [[A0:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <8 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <8 x i1> [[TMP2]] to i8
; CHECK-NEXT:    [[TMP4:%.*]] = zext i8 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %1 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %a0)
  %2 = and i32 %1, 255
  ret i32 %2
}

define i32 @test_upper_x86_avx_movmsk_pd_256(<4 x double> %a0) {
; CHECK-LABEL: @test_upper_x86_avx_movmsk_pd_256(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x double> [[A0:%.*]] to <4 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <4 x i64> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i1> [[TMP2]] to i4
; CHECK-NEXT:    [[TMP4:%.*]] = zext i4 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %1 = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> %a0)
  %2 = and i32 %1, 15
  ret i32 %2
}

; llvm.x86.avx2.pmovmskb uses the whole of the 32-bit register.

;
; DemandedBits - If we don't use the lower bits then we just return zero.
;

define i32 @test_lower_x86_mmx_pmovmskb(x86_mmx %a0) {
; CHECK-LABEL: @test_lower_x86_mmx_pmovmskb(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx %a0)
  %2 = and i32 %1, -256
  ret i32 %2
}

define i32 @test_lower_x86_sse_movmsk_ps(<4 x float> %a0) {
; CHECK-LABEL: @test_lower_x86_sse_movmsk_ps(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %a0)
  %2 = and i32 %1, -16
  ret i32 %2
}

define i32 @test_lower_x86_sse2_movmsk_pd(<2 x double> %a0) {
; CHECK-LABEL: @test_lower_x86_sse2_movmsk_pd(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> %a0)
  %2 = and i32 %1, -4
  ret i32 %2
}

define i32 @test_lower_x86_sse2_pmovmskb_128(<16 x i8> %a0) {
; CHECK-LABEL: @test_lower_x86_sse2_pmovmskb_128(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> %a0)
  %2 = and i32 %1, -65536
  ret i32 %2
}

define i32 @test_lower_x86_avx_movmsk_ps_256(<8 x float> %a0) {
; CHECK-LABEL: @test_lower_x86_avx_movmsk_ps_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %a0)
  %2 = and i32 %1, -256
  ret i32 %2
}

define i32 @test_lower_x86_avx_movmsk_pd_256(<4 x double> %a0) {
; CHECK-LABEL: @test_lower_x86_avx_movmsk_pd_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> %a0)
  %2 = and i32 %1, -16
  ret i32 %2
}

; llvm.x86.avx2.pmovmskb uses the whole of the 32-bit register.

;
; Constant Folding (UNDEF -> ZERO)
;

define i32 @undef_x86_mmx_pmovmskb() {
; CHECK-LABEL: @undef_x86_mmx_pmovmskb(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx undef)
  ret i32 %1
}

define i32 @undef_x86_sse_movmsk_ps() {
; CHECK-LABEL: @undef_x86_sse_movmsk_ps(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> undef)
  ret i32 %1
}

define i32 @undef_x86_sse2_movmsk_pd() {
; CHECK-LABEL: @undef_x86_sse2_movmsk_pd(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> undef)
  ret i32 %1
}

define i32 @undef_x86_sse2_pmovmskb_128() {
; CHECK-LABEL: @undef_x86_sse2_pmovmskb_128(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> undef)
  ret i32 %1
}

define i32 @undef_x86_avx_movmsk_ps_256() {
; CHECK-LABEL: @undef_x86_avx_movmsk_ps_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> undef)
  ret i32 %1
}

define i32 @undef_x86_avx_movmsk_pd_256() {
; CHECK-LABEL: @undef_x86_avx_movmsk_pd_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> undef)
  ret i32 %1
}

define i32 @undef_x86_avx2_pmovmskb() {
; CHECK-LABEL: @undef_x86_avx2_pmovmskb(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx2.pmovmskb(<32 x i8> undef)
  ret i32 %1
}

;
; Constant Folding (ZERO -> ZERO)
;

define i32 @zero_x86_mmx_pmovmskb() {
; CHECK-LABEL: @zero_x86_mmx_pmovmskb(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx bitcast (<1 x i64> zeroinitializer to x86_mmx))
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = bitcast <1 x i64> zeroinitializer to x86_mmx
  %2 = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx %1)
  ret i32 %2
}

define i32 @zero_x86_sse_movmsk_ps() {
; CHECK-LABEL: @zero_x86_sse_movmsk_ps(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> zeroinitializer)
  ret i32 %1
}

define i32 @zero_x86_sse2_movmsk_pd() {
; CHECK-LABEL: @zero_x86_sse2_movmsk_pd(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> zeroinitializer)
  ret i32 %1
}

define i32 @zero_x86_sse2_pmovmskb_128() {
; CHECK-LABEL: @zero_x86_sse2_pmovmskb_128(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> zeroinitializer)
  ret i32 %1
}

define i32 @zero_x86_avx_movmsk_ps_256() {
; CHECK-LABEL: @zero_x86_avx_movmsk_ps_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> zeroinitializer)
  ret i32 %1
}

define i32 @zero_x86_avx_movmsk_pd_256() {
; CHECK-LABEL: @zero_x86_avx_movmsk_pd_256(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> zeroinitializer)
  ret i32 %1
}

define i32 @zero_x86_avx2_pmovmskb() {
; CHECK-LABEL: @zero_x86_avx2_pmovmskb(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.x86.avx2.pmovmskb(<32 x i8> zeroinitializer)
  ret i32 %1
}

;
; Constant Folding
;

define i32 @fold_x86_mmx_pmovmskb() {
; CHECK-LABEL: @fold_x86_mmx_pmovmskb(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx bitcast (<8 x i8> <i8 0, i8 -1, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 0> to x86_mmx))
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = bitcast <8 x i8> <i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256> to x86_mmx
  %2 = call i32 @llvm.x86.mmx.pmovmskb(x86_mmx %1)
  ret i32 %2
}

define i32 @fold_x86_sse_movmsk_ps() {
; CHECK-LABEL: @fold_x86_sse_movmsk_ps(
; CHECK-NEXT:    ret i32 10
;
  %1 = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> <float 1.0, float -1.0, float 100.0, float -200.0>)
  ret i32 %1
}

define i32 @fold_x86_sse2_movmsk_pd() {
; CHECK-LABEL: @fold_x86_sse2_movmsk_pd(
; CHECK-NEXT:    ret i32 2
;
  %1 = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> <double 1.0, double -1.0>)
  ret i32 %1
}

define i32 @fold_x86_sse2_pmovmskb_128() {
; CHECK-LABEL: @fold_x86_sse2_pmovmskb_128(
; CHECK-NEXT:    ret i32 5654
;
  %1 = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> <i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256, i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256>)
  ret i32 %1
}

define i32 @fold_x86_avx_movmsk_ps_256() {
; CHECK-LABEL: @fold_x86_avx_movmsk_ps_256(
; CHECK-NEXT:    ret i32 170
;
  %1 = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> <float 1.0, float -1.0, float 100.0, float -200.0, float +0.0, float -0.0, float 100000.0, float -5000000.0>)
  ret i32 %1
}

define i32 @fold_x86_avx_movmsk_pd_256() {
; CHECK-LABEL: @fold_x86_avx_movmsk_pd_256(
; CHECK-NEXT:    ret i32 10
;
  %1 = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> <double 1.0, double -1.0, double 100.0, double -200.0>)
  ret i32 %1
}

define i32 @fold_x86_avx2_pmovmskb() {
; CHECK-LABEL: @fold_x86_avx2_pmovmskb(
; CHECK-NEXT:    ret i32 370546176
;
  %1 = call i32 @llvm.x86.avx2.pmovmskb(<32 x i8> <i8 0, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256, i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256, i8 0, i8 255, i8 -1, i8 127, i8 -127, i8 63, i8 64, i8 256>)
  ret i32 %1
}

define i32 @sext_sse_movmsk_ps(<4 x i1> %x) {
; CHECK-LABEL: @sext_sse_movmsk_ps(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[X:%.*]] to i4
; CHECK-NEXT:    [[TMP2:%.*]] = zext i4 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %sext = sext <4 x i1> %x to <4 x i32>
  %bc = bitcast <4 x i32> %sext to <4 x float>
  %r = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %bc)
  ret i32 %r
}

define i32 @sext_sse2_movmsk_pd(<2 x i1> %x) {
; CHECK-LABEL: @sext_sse2_movmsk_pd(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i1> [[X:%.*]] to i2
; CHECK-NEXT:    [[TMP2:%.*]] = zext i2 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %sext = sext <2 x i1> %x to <2 x i64>
  %bc = bitcast <2 x i64> %sext to <2 x double>
  %r = call i32 @llvm.x86.sse2.movmsk.pd(<2 x double> %bc)
  ret i32 %r
}

define i32 @sext_sse2_pmovmskb_128(<16 x i1> %x) {
; CHECK-LABEL: @sext_sse2_pmovmskb_128(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <16 x i1> [[X:%.*]] to i16
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %sext = sext <16 x i1> %x to <16 x i8>
  %r = call i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8> %sext)
  ret i32 %r
}

define i32 @sext_avx_movmsk_ps_256(<8 x i1> %x) {
; CHECK-LABEL: @sext_avx_movmsk_ps_256(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %sext = sext <8 x i1> %x to <8 x i32>
  %bc = bitcast <8 x i32> %sext to <8 x float>
  %r = call i32 @llvm.x86.avx.movmsk.ps.256(<8 x float> %bc)
  ret i32 %r
}

define i32 @sext_avx_movmsk_pd_256(<4 x i1> %x) {
; CHECK-LABEL: @sext_avx_movmsk_pd_256(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[X:%.*]] to i4
; CHECK-NEXT:    [[TMP2:%.*]] = zext i4 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %sext = sext <4 x i1> %x to <4 x i64>
  %bc = bitcast <4 x i64> %sext to <4 x double>
  %r = call i32 @llvm.x86.avx.movmsk.pd.256(<4 x double> %bc)
  ret i32 %r
}

define i32 @sext_avx2_pmovmskb(<32 x i1> %x) {
; CHECK-LABEL: @sext_avx2_pmovmskb(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <32 x i1> [[X:%.*]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %sext = sext <32 x i1> %x to <32 x i8>
  %r = call i32 @llvm.x86.avx2.pmovmskb(<32 x i8> %sext)
  ret i32 %r
}

; Bitcast from sign-extended scalar.

define i32 @sext_sse_movmsk_ps_scalar_source(i1 %x) {
; CHECK-LABEL: @sext_sse_movmsk_ps_scalar_source(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[X:%.*]] to i128
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i128 [[SEXT]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <4 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i1> [[TMP2]] to i4
; CHECK-NEXT:    [[TMP4:%.*]] = zext i4 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %sext = sext i1 %x to i128
  %bc = bitcast i128 %sext to <4 x float>
  %r = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %bc)
  ret i32 %r
}

; Bitcast from vector type with more elements.

define i32 @sext_sse_movmsk_ps_too_many_elts(<8 x i1> %x) {
; CHECK-LABEL: @sext_sse_movmsk_ps_too_many_elts(
; CHECK-NEXT:    [[SEXT:%.*]] = sext <8 x i1> [[X:%.*]] to <8 x i16>
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i16> [[SEXT]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <4 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i1> [[TMP2]] to i4
; CHECK-NEXT:    [[TMP4:%.*]] = zext i4 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %sext = sext <8 x i1> %x to <8 x i16>
  %bc = bitcast <8 x i16> %sext to <4 x float>
  %r = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %bc)
  ret i32 %r
}

; Handle this by doing a bitcasted sign-bit test after the sext.

define i32 @sext_sse_movmsk_ps_must_replicate_bits(<2 x i1> %x) {
; CHECK-LABEL: @sext_sse_movmsk_ps_must_replicate_bits(
; CHECK-NEXT:    [[SEXT:%.*]] = sext <2 x i1> [[X:%.*]] to <2 x i64>
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i64> [[SEXT]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt <4 x i32> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i1> [[TMP2]] to i4
; CHECK-NEXT:    [[TMP4:%.*]] = zext i4 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %sext = sext <2 x i1> %x to <2 x i64>
  %bc = bitcast <2 x i64> %sext to <4 x float>
  %r = call i32 @llvm.x86.sse.movmsk.ps(<4 x float> %bc)
  ret i32 %r
}

declare i32 @llvm.x86.mmx.pmovmskb(x86_mmx)

declare i32 @llvm.x86.sse.movmsk.ps(<4 x float>)
declare i32 @llvm.x86.sse2.movmsk.pd(<2 x double>)
declare i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8>)

declare i32 @llvm.x86.avx.movmsk.ps.256(<8 x float>)
declare i32 @llvm.x86.avx.movmsk.pd.256(<4 x double>)
declare i32 @llvm.x86.avx2.pmovmskb(<32 x i8>)

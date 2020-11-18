; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare double @llvm.sqrt.f64(double) nounwind readnone speculatable
declare <2 x float> @llvm.sqrt.v2f32(<2 x float>)
declare void @use(double)

; sqrt(a) * sqrt(b) no math flags

define double @sqrt_a_sqrt_b(double %a, double %b) {
; CHECK-LABEL: @sqrt_a_sqrt_b(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.sqrt.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.sqrt.f64(double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.sqrt.f64(double %a)
  %2 = call double @llvm.sqrt.f64(double %b)
  %mul = fmul double %1, %2
  ret double %mul
}

; sqrt(a) * sqrt(b) fast-math, multiple uses

define double @sqrt_a_sqrt_b_multiple_uses(double %a, double %b) {
; CHECK-LABEL: @sqrt_a_sqrt_b_multiple_uses(
; CHECK-NEXT:    [[TMP1:%.*]] = call fast double @llvm.sqrt.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call fast double @llvm.sqrt.f64(double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    call void @use(double [[TMP2]])
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call fast double @llvm.sqrt.f64(double %a)
  %2 = call fast double @llvm.sqrt.f64(double %b)
  %mul = fmul fast double %1, %2
  call void @use(double %2)
  ret double %mul
}

; sqrt(a) * sqrt(b) => sqrt(a*b) with fast-math

define double @sqrt_a_sqrt_b_reassoc_nnan(double %a, double %b) {
; CHECK-LABEL: @sqrt_a_sqrt_b_reassoc_nnan(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nnan double [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = call reassoc nnan double @llvm.sqrt.f64(double [[TMP1]])
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.sqrt.f64(double %a)
  %2 = call double @llvm.sqrt.f64(double %b)
  %mul = fmul reassoc nnan double %1, %2
  ret double %mul
}

; nnan disallows the possibility that both operands are negative,
; so we won't return a number when the answer should be NaN.

define double @sqrt_a_sqrt_b_reassoc(double %a, double %b) {
; CHECK-LABEL: @sqrt_a_sqrt_b_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.sqrt.f64(double [[A:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.sqrt.f64(double [[B:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc double [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %1 = call double @llvm.sqrt.f64(double %a)
  %2 = call double @llvm.sqrt.f64(double %b)
  %mul = fmul reassoc double %1, %2
  ret double %mul
}

; sqrt(a) * sqrt(b) * sqrt(c) * sqrt(d) => sqrt(a*b*c*d) with fast-math
; 'reassoc nnan' on the fmuls is all that is required, but check propagation of other FMF.

define double @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(double %a, double %b, double %c, double %d) {
; CHECK-LABEL: @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nnan arcp double [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = fmul reassoc nnan double [[TMP1]], [[C:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = fmul reassoc nnan ninf double [[TMP2]], [[D:%.*]]
; CHECK-NEXT:    [[TMP4:%.*]] = call reassoc nnan ninf double @llvm.sqrt.f64(double [[TMP3]])
; CHECK-NEXT:    ret double [[TMP4]]
;
  %1 = call double @llvm.sqrt.f64(double %a)
  %2 = call double @llvm.sqrt.f64(double %b)
  %3 = call double @llvm.sqrt.f64(double %c)
  %4 = call double @llvm.sqrt.f64(double %d)
  %mul = fmul reassoc nnan arcp double %1, %2
  %mul1 = fmul reassoc nnan double %mul, %3
  %mul2 = fmul reassoc nnan ninf double %mul1, %4
  ret double %mul2
}

define double @rsqrt_squared(double %x) {
; CHECK-LABEL: @rsqrt_squared(
; CHECK-NEXT:    [[SQUARED:%.*]] = fdiv fast double 1.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call fast double @llvm.sqrt.f64(double %x)
  %rsqrt = fdiv fast double 1.0, %sqrt
  %squared = fmul fast double %rsqrt, %rsqrt
  ret double %squared
}

define double @rsqrt_x_reassociate_extra_use(double %x, double * %p) {
; CHECK-LABEL: @rsqrt_x_reassociate_extra_use(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    [[RSQRT:%.*]] = fdiv double 1.000000e+00, [[SQRT]]
; CHECK-NEXT:    [[RES:%.*]] = fdiv reassoc nsz double [[X:%.*]], [[SQRT]]
; CHECK-NEXT:    store double [[RSQRT]], double* [[P:%.*]], align 8
; CHECK-NEXT:    ret double [[RES]]
;
  %sqrt = call double @llvm.sqrt.f64(double %x)
  %rsqrt = fdiv double 1.0, %sqrt
  %res = fmul reassoc nsz double %rsqrt, %x
  store double %rsqrt, double* %p
  ret double %res
}

define <2 x float> @x_add_y_rsqrt_reassociate_extra_use(<2 x float> %x, <2 x float> %y, <2 x float>* %p) {
; CHECK-LABEL: @x_add_y_rsqrt_reassociate_extra_use(
; CHECK-NEXT:    [[ADD:%.*]] = fadd fast <2 x float> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SQRT:%.*]] = call fast <2 x float> @llvm.sqrt.v2f32(<2 x float> [[ADD]])
; CHECK-NEXT:    [[RSQRT:%.*]] = fdiv fast <2 x float> <float 1.000000e+00, float 1.000000e+00>, [[SQRT]]
; CHECK-NEXT:    [[RES:%.*]] = fdiv fast <2 x float> [[ADD]], [[SQRT]]
; CHECK-NEXT:    store <2 x float> [[RSQRT]], <2 x float>* [[P:%.*]], align 8
; CHECK-NEXT:    ret <2 x float> [[RES]]
;
  %add = fadd fast <2 x float> %x, %y ; thwart complexity-based canonicalization
  %sqrt = call fast <2 x float> @llvm.sqrt.v2f32(<2 x float> %add)
  %rsqrt = fdiv fast <2 x float> <float 1.0, float 1.0>, %sqrt
  %res = fmul fast <2 x float> %add, %rsqrt
  store <2 x float> %rsqrt, <2 x float>* %p
  ret <2 x float> %res
}

define double @sqrt_divisor_squared(double %x, double %y) {
; CHECK-LABEL: @sqrt_divisor_squared(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nnan nsz double [[Y:%.*]], [[Y]]
; CHECK-NEXT:    [[SQUARED:%.*]] = fdiv reassoc nnan nsz double [[TMP1]], [[X:%.*]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call double @llvm.sqrt.f64(double %x)
  %div = fdiv double %y, %sqrt
  %squared = fmul reassoc nnan nsz double %div, %div
  ret double %squared
}

define <2 x float> @sqrt_dividend_squared(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @sqrt_dividend_squared(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast <2 x float> [[Y:%.*]], [[Y]]
; CHECK-NEXT:    [[SQUARED:%.*]] = fdiv fast <2 x float> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x float> [[SQUARED]]
;
  %sqrt = call <2 x float> @llvm.sqrt.v2f32(<2 x float> %x)
  %div = fdiv fast <2 x float> %sqrt, %y
  %squared = fmul fast <2 x float> %div, %div
  ret <2 x float> %squared
}

; We do not transform this because it would result in an extra instruction.
; This might still be a good optimization for the backend.

define double @sqrt_divisor_squared_extra_use(double %x, double %y) {
; CHECK-LABEL: @sqrt_divisor_squared_extra_use(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[Y:%.*]], [[SQRT]]
; CHECK-NEXT:    call void @use(double [[DIV]])
; CHECK-NEXT:    [[SQUARED:%.*]] = fmul reassoc nnan nsz double [[DIV]], [[DIV]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call double @llvm.sqrt.f64(double %x)
  %div = fdiv double %y, %sqrt
  call void @use(double %div)
  %squared = fmul reassoc nnan nsz double %div, %div
  ret double %squared
}

define double @sqrt_dividend_squared_extra_use(double %x, double %y) {
; CHECK-LABEL: @sqrt_dividend_squared_extra_use(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    call void @use(double [[SQRT]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[Y:%.*]], [[Y]]
; CHECK-NEXT:    [[SQUARED:%.*]] = fdiv fast double [[X]], [[TMP1]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call double @llvm.sqrt.f64(double %x)
  call void @use(double %sqrt)
  %div = fdiv fast double %sqrt, %y
  %squared = fmul fast double %div, %div
  ret double %squared
}

; Negative test - require 'nsz'.

define double @sqrt_divisor_not_enough_FMF(double %x, double %y) {
; CHECK-LABEL: @sqrt_divisor_not_enough_FMF(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[Y:%.*]], [[SQRT]]
; CHECK-NEXT:    [[SQUARED:%.*]] = fmul reassoc nnan double [[DIV]], [[DIV]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call double @llvm.sqrt.f64(double %x)
  %div = fdiv double %y, %sqrt
  %squared = fmul reassoc nnan double %div, %div
  ret double %squared
}

; TODO: This is a special-case of the general pattern. If we have a constant
; operand, the extra use limitation could be eased because this does not
; result in an extra instruction (1.0 * 1.0 is constant folded).

define double @rsqrt_squared_extra_use(double %x) {
; CHECK-LABEL: @rsqrt_squared_extra_use(
; CHECK-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    [[RSQRT:%.*]] = fdiv fast double 1.000000e+00, [[SQRT]]
; CHECK-NEXT:    call void @use(double [[RSQRT]])
; CHECK-NEXT:    [[SQUARED:%.*]] = fmul fast double [[RSQRT]], [[RSQRT]]
; CHECK-NEXT:    ret double [[SQUARED]]
;
  %sqrt = call fast double @llvm.sqrt.f64(double %x)
  %rsqrt = fdiv fast double 1.0, %sqrt
  call void @use(double %rsqrt)
  %squared = fmul fast double %rsqrt, %rsqrt
  ret double %squared
}

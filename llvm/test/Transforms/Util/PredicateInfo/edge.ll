; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -print-predicateinfo < %s 2>&1 | FileCheck %s

define i32 @f1(i32 %x) {
; CHECK-LABEL: @f1(
; CHECK-NEXT:  bb0:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.{{.+}}(i32 [[X]])
; CHECK-NEXT:    br i1 [[CMP]], label [[BB2:%.*]], label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[X_0]], [[BB0:%.*]] ], [ 0, [[BB1]] ]
; CHECK-NEXT:    [[FOO:%.*]] = add i32 [[COND]], [[X]]
; CHECK-NEXT:    ret i32 [[FOO]]
;
bb0:
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %bb2, label %bb1
bb1:
  br label %bb2
bb2:
  %cond = phi i32 [ %x, %bb0 ], [ 0, %bb1 ]
  %foo = add i32 %cond, %x
  ret i32 %foo
}

define i32 @f2(i32 %x) {
; CHECK-LABEL: @f2(
; CHECK-NEXT:  bb0:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[X:%.*]], 0
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.{{.+}}(i32 [[X]])
; CHECK-NEXT:    br i1 [[CMP]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[X_0]], [[BB0:%.*]] ], [ 0, [[BB1]] ]
; CHECK-NEXT:    [[FOO:%.*]] = add i32 [[COND]], [[X]]
; CHECK-NEXT:    ret i32 [[FOO]]
;
bb0:
  %cmp = icmp ne i32 %x, 0
  br i1 %cmp, label %bb1, label %bb2
bb1:
  br label %bb2
bb2:
  %cond = phi i32 [ %x, %bb0 ], [ 0, %bb1 ]
  %foo = add i32 %cond, %x
  ret i32 %foo
}

define i32 @f3(i32 %x) {
; CHECK-LABEL: @f3(
; CHECK-NEXT:  bb0:
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.{{.+}}(i32 [[X:%.*]])
; CHECK-NEXT:    switch i32 [[X]], label [[BB1:%.*]] [
; CHECK-NEXT:    i32 0, label [[BB2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[X_0]], [[BB0:%.*]] ], [ 0, [[BB1]] ]
; CHECK-NEXT:    [[FOO:%.*]] = add i32 [[COND]], [[X]]
; CHECK-NEXT:    ret i32 [[FOO]]
;
bb0:
  switch i32 %x, label %bb1 [ i32 0, label %bb2]
bb1:
  br label %bb2
bb2:
  %cond = phi i32 [ %x, %bb0 ], [ 0, %bb1 ]
  %foo = add i32 %cond, %x
  ret i32 %foo
}


define double @fcmp_oeq_not_zero(double %x, double %y) {
; CHECK-LABEL: @fcmp_oeq_not_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq double [[Y:%.*]], 2.000000e+00
; CHECK:         [[Y_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[RETURN:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Y_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[IF]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %cmp = fcmp oeq double %y, 2.0
  br i1 %cmp, label %if, label %return

if:
  %div = fdiv double %x, %y
  br label %return

return:
  %retval = phi double [ %div, %if ], [ %x, %entry ]
  ret double %retval

}

define double @fcmp_une_not_zero(double %x, double %y) {
; CHECK-LABEL: @fcmp_une_not_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = fcmp une double [[Y:%.*]], 2.000000e+00
; CHECK:         [[Y_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[RETURN:%.*]], label [[ELSE:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Y_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[ELSE]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %cmp = fcmp une double %y, 2.0
  br i1 %cmp, label %return, label %else

else:
  %div = fdiv double %x, %y
  br label %return

return:
  %retval = phi double [ %div, %else ], [ %x, %entry ]
  ret double %retval

}

define double @fcmp_oeq_zero(double %x, double %y) {
; CHECK-LABEL: @fcmp_oeq_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq double [[Y:%.*]], 0.000000e+00
; CHECK:         [[Y_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[RETURN:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Y_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[IF]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %cmp = fcmp oeq double %y, 0.0
  br i1 %cmp, label %if, label %return

if:
  %div = fdiv double %x, %y
  br label %return

return:
  %retval = phi double [ %div, %if ], [ %x, %entry ]
  ret double %retval

}

define double @fcmp_une_zero(double %x, double %y) {
; CHECK-LABEL: @fcmp_une_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = fcmp une double [[Y:%.*]], -0.000000e+00
; CHECK:         [[Y_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[RETURN:%.*]], label [[ELSE:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Y_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[ELSE]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %cmp = fcmp une double %y, -0.0
  br i1 %cmp, label %return, label %else

else:
  %div = fdiv double %x, %y
  br label %return

return:
  %retval = phi double [ %div, %else ], [ %x, %entry ]
  ret double %retval

}


define double @fcmp_oeq_maybe_zero(double %x, double %y, double %z1, double %z2) {
; CHECK-LABEL: @fcmp_oeq_maybe_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[Z:%.*]] = fadd double [[Z1:%.*]], [[Z2:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq double [[Y:%.*]], [[Z]]
; CHECK:         [[Z_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Z]])
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[RETURN:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Z_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[IF]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %z = fadd double %z1, %z2
  %cmp = fcmp oeq double %y, %z
  br i1 %cmp, label %if, label %return

if:
  %div = fdiv double %x, %z
  br label %return

return:
  %retval = phi double [ %div, %if ], [ %x, %entry ]
  ret double %retval

}

define double @fcmp_une_maybe_zero(double %x, double %y, double %z1, double %z2) {
; CHECK-LABEL: @fcmp_une_maybe_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[Z:%.*]] = fadd double [[Z1:%.*]], [[Z2:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp une double [[Y:%.*]], [[Z]]
; CHECK:         [[Z_0:%.*]] = call double @llvm.ssa.copy.{{.+}}(double [[Z]])
; CHECK-NEXT:    br i1 [[CMP]], label [[RETURN:%.*]], label [[ELSE:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[DIV:%.*]] = fdiv double [[X:%.*]], [[Z_0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL:%.*]] = phi double [ [[DIV]], [[ELSE]] ], [ [[X]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret double [[RETVAL]]
;
entry:
  %z = fadd double %z1, %z2
  %cmp = fcmp une double %y, %z
  br i1 %cmp, label %return, label %else

else:
  %div = fdiv double %x, %z
  br label %return

return:
  %retval = phi double [ %div, %else ], [ %x, %entry ]
  ret double %retval

}

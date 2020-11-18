; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=UNPACKED %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck -check-prefix=PACKED %s

define amdgpu_ps void @raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset(half %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret void
}

define amdgpu_ps void @raw_tbuffer_store_v2f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<2 x half> %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_v2f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; UNPACKED:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED:   [[V_LSHRREV_B32_e64_:%[0-9]+]]:vgpr_32 = V_LSHRREV_B32_e64 [[COPY7]], [[COPY]], implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[V_LSHRREV_B32_e64_]], %subreg.sub1
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_XY_gfx80_OFFEN_exact [[REG_SEQUENCE1]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 4 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_v2f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_XY_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 4 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.v2f16(<2 x half> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret void
}

; FIXME: Crashes
; define amdgpu_ps void @raw_tbuffer_store_v3f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<3 x half> %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
;   call void @llvm.amdgcn.raw.tbuffer.store.v3f16(<3 x half> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
;   ret void
; }

define amdgpu_ps void @raw_tbuffer_store_v4f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<4 x half> %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_v4f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; UNPACKED:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 16
  ; UNPACKED:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED:   [[V_LSHRREV_B32_e64_:%[0-9]+]]:vgpr_32 = V_LSHRREV_B32_e64 [[COPY8]], [[COPY]], implicit $exec
  ; UNPACKED:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[S_MOV_B32_]]
  ; UNPACKED:   [[V_LSHRREV_B32_e64_1:%[0-9]+]]:vgpr_32 = V_LSHRREV_B32_e64 [[COPY9]], [[COPY1]], implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[V_LSHRREV_B32_e64_]], %subreg.sub1, [[COPY1]], %subreg.sub2, [[V_LSHRREV_B32_e64_1]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_XYZW_gfx80_OFFEN_exact [[REG_SEQUENCE1]], [[COPY6]], [[REG_SEQUENCE]], [[COPY7]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 8 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_v4f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; PACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_XYZW_OFFEN_exact [[REG_SEQUENCE]], [[COPY6]], [[REG_SEQUENCE1]], [[COPY7]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 8 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.v4f16(<4 x half> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret void
}

; Waterfall for rsrc
define amdgpu_ps void @raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__sgpr_soffset(half %val, <4 x i32> %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   successors: %bb.2(0x80000000)
  ; UNPACKED:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; UNPACKED: bb.2:
  ; UNPACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; UNPACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY7]], implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY8]], implicit $exec
  ; UNPACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; UNPACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE3]], [[COPY6]], 0, 94, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; UNPACKED: bb.3:
  ; UNPACKED:   successors: %bb.4(0x80000000)
  ; UNPACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; UNPACKED: bb.4:
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__sgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   successors: %bb.2(0x80000000)
  ; PACKED:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; PACKED: bb.2:
  ; PACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; PACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY7]], implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY8]], implicit $exec
  ; PACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; PACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE3]], [[COPY6]], 0, 94, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; PACKED: bb.3:
  ; PACKED:   successors: %bb.4(0x80000000)
  ; PACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; PACKED: bb.4:
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 94, i32 0)
  ret void
}

; Waterfall for rsrc and soffset
define amdgpu_ps void @raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__vgpr_soffset(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__vgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   successors: %bb.2(0x80000000)
  ; UNPACKED:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; UNPACKED: bb.2:
  ; UNPACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; UNPACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY7]], implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY8]], implicit $exec
  ; UNPACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; UNPACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; UNPACKED:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; UNPACKED:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; UNPACKED: bb.3:
  ; UNPACKED:   successors: %bb.4(0x80000000)
  ; UNPACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; UNPACKED: bb.4:
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__vgpr_voffset__vgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   successors: %bb.2(0x80000000)
  ; PACKED:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   [[COPY7:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; PACKED: bb.2:
  ; PACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; PACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY7]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY7]], implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY8]], implicit $exec
  ; PACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; PACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; PACKED:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; PACKED:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; PACKED: bb.3:
  ; PACKED:   successors: %bb.4(0x80000000)
  ; PACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; PACKED: bb.4:
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret void
}

; Waterfall for rsrc and soffset, copy for voffset
define amdgpu_ps void @raw_tbuffer_store_f16__vgpr_rsrc__sgpr_voffset__vgpr_soffset(half %val, <4 x i32> %rsrc, i32 inreg %voffset, i32 %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   successors: %bb.2(0x80000000)
  ; UNPACKED:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; UNPACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; UNPACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; UNPACKED:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; UNPACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; UNPACKED:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; UNPACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; UNPACKED: bb.2:
  ; UNPACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; UNPACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY8]], implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub0, implicit $exec
  ; UNPACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub1, implicit $exec
  ; UNPACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; UNPACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY9]], implicit $exec
  ; UNPACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; UNPACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; UNPACKED:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; UNPACKED:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; UNPACKED:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY7]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; UNPACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; UNPACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; UNPACKED: bb.3:
  ; UNPACKED:   successors: %bb.4(0x80000000)
  ; UNPACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; UNPACKED: bb.4:
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   successors: %bb.2(0x80000000)
  ; PACKED:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; PACKED:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; PACKED:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; PACKED:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr5
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; PACKED:   [[COPY8:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; PACKED:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; PACKED:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; PACKED: bb.2:
  ; PACKED:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; PACKED:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY8]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY8]], implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub0, implicit $exec
  ; PACKED:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub1, implicit $exec
  ; PACKED:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; PACKED:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY9]], implicit $exec
  ; PACKED:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; PACKED:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; PACKED:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; PACKED:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; PACKED:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY7]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 78, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; PACKED:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; PACKED:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; PACKED: bb.3:
  ; PACKED:   successors: %bb.4(0x80000000)
  ; PACKED:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; PACKED: bb.4:
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret void
}

define amdgpu_ps void @raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_glc(half %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_glc
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 1, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_glc
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 1, 0, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 1)
  ret void
}

define amdgpu_ps void @raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc(half %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 1, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 1, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 2)
  ret void
}

define amdgpu_ps void @raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc_glc(half %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc_glc
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 1, 1, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc_glc
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 1, 1, 0, 0, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 3)
  ret void
}

define amdgpu_ps void @raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_dlc(half %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; UNPACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_dlc
  ; UNPACKED: bb.1 (%ir-block.0):
  ; UNPACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; UNPACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; UNPACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; UNPACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; UNPACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; UNPACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; UNPACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; UNPACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; UNPACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; UNPACKED:   TBUFFER_STORE_FORMAT_D16_X_gfx80_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 1, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; UNPACKED:   S_ENDPGM 0
  ; PACKED-LABEL: name: raw_tbuffer_store_f16__sgpr_rsrc__vgpr_voffset__sgpr_soffset_dlc
  ; PACKED: bb.1 (%ir-block.0):
  ; PACKED:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; PACKED:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; PACKED:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; PACKED:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; PACKED:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; PACKED:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; PACKED:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; PACKED:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; PACKED:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; PACKED:   TBUFFER_STORE_FORMAT_D16_X_OFFEN_exact [[COPY]], [[COPY5]], [[REG_SEQUENCE]], [[COPY6]], 0, 78, 0, 0, 0, 1, 0, implicit $exec :: (dereferenceable store 2 into custom "TargetCustom7", align 1, addrspace 4)
  ; PACKED:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.tbuffer.store.f16(half %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 4)
  ret void
}

declare void @llvm.amdgcn.raw.tbuffer.store.f16(half, <4 x i32>, i32, i32, i32 immarg, i32 immarg)
declare void @llvm.amdgcn.raw.tbuffer.store.v2f16(<2 x half>, <4 x i32>, i32, i32, i32 immarg, i32 immarg)
declare void @llvm.amdgcn.raw.tbuffer.store.v3f16(<3 x half>, <4 x i32>, i32, i32, i32 immarg, i32 immarg)
declare void @llvm.amdgcn.raw.tbuffer.store.v4f16(<4 x half>, <4 x i32>, i32, i32, i32 immarg, i32 immarg)

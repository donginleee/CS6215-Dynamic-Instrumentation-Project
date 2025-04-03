; ModuleID = 'cg.A.x.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.timeval = type { i64, i64 }

@wtime_.sec = internal unnamed_addr global i32 -1, align 4, !dbg !0

; Function Attrs: nofree nounwind uwtable
define dso_local void @wtime_(ptr nocapture noundef writeonly %0) local_unnamed_addr #0 !dbg !2 {
  %2 = alloca %struct.timeval, align 8, !DIAssignID !34
  call void @llvm.dbg.assign(metadata i1 undef, metadata !14, metadata !DIExpression(), metadata !34, metadata ptr %2, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.value(metadata ptr %0, metadata !13, metadata !DIExpression()), !dbg !35
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #4, !dbg !36
  %3 = call i32 @gettimeofday(ptr noundef nonnull %2, ptr noundef null) #4, !dbg !37
  %4 = load i32, ptr @wtime_.sec, align 4, !dbg !38, !tbaa !40
  %5 = icmp slt i32 %4, 0, !dbg !44
  br i1 %5, label %6, label %9, !dbg !45

6:                                                ; preds = %1
  %7 = load i64, ptr %2, align 8, !dbg !46, !tbaa !47
  %8 = trunc i64 %7 to i32, !dbg !50
  store i32 %8, ptr @wtime_.sec, align 4, !dbg !51, !tbaa !40
  br label %9, !dbg !52

9:                                                ; preds = %6, %1
  %10 = load i64, ptr %2, align 8, !dbg !53, !tbaa !47
  %11 = load i32, ptr @wtime_.sec, align 4, !dbg !54, !tbaa !40
  %12 = sext i32 %11 to i64, !dbg !54
  %13 = sub nsw i64 %10, %12, !dbg !55
  %14 = sitofp i64 %13 to double, !dbg !56
  %15 = getelementptr inbounds %struct.timeval, ptr %2, i64 0, i32 1, !dbg !57
  %16 = load i64, ptr %15, align 8, !dbg !57, !tbaa !58
  %17 = sitofp i64 %16 to double, !dbg !59
  %18 = tail call double @llvm.fmuladd.f64(double %17, double 0x3EB0C6F7A0B5ED8D, double %14), !dbg !60
  store double %18, ptr %0, align 8, !dbg !61, !tbaa !62
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #4, !dbg !64
  ret void, !dbg !64
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nofree nounwind
declare !dbg !65 noundef i32 @gettimeofday(ptr nocapture noundef, ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!8}
!llvm.ident = !{!25}
!llvm.module.flags = !{!26, !27, !28, !29, !30, !31, !32, !33}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sec", scope: !2, file: !3, line: 10, type: !24, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "wtime_", scope: !3, file: !3, line: 7, type: !4, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !8, retainedNodes: !12)
!3 = !DIFile(filename: "../common/wtime.c", directory: "/home/dongin/llvm-plugin-rs/NPB3.3.1/NPB3.3-OMP/common", checksumkind: CSK_MD5, checksum: "b988251c5a50cc3204e2c139378b1f70")
!4 = !DISubroutineType(types: !5)
!5 = !{null, !6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!8 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !9, globals: !11, splitDebugInlining: false, nameTableKind: None)
!9 = !{!10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !{!0}
!12 = !{!13, !14}
!13 = !DILocalVariable(name: "t", arg: 1, scope: !2, file: !3, line: 7, type: !6)
!14 = !DILocalVariable(name: "tv", scope: !2, file: !3, line: 11, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timeval", file: !16, line: 8, size: 128, elements: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h", directory: "", checksumkind: CSK_MD5, checksum: "9b45d950050c215f216850b27bd1e8f3")
!17 = !{!18, !22}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !15, file: !16, line: 14, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !20, line: 160, baseType: !21)
!20 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!21 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "tv_usec", scope: !15, file: !16, line: 15, baseType: !23, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__suseconds_t", file: !20, line: 162, baseType: !21)
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!26 = !{i32 7, !"Dwarf Version", i32 5}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = !{i32 7, !"openmp", i32 51}
!30 = !{i32 8, !"PIC Level", i32 2}
!31 = !{i32 7, !"PIE Level", i32 2}
!32 = !{i32 7, !"uwtable", i32 2}
!33 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!34 = distinct !DIAssignID()
!35 = !DILocation(line: 0, scope: !2)
!36 = !DILocation(line: 11, column: 4, scope: !2)
!37 = !DILocation(line: 12, column: 4, scope: !2)
!38 = !DILocation(line: 13, column: 8, scope: !39)
!39 = distinct !DILexicalBlock(scope: !2, file: !3, line: 13, column: 8)
!40 = !{!41, !41, i64 0}
!41 = !{!"int", !42, i64 0}
!42 = !{!"omnipotent char", !43, i64 0}
!43 = !{!"Simple C/C++ TBAA"}
!44 = !DILocation(line: 13, column: 12, scope: !39)
!45 = !DILocation(line: 13, column: 8, scope: !2)
!46 = !DILocation(line: 13, column: 26, scope: !39)
!47 = !{!48, !49, i64 0}
!48 = !{!"timeval", !49, i64 0, !49, i64 8}
!49 = !{!"long", !42, i64 0}
!50 = !DILocation(line: 13, column: 23, scope: !39)
!51 = !DILocation(line: 13, column: 21, scope: !39)
!52 = !DILocation(line: 13, column: 17, scope: !39)
!53 = !DILocation(line: 14, column: 13, scope: !2)
!54 = !DILocation(line: 14, column: 22, scope: !2)
!55 = !DILocation(line: 14, column: 20, scope: !2)
!56 = !DILocation(line: 14, column: 9, scope: !2)
!57 = !DILocation(line: 14, column: 39, scope: !2)
!58 = !{!48, !49, i64 8}
!59 = !DILocation(line: 14, column: 36, scope: !2)
!60 = !DILocation(line: 14, column: 27, scope: !2)
!61 = !DILocation(line: 14, column: 7, scope: !2)
!62 = !{!63, !63, i64 0}
!63 = !{!"double", !42, i64 0}
!64 = !DILocation(line: 15, column: 1, scope: !2)
!65 = !DISubprogram(name: "gettimeofday", scope: !66, file: !66, line: 67, type: !67, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!66 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/time.h", directory: "", checksumkind: CSK_MD5, checksum: "b36e339815f62ba7208e5294180e353c")
!67 = !DISubroutineType(types: !68)
!68 = !{!24, !69, !71}
!69 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !70)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !10)

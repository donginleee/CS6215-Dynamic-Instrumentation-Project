; ModuleID = 'in_1.ll'
source_filename = "pthread.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@NUM_THREADS = local_unnamed_addr global i32 2, align 4
@shared_var = local_unnamed_addr global i32 0, align 4
@atomic_var = local_unnamed_addr global i32 0, align 4
@.str = private unnamed_addr constant [33 x i8] c"Thread %d wrote shared_var = %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [33 x i8] c"Thread %d wrote atomic_var = %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"Thread %d read shared_var = %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [32 x i8] c"Thread %d read atomic_var = %d\0A\00", align 1
@stderr = external local_unnamed_addr global ptr, align 8
@.str.4 = private unnamed_addr constant [50 x i8] c"Error: Number of threads must be greater than 0.\0A\00", align 1
@.str.5 = private unnamed_addr constant [24 x i8] c"Creating %d threads...\0A\00", align 1
@str = private unnamed_addr constant [23 x i8] c"All threads completed.\00", align 1

; Function Attrs: nofree nounwind uwtable
define noalias ptr @writer(ptr nocapture noundef readonly %0) #0 {
  %2 = load i32, ptr %0, align 4, !tbaa !4
  %tid = call i64 @pthread_self()
  call void @log_store(i64 %tid, ptr @shared_var)
  store i32 %2, ptr @shared_var, align 4, !tbaa !4
  %3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %2, i32 noundef %2)
  %tid1 = call i64 @pthread_self()
  call void @log_store(i64 %tid1, ptr @atomic_var)
  store atomic i32 %2, ptr @atomic_var seq_cst, align 4
  %4 = load atomic i32, ptr @atomic_var seq_cst, align 4, !tbaa !8
  %5 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %2, i32 noundef %4)
  ret ptr null
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind uwtable
define noalias ptr @reader(ptr nocapture noundef readonly %0) #0 {
  %2 = load i32, ptr %0, align 4, !tbaa !4
  %3 = load i32, ptr @shared_var, align 4, !tbaa !4
  %4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %2, i32 noundef %3)
  %5 = load atomic i32, ptr @atomic_var seq_cst, align 4
  %6 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %2, i32 noundef %5)
  ret ptr null
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #2 {
  %3 = icmp sgt i32 %0, 1
  br i1 %3, label %4, label %13

4:                                                ; preds = %2
  %5 = getelementptr inbounds ptr, ptr %1, i64 1
  %6 = load ptr, ptr %5, align 8, !tbaa !9
  %7 = tail call i64 @strtol(ptr nocapture noundef nonnull %6, ptr noundef null, i32 noundef 10) #8
  %8 = trunc i64 %7 to i32
  %tid = call i64 @pthread_self()
  call void @log_store(i64 %tid, ptr @NUM_THREADS)
  store i32 %8, ptr @NUM_THREADS, align 4, !tbaa !4
  %9 = icmp slt i32 %8, 1
  br i1 %9, label %10, label %13

10:                                               ; preds = %4
  %11 = load ptr, ptr @stderr, align 8, !tbaa !9
  %12 = tail call i64 @fwrite(ptr nonnull @.str.4, i64 49, i64 1, ptr %11) #9
  br label %66

13:                                               ; preds = %4, %2
  %14 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef %14)
  %16 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %17 = zext i32 %16 to i64
  %18 = tail call ptr @llvm.stacksave()
  %19 = alloca i64, i64 %17, align 16
  %20 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %21 = zext i32 %20 to i64
  %22 = alloca i32, i64 %21, align 16
  %23 = sdiv i32 %20, 2
  %24 = icmp sgt i32 %20, 1
  br i1 %24, label %31, label %25

25:                                               ; preds = %31, %13
  %26 = phi i32 [ %23, %13 ], [ %39, %31 ]
  %27 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %42

29:                                               ; preds = %25
  %30 = sext i32 %26 to i64
  br label %45

31:                                               ; preds = %31, %13
  %32 = phi i64 [ %33, %31 ], [ 0, %13 ]
  %33 = add nuw nsw i64 %32, 1
  %34 = getelementptr inbounds i32, ptr %22, i64 %32
  %35 = trunc i64 %33 to i32
  %tid1 = call i64 @pthread_self()
  call void @log_store(i64 %tid1, ptr %34)
  store i32 %35, ptr %34, align 4, !tbaa !4
  %36 = getelementptr inbounds i64, ptr %19, i64 %32
  %37 = call i32 @pthread_create(ptr noundef nonnull %36, ptr noundef null, ptr noundef nonnull @writer, ptr noundef nonnull %34) #8
  %38 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %39 = sdiv i32 %38, 2
  %40 = sext i32 %39 to i64
  %41 = icmp slt i64 %33, %40
  br i1 %41, label %31, label %25, !llvm.loop !11

42:                                               ; preds = %45, %25
  %43 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %44 = icmp sgt i32 %43, 0
  br i1 %44, label %57, label %55

45:                                               ; preds = %45, %29
  %46 = phi i64 [ %30, %29 ], [ %47, %45 ]
  %47 = add nsw i64 %46, 1
  %48 = getelementptr inbounds i32, ptr %22, i64 %46
  %49 = trunc i64 %47 to i32
  %tid2 = call i64 @pthread_self()
  call void @log_store(i64 %tid2, ptr %48)
  store i32 %49, ptr %48, align 4, !tbaa !4
  %50 = getelementptr inbounds i64, ptr %19, i64 %46
  %51 = call i32 @pthread_create(ptr noundef nonnull %50, ptr noundef null, ptr noundef nonnull @reader, ptr noundef nonnull %48) #8
  %52 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %53 = sext i32 %52 to i64
  %54 = icmp slt i64 %47, %53
  br i1 %54, label %45, label %42, !llvm.loop !14

55:                                               ; preds = %57, %42
  %56 = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  call void @llvm.stackrestore(ptr %18)
  br label %66

57:                                               ; preds = %57, %42
  %58 = phi i64 [ %62, %57 ], [ 0, %42 ]
  %59 = getelementptr inbounds i64, ptr %19, i64 %58
  %60 = load i64, ptr %59, align 8, !tbaa !15
  %61 = call i32 @pthread_join(i64 noundef %60, ptr noundef null) #8
  %62 = add nuw nsw i64 %58, 1
  %63 = load i32, ptr @NUM_THREADS, align 4, !tbaa !4
  %64 = sext i32 %63 to i64
  %65 = icmp slt i64 %62, %64
  br i1 %65, label %57, label %55, !llvm.loop !17

66:                                               ; preds = %55, %10
  %67 = phi i32 [ 1, %10 ], [ 0, %55 ]
  ret i32 %67
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #3

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

declare i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #3

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #7

declare i64 @pthread_self()

declare void @log_store(i64, ptr)

declare void @log_load(i64, ptr)

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree nounwind }
attributes #8 = { nounwind }
attributes #9 = { cold }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{!6, !6, i64 0}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !6, i64 0}
!11 = distinct !{!11, !12, !13}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = distinct !{!14, !12, !13}
!15 = !{!16, !16, i64 0}
!16 = !{!"long", !6, i64 0}
!17 = distinct !{!17, !12, !13}

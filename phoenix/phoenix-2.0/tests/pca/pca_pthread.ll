; ModuleID = 'pca-pthread.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { ptr, ptr }
%struct.mean_arg_t = type { i32, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@num_rows = dso_local local_unnamed_addr global i32 0, align 4
@num_cols = dso_local local_unnamed_addr global i32 0, align 4
@grid_size = dso_local local_unnamed_addr global i32 0, align 4
@.str = private unnamed_addr constant [7 x i8] c"r:c:s:\00", align 1
@optarg = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [68 x i8] c"Usage: %s -r <num_rows> -c <num_cols> -s <max value> <num_threads>\0A\00", align 1
@optind = external local_unnamed_addr global i32, align 4
@num_procs = dso_local local_unnamed_addr global i32 0, align 4
@.str.4 = private unnamed_addr constant [47 x i8] c"Rows: %d, Cols: %d, Grid Max: %d, Threads: %d\0A\00", align 1
@stdout = external local_unnamed_addr global ptr, align 8
@.str.5 = private unnamed_addr constant [5 x i8] c"%5d \00", align 1
@matrix = dso_local local_unnamed_addr global ptr null, align 8
@mean = dso_local local_unnamed_addr global ptr null, align 8
@row_lock = dso_local global %union.pthread_mutex_t zeroinitializer, align 8
@next_row = dso_local local_unnamed_addr global i32 0, align 4
@cov = dso_local local_unnamed_addr global ptr null, align 8
@str = private unnamed_addr constant [40 x i8] c"All input values must be greater than 0\00", align 1
@str.7 = private unnamed_addr constant [40 x i8] c"Missing required <num_threads> argument\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @parse_args(i32 noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  store i32 10, ptr @num_rows, align 4, !tbaa !5
  store i32 10, ptr @num_cols, align 4, !tbaa !5
  store i32 100, ptr @grid_size, align 4, !tbaa !5
  br label %3

3:                                                ; preds = %15, %2
  %4 = tail call i32 @getopt(i32 noundef %0, ptr noundef %1, ptr noundef nonnull @.str) #13
  switch i32 %4, label %15 [
    i32 -1, label %16
    i32 114, label %10
    i32 99, label %5
    i32 115, label %6
    i32 63, label %7
  ]

5:                                                ; preds = %3
  br label %10

6:                                                ; preds = %3
  br label %10

7:                                                ; preds = %3
  %8 = load ptr, ptr %1, align 8, !tbaa !9
  %9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, ptr noundef %8)
  tail call void @exit(i32 noundef 1) #14
  unreachable

10:                                               ; preds = %3, %5, %6
  %11 = phi ptr [ @grid_size, %6 ], [ @num_cols, %5 ], [ @num_rows, %3 ]
  %12 = load ptr, ptr @optarg, align 8, !tbaa !9
  %13 = tail call i64 @strtol(ptr nocapture noundef nonnull %12, ptr noundef null, i32 noundef 10) #13
  %14 = trunc i64 %13 to i32
  store i32 %14, ptr %11, align 4, !tbaa !5
  br label %15

15:                                               ; preds = %10, %3
  br label %3, !llvm.loop !11

16:                                               ; preds = %3
  %17 = load i32, ptr @optind, align 4, !tbaa !5
  %18 = icmp slt i32 %17, %0
  br i1 %18, label %21, label %19

19:                                               ; preds = %16
  %20 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.7)
  tail call void @exit(i32 noundef 1) #14
  unreachable

21:                                               ; preds = %16
  %22 = sext i32 %17 to i64
  %23 = getelementptr inbounds ptr, ptr %1, i64 %22
  %24 = load ptr, ptr %23, align 8, !tbaa !9
  %25 = tail call i64 @strtol(ptr nocapture noundef nonnull %24, ptr noundef null, i32 noundef 10) #13
  %26 = trunc i64 %25 to i32
  store i32 %26, ptr @num_procs, align 4, !tbaa !5
  %27 = load i32, ptr @num_rows, align 4, !tbaa !5
  %28 = icmp slt i32 %27, 1
  %29 = load i32, ptr @num_cols, align 4
  %30 = icmp slt i32 %29, 1
  %31 = select i1 %28, i1 true, i1 %30
  %32 = load i32, ptr @grid_size, align 4
  %33 = icmp slt i32 %32, 1
  %34 = select i1 %31, i1 true, i1 %33
  %35 = icmp slt i32 %26, 1
  %36 = select i1 %34, i1 true, i1 %35
  br i1 %36, label %37, label %39

37:                                               ; preds = %21
  %38 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  tail call void @exit(i32 noundef 1) #14
  unreachable

39:                                               ; preds = %21
  %40 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %27, i32 noundef %29, i32 noundef %32, i32 noundef %26)
  ret void
}

; Function Attrs: nounwind
declare i32 @getopt(i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #5

; Function Attrs: nofree nounwind uwtable
define dso_local void @dump_points(ptr nocapture noundef readonly %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #6 {
  %4 = icmp sgt i32 %1, 0
  br i1 %4, label %5, label %33

5:                                                ; preds = %3
  %6 = icmp sgt i32 %2, 0
  br i1 %6, label %7, label %27

7:                                                ; preds = %5
  %8 = zext i32 %1 to i64
  %9 = zext i32 %2 to i64
  br label %10

10:                                               ; preds = %7, %22
  %11 = phi i64 [ 0, %7 ], [ %25, %22 ]
  %12 = getelementptr inbounds ptr, ptr %0, i64 %11
  br label %13

13:                                               ; preds = %10, %13
  %14 = phi i64 [ 0, %10 ], [ %20, %13 ]
  %15 = load ptr, ptr @stdout, align 8, !tbaa !9
  %16 = load ptr, ptr %12, align 8, !tbaa !9
  %17 = getelementptr inbounds i32, ptr %16, i64 %14
  %18 = load i32, ptr %17, align 4, !tbaa !5
  %19 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %15, ptr noundef nonnull @.str.5, i32 noundef %18)
  %20 = add nuw nsw i64 %14, 1
  %21 = icmp eq i64 %20, %9
  br i1 %21, label %22, label %13, !llvm.loop !13

22:                                               ; preds = %13
  %23 = load ptr, ptr @stdout, align 8, !tbaa !9
  %24 = tail call i32 @fputc(i32 10, ptr %23)
  %25 = add nuw nsw i64 %11, 1
  %26 = icmp eq i64 %25, %8
  br i1 %26, label %33, label %10, !llvm.loop !14

27:                                               ; preds = %5, %27
  %28 = phi i32 [ %31, %27 ], [ 0, %5 ]
  %29 = load ptr, ptr @stdout, align 8, !tbaa !9
  %30 = tail call i32 @fputc(i32 10, ptr %29)
  %31 = add nuw nsw i32 %28, 1
  %32 = icmp eq i32 %31, %1
  br i1 %32, label %33, label %27, !llvm.loop !14

33:                                               ; preds = %27, %22, %3
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nounwind uwtable
define dso_local void @generate_points(ptr nocapture noundef readonly %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %1, 0
  %5 = icmp sgt i32 %2, 0
  %6 = and i1 %4, %5
  br i1 %6, label %7, label %25

7:                                                ; preds = %3
  %8 = zext i32 %1 to i64
  %9 = zext i32 %2 to i64
  br label %10

10:                                               ; preds = %7, %22
  %11 = phi i64 [ 0, %7 ], [ %23, %22 ]
  %12 = getelementptr inbounds ptr, ptr %0, i64 %11
  br label %13

13:                                               ; preds = %10, %13
  %14 = phi i64 [ 0, %10 ], [ %20, %13 ]
  %15 = tail call i32 @rand() #13
  %16 = load i32, ptr @grid_size, align 4, !tbaa !5
  %17 = srem i32 %15, %16
  %18 = load ptr, ptr %12, align 8, !tbaa !9
  %19 = getelementptr inbounds i32, ptr %18, i64 %14
  store i32 %17, ptr %19, align 4, !tbaa !5
  %20 = add nuw nsw i64 %14, 1
  %21 = icmp eq i64 %20, %9
  br i1 %21, label %22, label %13, !llvm.loop !15

22:                                               ; preds = %13
  %23 = add nuw nsw i64 %11, 1
  %24 = icmp eq i64 %23, %8
  br i1 %24, label %25, label %10, !llvm.loop !16

25:                                               ; preds = %22, %3
  ret void
}

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #1

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local noalias ptr @calc_mean(ptr nocapture noundef readonly %0) #7 {
  %2 = load i32, ptr %0, align 4, !tbaa !17
  %3 = getelementptr inbounds %struct.mean_arg_t, ptr %0, i64 0, i32 1
  %4 = load i32, ptr %3, align 4, !tbaa !19
  %5 = icmp slt i32 %2, %4
  br i1 %5, label %6, label %40

6:                                                ; preds = %1
  %7 = load ptr, ptr @matrix, align 8
  %8 = load ptr, ptr @mean, align 8, !tbaa !9
  %9 = sext i32 %2 to i64
  br label %10

10:                                               ; preds = %6, %41
  %11 = phi i64 [ %9, %6 ], [ %45, %41 ]
  %12 = load i32, ptr @num_cols, align 4, !tbaa !5
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %41

14:                                               ; preds = %10
  %15 = getelementptr inbounds ptr, ptr %7, i64 %11
  %16 = load ptr, ptr %15, align 8, !tbaa !9
  %17 = zext i32 %12 to i64
  %18 = icmp ult i32 %12, 8
  br i1 %18, label %37, label %19

19:                                               ; preds = %14
  %20 = and i64 %17, 4294967288
  br label %21

21:                                               ; preds = %21, %19
  %22 = phi i64 [ 0, %19 ], [ %31, %21 ]
  %23 = phi <4 x i32> [ zeroinitializer, %19 ], [ %29, %21 ]
  %24 = phi <4 x i32> [ zeroinitializer, %19 ], [ %30, %21 ]
  %25 = getelementptr inbounds i32, ptr %16, i64 %22
  %26 = load <4 x i32>, ptr %25, align 4, !tbaa !5
  %27 = getelementptr inbounds i32, ptr %25, i64 4
  %28 = load <4 x i32>, ptr %27, align 4, !tbaa !5
  %29 = add <4 x i32> %26, %23
  %30 = add <4 x i32> %28, %24
  %31 = add nuw i64 %22, 8
  %32 = icmp eq i64 %31, %20
  br i1 %32, label %33, label %21, !llvm.loop !20

33:                                               ; preds = %21
  %34 = add <4 x i32> %30, %29
  %35 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %34)
  %36 = icmp eq i64 %20, %17
  br i1 %36, label %41, label %37

37:                                               ; preds = %14, %33
  %38 = phi i64 [ 0, %14 ], [ %20, %33 ]
  %39 = phi i32 [ 0, %14 ], [ %35, %33 ]
  br label %49

40:                                               ; preds = %41, %1
  ret ptr null

41:                                               ; preds = %49, %33, %10
  %42 = phi i32 [ 0, %10 ], [ %35, %33 ], [ %54, %49 ]
  %43 = sdiv i32 %42, %12
  %44 = getelementptr inbounds i32, ptr %8, i64 %11
  store i32 %43, ptr %44, align 4, !tbaa !5
  %45 = add nsw i64 %11, 1
  %46 = load i32, ptr %3, align 4, !tbaa !19
  %47 = sext i32 %46 to i64
  %48 = icmp slt i64 %45, %47
  br i1 %48, label %10, label %40, !llvm.loop !23

49:                                               ; preds = %37, %49
  %50 = phi i64 [ %55, %49 ], [ %38, %37 ]
  %51 = phi i32 [ %54, %49 ], [ %39, %37 ]
  %52 = getelementptr inbounds i32, ptr %16, i64 %50
  %53 = load i32, ptr %52, align 4, !tbaa !5
  %54 = add nsw i32 %53, %51
  %55 = add nuw nsw i64 %50, 1
  %56 = icmp eq i64 %55, %17
  br i1 %56, label %41, label %49, !llvm.loop !24
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #8

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @calc_cov(ptr nocapture readnone %0) #0 {
  %2 = tail call i32 @pthread_mutex_lock(ptr noundef nonnull @row_lock) #13
  %3 = load i32, ptr @next_row, align 4, !tbaa !5
  %4 = add nsw i32 %3, 1
  store i32 %4, ptr @next_row, align 4, !tbaa !5
  %5 = tail call i32 @pthread_mutex_unlock(ptr noundef nonnull @row_lock) #13
  %6 = load i32, ptr @num_rows, align 4, !tbaa !5
  %7 = icmp slt i32 %3, %6
  br i1 %7, label %15, label %105

8:                                                ; preds = %93, %15
  %9 = tail call i32 @pthread_mutex_lock(ptr noundef nonnull @row_lock) #13
  %10 = load i32, ptr @next_row, align 4, !tbaa !5
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr @next_row, align 4, !tbaa !5
  %12 = tail call i32 @pthread_mutex_unlock(ptr noundef nonnull @row_lock) #13
  %13 = load i32, ptr @num_rows, align 4, !tbaa !5
  %14 = icmp slt i32 %10, %13
  br i1 %14, label %15, label %105

15:                                               ; preds = %1, %8
  %16 = phi i32 [ %13, %8 ], [ %6, %1 ]
  %17 = phi i32 [ %10, %8 ], [ %3, %1 ]
  %18 = icmp slt i32 %17, %16
  br i1 %18, label %19, label %8

19:                                               ; preds = %15
  %20 = load ptr, ptr @matrix, align 8
  %21 = sext i32 %17 to i64
  %22 = getelementptr inbounds ptr, ptr %20, i64 %21
  %23 = load ptr, ptr @mean, align 8
  %24 = getelementptr inbounds i32, ptr %23, i64 %21
  %25 = load ptr, ptr @cov, align 8, !tbaa !9
  %26 = getelementptr inbounds ptr, ptr %25, i64 %21
  %27 = load ptr, ptr %26, align 8, !tbaa !9
  br label %28

28:                                               ; preds = %19, %93
  %29 = phi i64 [ %21, %19 ], [ %101, %93 ]
  %30 = load i32, ptr @num_cols, align 4, !tbaa !5
  %31 = icmp sgt i32 %30, 0
  br i1 %31, label %32, label %93

32:                                               ; preds = %28
  %33 = load ptr, ptr %22, align 8, !tbaa !9
  %34 = load i32, ptr %24, align 4, !tbaa !5
  %35 = getelementptr inbounds ptr, ptr %20, i64 %29
  %36 = load ptr, ptr %35, align 8, !tbaa !9
  %37 = getelementptr inbounds i32, ptr %23, i64 %29
  %38 = load i32, ptr %37, align 4, !tbaa !5
  %39 = zext i32 %30 to i64
  %40 = icmp ult i32 %30, 8
  br i1 %40, label %77, label %41

41:                                               ; preds = %32
  %42 = and i64 %39, 4294967288
  %43 = insertelement <4 x i32> poison, i32 %34, i64 0
  %44 = shufflevector <4 x i32> %43, <4 x i32> poison, <4 x i32> zeroinitializer
  %45 = insertelement <4 x i32> poison, i32 %34, i64 0
  %46 = shufflevector <4 x i32> %45, <4 x i32> poison, <4 x i32> zeroinitializer
  %47 = insertelement <4 x i32> poison, i32 %38, i64 0
  %48 = shufflevector <4 x i32> %47, <4 x i32> poison, <4 x i32> zeroinitializer
  %49 = insertelement <4 x i32> poison, i32 %38, i64 0
  %50 = shufflevector <4 x i32> %49, <4 x i32> poison, <4 x i32> zeroinitializer
  br label %51

51:                                               ; preds = %51, %41
  %52 = phi i64 [ 0, %41 ], [ %71, %51 ]
  %53 = phi <4 x i32> [ zeroinitializer, %41 ], [ %69, %51 ]
  %54 = phi <4 x i32> [ zeroinitializer, %41 ], [ %70, %51 ]
  %55 = getelementptr inbounds i32, ptr %33, i64 %52
  %56 = load <4 x i32>, ptr %55, align 4, !tbaa !5
  %57 = getelementptr inbounds i32, ptr %55, i64 4
  %58 = load <4 x i32>, ptr %57, align 4, !tbaa !5
  %59 = sub nsw <4 x i32> %56, %44
  %60 = sub nsw <4 x i32> %58, %46
  %61 = getelementptr inbounds i32, ptr %36, i64 %52
  %62 = load <4 x i32>, ptr %61, align 4, !tbaa !5
  %63 = getelementptr inbounds i32, ptr %61, i64 4
  %64 = load <4 x i32>, ptr %63, align 4, !tbaa !5
  %65 = sub nsw <4 x i32> %62, %48
  %66 = sub nsw <4 x i32> %64, %50
  %67 = mul nsw <4 x i32> %65, %59
  %68 = mul nsw <4 x i32> %66, %60
  %69 = add <4 x i32> %67, %53
  %70 = add <4 x i32> %68, %54
  %71 = add nuw i64 %52, 8
  %72 = icmp eq i64 %71, %42
  br i1 %72, label %73, label %51, !llvm.loop !25

73:                                               ; preds = %51
  %74 = add <4 x i32> %70, %69
  %75 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %74)
  %76 = icmp eq i64 %42, %39
  br i1 %76, label %93, label %77

77:                                               ; preds = %32, %73
  %78 = phi i64 [ 0, %32 ], [ %42, %73 ]
  %79 = phi i32 [ 0, %32 ], [ %75, %73 ]
  br label %80

80:                                               ; preds = %77, %80
  %81 = phi i64 [ %91, %80 ], [ %78, %77 ]
  %82 = phi i32 [ %90, %80 ], [ %79, %77 ]
  %83 = getelementptr inbounds i32, ptr %33, i64 %81
  %84 = load i32, ptr %83, align 4, !tbaa !5
  %85 = sub nsw i32 %84, %34
  %86 = getelementptr inbounds i32, ptr %36, i64 %81
  %87 = load i32, ptr %86, align 4, !tbaa !5
  %88 = sub nsw i32 %87, %38
  %89 = mul nsw i32 %88, %85
  %90 = add nsw i32 %89, %82
  %91 = add nuw nsw i64 %81, 1
  %92 = icmp eq i64 %91, %39
  br i1 %92, label %93, label %80, !llvm.loop !26

93:                                               ; preds = %80, %73, %28
  %94 = phi i32 [ 0, %28 ], [ %75, %73 ], [ %90, %80 ]
  %95 = add nsw i32 %30, -1
  %96 = sdiv i32 %94, %95
  %97 = getelementptr inbounds ptr, ptr %25, i64 %29
  %98 = load ptr, ptr %97, align 8, !tbaa !9
  %99 = getelementptr inbounds i32, ptr %98, i64 %21
  store i32 %96, ptr %99, align 4, !tbaa !5
  %100 = getelementptr inbounds i32, ptr %27, i64 %29
  store i32 %96, ptr %100, align 4, !tbaa !5
  %101 = add nsw i64 %29, 1
  %102 = load i32, ptr @num_rows, align 4, !tbaa !5
  %103 = sext i32 %102 to i64
  %104 = icmp slt i64 %101, %103
  br i1 %104, label %28, label %8, !llvm.loop !27

105:                                              ; preds = %8, %1
  ret ptr null
}

; Function Attrs: nounwind
declare i32 @pthread_mutex_lock(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @pthread_mutex_unlock(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local void @pthread_mean() local_unnamed_addr #0 {
  %1 = alloca %union.pthread_attr_t, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %1) #13
  %2 = load i32, ptr @num_procs, align 4, !tbaa !5
  %3 = sext i32 %2 to i64
  %4 = shl nsw i64 %3, 3
  %5 = tail call noalias ptr @malloc(i64 noundef %4) #15
  %6 = tail call noalias ptr @malloc(i64 noundef %4) #15
  %7 = call i32 @pthread_attr_init(ptr noundef nonnull %1) #13
  %8 = call i32 @pthread_attr_setscope(ptr noundef nonnull %1, i32 noundef 0) #13
  %9 = load i32, ptr @num_rows, align 4, !tbaa !5
  %10 = load i32, ptr @num_procs, align 4, !tbaa !5
  %11 = sdiv i32 %9, %10
  %12 = srem i32 %9, %10
  %13 = icmp sgt i32 %10, 0
  br i1 %13, label %16, label %33

14:                                               ; preds = %16
  %15 = icmp sgt i32 %30, 0
  br i1 %15, label %34, label %33

16:                                               ; preds = %0, %16
  %17 = phi i64 [ %29, %16 ], [ 0, %0 ]
  %18 = phi i32 [ %25, %16 ], [ 0, %0 ]
  %19 = phi i32 [ %22, %16 ], [ %12, %0 ]
  %20 = getelementptr inbounds %struct.mean_arg_t, ptr %6, i64 %17
  store i32 %18, ptr %20, align 4, !tbaa !17
  %21 = add nsw i32 %18, %11
  %22 = add nsw i32 %19, -1
  %23 = icmp sgt i32 %19, 0
  %24 = zext i1 %23 to i32
  %25 = add nsw i32 %21, %24
  %26 = getelementptr inbounds %struct.mean_arg_t, ptr %6, i64 %17, i32 1
  store i32 %25, ptr %26, align 4, !tbaa !19
  %27 = getelementptr inbounds i64, ptr %5, i64 %17
  %28 = call i32 @pthread_create(ptr noundef %27, ptr noundef nonnull %1, ptr noundef nonnull @calc_mean, ptr noundef nonnull %20) #13
  %29 = add nuw nsw i64 %17, 1
  %30 = load i32, ptr @num_procs, align 4, !tbaa !5
  %31 = sext i32 %30 to i64
  %32 = icmp slt i64 %29, %31
  br i1 %32, label %16, label %14, !llvm.loop !28

33:                                               ; preds = %34, %0, %14
  call void @free(ptr noundef %5) #13
  call void @free(ptr noundef %6) #13
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %1) #13
  ret void

34:                                               ; preds = %14, %34
  %35 = phi i64 [ %39, %34 ], [ 0, %14 ]
  %36 = getelementptr inbounds i64, ptr %5, i64 %35
  %37 = load i64, ptr %36, align 8, !tbaa !29
  %38 = call i32 @pthread_join(i64 noundef %37, ptr noundef null) #13
  %39 = add nuw nsw i64 %35, 1
  %40 = load i32, ptr @num_procs, align 4, !tbaa !5
  %41 = sext i32 %40 to i64
  %42 = icmp slt i64 %39, %41
  br i1 %42, label %34, label %33, !llvm.loop !31
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #9

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind
declare i32 @pthread_attr_init(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @pthread_attr_setscope(ptr noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #9

declare i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local void @pthread_cov() local_unnamed_addr #0 {
  %1 = alloca %union.pthread_attr_t, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %1) #13
  %2 = load i32, ptr @num_procs, align 4, !tbaa !5
  %3 = sext i32 %2 to i64
  %4 = shl nsw i64 %3, 3
  %5 = tail call noalias ptr @malloc(i64 noundef %4) #15
  %6 = tail call i32 @pthread_mutex_init(ptr noundef nonnull @row_lock, ptr noundef null) #13
  %7 = call i32 @pthread_attr_init(ptr noundef nonnull %1) #13
  %8 = call i32 @pthread_attr_setscope(ptr noundef nonnull %1, i32 noundef 0) #13
  store i32 0, ptr @next_row, align 4, !tbaa !5
  %9 = load i32, ptr @num_procs, align 4, !tbaa !5
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %13, label %21

11:                                               ; preds = %13
  %12 = icmp sgt i32 %18, 0
  br i1 %12, label %22, label %21

13:                                               ; preds = %0, %13
  %14 = phi i64 [ %17, %13 ], [ 0, %0 ]
  %15 = getelementptr inbounds i64, ptr %5, i64 %14
  %16 = call i32 @pthread_create(ptr noundef %15, ptr noundef nonnull %1, ptr noundef nonnull @calc_cov, ptr noundef null) #13
  %17 = add nuw nsw i64 %14, 1
  %18 = load i32, ptr @num_procs, align 4, !tbaa !5
  %19 = sext i32 %18 to i64
  %20 = icmp slt i64 %17, %19
  br i1 %20, label %13, label %11, !llvm.loop !32

21:                                               ; preds = %22, %0, %11
  call void @free(ptr noundef %5) #13
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %1) #13
  ret void

22:                                               ; preds = %11, %22
  %23 = phi i64 [ %27, %22 ], [ 0, %11 ]
  %24 = getelementptr inbounds i64, ptr %5, i64 %23
  %25 = load i64, ptr %24, align 8, !tbaa !29
  %26 = call i32 @pthread_join(i64 noundef %25, ptr noundef null) #13
  %27 = add nuw nsw i64 %23, 1
  %28 = load i32, ptr @num_procs, align 4, !tbaa !5
  %29 = sext i32 %28 to i64
  %30 = icmp slt i64 %27, %29
  br i1 %30, label %22, label %21, !llvm.loop !33
}

; Function Attrs: nounwind
declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  tail call void @parse_args(i32 noundef %0, ptr noundef %1)
  %3 = load i32, ptr @num_rows, align 4, !tbaa !5
  %4 = sext i32 %3 to i64
  %5 = shl nsw i64 %4, 3
  %6 = tail call noalias ptr @malloc(i64 noundef %5) #15
  store ptr %6, ptr @matrix, align 8, !tbaa !9
  %7 = icmp sgt i32 %3, 0
  %8 = load i32, ptr @num_cols, align 4, !tbaa !5
  br i1 %7, label %9, label %72

9:                                                ; preds = %2
  %10 = sext i32 %8 to i64
  %11 = shl nsw i64 %10, 2
  %12 = zext i32 %3 to i64
  br label %82

13:                                               ; preds = %82
  %14 = load ptr, ptr @matrix, align 8, !tbaa !9
  %15 = icmp sgt i32 %8, 0
  %16 = and i1 %7, %15
  br i1 %16, label %17, label %39

17:                                               ; preds = %13
  %18 = zext i32 %3 to i64
  %19 = zext i32 %8 to i64
  br label %20

20:                                               ; preds = %32, %17
  %21 = phi i64 [ 0, %17 ], [ %33, %32 ]
  %22 = getelementptr inbounds ptr, ptr %14, i64 %21
  br label %23

23:                                               ; preds = %23, %20
  %24 = phi i64 [ 0, %20 ], [ %30, %23 ]
  %25 = tail call i32 @rand() #13
  %26 = load i32, ptr @grid_size, align 4, !tbaa !5
  %27 = srem i32 %25, %26
  %28 = load ptr, ptr %22, align 8, !tbaa !9
  %29 = getelementptr inbounds i32, ptr %28, i64 %24
  store i32 %27, ptr %29, align 4, !tbaa !5
  %30 = add nuw nsw i64 %24, 1
  %31 = icmp eq i64 %30, %19
  br i1 %31, label %32, label %23, !llvm.loop !15

32:                                               ; preds = %23
  %33 = add nuw nsw i64 %21, 1
  %34 = icmp eq i64 %33, %18
  br i1 %34, label %35, label %20, !llvm.loop !16

35:                                               ; preds = %32
  %36 = load i32, ptr @num_cols, align 4, !tbaa !5
  %37 = load ptr, ptr @matrix, align 8, !tbaa !9
  %38 = load i32, ptr @num_rows, align 4, !tbaa !5
  br label %39

39:                                               ; preds = %35, %13
  %40 = phi i32 [ %38, %35 ], [ %3, %13 ]
  %41 = phi ptr [ %37, %35 ], [ %14, %13 ]
  %42 = phi i32 [ %36, %35 ], [ %8, %13 ]
  %43 = icmp sgt i32 %40, 0
  br i1 %43, label %44, label %72

44:                                               ; preds = %39
  %45 = icmp sgt i32 %42, 0
  br i1 %45, label %46, label %66

46:                                               ; preds = %44
  %47 = zext i32 %40 to i64
  %48 = zext i32 %42 to i64
  br label %49

49:                                               ; preds = %61, %46
  %50 = phi i64 [ 0, %46 ], [ %64, %61 ]
  %51 = getelementptr inbounds ptr, ptr %41, i64 %50
  br label %52

52:                                               ; preds = %52, %49
  %53 = phi i64 [ 0, %49 ], [ %59, %52 ]
  %54 = load ptr, ptr @stdout, align 8, !tbaa !9
  %55 = load ptr, ptr %51, align 8, !tbaa !9
  %56 = getelementptr inbounds i32, ptr %55, i64 %53
  %57 = load i32, ptr %56, align 4, !tbaa !5
  %58 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %54, ptr noundef nonnull @.str.5, i32 noundef %57)
  %59 = add nuw nsw i64 %53, 1
  %60 = icmp eq i64 %59, %48
  br i1 %60, label %61, label %52, !llvm.loop !13

61:                                               ; preds = %52
  %62 = load ptr, ptr @stdout, align 8, !tbaa !9
  %63 = tail call i32 @fputc(i32 10, ptr %62)
  %64 = add nuw nsw i64 %50, 1
  %65 = icmp eq i64 %64, %47
  br i1 %65, label %72, label %49, !llvm.loop !14

66:                                               ; preds = %44, %66
  %67 = phi i32 [ %70, %66 ], [ 0, %44 ]
  %68 = load ptr, ptr @stdout, align 8, !tbaa !9
  %69 = tail call i32 @fputc(i32 10, ptr %68)
  %70 = add nuw nsw i32 %67, 1
  %71 = icmp eq i32 %70, %40
  br i1 %71, label %72, label %66, !llvm.loop !14

72:                                               ; preds = %66, %61, %2, %39
  %73 = load i32, ptr @num_rows, align 4, !tbaa !5
  %74 = sext i32 %73 to i64
  %75 = shl nsw i64 %74, 2
  %76 = tail call noalias ptr @malloc(i64 noundef %75) #15
  store ptr %76, ptr @mean, align 8, !tbaa !9
  %77 = shl nsw i64 %74, 3
  %78 = tail call noalias ptr @malloc(i64 noundef %77) #15
  store ptr %78, ptr @cov, align 8, !tbaa !9
  %79 = icmp sgt i32 %73, 0
  br i1 %79, label %80, label %89

80:                                               ; preds = %72
  %81 = zext i32 %73 to i64
  br label %115

82:                                               ; preds = %9, %82
  %83 = phi i64 [ 0, %9 ], [ %87, %82 ]
  %84 = tail call noalias ptr @malloc(i64 noundef %11) #15
  %85 = load ptr, ptr @matrix, align 8, !tbaa !9
  %86 = getelementptr inbounds ptr, ptr %85, i64 %83
  store ptr %84, ptr %86, align 8, !tbaa !9
  %87 = add nuw nsw i64 %83, 1
  %88 = icmp eq i64 %87, %12
  br i1 %88, label %13, label %82, !llvm.loop !34

89:                                               ; preds = %115, %72
  tail call void @pthread_mean()
  tail call void @pthread_cov()
  %90 = load ptr, ptr @cov, align 8, !tbaa !9
  %91 = load i32, ptr @num_rows, align 4, !tbaa !5
  %92 = icmp sgt i32 %91, 0
  br i1 %92, label %93, label %122

93:                                               ; preds = %89
  %94 = zext i32 %91 to i64
  br label %95

95:                                               ; preds = %107, %93
  %96 = phi i64 [ 0, %93 ], [ %110, %107 ]
  %97 = getelementptr inbounds ptr, ptr %90, i64 %96
  br label %98

98:                                               ; preds = %98, %95
  %99 = phi i64 [ 0, %95 ], [ %105, %98 ]
  %100 = load ptr, ptr @stdout, align 8, !tbaa !9
  %101 = load ptr, ptr %97, align 8, !tbaa !9
  %102 = getelementptr inbounds i32, ptr %101, i64 %99
  %103 = load i32, ptr %102, align 4, !tbaa !5
  %104 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %100, ptr noundef nonnull @.str.5, i32 noundef %103)
  %105 = add nuw nsw i64 %99, 1
  %106 = icmp eq i64 %105, %94
  br i1 %106, label %107, label %98, !llvm.loop !13

107:                                              ; preds = %98
  %108 = load ptr, ptr @stdout, align 8, !tbaa !9
  %109 = tail call i32 @fputc(i32 10, ptr %108)
  %110 = add nuw nsw i64 %96, 1
  %111 = icmp eq i64 %110, %94
  br i1 %111, label %112, label %95, !llvm.loop !14

112:                                              ; preds = %107
  %113 = load i32, ptr @num_rows, align 4, !tbaa !5
  %114 = icmp sgt i32 %113, 0
  br i1 %114, label %126, label %122

115:                                              ; preds = %80, %115
  %116 = phi i64 [ 0, %80 ], [ %120, %115 ]
  %117 = tail call noalias ptr @malloc(i64 noundef %75) #15
  %118 = load ptr, ptr @cov, align 8, !tbaa !9
  %119 = getelementptr inbounds ptr, ptr %118, i64 %116
  store ptr %117, ptr %119, align 8, !tbaa !9
  %120 = add nuw nsw i64 %116, 1
  %121 = icmp eq i64 %120, %81
  br i1 %121, label %89, label %115, !llvm.loop !35

122:                                              ; preds = %126, %89, %112
  %123 = load ptr, ptr @matrix, align 8, !tbaa !9
  tail call void @free(ptr noundef %123) #13
  %124 = load ptr, ptr @cov, align 8, !tbaa !9
  tail call void @free(ptr noundef %124) #13
  %125 = load ptr, ptr @mean, align 8, !tbaa !9
  tail call void @free(ptr noundef %125) #13
  ret i32 0

126:                                              ; preds = %112, %126
  %127 = phi i64 [ %134, %126 ], [ 0, %112 ]
  %128 = load ptr, ptr @matrix, align 8, !tbaa !9
  %129 = getelementptr inbounds ptr, ptr %128, i64 %127
  %130 = load ptr, ptr %129, align 8, !tbaa !9
  tail call void @free(ptr noundef %130) #13
  %131 = load ptr, ptr @cov, align 8, !tbaa !9
  %132 = getelementptr inbounds ptr, ptr %131, i64 %127
  %133 = load ptr, ptr %132, align 8, !tbaa !9
  tail call void @free(ptr noundef %133) #13
  %134 = add nuw nsw i64 %127, 1
  %135 = load i32, ptr @num_rows, align 4, !tbaa !5
  %136 = sext i32 %135 to i64
  %137 = icmp slt i64 %134, %136
  br i1 %137, label %126, label %122, !llvm.loop !36
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #10 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { nounwind }
attributes #14 = { noreturn nounwind }
attributes #15 = { nounwind allocsize(0) }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = distinct !{!13, !12}
!14 = distinct !{!14, !12}
!15 = distinct !{!15, !12}
!16 = distinct !{!16, !12}
!17 = !{!18, !6, i64 0}
!18 = !{!"", !6, i64 0, !6, i64 4}
!19 = !{!18, !6, i64 4}
!20 = distinct !{!20, !12, !21, !22}
!21 = !{!"llvm.loop.isvectorized", i32 1}
!22 = !{!"llvm.loop.unroll.runtime.disable"}
!23 = distinct !{!23, !12}
!24 = distinct !{!24, !12, !22, !21}
!25 = distinct !{!25, !12, !21, !22}
!26 = distinct !{!26, !12, !22, !21}
!27 = distinct !{!27, !12}
!28 = distinct !{!28, !12}
!29 = !{!30, !30, i64 0}
!30 = !{!"long", !7, i64 0}
!31 = distinct !{!31, !12}
!32 = distinct !{!32, !12}
!33 = distinct !{!33, !12}
!34 = distinct !{!34, !12}
!35 = distinct !{!35, !12}
!36 = distinct !{!36, !12}
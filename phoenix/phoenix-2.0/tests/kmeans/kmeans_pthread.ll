; ModuleID = 'kmeans-pthread.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.thread_arg = type { i32, i32, ptr }
%union.pthread_attr_t = type { i64, [48 x i8] }

@num_pts = dso_local local_unnamed_addr global i32 0, align 4
@dim = dso_local local_unnamed_addr global i32 0, align 4
@stdout = external local_unnamed_addr global ptr, align 8
@.str = private unnamed_addr constant [5 x i8] c"%5d \00", align 1
@num_points = dso_local local_unnamed_addr global i32 0, align 4
@num_means = dso_local local_unnamed_addr global i32 0, align 4
@grid_size = dso_local local_unnamed_addr global i32 0, align 4
@.str.2 = private unnamed_addr constant [9 x i8] c"d:c:p:s:\00", align 1
@optarg = external local_unnamed_addr global ptr, align 8
@.str.3 = private unnamed_addr constant [74 x i8] c"Usage: %s -d <dim> -c <clusters> -p <points> -s <gridsize> <num_threads>\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"Dimension = %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [25 x i8] c"Number of clusters = %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"Number of points = %d\0A\00", align 1
@.str.8 = private unnamed_addr constant [29 x i8] c"Size of each dimension = %d\0A\00", align 1
@points = dso_local local_unnamed_addr global ptr null, align 8
@means = dso_local local_unnamed_addr global ptr null, align 8
@clusters = dso_local local_unnamed_addr global ptr null, align 8
@modified = dso_local local_unnamed_addr global i32 0, align 4
@optind = external local_unnamed_addr global i32, align 4
@.str.9 = private unnamed_addr constant [19 x i8] c"Generating points\0A\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"Generating means\0A\00", align 1
@.str.11 = private unnamed_addr constant [93 x i8] c"Error at line\0A\09(pid = (pthread_t *)malloc(sizeof(pthread_t) * num_procs)) == NULL\0ASystem Msg\00", align 1
@.str.12 = private unnamed_addr constant [80 x i8] c"((pid = (pthread_t *)malloc(sizeof(pthread_t) * num_procs)) == ((void*)0)) == 0\00", align 1
@.str.13 = private unnamed_addr constant [17 x i8] c"kmeans-pthread.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str.15 = private unnamed_addr constant [83 x i8] c"Error at line\0A\09(arg = (thread_arg *)malloc(sizeof(thread_arg))) == NULL\0ASystem Msg\00", align 1
@.str.16 = private unnamed_addr constant [70 x i8] c"((arg = (thread_arg *)malloc(sizeof(thread_arg))) == ((void*)0)) == 0\00", align 1
@.str.17 = private unnamed_addr constant [108 x i8] c"Error at line\0A\09(pthread_create(&(pid[num_threads++]), &attr, find_clusters, (void *)(arg))) != 0\0ASystem Msg\00", align 1
@.str.18 = private unnamed_addr constant [89 x i8] c"((pthread_create(&(pid[num_threads++]), &attr, find_clusters, (void *)(arg))) != 0) == 0\00", align 1
@.str.19 = private unnamed_addr constant [25 x i8] c"num_threads <= num_procs\00", align 1
@.str.20 = private unnamed_addr constant [105 x i8] c"Error at line\0A\09(pthread_create(&(pid[num_threads++]), &attr, calc_means, (void *)(arg))) != 0\0ASystem Msg\00", align 1
@.str.21 = private unnamed_addr constant [86 x i8] c"((pthread_create(&(pid[num_threads++]), &attr, calc_means, (void *)(arg))) != 0) == 0\00", align 1
@.str.22 = private unnamed_addr constant [16 x i8] c"\0A\0AFinal means:\0A\00", align 1
@str = private unnamed_addr constant [70 x i8] c"Illegal argument value. All values must be numeric and greater than 0\00", align 1
@str.23 = private unnamed_addr constant [29 x i8] c"Starting iterative algorithm\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local void @dump_points(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %4, label %28

4:                                                ; preds = %2
  %5 = zext i32 %1 to i64
  br label %6

6:                                                ; preds = %4, %23
  %7 = phi i64 [ 0, %4 ], [ %26, %23 ]
  %8 = load i32, ptr @dim, align 4, !tbaa !5
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %23

10:                                               ; preds = %6
  %11 = getelementptr inbounds ptr, ptr %0, i64 %7
  br label %12

12:                                               ; preds = %10, %12
  %13 = phi i64 [ 0, %10 ], [ %19, %12 ]
  %14 = load ptr, ptr @stdout, align 8, !tbaa !9
  %15 = load ptr, ptr %11, align 8, !tbaa !9
  %16 = getelementptr inbounds i32, ptr %15, i64 %13
  %17 = load i32, ptr %16, align 4, !tbaa !5
  %18 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %14, ptr noundef nonnull @.str, i32 noundef %17)
  %19 = add nuw nsw i64 %13, 1
  %20 = load i32, ptr @dim, align 4, !tbaa !5
  %21 = sext i32 %20 to i64
  %22 = icmp slt i64 %19, %21
  br i1 %22, label %12, label %23, !llvm.loop !11

23:                                               ; preds = %12, %6
  %24 = load ptr, ptr @stdout, align 8, !tbaa !9
  %25 = tail call i32 @fputc(i32 10, ptr %24)
  %26 = add nuw nsw i64 %7, 1
  %27 = icmp eq i64 %26, %5
  br i1 %27, label %28, label %6, !llvm.loop !13

28:                                               ; preds = %23, %2
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @parse_args(i32 noundef %0, ptr noundef %1) local_unnamed_addr #3 {
  store i32 100000, ptr @num_points, align 4, !tbaa !5
  store i32 100, ptr @num_means, align 4, !tbaa !5
  store i32 3, ptr @dim, align 4, !tbaa !5
  store i32 1000, ptr @grid_size, align 4, !tbaa !5
  br label %3

3:                                                ; preds = %16, %2
  %4 = tail call i32 @getopt(i32 noundef %0, ptr noundef %1, ptr noundef nonnull @.str.2) #15
  switch i32 %4, label %16 [
    i32 -1, label %17
    i32 100, label %11
    i32 99, label %5
    i32 112, label %6
    i32 115, label %7
    i32 63, label %8
  ]

5:                                                ; preds = %3
  br label %11

6:                                                ; preds = %3
  br label %11

7:                                                ; preds = %3
  br label %11

8:                                                ; preds = %3
  %9 = load ptr, ptr %1, align 8, !tbaa !9
  %10 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, ptr noundef %9)
  tail call void @exit(i32 noundef 1) #16
  unreachable

11:                                               ; preds = %3, %5, %6, %7
  %12 = phi ptr [ @grid_size, %7 ], [ @num_points, %6 ], [ @num_means, %5 ], [ @dim, %3 ]
  %13 = load ptr, ptr @optarg, align 8, !tbaa !9
  %14 = tail call i64 @strtol(ptr nocapture noundef nonnull %13, ptr noundef null, i32 noundef 10) #15
  %15 = trunc i64 %14 to i32
  store i32 %15, ptr %12, align 4, !tbaa !5
  br label %16

16:                                               ; preds = %11, %3
  br label %3, !llvm.loop !14

17:                                               ; preds = %3
  %18 = load i32, ptr @dim, align 4, !tbaa !5
  %19 = icmp slt i32 %18, 1
  %20 = load i32, ptr @num_means, align 4
  %21 = icmp slt i32 %20, 1
  %22 = select i1 %19, i1 true, i1 %21
  %23 = load i32, ptr @num_points, align 4
  %24 = icmp slt i32 %23, 1
  %25 = select i1 %22, i1 true, i1 %24
  %26 = load i32, ptr @grid_size, align 4
  %27 = icmp slt i32 %26, 1
  %28 = select i1 %25, i1 true, i1 %27
  br i1 %28, label %29, label %31

29:                                               ; preds = %17
  %30 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  tail call void @exit(i32 noundef 1) #16
  unreachable

31:                                               ; preds = %17
  %32 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef %18)
  %33 = load i32, ptr @num_means, align 4, !tbaa !5
  %34 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i32 noundef %33)
  %35 = load i32, ptr @num_points, align 4, !tbaa !5
  %36 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, i32 noundef %35)
  %37 = load i32, ptr @grid_size, align 4, !tbaa !5
  %38 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, i32 noundef %37)
  ret void
}

; Function Attrs: nounwind
declare i32 @getopt(i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @generate_points(ptr nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %4, label %30

4:                                                ; preds = %2
  %5 = load i32, ptr @dim, align 4, !tbaa !5
  %6 = icmp sgt i32 %5, 0
  br i1 %6, label %7, label %30

7:                                                ; preds = %4
  %8 = zext i32 %1 to i64
  br label %9

9:                                                ; preds = %7, %26
  %10 = phi i32 [ %5, %7 ], [ %27, %26 ]
  %11 = phi i64 [ 0, %7 ], [ %28, %26 ]
  %12 = icmp sgt i32 %10, 0
  br i1 %12, label %13, label %26

13:                                               ; preds = %9
  %14 = getelementptr inbounds ptr, ptr %0, i64 %11
  br label %15

15:                                               ; preds = %13, %15
  %16 = phi i64 [ 0, %13 ], [ %22, %15 ]
  %17 = tail call i32 @rand() #15
  %18 = load i32, ptr @grid_size, align 4, !tbaa !5
  %19 = srem i32 %17, %18
  %20 = load ptr, ptr %14, align 8, !tbaa !9
  %21 = getelementptr inbounds i32, ptr %20, i64 %16
  store i32 %19, ptr %21, align 4, !tbaa !5
  %22 = add nuw nsw i64 %16, 1
  %23 = load i32, ptr @dim, align 4, !tbaa !5
  %24 = sext i32 %23 to i64
  %25 = icmp slt i64 %22, %24
  br i1 %25, label %15, label %26, !llvm.loop !15

26:                                               ; preds = %15, %9
  %27 = phi i32 [ %10, %9 ], [ %23, %15 ]
  %28 = add nuw nsw i64 %11, 1
  %29 = icmp eq i64 %28, %8
  br i1 %29, label %30, label %9, !llvm.loop !16

30:                                               ; preds = %26, %4, %2
  ret void
}

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #4

; Function Attrs: nofree norecurse nosync nounwind memory(read, argmem: readwrite, inaccessiblemem: none) uwtable
define dso_local void @add_to_sum(ptr nocapture noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #7 {
  %3 = load i32, ptr @dim, align 4, !tbaa !5
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %2, %5
  %6 = phi i64 [ %12, %5 ], [ 0, %2 ]
  %7 = getelementptr inbounds i32, ptr %1, i64 %6
  %8 = load i32, ptr %7, align 4, !tbaa !5
  %9 = getelementptr inbounds i32, ptr %0, i64 %6
  %10 = load i32, ptr %9, align 4, !tbaa !5
  %11 = add nsw i32 %10, %8
  store i32 %11, ptr %9, align 4, !tbaa !5
  %12 = add nuw nsw i64 %6, 1
  %13 = load i32, ptr @dim, align 4, !tbaa !5
  %14 = sext i32 %13 to i64
  %15 = icmp slt i64 %12, %14
  br i1 %15, label %5, label %16, !llvm.loop !18

16:                                               ; preds = %5, %2
  ret void
}

; Function Attrs: nofree nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local noalias ptr @find_clusters(ptr nocapture noundef readonly %0) #8 {
  %2 = getelementptr inbounds %struct.thread_arg, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !19
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %146

5:                                                ; preds = %1
  %6 = load i32, ptr %0, align 8, !tbaa !21
  %7 = add nsw i32 %3, %6
  %8 = load ptr, ptr @points, align 8, !tbaa !9
  %9 = load ptr, ptr @means, align 8, !tbaa !9
  %10 = load ptr, ptr %9, align 8, !tbaa !9
  %11 = load ptr, ptr @clusters, align 8, !tbaa !9
  %12 = sext i32 %6 to i64
  %13 = sext i32 %7 to i64
  %14 = load i32, ptr @dim, align 4, !tbaa !5
  br label %15

15:                                               ; preds = %5, %142
  %16 = phi i32 [ %14, %5 ], [ %143, %142 ]
  %17 = phi i64 [ %12, %5 ], [ %144, %142 ]
  %18 = getelementptr inbounds ptr, ptr %8, i64 %17
  %19 = load ptr, ptr %18, align 8, !tbaa !9
  %20 = icmp sgt i32 %16, 0
  br i1 %20, label %21, label %69

21:                                               ; preds = %15
  %22 = zext i32 %16 to i64
  %23 = icmp ult i32 %16, 8
  br i1 %23, label %50, label %24

24:                                               ; preds = %21
  %25 = and i64 %22, 4294967288
  br label %26

26:                                               ; preds = %26, %24
  %27 = phi i64 [ 0, %24 ], [ %44, %26 ]
  %28 = phi <4 x i32> [ zeroinitializer, %24 ], [ %42, %26 ]
  %29 = phi <4 x i32> [ zeroinitializer, %24 ], [ %43, %26 ]
  %30 = getelementptr inbounds i32, ptr %19, i64 %27
  %31 = load <4 x i32>, ptr %30, align 4, !tbaa !5
  %32 = getelementptr inbounds i32, ptr %30, i64 4
  %33 = load <4 x i32>, ptr %32, align 4, !tbaa !5
  %34 = getelementptr inbounds i32, ptr %10, i64 %27
  %35 = load <4 x i32>, ptr %34, align 4, !tbaa !5
  %36 = getelementptr inbounds i32, ptr %34, i64 4
  %37 = load <4 x i32>, ptr %36, align 4, !tbaa !5
  %38 = sub nsw <4 x i32> %31, %35
  %39 = sub nsw <4 x i32> %33, %37
  %40 = mul nsw <4 x i32> %38, %38
  %41 = mul nsw <4 x i32> %39, %39
  %42 = add <4 x i32> %40, %28
  %43 = add <4 x i32> %41, %29
  %44 = add nuw i64 %27, 8
  %45 = icmp eq i64 %44, %25
  br i1 %45, label %46, label %26, !llvm.loop !22

46:                                               ; preds = %26
  %47 = add <4 x i32> %43, %42
  %48 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %47)
  %49 = icmp eq i64 %25, %22
  br i1 %49, label %65, label %50

50:                                               ; preds = %21, %46
  %51 = phi i64 [ 0, %21 ], [ %25, %46 ]
  %52 = phi i32 [ 0, %21 ], [ %48, %46 ]
  br label %53

53:                                               ; preds = %50, %53
  %54 = phi i64 [ %63, %53 ], [ %51, %50 ]
  %55 = phi i32 [ %62, %53 ], [ %52, %50 ]
  %56 = getelementptr inbounds i32, ptr %19, i64 %54
  %57 = load i32, ptr %56, align 4, !tbaa !5
  %58 = getelementptr inbounds i32, ptr %10, i64 %54
  %59 = load i32, ptr %58, align 4, !tbaa !5
  %60 = sub nsw i32 %57, %59
  %61 = mul nsw i32 %60, %60
  %62 = add i32 %61, %55
  %63 = add nuw nsw i64 %54, 1
  %64 = icmp eq i64 %63, %22
  br i1 %64, label %65, label %53, !llvm.loop !25

65:                                               ; preds = %53, %46
  %66 = phi i32 [ %48, %46 ], [ %62, %53 ]
  %67 = load i32, ptr @num_means, align 4, !tbaa !5
  %68 = icmp sgt i32 %67, 1
  br i1 %68, label %72, label %135

69:                                               ; preds = %15
  %70 = load i32, ptr @num_means, align 4, !tbaa !5
  %71 = icmp sgt i32 %70, 1
  br i1 %71, label %74, label %135

72:                                               ; preds = %65
  %73 = zext i32 %16 to i64
  br i1 %20, label %78, label %74

74:                                               ; preds = %69, %72
  %75 = phi i32 [ %66, %72 ], [ 0, %69 ]
  %76 = icmp ne i32 %75, 0
  %77 = zext i1 %76 to i32
  br label %135

78:                                               ; preds = %72
  %79 = zext i32 %67 to i64
  %80 = icmp ult i32 %16, 8
  %81 = and i64 %22, 4294967288
  %82 = icmp eq i64 %81, %22
  br label %83

83:                                               ; preds = %78, %127
  %84 = phi i64 [ 1, %78 ], [ %133, %127 ]
  %85 = phi i32 [ 0, %78 ], [ %132, %127 ]
  %86 = phi i32 [ %66, %78 ], [ %130, %127 ]
  %87 = getelementptr inbounds ptr, ptr %9, i64 %84
  %88 = load ptr, ptr %87, align 8, !tbaa !9
  br i1 %80, label %112, label %89

89:                                               ; preds = %83, %89
  %90 = phi i64 [ %107, %89 ], [ 0, %83 ]
  %91 = phi <4 x i32> [ %105, %89 ], [ zeroinitializer, %83 ]
  %92 = phi <4 x i32> [ %106, %89 ], [ zeroinitializer, %83 ]
  %93 = getelementptr inbounds i32, ptr %19, i64 %90
  %94 = load <4 x i32>, ptr %93, align 4, !tbaa !5
  %95 = getelementptr inbounds i32, ptr %93, i64 4
  %96 = load <4 x i32>, ptr %95, align 4, !tbaa !5
  %97 = getelementptr inbounds i32, ptr %88, i64 %90
  %98 = load <4 x i32>, ptr %97, align 4, !tbaa !5
  %99 = getelementptr inbounds i32, ptr %97, i64 4
  %100 = load <4 x i32>, ptr %99, align 4, !tbaa !5
  %101 = sub nsw <4 x i32> %94, %98
  %102 = sub nsw <4 x i32> %96, %100
  %103 = mul nsw <4 x i32> %101, %101
  %104 = mul nsw <4 x i32> %102, %102
  %105 = add <4 x i32> %103, %91
  %106 = add <4 x i32> %104, %92
  %107 = add nuw i64 %90, 8
  %108 = icmp eq i64 %107, %81
  br i1 %108, label %109, label %89, !llvm.loop !26

109:                                              ; preds = %89
  %110 = add <4 x i32> %106, %105
  %111 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %110)
  br i1 %82, label %127, label %112

112:                                              ; preds = %83, %109
  %113 = phi i64 [ 0, %83 ], [ %81, %109 ]
  %114 = phi i32 [ 0, %83 ], [ %111, %109 ]
  br label %115

115:                                              ; preds = %112, %115
  %116 = phi i64 [ %125, %115 ], [ %113, %112 ]
  %117 = phi i32 [ %124, %115 ], [ %114, %112 ]
  %118 = getelementptr inbounds i32, ptr %19, i64 %116
  %119 = load i32, ptr %118, align 4, !tbaa !5
  %120 = getelementptr inbounds i32, ptr %88, i64 %116
  %121 = load i32, ptr %120, align 4, !tbaa !5
  %122 = sub nsw i32 %119, %121
  %123 = mul nsw i32 %122, %122
  %124 = add i32 %123, %117
  %125 = add nuw nsw i64 %116, 1
  %126 = icmp eq i64 %125, %73
  br i1 %126, label %127, label %115, !llvm.loop !27

127:                                              ; preds = %115, %109
  %128 = phi i32 [ %111, %109 ], [ %124, %115 ]
  %129 = icmp ult i32 %128, %86
  %130 = tail call i32 @llvm.umin.i32(i32 %128, i32 %86)
  %131 = trunc i64 %84 to i32
  %132 = select i1 %129, i32 %131, i32 %85
  %133 = add nuw nsw i64 %84, 1
  %134 = icmp eq i64 %133, %79
  br i1 %134, label %135, label %83, !llvm.loop !28

135:                                              ; preds = %127, %74, %69, %65
  %136 = phi i32 [ 0, %65 ], [ 0, %69 ], [ %77, %74 ], [ %132, %127 ]
  %137 = getelementptr inbounds i32, ptr %11, i64 %17
  %138 = load i32, ptr %137, align 4, !tbaa !5
  %139 = icmp eq i32 %138, %136
  br i1 %139, label %142, label %140

140:                                              ; preds = %135
  store i32 %136, ptr %137, align 4, !tbaa !5
  store i32 1, ptr @modified, align 4, !tbaa !5
  %141 = load i32, ptr @dim, align 4, !tbaa !5
  br label %142

142:                                              ; preds = %135, %140
  %143 = phi i32 [ %16, %135 ], [ %141, %140 ]
  %144 = add nsw i64 %17, 1
  %145 = icmp slt i64 %144, %13
  br i1 %145, label %15, label %146, !llvm.loop !29

146:                                              ; preds = %142, %1
  ret ptr null
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #9

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @calc_means(ptr nocapture noundef readonly %0) #3 {
  %2 = getelementptr inbounds %struct.thread_arg, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !19
  %4 = getelementptr inbounds %struct.thread_arg, ptr %0, i64 0, i32 2
  %5 = load ptr, ptr %4, align 8, !tbaa !30
  %6 = icmp sgt i32 %3, 0
  br i1 %6, label %7, label %85

7:                                                ; preds = %1
  %8 = load i32, ptr %0, align 8, !tbaa !21
  %9 = add nsw i32 %3, %8
  %10 = sext i32 %8 to i64
  %11 = sext i32 %9 to i64
  %12 = load i32, ptr @dim, align 4, !tbaa !5
  br label %13

13:                                               ; preds = %7, %81
  %14 = phi i32 [ %12, %7 ], [ %82, %81 ]
  %15 = phi i64 [ %10, %7 ], [ %83, %81 ]
  %16 = sext i32 %14 to i64
  %17 = shl nsw i64 %16, 2
  tail call void @llvm.memset.p0.i64(ptr align 4 %5, i8 0, i64 %17, i1 false)
  %18 = load i32, ptr @num_points, align 4, !tbaa !5
  %19 = icmp sgt i32 %18, 0
  br i1 %19, label %20, label %29

20:                                               ; preds = %13
  %21 = load ptr, ptr @clusters, align 8, !tbaa !9
  %22 = load ptr, ptr @points, align 8
  %23 = trunc i64 %15 to i32
  br label %35

24:                                               ; preds = %64
  %25 = load i32, ptr @dim, align 4, !tbaa !5
  %26 = icmp slt i32 %25, 1
  %27 = icmp eq i32 %67, 0
  %28 = select i1 %26, i1 true, i1 %27
  br i1 %28, label %81, label %31

29:                                               ; preds = %13
  %30 = load i32, ptr @dim, align 4, !tbaa !5
  br label %81

31:                                               ; preds = %24
  %32 = load ptr, ptr @means, align 8
  %33 = getelementptr inbounds ptr, ptr %32, i64 %15
  %34 = load ptr, ptr %33, align 8, !tbaa !9
  br label %71

35:                                               ; preds = %20, %64
  %36 = phi i32 [ %18, %20 ], [ %65, %64 ]
  %37 = phi i32 [ %18, %20 ], [ %66, %64 ]
  %38 = phi i64 [ 0, %20 ], [ %68, %64 ]
  %39 = phi i32 [ 0, %20 ], [ %67, %64 ]
  %40 = getelementptr inbounds i32, ptr %21, i64 %38
  %41 = load i32, ptr %40, align 4, !tbaa !5
  %42 = icmp eq i32 %41, %23
  br i1 %42, label %43, label %64

43:                                               ; preds = %35
  %44 = getelementptr inbounds ptr, ptr %22, i64 %38
  %45 = load ptr, ptr %44, align 8, !tbaa !9
  %46 = load i32, ptr @dim, align 4, !tbaa !5
  %47 = icmp sgt i32 %46, 0
  br i1 %47, label %48, label %61

48:                                               ; preds = %43, %48
  %49 = phi i64 [ %55, %48 ], [ 0, %43 ]
  %50 = getelementptr inbounds i32, ptr %45, i64 %49
  %51 = load i32, ptr %50, align 4, !tbaa !5
  %52 = getelementptr inbounds i32, ptr %5, i64 %49
  %53 = load i32, ptr %52, align 4, !tbaa !5
  %54 = add nsw i32 %53, %51
  store i32 %54, ptr %52, align 4, !tbaa !5
  %55 = add nuw nsw i64 %49, 1
  %56 = load i32, ptr @dim, align 4, !tbaa !5
  %57 = sext i32 %56 to i64
  %58 = icmp slt i64 %55, %57
  br i1 %58, label %48, label %59, !llvm.loop !18

59:                                               ; preds = %48
  %60 = load i32, ptr @num_points, align 4, !tbaa !5
  br label %61

61:                                               ; preds = %59, %43
  %62 = phi i32 [ %60, %59 ], [ %36, %43 ]
  %63 = add nsw i32 %39, 1
  br label %64

64:                                               ; preds = %35, %61
  %65 = phi i32 [ %62, %61 ], [ %36, %35 ]
  %66 = phi i32 [ %62, %61 ], [ %37, %35 ]
  %67 = phi i32 [ %63, %61 ], [ %39, %35 ]
  %68 = add nuw nsw i64 %38, 1
  %69 = sext i32 %66 to i64
  %70 = icmp slt i64 %68, %69
  br i1 %70, label %35, label %24, !llvm.loop !31

71:                                               ; preds = %31, %71
  %72 = phi i64 [ 0, %31 ], [ %77, %71 ]
  %73 = getelementptr inbounds i32, ptr %5, i64 %72
  %74 = load i32, ptr %73, align 4, !tbaa !5
  %75 = sdiv i32 %74, %67
  %76 = getelementptr inbounds i32, ptr %34, i64 %72
  store i32 %75, ptr %76, align 4, !tbaa !5
  %77 = add nuw nsw i64 %72, 1
  %78 = load i32, ptr @dim, align 4, !tbaa !5
  %79 = sext i32 %78 to i64
  %80 = icmp slt i64 %77, %79
  br i1 %80, label %71, label %81, !llvm.loop !32

81:                                               ; preds = %71, %29, %24
  %82 = phi i32 [ %25, %24 ], [ %30, %29 ], [ %78, %71 ]
  %83 = add nsw i64 %15, 1
  %84 = icmp slt i64 %83, %11
  br i1 %84, label %13, label %85, !llvm.loop !33

85:                                               ; preds = %81, %1
  tail call void @free(ptr noundef %5) #15
  ret ptr null
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #10

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #11

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) local_unnamed_addr #3 {
  %3 = alloca %union.pthread_attr_t, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %3) #15
  tail call void @parse_args(i32 noundef %0, ptr noundef %1)
  %4 = load i32, ptr @optind, align 4, !tbaa !5
  %5 = icmp slt i32 %4, %0
  br i1 %5, label %9, label %6

6:                                                ; preds = %2
  %7 = load ptr, ptr %1, align 8, !tbaa !9
  %8 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, ptr noundef %7)
  tail call void @exit(i32 noundef 1) #16
  unreachable

9:                                                ; preds = %2
  %10 = sext i32 %4 to i64
  %11 = getelementptr inbounds ptr, ptr %1, i64 %10
  %12 = load ptr, ptr %11, align 8, !tbaa !9
  %13 = tail call i64 @strtol(ptr nocapture noundef nonnull %12, ptr noundef null, i32 noundef 10) #15
  %14 = trunc i64 %13 to i32
  %15 = load i32, ptr @num_points, align 4, !tbaa !5
  %16 = sext i32 %15 to i64
  %17 = shl nsw i64 %16, 3
  %18 = tail call noalias ptr @malloc(i64 noundef %17) #17
  store ptr %18, ptr @points, align 8, !tbaa !9
  %19 = icmp sgt i32 %15, 0
  br i1 %19, label %20, label %32

20:                                               ; preds = %9
  %21 = load i32, ptr @dim, align 4, !tbaa !5
  %22 = sext i32 %21 to i64
  %23 = shl nsw i64 %22, 2
  %24 = zext i32 %15 to i64
  br label %25

25:                                               ; preds = %20, %25
  %26 = phi i64 [ 0, %20 ], [ %30, %25 ]
  %27 = tail call noalias ptr @malloc(i64 noundef %23) #17
  %28 = load ptr, ptr @points, align 8, !tbaa !9
  %29 = getelementptr inbounds ptr, ptr %28, i64 %26
  store ptr %27, ptr %29, align 8, !tbaa !9
  %30 = add nuw nsw i64 %26, 1
  %31 = icmp eq i64 %30, %24
  br i1 %31, label %32, label %25, !llvm.loop !34

32:                                               ; preds = %25, %9
  %33 = load ptr, ptr @stdout, align 8, !tbaa !9
  %34 = tail call i64 @fwrite(ptr nonnull @.str.9, i64 18, i64 1, ptr %33)
  %35 = load ptr, ptr @points, align 8, !tbaa !9
  %36 = load i32, ptr @num_points, align 4, !tbaa !5
  %37 = icmp sgt i32 %36, 0
  br i1 %37, label %38, label %64

38:                                               ; preds = %32
  %39 = load i32, ptr @dim, align 4, !tbaa !5
  %40 = icmp sgt i32 %39, 0
  br i1 %40, label %41, label %64

41:                                               ; preds = %38
  %42 = zext i32 %36 to i64
  br label %43

43:                                               ; preds = %60, %41
  %44 = phi i32 [ %39, %41 ], [ %61, %60 ]
  %45 = phi i64 [ 0, %41 ], [ %62, %60 ]
  %46 = icmp sgt i32 %44, 0
  br i1 %46, label %47, label %60

47:                                               ; preds = %43
  %48 = getelementptr inbounds ptr, ptr %35, i64 %45
  br label %49

49:                                               ; preds = %49, %47
  %50 = phi i64 [ 0, %47 ], [ %56, %49 ]
  %51 = tail call i32 @rand() #15
  %52 = load i32, ptr @grid_size, align 4, !tbaa !5
  %53 = srem i32 %51, %52
  %54 = load ptr, ptr %48, align 8, !tbaa !9
  %55 = getelementptr inbounds i32, ptr %54, i64 %50
  store i32 %53, ptr %55, align 4, !tbaa !5
  %56 = add nuw nsw i64 %50, 1
  %57 = load i32, ptr @dim, align 4, !tbaa !5
  %58 = sext i32 %57 to i64
  %59 = icmp slt i64 %56, %58
  br i1 %59, label %49, label %60, !llvm.loop !15

60:                                               ; preds = %49, %43
  %61 = phi i32 [ %44, %43 ], [ %57, %49 ]
  %62 = add nuw nsw i64 %45, 1
  %63 = icmp eq i64 %62, %42
  br i1 %63, label %64, label %43, !llvm.loop !16

64:                                               ; preds = %60, %32, %38
  %65 = load i32, ptr @num_means, align 4, !tbaa !5
  %66 = sext i32 %65 to i64
  %67 = shl nsw i64 %66, 3
  %68 = tail call noalias ptr @malloc(i64 noundef %67) #17
  store ptr %68, ptr @means, align 8, !tbaa !9
  %69 = icmp sgt i32 %65, 0
  br i1 %69, label %70, label %82

70:                                               ; preds = %64
  %71 = load i32, ptr @dim, align 4, !tbaa !5
  %72 = sext i32 %71 to i64
  %73 = shl nsw i64 %72, 2
  %74 = zext i32 %65 to i64
  br label %75

75:                                               ; preds = %70, %75
  %76 = phi i64 [ 0, %70 ], [ %80, %75 ]
  %77 = tail call noalias ptr @malloc(i64 noundef %73) #17
  %78 = load ptr, ptr @means, align 8, !tbaa !9
  %79 = getelementptr inbounds ptr, ptr %78, i64 %76
  store ptr %77, ptr %79, align 8, !tbaa !9
  %80 = add nuw nsw i64 %76, 1
  %81 = icmp eq i64 %80, %74
  br i1 %81, label %82, label %75, !llvm.loop !35

82:                                               ; preds = %75, %64
  %83 = load ptr, ptr @stdout, align 8, !tbaa !9
  %84 = tail call i64 @fwrite(ptr nonnull @.str.10, i64 17, i64 1, ptr %83)
  %85 = load ptr, ptr @means, align 8, !tbaa !9
  %86 = load i32, ptr @num_means, align 4, !tbaa !5
  %87 = icmp sgt i32 %86, 0
  br i1 %87, label %88, label %114

88:                                               ; preds = %82
  %89 = load i32, ptr @dim, align 4, !tbaa !5
  %90 = icmp sgt i32 %89, 0
  br i1 %90, label %91, label %114

91:                                               ; preds = %88
  %92 = zext i32 %86 to i64
  br label %93

93:                                               ; preds = %110, %91
  %94 = phi i32 [ %89, %91 ], [ %111, %110 ]
  %95 = phi i64 [ 0, %91 ], [ %112, %110 ]
  %96 = icmp sgt i32 %94, 0
  br i1 %96, label %97, label %110

97:                                               ; preds = %93
  %98 = getelementptr inbounds ptr, ptr %85, i64 %95
  br label %99

99:                                               ; preds = %99, %97
  %100 = phi i64 [ 0, %97 ], [ %106, %99 ]
  %101 = tail call i32 @rand() #15
  %102 = load i32, ptr @grid_size, align 4, !tbaa !5
  %103 = srem i32 %101, %102
  %104 = load ptr, ptr %98, align 8, !tbaa !9
  %105 = getelementptr inbounds i32, ptr %104, i64 %100
  store i32 %103, ptr %105, align 4, !tbaa !5
  %106 = add nuw nsw i64 %100, 1
  %107 = load i32, ptr @dim, align 4, !tbaa !5
  %108 = sext i32 %107 to i64
  %109 = icmp slt i64 %106, %108
  br i1 %109, label %99, label %110, !llvm.loop !15

110:                                              ; preds = %99, %93
  %111 = phi i32 [ %94, %93 ], [ %107, %99 ]
  %112 = add nuw nsw i64 %95, 1
  %113 = icmp eq i64 %112, %92
  br i1 %113, label %114, label %93, !llvm.loop !16

114:                                              ; preds = %110, %82, %88
  %115 = load i32, ptr @num_points, align 4, !tbaa !5
  %116 = sext i32 %115 to i64
  %117 = shl nsw i64 %116, 2
  %118 = tail call noalias ptr @malloc(i64 noundef %117) #17
  store ptr %118, ptr @clusters, align 8, !tbaa !9
  tail call void @llvm.memset.p0.i64(ptr align 4 %118, i8 -1, i64 %117, i1 false)
  %119 = call i32 @pthread_attr_init(ptr noundef nonnull %3) #15
  %120 = call i32 @pthread_attr_setscope(ptr noundef nonnull %3, i32 noundef 0) #15
  %121 = shl i64 %13, 32
  %122 = ashr exact i64 %121, 29
  %123 = call noalias ptr @malloc(i64 noundef %122) #17
  %124 = icmp eq ptr %123, null
  br i1 %124, label %125, label %129

125:                                              ; preds = %114
  call void @perror(ptr noundef nonnull @.str.11) #18
  %126 = call noalias ptr @malloc(i64 noundef %122) #17
  %127 = icmp eq ptr %126, null
  br i1 %127, label %128, label %129

128:                                              ; preds = %125
  call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.13, i32 noundef 215, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

129:                                              ; preds = %125, %114
  %130 = phi ptr [ %126, %125 ], [ %123, %114 ]
  store i32 1, ptr @modified, align 4, !tbaa !5
  %131 = call i32 @puts(ptr nonnull dereferenceable(1) @str.23)
  %132 = load i32, ptr @modified, align 4, !tbaa !5
  %133 = icmp eq i32 %132, 0
  br i1 %133, label %261, label %134

134:                                              ; preds = %129
  %135 = icmp slt i32 %14, 0
  %136 = icmp slt i32 %14, 0
  br label %140

137:                                              ; preds = %254, %248, %249
  %138 = load i32, ptr @modified, align 4, !tbaa !5
  %139 = icmp eq i32 %138, 0
  br i1 %139, label %261, label %140, !llvm.loop !36

140:                                              ; preds = %134, %137
  %141 = load i32, ptr @num_points, align 4, !tbaa !5
  %142 = sdiv i32 %141, %14
  %143 = srem i32 %141, %14
  store i32 0, ptr @modified, align 4, !tbaa !5
  %144 = icmp sgt i32 %141, 0
  br i1 %144, label %145, label %185

145:                                              ; preds = %140
  %146 = add nsw i32 %142, 1
  br label %147

147:                                              ; preds = %145, %177
  %148 = phi i32 [ 0, %145 ], [ %178, %177 ]
  %149 = phi i32 [ %143, %145 ], [ %164, %177 ]
  %150 = phi i32 [ 0, %145 ], [ %180, %177 ]
  %151 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #17
  %152 = icmp eq ptr %151, null
  br i1 %152, label %153, label %157

153:                                              ; preds = %147
  call void @perror(ptr noundef nonnull @.str.15) #18
  %154 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #17
  %155 = icmp eq ptr %154, null
  br i1 %155, label %156, label %157

156:                                              ; preds = %153
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.13, i32 noundef 230, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

157:                                              ; preds = %153, %147
  %158 = phi ptr [ %154, %153 ], [ %151, %147 ]
  store i32 %150, ptr %158, align 8, !tbaa !21
  %159 = getelementptr inbounds %struct.thread_arg, ptr %158, i64 0, i32 1
  store i32 %142, ptr %159, align 4, !tbaa !19
  %160 = icmp sgt i32 %149, 0
  br i1 %160, label %161, label %163

161:                                              ; preds = %157
  store i32 %146, ptr %159, align 4, !tbaa !19
  %162 = add nsw i32 %149, -1
  br label %163

163:                                              ; preds = %161, %157
  %164 = phi i32 [ %162, %161 ], [ %149, %157 ]
  %165 = add nsw i32 %148, 1
  %166 = sext i32 %148 to i64
  %167 = getelementptr inbounds i64, ptr %130, i64 %166
  %168 = call i32 @pthread_create(ptr noundef %167, ptr noundef nonnull %3, ptr noundef nonnull @find_clusters, ptr noundef nonnull %158) #15
  %169 = icmp eq i32 %168, 0
  br i1 %169, label %177, label %170

170:                                              ; preds = %163
  call void @perror(ptr noundef nonnull @.str.17) #18
  %171 = add nsw i32 %148, 2
  %172 = sext i32 %165 to i64
  %173 = getelementptr inbounds i64, ptr %130, i64 %172
  %174 = call i32 @pthread_create(ptr noundef %173, ptr noundef nonnull %3, ptr noundef nonnull @find_clusters, ptr noundef nonnull %158) #15
  %175 = icmp eq i32 %174, 0
  br i1 %175, label %177, label %176

176:                                              ; preds = %170
  call void @__assert_fail(ptr noundef nonnull @.str.18, ptr noundef nonnull @.str.13, i32 noundef 237, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

177:                                              ; preds = %170, %163
  %178 = phi i32 [ %171, %170 ], [ %165, %163 ]
  %179 = load i32, ptr %159, align 4, !tbaa !19
  %180 = add nsw i32 %179, %150
  %181 = load i32, ptr @num_points, align 4, !tbaa !5
  %182 = icmp slt i32 %180, %181
  br i1 %182, label %147, label %183, !llvm.loop !37

183:                                              ; preds = %177
  %184 = icmp sgt i32 %178, %14
  br i1 %184, label %190, label %186

185:                                              ; preds = %140
  br i1 %135, label %190, label %198

186:                                              ; preds = %183
  %187 = icmp sgt i32 %178, 0
  br i1 %187, label %188, label %198

188:                                              ; preds = %186
  %189 = zext i32 %178 to i64
  br label %191

190:                                              ; preds = %185, %183
  call void @__assert_fail(ptr noundef nonnull @.str.19, ptr noundef nonnull @.str.13, i32 noundef 241, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

191:                                              ; preds = %188, %191
  %192 = phi i64 [ 0, %188 ], [ %196, %191 ]
  %193 = getelementptr inbounds i64, ptr %130, i64 %192
  %194 = load i64, ptr %193, align 8, !tbaa !38
  %195 = call i32 @pthread_join(i64 noundef %194, ptr noundef null) #15
  %196 = add nuw nsw i64 %192, 1
  %197 = icmp eq i64 %196, %189
  br i1 %197, label %198, label %191, !llvm.loop !40

198:                                              ; preds = %191, %185, %186
  %199 = load i32, ptr @num_means, align 4, !tbaa !5
  %200 = sdiv i32 %199, %14
  %201 = srem i32 %199, %14
  %202 = icmp sgt i32 %199, 0
  br i1 %202, label %203, label %248

203:                                              ; preds = %198
  %204 = add nsw i32 %200, 1
  br label %205

205:                                              ; preds = %203, %240
  %206 = phi i32 [ 0, %203 ], [ %241, %240 ]
  %207 = phi i32 [ %201, %203 ], [ %227, %240 ]
  %208 = phi i32 [ 0, %203 ], [ %243, %240 ]
  %209 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #17
  %210 = icmp eq ptr %209, null
  br i1 %210, label %211, label %215

211:                                              ; preds = %205
  call void @perror(ptr noundef nonnull @.str.15) #18
  %212 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #17
  %213 = icmp eq ptr %212, null
  br i1 %213, label %214, label %215

214:                                              ; preds = %211
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.13, i32 noundef 252, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

215:                                              ; preds = %211, %205
  %216 = phi ptr [ %212, %211 ], [ %209, %205 ]
  store i32 %208, ptr %216, align 8, !tbaa !21
  %217 = load i32, ptr @dim, align 4, !tbaa !5
  %218 = sext i32 %217 to i64
  %219 = shl nsw i64 %218, 2
  %220 = call noalias ptr @malloc(i64 noundef %219) #17
  %221 = getelementptr inbounds %struct.thread_arg, ptr %216, i64 0, i32 2
  store ptr %220, ptr %221, align 8, !tbaa !30
  %222 = getelementptr inbounds %struct.thread_arg, ptr %216, i64 0, i32 1
  store i32 %200, ptr %222, align 4, !tbaa !19
  %223 = icmp sgt i32 %207, 0
  br i1 %223, label %224, label %226

224:                                              ; preds = %215
  store i32 %204, ptr %222, align 4, !tbaa !19
  %225 = add nsw i32 %207, -1
  br label %226

226:                                              ; preds = %224, %215
  %227 = phi i32 [ %225, %224 ], [ %207, %215 ]
  %228 = add nsw i32 %206, 1
  %229 = sext i32 %206 to i64
  %230 = getelementptr inbounds i64, ptr %130, i64 %229
  %231 = call i32 @pthread_create(ptr noundef %230, ptr noundef nonnull %3, ptr noundef nonnull @calc_means, ptr noundef nonnull %216) #15
  %232 = icmp eq i32 %231, 0
  br i1 %232, label %240, label %233

233:                                              ; preds = %226
  call void @perror(ptr noundef nonnull @.str.20) #18
  %234 = add nsw i32 %206, 2
  %235 = sext i32 %228 to i64
  %236 = getelementptr inbounds i64, ptr %130, i64 %235
  %237 = call i32 @pthread_create(ptr noundef %236, ptr noundef nonnull %3, ptr noundef nonnull @calc_means, ptr noundef nonnull %216) #15
  %238 = icmp eq i32 %237, 0
  br i1 %238, label %240, label %239

239:                                              ; preds = %233
  call void @__assert_fail(ptr noundef nonnull @.str.21, ptr noundef nonnull @.str.13, i32 noundef 260, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

240:                                              ; preds = %233, %226
  %241 = phi i32 [ %234, %233 ], [ %228, %226 ]
  %242 = load i32, ptr %222, align 4, !tbaa !19
  %243 = add nsw i32 %242, %208
  %244 = load i32, ptr @num_means, align 4, !tbaa !5
  %245 = icmp slt i32 %243, %244
  br i1 %245, label %205, label %246, !llvm.loop !41

246:                                              ; preds = %240
  %247 = icmp sgt i32 %241, %14
  br i1 %247, label %253, label %249

248:                                              ; preds = %198
  br i1 %136, label %253, label %137

249:                                              ; preds = %246
  %250 = icmp sgt i32 %241, 0
  br i1 %250, label %251, label %137

251:                                              ; preds = %249
  %252 = zext i32 %241 to i64
  br label %254

253:                                              ; preds = %248, %246
  call void @__assert_fail(ptr noundef nonnull @.str.19, ptr noundef nonnull @.str.13, i32 noundef 264, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #16
  unreachable

254:                                              ; preds = %251, %254
  %255 = phi i64 [ 0, %251 ], [ %259, %254 ]
  %256 = getelementptr inbounds i64, ptr %130, i64 %255
  %257 = load i64, ptr %256, align 8, !tbaa !38
  %258 = call i32 @pthread_join(i64 noundef %257, ptr noundef null) #15
  %259 = add nuw nsw i64 %255, 1
  %260 = icmp eq i64 %259, %252
  br i1 %260, label %137, label %254, !llvm.loop !42

261:                                              ; preds = %137, %129
  %262 = load ptr, ptr @stdout, align 8, !tbaa !9
  %263 = call i64 @fwrite(ptr nonnull @.str.22, i64 15, i64 1, ptr %262)
  %264 = load ptr, ptr @means, align 8, !tbaa !9
  %265 = load i32, ptr @num_means, align 4, !tbaa !5
  %266 = icmp sgt i32 %265, 0
  br i1 %266, label %267, label %291

267:                                              ; preds = %261
  %268 = zext i32 %265 to i64
  br label %269

269:                                              ; preds = %286, %267
  %270 = phi i64 [ 0, %267 ], [ %289, %286 ]
  %271 = load i32, ptr @dim, align 4, !tbaa !5
  %272 = icmp sgt i32 %271, 0
  br i1 %272, label %273, label %286

273:                                              ; preds = %269
  %274 = getelementptr inbounds ptr, ptr %264, i64 %270
  br label %275

275:                                              ; preds = %275, %273
  %276 = phi i64 [ 0, %273 ], [ %282, %275 ]
  %277 = load ptr, ptr @stdout, align 8, !tbaa !9
  %278 = load ptr, ptr %274, align 8, !tbaa !9
  %279 = getelementptr inbounds i32, ptr %278, i64 %276
  %280 = load i32, ptr %279, align 4, !tbaa !5
  %281 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %277, ptr noundef nonnull @.str, i32 noundef %280)
  %282 = add nuw nsw i64 %276, 1
  %283 = load i32, ptr @dim, align 4, !tbaa !5
  %284 = sext i32 %283 to i64
  %285 = icmp slt i64 %282, %284
  br i1 %285, label %275, label %286, !llvm.loop !11

286:                                              ; preds = %275, %269
  %287 = load ptr, ptr @stdout, align 8, !tbaa !9
  %288 = call i32 @fputc(i32 10, ptr %287)
  %289 = add nuw nsw i64 %270, 1
  %290 = icmp eq i64 %289, %268
  br i1 %290, label %291, label %269, !llvm.loop !13

291:                                              ; preds = %286, %261
  %292 = load i32, ptr @num_points, align 4, !tbaa !5
  %293 = icmp sgt i32 %292, 0
  br i1 %293, label %294, label %303

294:                                              ; preds = %291, %294
  %295 = phi i64 [ %299, %294 ], [ 0, %291 ]
  %296 = load ptr, ptr @points, align 8, !tbaa !9
  %297 = getelementptr inbounds ptr, ptr %296, i64 %295
  %298 = load ptr, ptr %297, align 8, !tbaa !9
  call void @free(ptr noundef %298) #15
  %299 = add nuw nsw i64 %295, 1
  %300 = load i32, ptr @num_points, align 4, !tbaa !5
  %301 = sext i32 %300 to i64
  %302 = icmp slt i64 %299, %301
  br i1 %302, label %294, label %303, !llvm.loop !43

303:                                              ; preds = %294, %291
  %304 = load ptr, ptr @points, align 8, !tbaa !9
  call void @free(ptr noundef %304) #15
  %305 = load i32, ptr @num_means, align 4, !tbaa !5
  %306 = icmp sgt i32 %305, 0
  br i1 %306, label %307, label %316

307:                                              ; preds = %303, %307
  %308 = phi i64 [ %312, %307 ], [ 0, %303 ]
  %309 = load ptr, ptr @means, align 8, !tbaa !9
  %310 = getelementptr inbounds ptr, ptr %309, i64 %308
  %311 = load ptr, ptr %310, align 8, !tbaa !9
  call void @free(ptr noundef %311) #15
  %312 = add nuw nsw i64 %308, 1
  %313 = load i32, ptr @num_means, align 4, !tbaa !5
  %314 = sext i32 %313 to i64
  %315 = icmp slt i64 %312, %314
  br i1 %315, label %307, label %316, !llvm.loop !44

316:                                              ; preds = %307, %303
  %317 = load ptr, ptr @means, align 8, !tbaa !9
  call void @free(ptr noundef %317) #15
  %318 = load ptr, ptr @clusters, align 8, !tbaa !9
  call void @free(ptr noundef %318) #15
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %3) #15
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #12

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nounwind
declare i32 @pthread_attr_init(ptr noundef) local_unnamed_addr #4

; Function Attrs: nounwind
declare i32 @pthread_attr_setscope(ptr noundef, i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare void @perror(ptr nocapture noundef readonly) local_unnamed_addr #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #5

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

declare i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #14

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #12

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree norecurse nosync nounwind memory(read, argmem: readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nofree nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #11 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #13 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #15 = { nounwind }
attributes #16 = { noreturn nounwind }
attributes #17 = { nounwind allocsize(0) }
attributes #18 = { cold }

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
!16 = distinct !{!16, !12, !17}
!17 = !{!"llvm.loop.unswitch.partial.disable"}
!18 = distinct !{!18, !12}
!19 = !{!20, !6, i64 4}
!20 = !{!"", !6, i64 0, !6, i64 4, !10, i64 8}
!21 = !{!20, !6, i64 0}
!22 = distinct !{!22, !12, !23, !24}
!23 = !{!"llvm.loop.isvectorized", i32 1}
!24 = !{!"llvm.loop.unroll.runtime.disable"}
!25 = distinct !{!25, !12, !24, !23}
!26 = distinct !{!26, !12, !23, !24}
!27 = distinct !{!27, !12, !24, !23}
!28 = distinct !{!28, !12}
!29 = distinct !{!29, !12}
!30 = !{!20, !10, i64 8}
!31 = distinct !{!31, !12}
!32 = distinct !{!32, !12}
!33 = distinct !{!33, !12}
!34 = distinct !{!34, !12}
!35 = distinct !{!35, !12}
!36 = distinct !{!36, !12}
!37 = distinct !{!37, !12}
!38 = !{!39, !39, i64 0}
!39 = !{!"long", !7, i64 0}
!40 = distinct !{!40, !12}
!41 = distinct !{!41, !12}
!42 = distinct !{!42, !12}
!43 = distinct !{!43, !12}
!44 = distinct !{!44, !12}
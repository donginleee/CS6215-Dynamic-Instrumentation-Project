; ModuleID = 'matrix_multiply-pthread.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }
%struct.mm_data_t = type { i32, ptr, ptr, i32, ptr }
%struct.map_args_t = type { i64, ptr }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [8 x i8] c"data_in\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"matrix_multiply-pthread.c\00", align 1
@__PRETTY_FUNCTION__.matrixmult_splitter = private unnamed_addr constant [38 x i8] c"void matrixmult_splitter(void *, int)\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"data->matrix_len >= 0\00", align 1
@.str.3 = private unnamed_addr constant [15 x i8] c"data->matrix_A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"data->matrix_B\00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"data->output\00", align 1
@stdout = external local_unnamed_addr global ptr, align 8
@.str.6 = private unnamed_addr constant [25 x i8] c"Running with %d threads\0A\00", align 1
@.str.7 = private unnamed_addr constant [42 x i8] c"Allocated rows = %ld, data->row_num = %d\0A\00", align 1
@.str.8 = private unnamed_addr constant [90 x i8] c"Error at line\0A\09pthread_create(&tid[i], &attr, matrixmult_map, (void*)out) != 0\0ASystem Msg\00", align 1
@.str.9 = private unnamed_addr constant [71 x i8] c"(pthread_create(&tid[i], &attr, matrixmult_map, (void*)out) != 0) == 0\00", align 1
@.str.10 = private unnamed_addr constant [71 x i8] c"Error at line\0A\09pthread_join(tid[i], (void **)&ret_val) != 0\0ASystem Msg\00", align 1
@.str.11 = private unnamed_addr constant [52 x i8] c"(pthread_join(tid[i], (void **)&ret_val) != 0) == 0\00", align 1
@.str.12 = private unnamed_addr constant [39 x i8] c"Error at line\0A\09ret_val != 0\0ASystem Msg\00", align 1
@.str.13 = private unnamed_addr constant [20 x i8] c"(ret_val != 0) == 0\00", align 1
@.str.14 = private unnamed_addr constant [5 x i8] c"args\00", align 1
@__PRETTY_FUNCTION__.matrixmult_map = private unnamed_addr constant [29 x i8] c"void *matrixmult_map(void *)\00", align 1
@.str.15 = private unnamed_addr constant [5 x i8] c"data\00", align 1
@.str.16 = private unnamed_addr constant [59 x i8] c"USAGE: %s [matrix size] [create_files: 0|1] [num_threads]\0A\00", align 1
@.str.17 = private unnamed_addr constant [18 x i8] c"matrix_file_A.txt\00", align 1
@.str.18 = private unnamed_addr constant [18 x i8] c"matrix_file_B.txt\00", align 1
@.str.19 = private unnamed_addr constant [29 x i8] c"matrix_file_out_pthreads.txt\00", align 1
@.str.20 = private unnamed_addr constant [60 x i8] c"Error at line\0A\09(matrix_len = atoi(argv[1])) <= 0\0ASystem Msg\00", align 1
@.str.21 = private unnamed_addr constant [41 x i8] c"((matrix_len = atoi(argv[1])) <= 0) == 0\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str.22 = private unnamed_addr constant [47 x i8] c"MatrixMult_pthreads: Side of the matrix is %d\0A\00", align 1
@.str.23 = private unnamed_addr constant [46 x i8] c"MatrixMult_pthreads: Running with %d threads\0A\00", align 1
@.str.24 = private unnamed_addr constant [84 x i8] c"Error at line\0A\09(fd_out = open(fname_out, O_CREAT | O_RDWR, S_IRWXU)) < 0\0ASystem Msg\00", align 1
@.str.25 = private unnamed_addr constant [67 x i8] c"((fd_out = open(fname_out, 0100 | 02, (0400|0200|0100))) < 0) == 0\00", align 1
@.str.26 = private unnamed_addr constant [22 x i8] c"Creating input files\0A\00", align 1
@.str.27 = private unnamed_addr constant [80 x i8] c"Error at line\0A\09(fd_A = open(fname_A, O_CREAT | O_RDWR, S_IRWXU)) < 0\0ASystem Msg\00", align 1
@.str.28 = private unnamed_addr constant [63 x i8] c"((fd_A = open(fname_A, 0100 | 02, (0400|0200|0100))) < 0) == 0\00", align 1
@.str.29 = private unnamed_addr constant [80 x i8] c"Error at line\0A\09(fd_B = open(fname_B, O_CREAT | O_RDWR, S_IRWXU)) < 0\0ASystem Msg\00", align 1
@.str.30 = private unnamed_addr constant [63 x i8] c"((fd_B = open(fname_B, 0100 | 02, (0400|0200|0100))) < 0) == 0\00", align 1
@.str.31 = private unnamed_addr constant [42 x i8] c"Error at line\0A\09close(fd_A) < 0\0ASystem Msg\00", align 1
@.str.32 = private unnamed_addr constant [23 x i8] c"(close(fd_A) < 0) == 0\00", align 1
@.str.33 = private unnamed_addr constant [42 x i8] c"Error at line\0A\09close(fd_B) < 0\0ASystem Msg\00", align 1
@.str.34 = private unnamed_addr constant [23 x i8] c"(close(fd_B) < 0) == 0\00", align 1
@.str.35 = private unnamed_addr constant [63 x i8] c"Error at line\0A\09(fd_A = open(fname_A, O_RDONLY)) < 0\0ASystem Msg\00", align 1
@.str.36 = private unnamed_addr constant [38 x i8] c"((fd_A = open(fname_A, 00)) < 0) == 0\00", align 1
@.str.37 = private unnamed_addr constant [52 x i8] c"Error at line\0A\09fstat(fd_A, &finfo_A) < 0\0ASystem Msg\00", align 1
@.str.38 = private unnamed_addr constant [33 x i8] c"(fstat(fd_A, &finfo_A) < 0) == 0\00", align 1
@.str.39 = private unnamed_addr constant [115 x i8] c"Error at line\0A\09(fdata_A = mmap(0, file_size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd_A, 0)) == NULL\0ASystem Msg\00", align 1
@.str.40 = private unnamed_addr constant [82 x i8] c"((fdata_A = mmap(0, file_size + 1, 0x1 | 0x2, 0x02, fd_A, 0)) == ((void*)0)) == 0\00", align 1
@.str.41 = private unnamed_addr constant [63 x i8] c"Error at line\0A\09(fd_B = open(fname_B, O_RDONLY)) < 0\0ASystem Msg\00", align 1
@.str.42 = private unnamed_addr constant [38 x i8] c"((fd_B = open(fname_B, 00)) < 0) == 0\00", align 1
@.str.43 = private unnamed_addr constant [52 x i8] c"Error at line\0A\09fstat(fd_B, &finfo_B) < 0\0ASystem Msg\00", align 1
@.str.44 = private unnamed_addr constant [33 x i8] c"(fstat(fd_B, &finfo_B) < 0) == 0\00", align 1
@.str.45 = private unnamed_addr constant [115 x i8] c"Error at line\0A\09(fdata_B = mmap(0, file_size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd_B, 0)) == NULL\0ASystem Msg\00", align 1
@.str.46 = private unnamed_addr constant [82 x i8] c"((fdata_B = mmap(0, file_size + 1, 0x1 | 0x2, 0x02, fd_B, 0)) == ((void*)0)) == 0\00", align 1
@.str.47 = private unnamed_addr constant [52 x i8] c"MatrixMult_pthreads: Multiply Completed in %ld sec\0A\00", align 1
@.str.49 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.50 = private unnamed_addr constant [61 x i8] c"Error at line\0A\09munmap(fdata_A, file_size + 1) < 0\0ASystem Msg\00", align 1
@.str.51 = private unnamed_addr constant [42 x i8] c"(munmap(fdata_A, file_size + 1) < 0) == 0\00", align 1
@.str.52 = private unnamed_addr constant [61 x i8] c"Error at line\0A\09munmap(fdata_B, file_size + 1) < 0\0ASystem Msg\00", align 1
@.str.53 = private unnamed_addr constant [42 x i8] c"(munmap(fdata_B, file_size + 1) < 0) == 0\00", align 1
@.str.54 = private unnamed_addr constant [44 x i8] c"Error at line\0A\09close(fd_out) < 0\0ASystem Msg\00", align 1
@.str.55 = private unnamed_addr constant [25 x i8] c"(close(fd_out) < 0) == 0\00", align 1
@.str.56 = private unnamed_addr constant [5 x i8] c"temp\00", align 1
@.str.57 = private unnamed_addr constant [27 x i8] c"../../include/stddefines.h\00", align 1
@__PRETTY_FUNCTION__.MALLOC = private unnamed_addr constant [21 x i8] c"void *MALLOC(size_t)\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @matrixmult_splitter(ptr noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = alloca %union.pthread_attr_t, align 8
  %4 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %3) #13
  %5 = icmp eq ptr %0, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %2
  tail call void @__assert_fail(ptr noundef nonnull @.str, ptr noundef nonnull @.str.1, i32 noundef 45, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

7:                                                ; preds = %2
  %8 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 3
  %9 = load i32, ptr %8, align 8, !tbaa !5
  %10 = icmp sgt i32 %9, -1
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  tail call void @__assert_fail(ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.1, i32 noundef 46, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 1
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = icmp eq ptr %14, null
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  tail call void @__assert_fail(ptr noundef nonnull @.str.3, ptr noundef nonnull @.str.1, i32 noundef 47, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

17:                                               ; preds = %12
  %18 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 2
  %19 = load ptr, ptr %18, align 8, !tbaa !12
  %20 = icmp eq ptr %19, null
  br i1 %20, label %21, label %22

21:                                               ; preds = %17
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.1, i32 noundef 48, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

22:                                               ; preds = %17
  %23 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 4
  %24 = load ptr, ptr %23, align 8, !tbaa !13
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %27

26:                                               ; preds = %22
  tail call void @__assert_fail(ptr noundef nonnull @.str.5, ptr noundef nonnull @.str.1, i32 noundef 49, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

27:                                               ; preds = %22
  %28 = load ptr, ptr @stdout, align 8, !tbaa !14
  %29 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %28, ptr noundef nonnull @.str.6, i32 noundef %1)
  %30 = sext i32 %1 to i64
  %31 = shl nsw i64 %30, 3
  %32 = tail call noalias ptr @malloc(i64 noundef %31) #15
  %33 = icmp eq ptr %32, null
  br i1 %33, label %34, label %35

34:                                               ; preds = %27
  tail call void @__assert_fail(ptr noundef nonnull @.str.56, ptr noundef nonnull @.str.57, i32 noundef 52, ptr noundef nonnull @__PRETTY_FUNCTION__.MALLOC) #14
  unreachable

35:                                               ; preds = %27
  %36 = call i32 @pthread_attr_init(ptr noundef nonnull %3) #13
  %37 = call i32 @pthread_attr_setscope(ptr noundef nonnull %3, i32 noundef 0) #13
  %38 = load i32, ptr %8, align 8, !tbaa !5
  %39 = sdiv i32 %38, %1
  %40 = icmp sgt i32 %1, 0
  br i1 %40, label %41, label %100

41:                                               ; preds = %35
  %42 = add nsw i32 %1, -1
  %43 = zext i32 %42 to i64
  %44 = zext i32 %1 to i64
  %45 = mul nsw i32 %42, %39
  br label %49

46:                                               ; preds = %76
  br i1 %40, label %47, label %100

47:                                               ; preds = %46
  %48 = zext i32 %1 to i64
  br label %79

49:                                               ; preds = %41, %76
  %50 = phi i64 [ 0, %41 ], [ %77, %76 ]
  %51 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #15
  %52 = call noalias dereferenceable_or_null(40) ptr @malloc(i64 noundef 40) #15
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %52, ptr noundef nonnull align 8 dereferenceable(40) %0, i64 40, i1 false)
  %53 = load i32, ptr %8, align 8, !tbaa !5
  %54 = load i32, ptr %0, align 8, !tbaa !15
  %55 = sub nsw i32 %53, %54
  %56 = call i32 @llvm.smin.i32(i32 %39, i32 %55)
  %57 = sext i32 %56 to i64
  store i64 %57, ptr %51, align 8, !tbaa !16
  %58 = getelementptr inbounds %struct.map_args_t, ptr %51, i64 0, i32 1
  store ptr %52, ptr %58, align 8, !tbaa !19
  %59 = icmp eq i64 %50, %43
  br i1 %59, label %60, label %63

60:                                               ; preds = %49
  %61 = sub nsw i32 %53, %45
  %62 = sext i32 %61 to i64
  store i64 %62, ptr %51, align 8, !tbaa !16
  br label %63

63:                                               ; preds = %60, %49
  %64 = phi i64 [ %62, %60 ], [ %57, %49 ]
  %65 = trunc i64 %64 to i32
  %66 = add i32 %54, %65
  store i32 %66, ptr %0, align 8, !tbaa !15
  %67 = load ptr, ptr @stdout, align 8, !tbaa !14
  %68 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %67, ptr noundef nonnull @.str.7, i64 noundef %64, i32 noundef %66)
  %69 = getelementptr inbounds i64, ptr %32, i64 %50
  %70 = call i32 @pthread_create(ptr noundef nonnull %69, ptr noundef nonnull %3, ptr noundef nonnull @matrixmult_map, ptr noundef nonnull %51) #13
  %71 = icmp eq i32 %70, 0
  br i1 %71, label %76, label %72

72:                                               ; preds = %63
  call void @perror(ptr noundef nonnull @.str.8) #16
  %73 = call i32 @pthread_create(ptr noundef nonnull %69, ptr noundef nonnull %3, ptr noundef nonnull @matrixmult_map, ptr noundef nonnull %51) #13
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %76, label %75

75:                                               ; preds = %72
  call void @__assert_fail(ptr noundef nonnull @.str.9, ptr noundef nonnull @.str.1, i32 noundef 76, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

76:                                               ; preds = %72, %63
  %77 = add nuw nsw i64 %50, 1
  %78 = icmp eq i64 %77, %44
  br i1 %78, label %46, label %49, !llvm.loop !20

79:                                               ; preds = %47, %97
  %80 = phi i64 [ 0, %47 ], [ %98, %97 ]
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #13
  %81 = getelementptr inbounds i64, ptr %32, i64 %80
  %82 = load i64, ptr %81, align 8, !tbaa !22
  %83 = call i32 @pthread_join(i64 noundef %82, ptr noundef nonnull %4) #13
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %90, label %85

85:                                               ; preds = %79
  call void @perror(ptr noundef nonnull @.str.10) #16
  %86 = load i64, ptr %81, align 8, !tbaa !22
  %87 = call i32 @pthread_join(i64 noundef %86, ptr noundef nonnull %4) #13
  %88 = icmp eq i32 %87, 0
  br i1 %88, label %90, label %89

89:                                               ; preds = %85
  call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.1, i32 noundef 81, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

90:                                               ; preds = %85, %79
  %91 = load i32, ptr %4, align 4, !tbaa !23
  %92 = icmp eq i32 %91, 0
  br i1 %92, label %97, label %93

93:                                               ; preds = %90
  call void @perror(ptr noundef nonnull @.str.12) #16
  %94 = load i32, ptr %4, align 4, !tbaa !23
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %97, label %96

96:                                               ; preds = %93
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.1, i32 noundef 82, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #14
  unreachable

97:                                               ; preds = %93, %90
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #13
  %98 = add nuw nsw i64 %80, 1
  %99 = icmp eq i64 %98, %48
  br i1 %99, label %100, label %79, !llvm.loop !24

100:                                              ; preds = %97, %35, %46
  call void @free(ptr noundef %32) #13
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %3) #13
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: nounwind
declare i32 @pthread_attr_init(ptr noundef) local_unnamed_addr #5

; Function Attrs: nounwind
declare i32 @pthread_attr_setscope(ptr noundef, i32 noundef) local_unnamed_addr #5

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #7

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @matrixmult_map(ptr noundef %0) #0 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %3, label %4

3:                                                ; preds = %1
  tail call void @__assert_fail(ptr noundef nonnull @.str.14, ptr noundef nonnull @.str.1, i32 noundef 94, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_map) #14
  unreachable

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.map_args_t, ptr %0, i64 0, i32 1
  %6 = load ptr, ptr %5, align 8, !tbaa !19
  %7 = icmp eq ptr %6, null
  br i1 %7, label %19, label %8

8:                                                ; preds = %4
  %9 = load i64, ptr %0, align 8, !tbaa !16
  %10 = icmp sgt i64 %9, 0
  br i1 %10, label %11, label %117

11:                                               ; preds = %8
  %12 = getelementptr inbounds %struct.mm_data_t, ptr %6, i64 0, i32 1
  %13 = load ptr, ptr %12, align 8, !tbaa !11
  %14 = getelementptr inbounds %struct.mm_data_t, ptr %6, i64 0, i32 3
  %15 = getelementptr inbounds %struct.mm_data_t, ptr %6, i64 0, i32 2
  %16 = getelementptr inbounds %struct.mm_data_t, ptr %6, i64 0, i32 4
  %17 = load i32, ptr %14, align 8, !tbaa !5
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %20, label %117

19:                                               ; preds = %4
  tail call void @__assert_fail(ptr noundef nonnull @.str.15, ptr noundef nonnull @.str.1, i32 noundef 96, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_map) #14
  unreachable

20:                                               ; preds = %11, %113
  %21 = phi i32 [ %114, %113 ], [ %17, %11 ]
  %22 = phi i64 [ %115, %113 ], [ 0, %11 ]
  %23 = load i32, ptr %6, align 8, !tbaa !15
  %24 = trunc i64 %22 to i32
  %25 = add nsw i32 %23, %24
  %26 = mul nsw i32 %25, %21
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i32, ptr %13, i64 %27
  %29 = icmp sgt i32 %21, 0
  br i1 %29, label %30, label %113

30:                                               ; preds = %20
  %31 = load ptr, ptr %15, align 8, !tbaa !12
  %32 = load ptr, ptr %16, align 8, !tbaa !13
  br label %33

33:                                               ; preds = %30, %100
  %34 = phi i64 [ 0, %30 ], [ %109, %100 ]
  %35 = phi i32 [ %21, %30 ], [ %110, %100 ]
  %36 = icmp sgt i32 %35, 0
  br i1 %36, label %37, label %100

37:                                               ; preds = %33
  %38 = getelementptr inbounds i32, ptr %31, i64 %34
  %39 = zext i32 %35 to i64
  %40 = zext i32 %35 to i64
  %41 = and i64 %40, 3
  %42 = icmp ult i32 %35, 4
  br i1 %42, label %80, label %43

43:                                               ; preds = %37
  %44 = and i64 %40, 4294967292
  br label %45

45:                                               ; preds = %45, %43
  %46 = phi i64 [ 0, %43 ], [ %77, %45 ]
  %47 = phi ptr [ %38, %43 ], [ %76, %45 ]
  %48 = phi i32 [ 0, %43 ], [ %75, %45 ]
  %49 = phi i64 [ 0, %43 ], [ %78, %45 ]
  %50 = getelementptr inbounds i32, ptr %28, i64 %46
  %51 = load i32, ptr %50, align 4, !tbaa !23
  %52 = load i32, ptr %47, align 4, !tbaa !23
  %53 = mul nsw i32 %52, %51
  %54 = add nsw i32 %53, %48
  %55 = getelementptr inbounds i32, ptr %47, i64 %39
  %56 = or i64 %46, 1
  %57 = getelementptr inbounds i32, ptr %28, i64 %56
  %58 = load i32, ptr %57, align 4, !tbaa !23
  %59 = load i32, ptr %55, align 4, !tbaa !23
  %60 = mul nsw i32 %59, %58
  %61 = add nsw i32 %60, %54
  %62 = getelementptr inbounds i32, ptr %55, i64 %39
  %63 = or i64 %46, 2
  %64 = getelementptr inbounds i32, ptr %28, i64 %63
  %65 = load i32, ptr %64, align 4, !tbaa !23
  %66 = load i32, ptr %62, align 4, !tbaa !23
  %67 = mul nsw i32 %66, %65
  %68 = add nsw i32 %67, %61
  %69 = getelementptr inbounds i32, ptr %62, i64 %39
  %70 = or i64 %46, 3
  %71 = getelementptr inbounds i32, ptr %28, i64 %70
  %72 = load i32, ptr %71, align 4, !tbaa !23
  %73 = load i32, ptr %69, align 4, !tbaa !23
  %74 = mul nsw i32 %73, %72
  %75 = add nsw i32 %74, %68
  %76 = getelementptr inbounds i32, ptr %69, i64 %39
  %77 = add nuw nsw i64 %46, 4
  %78 = add nuw i64 %49, 4
  %79 = icmp eq i64 %78, %44
  br i1 %79, label %80, label %45, !llvm.loop !25

80:                                               ; preds = %45, %37
  %81 = phi i32 [ undef, %37 ], [ %75, %45 ]
  %82 = phi i64 [ 0, %37 ], [ %77, %45 ]
  %83 = phi ptr [ %38, %37 ], [ %76, %45 ]
  %84 = phi i32 [ 0, %37 ], [ %75, %45 ]
  %85 = icmp eq i64 %41, 0
  br i1 %85, label %100, label %86

86:                                               ; preds = %80, %86
  %87 = phi i64 [ %97, %86 ], [ %82, %80 ]
  %88 = phi ptr [ %96, %86 ], [ %83, %80 ]
  %89 = phi i32 [ %95, %86 ], [ %84, %80 ]
  %90 = phi i64 [ %98, %86 ], [ 0, %80 ]
  %91 = getelementptr inbounds i32, ptr %28, i64 %87
  %92 = load i32, ptr %91, align 4, !tbaa !23
  %93 = load i32, ptr %88, align 4, !tbaa !23
  %94 = mul nsw i32 %93, %92
  %95 = add nsw i32 %94, %89
  %96 = getelementptr inbounds i32, ptr %88, i64 %39
  %97 = add nuw nsw i64 %87, 1
  %98 = add i64 %90, 1
  %99 = icmp eq i64 %98, %41
  br i1 %99, label %100, label %86, !llvm.loop !26

100:                                              ; preds = %80, %86, %33
  %101 = phi i32 [ 0, %33 ], [ %81, %80 ], [ %95, %86 ]
  %102 = load i32, ptr %6, align 8, !tbaa !15
  %103 = add nsw i32 %102, %24
  %104 = mul nsw i32 %103, %35
  %105 = trunc i64 %34 to i32
  %106 = add nsw i32 %104, %105
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds i32, ptr %32, i64 %107
  store i32 %101, ptr %108, align 4, !tbaa !23
  %109 = add nuw nsw i64 %34, 1
  %110 = load i32, ptr %14, align 8, !tbaa !5
  %111 = sext i32 %110 to i64
  %112 = icmp slt i64 %109, %111
  br i1 %112, label %33, label %113, !llvm.loop !28

113:                                              ; preds = %100, %20
  %114 = phi i32 [ %21, %20 ], [ %110, %100 ]
  %115 = add nuw nsw i64 %22, 1
  %116 = icmp eq i64 %115, %9
  br i1 %116, label %117, label %20, !llvm.loop !29

117:                                              ; preds = %113, %11, %8
  tail call void @free(ptr noundef nonnull %6) #13
  tail call void @free(ptr noundef nonnull %0) #13
  ret ptr null
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare void @perror(ptr nocapture noundef readonly) local_unnamed_addr #3

declare i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = alloca %struct.stat, align 8
  %4 = alloca %struct.stat, align 8
  %5 = alloca %struct.timespec, align 8
  %6 = alloca %struct.timespec, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.mm_data_t, align 8
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %3) #13
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %4) #13
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %5) #13
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6) #13
  %9 = tail call i64 @time(ptr noundef null) #13
  %10 = trunc i64 %9 to i32
  tail call void @srand(i32 noundef %10) #13
  %11 = icmp slt i32 %0, 4
  br i1 %11, label %12, label %15

12:                                               ; preds = %2
  %13 = load ptr, ptr %1, align 8, !tbaa !14
  %14 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.16, ptr noundef %13)
  tail call void @exit(i32 noundef 1) #14
  unreachable

15:                                               ; preds = %2
  %16 = getelementptr inbounds ptr, ptr %1, i64 1
  %17 = load ptr, ptr %16, align 8, !tbaa !14
  %18 = tail call i64 @strtol(ptr nocapture noundef nonnull %17, ptr noundef null, i32 noundef 10) #13
  %19 = trunc i64 %18 to i32
  %20 = icmp slt i32 %19, 1
  br i1 %20, label %21, label %27

21:                                               ; preds = %15
  tail call void @perror(ptr noundef nonnull @.str.20) #16
  %22 = load ptr, ptr %16, align 8, !tbaa !14
  %23 = tail call i64 @strtol(ptr nocapture noundef nonnull %22, ptr noundef null, i32 noundef 10) #13
  %24 = trunc i64 %23 to i32
  %25 = icmp sgt i32 %24, 0
  br i1 %25, label %27, label %26

26:                                               ; preds = %21
  tail call void @__assert_fail(ptr noundef nonnull @.str.21, ptr noundef nonnull @.str.1, i32 noundef 149, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

27:                                               ; preds = %21, %15
  %28 = phi i32 [ %24, %21 ], [ %19, %15 ]
  %29 = getelementptr inbounds ptr, ptr %1, i64 2
  %30 = load ptr, ptr %29, align 8, !tbaa !14
  %31 = tail call i64 @strtol(ptr nocapture noundef nonnull %30, ptr noundef null, i32 noundef 10) #13
  %32 = getelementptr inbounds ptr, ptr %1, i64 3
  %33 = load ptr, ptr %32, align 8, !tbaa !14
  %34 = tail call i64 @strtol(ptr nocapture noundef nonnull %33, ptr noundef null, i32 noundef 10) #13
  %35 = trunc i64 %34 to i32
  %36 = mul i32 %28, %28
  %37 = zext i32 %36 to i64
  %38 = shl nuw nsw i64 %37, 2
  %39 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.22, i32 noundef %28)
  %40 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.23, i32 noundef %35)
  %41 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.19, i32 noundef 66, i32 noundef 448) #13
  %42 = icmp slt i32 %41, 0
  br i1 %42, label %43, label %47

43:                                               ; preds = %27
  tail call void @perror(ptr noundef nonnull @.str.24) #16
  %44 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.19, i32 noundef 66, i32 noundef 448) #13
  %45 = icmp sgt i32 %44, -1
  br i1 %45, label %47, label %46

46:                                               ; preds = %43
  tail call void @__assert_fail(ptr noundef nonnull @.str.25, ptr noundef nonnull @.str.1, i32 noundef 157, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

47:                                               ; preds = %43, %27
  %48 = phi i32 [ %44, %43 ], [ %41, %27 ]
  %49 = and i64 %31, 4294967295
  %50 = icmp eq i64 %49, 0
  br i1 %50, label %109, label %51

51:                                               ; preds = %47
  %52 = load ptr, ptr @stdout, align 8, !tbaa !14
  %53 = tail call i64 @fwrite(ptr nonnull @.str.26, i64 21, i64 1, ptr %52)
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %7) #13
  %54 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 66, i32 noundef 448) #13
  %55 = icmp slt i32 %54, 0
  br i1 %55, label %56, label %60

56:                                               ; preds = %51
  tail call void @perror(ptr noundef nonnull @.str.27) #16
  %57 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 66, i32 noundef 448) #13
  %58 = icmp sgt i32 %57, -1
  br i1 %58, label %60, label %59

59:                                               ; preds = %56
  tail call void @__assert_fail(ptr noundef nonnull @.str.28, ptr noundef nonnull @.str.1, i32 noundef 163, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

60:                                               ; preds = %56, %51
  %61 = phi i32 [ %57, %56 ], [ %54, %51 ]
  %62 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 66, i32 noundef 448) #13
  %63 = icmp slt i32 %62, 0
  br i1 %63, label %64, label %68

64:                                               ; preds = %60
  tail call void @perror(ptr noundef nonnull @.str.29) #16
  %65 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 66, i32 noundef 448) #13
  %66 = icmp sgt i32 %65, -1
  br i1 %66, label %68, label %67

67:                                               ; preds = %64
  tail call void @__assert_fail(ptr noundef nonnull @.str.30, ptr noundef nonnull @.str.1, i32 noundef 164, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

68:                                               ; preds = %60, %64
  %69 = phi i32 [ %65, %64 ], [ %62, %60 ]
  br label %70

70:                                               ; preds = %68, %79
  %71 = phi i32 [ %80, %79 ], [ 0, %68 ]
  br label %72

72:                                               ; preds = %70, %72
  %73 = phi i32 [ 0, %70 ], [ %77, %72 ]
  %74 = tail call i32 @rand() #13
  %75 = srem i32 %74, 11
  store i32 %75, ptr %7, align 4, !tbaa !23
  %76 = call i64 @write(i32 noundef %61, ptr noundef nonnull %7, i64 noundef 4) #13
  %77 = add nuw nsw i32 %73, 1
  %78 = icmp eq i32 %77, %28
  br i1 %78, label %79, label %72, !llvm.loop !31

79:                                               ; preds = %72
  %80 = add nuw nsw i32 %71, 1
  %81 = icmp eq i32 %80, %28
  br i1 %81, label %82, label %70, !llvm.loop !32

82:                                               ; preds = %79, %91
  %83 = phi i32 [ %92, %91 ], [ 0, %79 ]
  br label %84

84:                                               ; preds = %82, %84
  %85 = phi i32 [ 0, %82 ], [ %89, %84 ]
  %86 = tail call i32 @rand() #13
  %87 = srem i32 %86, 11
  store i32 %87, ptr %7, align 4, !tbaa !23
  %88 = call i64 @write(i32 noundef %69, ptr noundef nonnull %7, i64 noundef 4) #13
  %89 = add nuw nsw i32 %85, 1
  %90 = icmp eq i32 %89, %28
  br i1 %90, label %91, label %84, !llvm.loop !33

91:                                               ; preds = %84
  %92 = add nuw nsw i32 %83, 1
  %93 = icmp eq i32 %92, %28
  br i1 %93, label %94, label %82, !llvm.loop !34

94:                                               ; preds = %91
  %95 = tail call i32 @close(i32 noundef %61) #13
  %96 = icmp slt i32 %95, 0
  br i1 %96, label %97, label %101

97:                                               ; preds = %94
  tail call void @perror(ptr noundef nonnull @.str.31) #16
  %98 = tail call i32 @close(i32 noundef %61) #13
  %99 = icmp sgt i32 %98, -1
  br i1 %99, label %101, label %100

100:                                              ; preds = %97
  tail call void @__assert_fail(ptr noundef nonnull @.str.32, ptr noundef nonnull @.str.1, i32 noundef 180, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

101:                                              ; preds = %97, %94
  %102 = tail call i32 @close(i32 noundef %69) #13
  %103 = icmp slt i32 %102, 0
  br i1 %103, label %104, label %108

104:                                              ; preds = %101
  tail call void @perror(ptr noundef nonnull @.str.33) #16
  %105 = tail call i32 @close(i32 noundef %69) #13
  %106 = icmp sgt i32 %105, -1
  br i1 %106, label %108, label %107

107:                                              ; preds = %104
  tail call void @__assert_fail(ptr noundef nonnull @.str.34, ptr noundef nonnull @.str.1, i32 noundef 181, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

108:                                              ; preds = %104, %101
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %7) #13
  br label %109

109:                                              ; preds = %108, %47
  %110 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 0) #13
  %111 = icmp slt i32 %110, 0
  br i1 %111, label %112, label %116

112:                                              ; preds = %109
  tail call void @perror(ptr noundef nonnull @.str.35) #16
  %113 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 0) #13
  %114 = icmp sgt i32 %113, -1
  br i1 %114, label %116, label %115

115:                                              ; preds = %112
  tail call void @__assert_fail(ptr noundef nonnull @.str.36, ptr noundef nonnull @.str.1, i32 noundef 184, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

116:                                              ; preds = %112, %109
  %117 = phi i32 [ %113, %112 ], [ %110, %109 ]
  %118 = call i32 @fstat(i32 noundef %117, ptr noundef nonnull %3) #13
  %119 = icmp slt i32 %118, 0
  br i1 %119, label %120, label %124

120:                                              ; preds = %116
  tail call void @perror(ptr noundef nonnull @.str.37) #16
  %121 = call i32 @fstat(i32 noundef %117, ptr noundef nonnull %3) #13
  %122 = icmp sgt i32 %121, -1
  br i1 %122, label %124, label %123

123:                                              ; preds = %120
  tail call void @__assert_fail(ptr noundef nonnull @.str.38, ptr noundef nonnull @.str.1, i32 noundef 185, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

124:                                              ; preds = %120, %116
  %125 = shl i64 %37, 34
  %126 = ashr exact i64 %125, 32
  %127 = or i64 %126, 1
  %128 = tail call ptr @mmap(ptr noundef null, i64 noundef %127, i32 noundef 3, i32 noundef 2, i32 noundef %117, i64 noundef 0) #13
  %129 = icmp eq ptr %128, null
  br i1 %129, label %130, label %134

130:                                              ; preds = %124
  tail call void @perror(ptr noundef nonnull @.str.39) #16
  %131 = tail call ptr @mmap(ptr noundef null, i64 noundef %127, i32 noundef 3, i32 noundef 2, i32 noundef %117, i64 noundef 0) #13
  %132 = icmp eq ptr %131, null
  br i1 %132, label %133, label %134

133:                                              ; preds = %130
  tail call void @__assert_fail(ptr noundef nonnull @.str.40, ptr noundef nonnull @.str.1, i32 noundef 186, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

134:                                              ; preds = %130, %124
  %135 = phi ptr [ %131, %130 ], [ %128, %124 ]
  %136 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 0) #13
  %137 = icmp slt i32 %136, 0
  br i1 %137, label %138, label %142

138:                                              ; preds = %134
  tail call void @perror(ptr noundef nonnull @.str.41) #16
  %139 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 0) #13
  %140 = icmp sgt i32 %139, -1
  br i1 %140, label %142, label %141

141:                                              ; preds = %138
  tail call void @__assert_fail(ptr noundef nonnull @.str.42, ptr noundef nonnull @.str.1, i32 noundef 188, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

142:                                              ; preds = %138, %134
  %143 = phi i32 [ %139, %138 ], [ %136, %134 ]
  %144 = call i32 @fstat(i32 noundef %143, ptr noundef nonnull %4) #13
  %145 = icmp slt i32 %144, 0
  br i1 %145, label %146, label %150

146:                                              ; preds = %142
  tail call void @perror(ptr noundef nonnull @.str.43) #16
  %147 = call i32 @fstat(i32 noundef %143, ptr noundef nonnull %4) #13
  %148 = icmp sgt i32 %147, -1
  br i1 %148, label %150, label %149

149:                                              ; preds = %146
  tail call void @__assert_fail(ptr noundef nonnull @.str.44, ptr noundef nonnull @.str.1, i32 noundef 189, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

150:                                              ; preds = %146, %142
  %151 = tail call ptr @mmap(ptr noundef null, i64 noundef %127, i32 noundef 3, i32 noundef 2, i32 noundef %143, i64 noundef 0) #13
  %152 = icmp eq ptr %151, null
  br i1 %152, label %153, label %157

153:                                              ; preds = %150
  tail call void @perror(ptr noundef nonnull @.str.45) #16
  %154 = tail call ptr @mmap(ptr noundef null, i64 noundef %127, i32 noundef 3, i32 noundef 2, i32 noundef %143, i64 noundef 0) #13
  %155 = icmp eq ptr %154, null
  br i1 %155, label %156, label %157

156:                                              ; preds = %153
  tail call void @__assert_fail(ptr noundef nonnull @.str.46, ptr noundef nonnull @.str.1, i32 noundef 190, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

157:                                              ; preds = %153, %150
  %158 = phi ptr [ %154, %153 ], [ %151, %150 ]
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %8) #13
  %159 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 3
  store i32 %28, ptr %159, align 8, !tbaa !5
  %160 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 1
  %161 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 2
  store i32 0, ptr %8, align 8, !tbaa !15
  %162 = tail call noalias ptr @malloc(i64 noundef %38) #15
  %163 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 4
  store ptr %162, ptr %163, align 8, !tbaa !13
  store ptr %135, ptr %160, align 8, !tbaa !11
  store ptr %158, ptr %161, align 8, !tbaa !12
  %164 = call i32 @gettimeofday(ptr noundef nonnull %5, ptr noundef null) #13
  call void @matrixmult_splitter(ptr noundef nonnull %8, i32 noundef %35)
  %165 = call i32 @gettimeofday(ptr noundef nonnull %6, ptr noundef null) #13
  %166 = load i64, ptr %6, align 8, !tbaa !35
  %167 = load i64, ptr %5, align 8, !tbaa !35
  %168 = sub nsw i64 %166, %167
  %169 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.47, i64 noundef %168)
  %170 = icmp eq i32 %28, 0
  br i1 %170, label %190, label %171

171:                                              ; preds = %157
  %172 = call i32 @llvm.umax.i32(i32 %36, i32 1)
  %173 = zext i32 %172 to i64
  br label %174

174:                                              ; preds = %171, %182
  %175 = phi i64 [ 0, %171 ], [ %188, %182 ]
  %176 = trunc i64 %175 to i32
  %177 = srem i32 %176, %28
  %178 = icmp eq i32 %177, 0
  br i1 %178, label %179, label %182

179:                                              ; preds = %174
  %180 = load ptr, ptr @stdout, align 8, !tbaa !14
  %181 = call i32 @fputc(i32 10, ptr %180)
  br label %182

182:                                              ; preds = %179, %174
  %183 = load ptr, ptr @stdout, align 8, !tbaa !14
  %184 = load ptr, ptr %163, align 8, !tbaa !13
  %185 = getelementptr inbounds i32, ptr %184, i64 %175
  %186 = load i32, ptr %185, align 4, !tbaa !23
  %187 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %183, ptr noundef nonnull @.str.49, i32 noundef %186)
  %188 = add nuw nsw i64 %175, 1
  %189 = icmp eq i64 %188, %173
  br i1 %189, label %190, label %174, !llvm.loop !37

190:                                              ; preds = %182, %157
  %191 = load ptr, ptr @stdout, align 8, !tbaa !14
  %192 = call i32 @fputc(i32 10, ptr %191)
  %193 = load ptr, ptr %163, align 8, !tbaa !13
  call void @free(ptr noundef %193) #13
  %194 = call i32 @munmap(ptr noundef %135, i64 noundef %127) #13
  %195 = icmp slt i32 %194, 0
  br i1 %195, label %196, label %200

196:                                              ; preds = %190
  call void @perror(ptr noundef nonnull @.str.50) #16
  %197 = call i32 @munmap(ptr noundef %135, i64 noundef %127) #13
  %198 = icmp sgt i32 %197, -1
  br i1 %198, label %200, label %199

199:                                              ; preds = %196
  call void @__assert_fail(ptr noundef nonnull @.str.51, ptr noundef nonnull @.str.1, i32 noundef 216, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

200:                                              ; preds = %196, %190
  %201 = call i32 @close(i32 noundef %117) #13
  %202 = icmp slt i32 %201, 0
  br i1 %202, label %203, label %207

203:                                              ; preds = %200
  call void @perror(ptr noundef nonnull @.str.31) #16
  %204 = call i32 @close(i32 noundef %117) #13
  %205 = icmp sgt i32 %204, -1
  br i1 %205, label %207, label %206

206:                                              ; preds = %203
  call void @__assert_fail(ptr noundef nonnull @.str.32, ptr noundef nonnull @.str.1, i32 noundef 217, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

207:                                              ; preds = %203, %200
  %208 = call i32 @munmap(ptr noundef %158, i64 noundef %127) #13
  %209 = icmp slt i32 %208, 0
  br i1 %209, label %210, label %214

210:                                              ; preds = %207
  call void @perror(ptr noundef nonnull @.str.52) #16
  %211 = call i32 @munmap(ptr noundef %158, i64 noundef %127) #13
  %212 = icmp sgt i32 %211, -1
  br i1 %212, label %214, label %213

213:                                              ; preds = %210
  call void @__assert_fail(ptr noundef nonnull @.str.53, ptr noundef nonnull @.str.1, i32 noundef 218, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

214:                                              ; preds = %210, %207
  %215 = call i32 @close(i32 noundef %143) #13
  %216 = icmp slt i32 %215, 0
  br i1 %216, label %217, label %221

217:                                              ; preds = %214
  call void @perror(ptr noundef nonnull @.str.33) #16
  %218 = call i32 @close(i32 noundef %143) #13
  %219 = icmp sgt i32 %218, -1
  br i1 %219, label %221, label %220

220:                                              ; preds = %217
  call void @__assert_fail(ptr noundef nonnull @.str.34, ptr noundef nonnull @.str.1, i32 noundef 219, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

221:                                              ; preds = %217, %214
  %222 = call i32 @close(i32 noundef %48) #13
  %223 = icmp slt i32 %222, 0
  br i1 %223, label %224, label %228

224:                                              ; preds = %221
  call void @perror(ptr noundef nonnull @.str.54) #16
  %225 = call i32 @close(i32 noundef %48) #13
  %226 = icmp sgt i32 %225, -1
  br i1 %226, label %228, label %227

227:                                              ; preds = %224
  call void @__assert_fail(ptr noundef nonnull @.str.55, ptr noundef nonnull @.str.1, i32 noundef 220, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #14
  unreachable

228:                                              ; preds = %224, %221
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %8) #13
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6) #13
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %5) #13
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %4) #13
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %3) #13
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @time(ptr noundef) local_unnamed_addr #5

; Function Attrs: nounwind
declare void @srand(i32 noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #10

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #11

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #5

; Function Attrs: nofree
declare noundef i64 @write(i32 noundef, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #11

declare i32 @close(i32 noundef) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare noundef i32 @fstat(i32 noundef, ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind
declare ptr @mmap(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @gettimeofday(ptr nocapture noundef, ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umax.i32(i32, i32) #7

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind
declare i32 @munmap(ptr noundef, i64 noundef) local_unnamed_addr #5

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nofree nounwind }
attributes #13 = { nounwind }
attributes #14 = { noreturn nounwind }
attributes #15 = { nounwind allocsize(0) }
attributes #16 = { cold }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !7, i64 24}
!6 = !{!"", !7, i64 0, !10, i64 8, !10, i64 16, !7, i64 24, !10, i64 32}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!"any pointer", !8, i64 0}
!11 = !{!6, !10, i64 8}
!12 = !{!6, !10, i64 16}
!13 = !{!6, !10, i64 32}
!14 = !{!10, !10, i64 0}
!15 = !{!6, !7, i64 0}
!16 = !{!17, !18, i64 0}
!17 = !{!"", !18, i64 0, !10, i64 8}
!18 = !{!"long", !8, i64 0}
!19 = !{!17, !10, i64 8}
!20 = distinct !{!20, !21}
!21 = !{!"llvm.loop.mustprogress"}
!22 = !{!18, !18, i64 0}
!23 = !{!7, !7, i64 0}
!24 = distinct !{!24, !21}
!25 = distinct !{!25, !21}
!26 = distinct !{!26, !27}
!27 = !{!"llvm.loop.unroll.disable"}
!28 = distinct !{!28, !21}
!29 = distinct !{!29, !21, !30}
!30 = !{!"llvm.loop.unswitch.partial.disable"}
!31 = distinct !{!31, !21}
!32 = distinct !{!32, !21}
!33 = distinct !{!33, !21}
!34 = distinct !{!34, !21}
!35 = !{!36, !18, i64 0}
!36 = !{!"timeval", !18, i64 0, !18, i64 8}
!37 = distinct !{!37, !21}

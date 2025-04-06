; ModuleID = 'linked.ll'
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
@LAST_WRITES = local_unnamed_addr global <{ [524288 x i8] }> zeroinitializer, align 8
@alloc_f4edb16977186e9ae4559a0ffa645764 = private unnamed_addr constant <{ [45 x i8] }> <{ [45 x i8] c"[Instrumentation] Store at addr=%p, tid=%lu\0A\00" }>, align 1
@alloc_eaa8d86eb8418cd1619ec8c976029920 = private unnamed_addr constant <{ [69 x i8] }> <{ [69 x i8] c"[Instrumentation] Load at addr=%p, tid=%lu, no prior store recorded\0A\00" }>, align 1
@alloc_495169d419c395796b86eab1ffe3ce6c = private unnamed_addr constant <{ [66 x i8] }> <{ [66 x i8] c"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=%lu\0A\00" }>, align 1
@alloc_2c7ab4da309e7a77ecad0a4e9c550e6d = private unnamed_addr constant <{ [78 x i8] }> <{ [78 x i8] c"[Instrumentation] Load at addr=%p, tid=%lu, last_modified_by=the same thread\0A\00" }>, align 1

; Function Attrs: nounwind uwtable
define dso_local void @matrixmult_splitter(ptr noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = alloca %union.pthread_attr_t, align 8
  %4 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %3) #14
  %5 = icmp eq ptr %0, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %2
  tail call void @__assert_fail(ptr noundef nonnull @.str, ptr noundef nonnull @.str.1, i32 noundef 45, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

7:                                                ; preds = %2
  %8 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 3
  %tid = call i64 @pthread_self()
  %_4.i = ptrtoint ptr %8 to i64
  %index.i = and i64 %_4.i, 65535
  %9 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i
  %prev_tid.i = load i64, ptr %9, align 8, !noundef !7
  %10 = icmp eq i64 %prev_tid.i, 0
  br i1 %10, label %bb2.i, label %bb4.i

bb2.i:                                            ; preds = %7
  %_8.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %8, i64 noundef %tid) #14
  br label %log_load.exit

bb4.i:                                            ; preds = %7
  %_11.i = icmp eq i64 %prev_tid.i, %tid
  br i1 %_11.i, label %bb5.i, label %bb7.i

bb7.i:                                            ; preds = %bb4.i
  %_15.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %8, i64 noundef %tid, i64 noundef %prev_tid.i) #14
  br label %log_load.exit

bb5.i:                                            ; preds = %bb4.i
  %_12.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %8, i64 noundef %tid) #14
  br label %log_load.exit

log_load.exit:                                    ; preds = %bb2.i, %bb7.i, %bb5.i
  %11 = load i32, ptr %8, align 8, !tbaa !8
  %12 = icmp sgt i32 %11, -1
  br i1 %12, label %14, label %13

13:                                               ; preds = %log_load.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.1, i32 noundef 46, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

14:                                               ; preds = %log_load.exit
  %15 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 1
  %tid1 = call i64 @pthread_self()
  %_4.i1 = ptrtoint ptr %15 to i64
  %index.i2 = and i64 %_4.i1, 65535
  %16 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i2
  %prev_tid.i3 = load i64, ptr %16, align 8, !noundef !7
  %17 = icmp eq i64 %prev_tid.i3, 0
  br i1 %17, label %bb2.i10, label %bb4.i4

bb2.i10:                                          ; preds = %14
  %_8.i11 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %15, i64 noundef %tid1) #14
  br label %log_load.exit12

bb4.i4:                                           ; preds = %14
  %_11.i5 = icmp eq i64 %prev_tid.i3, %tid1
  br i1 %_11.i5, label %bb5.i8, label %bb7.i6

bb7.i6:                                           ; preds = %bb4.i4
  %_15.i7 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %15, i64 noundef %tid1, i64 noundef %prev_tid.i3) #14
  br label %log_load.exit12

bb5.i8:                                           ; preds = %bb4.i4
  %_12.i9 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %15, i64 noundef %tid1) #14
  br label %log_load.exit12

log_load.exit12:                                  ; preds = %bb2.i10, %bb7.i6, %bb5.i8
  %18 = load ptr, ptr %15, align 8, !tbaa !14
  %19 = icmp eq ptr %18, null
  br i1 %19, label %20, label %21

20:                                               ; preds = %log_load.exit12
  tail call void @__assert_fail(ptr noundef nonnull @.str.3, ptr noundef nonnull @.str.1, i32 noundef 47, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

21:                                               ; preds = %log_load.exit12
  %22 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 2
  %tid2 = call i64 @pthread_self()
  %_4.i13 = ptrtoint ptr %22 to i64
  %index.i14 = and i64 %_4.i13, 65535
  %23 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i14
  %prev_tid.i15 = load i64, ptr %23, align 8, !noundef !7
  %24 = icmp eq i64 %prev_tid.i15, 0
  br i1 %24, label %bb2.i22, label %bb4.i16

bb2.i22:                                          ; preds = %21
  %_8.i23 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %22, i64 noundef %tid2) #14
  br label %log_load.exit24

bb4.i16:                                          ; preds = %21
  %_11.i17 = icmp eq i64 %prev_tid.i15, %tid2
  br i1 %_11.i17, label %bb5.i20, label %bb7.i18

bb7.i18:                                          ; preds = %bb4.i16
  %_15.i19 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %22, i64 noundef %tid2, i64 noundef %prev_tid.i15) #14
  br label %log_load.exit24

bb5.i20:                                          ; preds = %bb4.i16
  %_12.i21 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %22, i64 noundef %tid2) #14
  br label %log_load.exit24

log_load.exit24:                                  ; preds = %bb2.i22, %bb7.i18, %bb5.i20
  %25 = load ptr, ptr %22, align 8, !tbaa !15
  %26 = icmp eq ptr %25, null
  br i1 %26, label %27, label %28

27:                                               ; preds = %log_load.exit24
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.1, i32 noundef 48, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

28:                                               ; preds = %log_load.exit24
  %29 = getelementptr inbounds %struct.mm_data_t, ptr %0, i64 0, i32 4
  %tid3 = call i64 @pthread_self()
  %_4.i25 = ptrtoint ptr %29 to i64
  %index.i26 = and i64 %_4.i25, 65535
  %30 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i26
  %prev_tid.i27 = load i64, ptr %30, align 8, !noundef !7
  %31 = icmp eq i64 %prev_tid.i27, 0
  br i1 %31, label %bb2.i34, label %bb4.i28

bb2.i34:                                          ; preds = %28
  %_8.i35 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %29, i64 noundef %tid3) #14
  br label %log_load.exit36

bb4.i28:                                          ; preds = %28
  %_11.i29 = icmp eq i64 %prev_tid.i27, %tid3
  br i1 %_11.i29, label %bb5.i32, label %bb7.i30

bb7.i30:                                          ; preds = %bb4.i28
  %_15.i31 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %29, i64 noundef %tid3, i64 noundef %prev_tid.i27) #14
  br label %log_load.exit36

bb5.i32:                                          ; preds = %bb4.i28
  %_12.i33 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %29, i64 noundef %tid3) #14
  br label %log_load.exit36

log_load.exit36:                                  ; preds = %bb2.i34, %bb7.i30, %bb5.i32
  %32 = load ptr, ptr %29, align 8, !tbaa !16
  %33 = icmp eq ptr %32, null
  br i1 %33, label %34, label %35

34:                                               ; preds = %log_load.exit36
  tail call void @__assert_fail(ptr noundef nonnull @.str.5, ptr noundef nonnull @.str.1, i32 noundef 49, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

35:                                               ; preds = %log_load.exit36
  %tid4 = call i64 @pthread_self()
  %prev_tid.i37 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %36 = icmp eq i64 %prev_tid.i37, 0
  br i1 %36, label %bb2.i44, label %bb4.i38

bb2.i44:                                          ; preds = %35
  %_8.i45 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid4) #14
  br label %log_load.exit46

bb4.i38:                                          ; preds = %35
  %_11.i39 = icmp eq i64 %prev_tid.i37, %tid4
  br i1 %_11.i39, label %bb5.i42, label %bb7.i40

bb7.i40:                                          ; preds = %bb4.i38
  %_15.i41 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid4, i64 noundef %prev_tid.i37) #14
  br label %log_load.exit46

bb5.i42:                                          ; preds = %bb4.i38
  %_12.i43 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid4) #14
  br label %log_load.exit46

log_load.exit46:                                  ; preds = %bb2.i44, %bb7.i40, %bb5.i42
  %37 = load ptr, ptr @stdout, align 8, !tbaa !17
  %38 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %37, ptr noundef nonnull @.str.6, i32 noundef %1)
  %39 = sext i32 %1 to i64
  %40 = shl nsw i64 %39, 3
  %41 = tail call noalias ptr @malloc(i64 noundef %40) #16
  %42 = icmp eq ptr %41, null
  br i1 %42, label %43, label %44

43:                                               ; preds = %log_load.exit46
  tail call void @__assert_fail(ptr noundef nonnull @.str.56, ptr noundef nonnull @.str.57, i32 noundef 52, ptr noundef nonnull @__PRETTY_FUNCTION__.MALLOC) #15
  unreachable

44:                                               ; preds = %log_load.exit46
  %45 = call i32 @pthread_attr_init(ptr noundef nonnull %3) #14
  %46 = call i32 @pthread_attr_setscope(ptr noundef nonnull %3, i32 noundef 0) #14
  %tid5 = call i64 @pthread_self()
  %_4.i47 = ptrtoint ptr %8 to i64
  %index.i48 = and i64 %_4.i47, 65535
  %47 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i48
  %prev_tid.i49 = load i64, ptr %47, align 8, !noundef !7
  %48 = icmp eq i64 %prev_tid.i49, 0
  br i1 %48, label %bb2.i56, label %bb4.i50

bb2.i56:                                          ; preds = %44
  %_8.i57 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %8, i64 noundef %tid5) #14
  br label %log_load.exit58

bb4.i50:                                          ; preds = %44
  %_11.i51 = icmp eq i64 %prev_tid.i49, %tid5
  br i1 %_11.i51, label %bb5.i54, label %bb7.i52

bb7.i52:                                          ; preds = %bb4.i50
  %_15.i53 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %8, i64 noundef %tid5, i64 noundef %prev_tid.i49) #14
  br label %log_load.exit58

bb5.i54:                                          ; preds = %bb4.i50
  %_12.i55 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %8, i64 noundef %tid5) #14
  br label %log_load.exit58

log_load.exit58:                                  ; preds = %bb2.i56, %bb7.i52, %bb5.i54
  %49 = load i32, ptr %8, align 8, !tbaa !8
  %50 = sdiv i32 %49, %1
  %51 = icmp sgt i32 %1, 0
  br i1 %51, label %52, label %128

52:                                               ; preds = %log_load.exit58
  %53 = add nsw i32 %1, -1
  %54 = zext i32 %53 to i64
  %55 = zext i32 %1 to i64
  %56 = mul nsw i32 %53, %50
  br label %60

57:                                               ; preds = %96
  br i1 %51, label %58, label %128

58:                                               ; preds = %57
  %59 = zext i32 %1 to i64
  br label %99

60:                                               ; preds = %96, %52
  %61 = phi i64 [ 0, %52 ], [ %97, %96 ]
  %62 = call noalias dereferenceable_or_null(16) ptr @malloc(i64 noundef 16) #16
  %63 = call noalias dereferenceable_or_null(40) ptr @malloc(i64 noundef 40) #16
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %63, ptr noundef nonnull align 8 dereferenceable(40) %0, i64 40, i1 false)
  %tid6 = call i64 @pthread_self()
  %_4.i59 = ptrtoint ptr %8 to i64
  %index.i60 = and i64 %_4.i59, 65535
  %64 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i60
  %prev_tid.i61 = load i64, ptr %64, align 8, !noundef !7
  %65 = icmp eq i64 %prev_tid.i61, 0
  br i1 %65, label %bb2.i68, label %bb4.i62

bb2.i68:                                          ; preds = %60
  %_8.i69 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %8, i64 noundef %tid6) #14
  br label %log_load.exit70

bb4.i62:                                          ; preds = %60
  %_11.i63 = icmp eq i64 %prev_tid.i61, %tid6
  br i1 %_11.i63, label %bb5.i66, label %bb7.i64

bb7.i64:                                          ; preds = %bb4.i62
  %_15.i65 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %8, i64 noundef %tid6, i64 noundef %prev_tid.i61) #14
  br label %log_load.exit70

bb5.i66:                                          ; preds = %bb4.i62
  %_12.i67 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %8, i64 noundef %tid6) #14
  br label %log_load.exit70

log_load.exit70:                                  ; preds = %bb2.i68, %bb7.i64, %bb5.i66
  %66 = load i32, ptr %8, align 8, !tbaa !8
  %tid7 = call i64 @pthread_self()
  %_4.i71 = ptrtoint ptr %0 to i64
  %index.i72 = and i64 %_4.i71, 65535
  %67 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i72
  %prev_tid.i73 = load i64, ptr %67, align 8, !noundef !7
  %68 = icmp eq i64 %prev_tid.i73, 0
  br i1 %68, label %bb2.i80, label %bb4.i74

bb2.i80:                                          ; preds = %log_load.exit70
  %_8.i81 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %0, i64 noundef %tid7) #14
  br label %log_load.exit82

bb4.i74:                                          ; preds = %log_load.exit70
  %_11.i75 = icmp eq i64 %prev_tid.i73, %tid7
  br i1 %_11.i75, label %bb5.i78, label %bb7.i76

bb7.i76:                                          ; preds = %bb4.i74
  %_15.i77 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %0, i64 noundef %tid7, i64 noundef %prev_tid.i73) #14
  br label %log_load.exit82

bb5.i78:                                          ; preds = %bb4.i74
  %_12.i79 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %0, i64 noundef %tid7) #14
  br label %log_load.exit82

log_load.exit82:                                  ; preds = %bb2.i80, %bb7.i76, %bb5.i78
  %69 = load i32, ptr %0, align 8, !tbaa !18
  %70 = sub nsw i32 %66, %69
  %71 = call i32 @llvm.smin.i32(i32 %50, i32 %70)
  %72 = sext i32 %71 to i64
  %tid8 = call i64 @pthread_self()
  %_4.i83 = ptrtoint ptr %62 to i64
  %index.i84 = and i64 %_4.i83, 65535
  %73 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i84
  store i64 %tid8, ptr %73, align 8
  %_7.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %62, i64 noundef %tid8) #14
  store i64 %72, ptr %62, align 8, !tbaa !19
  %74 = getelementptr inbounds %struct.map_args_t, ptr %62, i64 0, i32 1
  %tid9 = call i64 @pthread_self()
  %_4.i85 = ptrtoint ptr %74 to i64
  %index.i86 = and i64 %_4.i85, 65535
  %75 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i86
  store i64 %tid9, ptr %75, align 8
  %_7.i87 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %74, i64 noundef %tid9) #14
  store ptr %63, ptr %74, align 8, !tbaa !22
  %76 = icmp eq i64 %61, %54
  br i1 %76, label %77, label %81

77:                                               ; preds = %log_load.exit82
  %78 = sub nsw i32 %66, %56
  %79 = sext i32 %78 to i64
  %tid10 = call i64 @pthread_self()
  %_4.i88 = ptrtoint ptr %62 to i64
  %index.i89 = and i64 %_4.i88, 65535
  %80 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i89
  store i64 %tid10, ptr %80, align 8
  %_7.i90 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %62, i64 noundef %tid10) #14
  store i64 %79, ptr %62, align 8, !tbaa !19
  br label %81

81:                                               ; preds = %77, %log_load.exit82
  %82 = phi i64 [ %79, %77 ], [ %72, %log_load.exit82 ]
  %83 = trunc i64 %82 to i32
  %84 = add i32 %69, %83
  %tid11 = call i64 @pthread_self()
  %_4.i91 = ptrtoint ptr %0 to i64
  %index.i92 = and i64 %_4.i91, 65535
  %85 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i92
  store i64 %tid11, ptr %85, align 8
  %_7.i93 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %0, i64 noundef %tid11) #14
  store i32 %84, ptr %0, align 8, !tbaa !18
  %tid12 = call i64 @pthread_self()
  %prev_tid.i94 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %86 = icmp eq i64 %prev_tid.i94, 0
  br i1 %86, label %bb2.i101, label %bb4.i95

bb2.i101:                                         ; preds = %81
  %_8.i102 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid12) #14
  br label %log_load.exit103

bb4.i95:                                          ; preds = %81
  %_11.i96 = icmp eq i64 %prev_tid.i94, %tid12
  br i1 %_11.i96, label %bb5.i99, label %bb7.i97

bb7.i97:                                          ; preds = %bb4.i95
  %_15.i98 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid12, i64 noundef %prev_tid.i94) #14
  br label %log_load.exit103

bb5.i99:                                          ; preds = %bb4.i95
  %_12.i100 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid12) #14
  br label %log_load.exit103

log_load.exit103:                                 ; preds = %bb2.i101, %bb7.i97, %bb5.i99
  %87 = load ptr, ptr @stdout, align 8, !tbaa !17
  %88 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %87, ptr noundef nonnull @.str.7, i64 noundef %82, i32 noundef %84)
  %89 = getelementptr inbounds i64, ptr %41, i64 %61
  %90 = call i32 @pthread_create(ptr noundef nonnull %89, ptr noundef nonnull %3, ptr noundef nonnull @matrixmult_map, ptr noundef nonnull %62) #14
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %96, label %92

92:                                               ; preds = %log_load.exit103
  call void @perror(ptr noundef nonnull @.str.8) #17
  %93 = call i32 @pthread_create(ptr noundef nonnull %89, ptr noundef nonnull %3, ptr noundef nonnull @matrixmult_map, ptr noundef nonnull %62) #14
  %94 = icmp eq i32 %93, 0
  br i1 %94, label %96, label %95

95:                                               ; preds = %92
  call void @__assert_fail(ptr noundef nonnull @.str.9, ptr noundef nonnull @.str.1, i32 noundef 76, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

96:                                               ; preds = %92, %log_load.exit103
  %97 = add nuw nsw i64 %61, 1
  %98 = icmp eq i64 %97, %55
  br i1 %98, label %57, label %60, !llvm.loop !23

99:                                               ; preds = %125, %58
  %100 = phi i64 [ 0, %58 ], [ %126, %125 ]
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #14
  %101 = getelementptr inbounds i64, ptr %41, i64 %100
  %tid13 = call i64 @pthread_self()
  %_4.i104 = ptrtoint ptr %101 to i64
  %index.i105 = and i64 %_4.i104, 65535
  %102 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i105
  %prev_tid.i106 = load i64, ptr %102, align 8, !noundef !7
  %103 = icmp eq i64 %prev_tid.i106, 0
  br i1 %103, label %bb2.i113, label %bb4.i107

bb2.i113:                                         ; preds = %99
  %_8.i114 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %101, i64 noundef %tid13) #14
  br label %log_load.exit115

bb4.i107:                                         ; preds = %99
  %_11.i108 = icmp eq i64 %prev_tid.i106, %tid13
  br i1 %_11.i108, label %bb5.i111, label %bb7.i109

bb7.i109:                                         ; preds = %bb4.i107
  %_15.i110 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %101, i64 noundef %tid13, i64 noundef %prev_tid.i106) #14
  br label %log_load.exit115

bb5.i111:                                         ; preds = %bb4.i107
  %_12.i112 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %101, i64 noundef %tid13) #14
  br label %log_load.exit115

log_load.exit115:                                 ; preds = %bb2.i113, %bb7.i109, %bb5.i111
  %104 = load i64, ptr %101, align 8, !tbaa !25
  %105 = call i32 @pthread_join(i64 noundef %104, ptr noundef nonnull %4) #14
  %106 = icmp eq i32 %105, 0
  br i1 %106, label %114, label %107

107:                                              ; preds = %log_load.exit115
  call void @perror(ptr noundef nonnull @.str.10) #17
  %tid14 = call i64 @pthread_self()
  %_4.i116 = ptrtoint ptr %101 to i64
  %index.i117 = and i64 %_4.i116, 65535
  %108 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i117
  %prev_tid.i118 = load i64, ptr %108, align 8, !noundef !7
  %109 = icmp eq i64 %prev_tid.i118, 0
  br i1 %109, label %bb2.i125, label %bb4.i119

bb2.i125:                                         ; preds = %107
  %_8.i126 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %101, i64 noundef %tid14) #14
  br label %log_load.exit127

bb4.i119:                                         ; preds = %107
  %_11.i120 = icmp eq i64 %prev_tid.i118, %tid14
  br i1 %_11.i120, label %bb5.i123, label %bb7.i121

bb7.i121:                                         ; preds = %bb4.i119
  %_15.i122 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %101, i64 noundef %tid14, i64 noundef %prev_tid.i118) #14
  br label %log_load.exit127

bb5.i123:                                         ; preds = %bb4.i119
  %_12.i124 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %101, i64 noundef %tid14) #14
  br label %log_load.exit127

log_load.exit127:                                 ; preds = %bb2.i125, %bb7.i121, %bb5.i123
  %110 = load i64, ptr %101, align 8, !tbaa !25
  %111 = call i32 @pthread_join(i64 noundef %110, ptr noundef nonnull %4) #14
  %112 = icmp eq i32 %111, 0
  br i1 %112, label %114, label %113

113:                                              ; preds = %log_load.exit127
  call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.1, i32 noundef 81, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

114:                                              ; preds = %log_load.exit127, %log_load.exit115
  %tid15 = call i64 @pthread_self()
  %_4.i128 = ptrtoint ptr %4 to i64
  %index.i129 = and i64 %_4.i128, 65535
  %115 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i129
  %prev_tid.i130 = load i64, ptr %115, align 8, !noundef !7
  %116 = icmp eq i64 %prev_tid.i130, 0
  br i1 %116, label %bb2.i137, label %bb4.i131

bb2.i137:                                         ; preds = %114
  %_8.i138 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %4, i64 noundef %tid15) #14
  br label %log_load.exit139

bb4.i131:                                         ; preds = %114
  %_11.i132 = icmp eq i64 %prev_tid.i130, %tid15
  br i1 %_11.i132, label %bb5.i135, label %bb7.i133

bb7.i133:                                         ; preds = %bb4.i131
  %_15.i134 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %4, i64 noundef %tid15, i64 noundef %prev_tid.i130) #14
  br label %log_load.exit139

bb5.i135:                                         ; preds = %bb4.i131
  %_12.i136 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %4, i64 noundef %tid15) #14
  br label %log_load.exit139

log_load.exit139:                                 ; preds = %bb2.i137, %bb7.i133, %bb5.i135
  %117 = load i32, ptr %4, align 4, !tbaa !26
  %118 = icmp eq i32 %117, 0
  br i1 %118, label %125, label %119

119:                                              ; preds = %log_load.exit139
  call void @perror(ptr noundef nonnull @.str.12) #17
  %tid16 = call i64 @pthread_self()
  %_4.i140 = ptrtoint ptr %4 to i64
  %index.i141 = and i64 %_4.i140, 65535
  %120 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i141
  %prev_tid.i142 = load i64, ptr %120, align 8, !noundef !7
  %121 = icmp eq i64 %prev_tid.i142, 0
  br i1 %121, label %bb2.i149, label %bb4.i143

bb2.i149:                                         ; preds = %119
  %_8.i150 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %4, i64 noundef %tid16) #14
  br label %log_load.exit151

bb4.i143:                                         ; preds = %119
  %_11.i144 = icmp eq i64 %prev_tid.i142, %tid16
  br i1 %_11.i144, label %bb5.i147, label %bb7.i145

bb7.i145:                                         ; preds = %bb4.i143
  %_15.i146 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %4, i64 noundef %tid16, i64 noundef %prev_tid.i142) #14
  br label %log_load.exit151

bb5.i147:                                         ; preds = %bb4.i143
  %_12.i148 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %4, i64 noundef %tid16) #14
  br label %log_load.exit151

log_load.exit151:                                 ; preds = %bb2.i149, %bb7.i145, %bb5.i147
  %122 = load i32, ptr %4, align 4, !tbaa !26
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %125, label %124

124:                                              ; preds = %log_load.exit151
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.1, i32 noundef 82, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_splitter) #15
  unreachable

125:                                              ; preds = %log_load.exit151, %log_load.exit139
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #14
  %126 = add nuw nsw i64 %100, 1
  %127 = icmp eq i64 %126, %59
  br i1 %127, label %128, label %99, !llvm.loop !27

128:                                              ; preds = %125, %57, %log_load.exit58
  call void @free(ptr noundef %41) #14
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %3) #14
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #2

declare i64 @pthread_self()

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
  tail call void @__assert_fail(ptr noundef nonnull @.str.14, ptr noundef nonnull @.str.1, i32 noundef 94, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_map) #15
  unreachable

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.map_args_t, ptr %0, i64 0, i32 1
  %tid = call i64 @pthread_self()
  %_4.i = ptrtoint ptr %5 to i64
  %index.i = and i64 %_4.i, 65535
  %6 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i
  %prev_tid.i = load i64, ptr %6, align 8, !noundef !7
  %7 = icmp eq i64 %prev_tid.i, 0
  br i1 %7, label %bb2.i, label %bb4.i

bb2.i:                                            ; preds = %4
  %_8.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %5, i64 noundef %tid) #14
  br label %log_load.exit

bb4.i:                                            ; preds = %4
  %_11.i = icmp eq i64 %prev_tid.i, %tid
  br i1 %_11.i, label %bb5.i, label %bb7.i

bb7.i:                                            ; preds = %bb4.i
  %_15.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %5, i64 noundef %tid, i64 noundef %prev_tid.i) #14
  br label %log_load.exit

bb5.i:                                            ; preds = %bb4.i
  %_12.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %5, i64 noundef %tid) #14
  br label %log_load.exit

log_load.exit:                                    ; preds = %bb2.i, %bb7.i, %bb5.i
  %8 = load ptr, ptr %5, align 8, !tbaa !22
  %9 = icmp eq ptr %8, null
  br i1 %9, label %27, label %10

10:                                               ; preds = %log_load.exit
  %tid1 = call i64 @pthread_self()
  %_4.i1 = ptrtoint ptr %0 to i64
  %index.i2 = and i64 %_4.i1, 65535
  %11 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i2
  %prev_tid.i3 = load i64, ptr %11, align 8, !noundef !7
  %12 = icmp eq i64 %prev_tid.i3, 0
  br i1 %12, label %bb2.i10, label %bb4.i4

bb2.i10:                                          ; preds = %10
  %_8.i11 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %0, i64 noundef %tid1) #14
  br label %log_load.exit12

bb4.i4:                                           ; preds = %10
  %_11.i5 = icmp eq i64 %prev_tid.i3, %tid1
  br i1 %_11.i5, label %bb5.i8, label %bb7.i6

bb7.i6:                                           ; preds = %bb4.i4
  %_15.i7 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %0, i64 noundef %tid1, i64 noundef %prev_tid.i3) #14
  br label %log_load.exit12

bb5.i8:                                           ; preds = %bb4.i4
  %_12.i9 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %0, i64 noundef %tid1) #14
  br label %log_load.exit12

log_load.exit12:                                  ; preds = %bb2.i10, %bb7.i6, %bb5.i8
  %13 = load i64, ptr %0, align 8, !tbaa !19
  %14 = icmp sgt i64 %13, 0
  br i1 %14, label %15, label %156

15:                                               ; preds = %log_load.exit12
  %16 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 1
  %tid2 = call i64 @pthread_self()
  %_4.i13 = ptrtoint ptr %16 to i64
  %index.i14 = and i64 %_4.i13, 65535
  %17 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i14
  %prev_tid.i15 = load i64, ptr %17, align 8, !noundef !7
  %18 = icmp eq i64 %prev_tid.i15, 0
  br i1 %18, label %bb2.i22, label %bb4.i16

bb2.i22:                                          ; preds = %15
  %_8.i23 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %16, i64 noundef %tid2) #14
  br label %log_load.exit24

bb4.i16:                                          ; preds = %15
  %_11.i17 = icmp eq i64 %prev_tid.i15, %tid2
  br i1 %_11.i17, label %bb5.i20, label %bb7.i18

bb7.i18:                                          ; preds = %bb4.i16
  %_15.i19 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %16, i64 noundef %tid2, i64 noundef %prev_tid.i15) #14
  br label %log_load.exit24

bb5.i20:                                          ; preds = %bb4.i16
  %_12.i21 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %16, i64 noundef %tid2) #14
  br label %log_load.exit24

log_load.exit24:                                  ; preds = %bb2.i22, %bb7.i18, %bb5.i20
  %19 = load ptr, ptr %16, align 8, !tbaa !14
  %20 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 3
  %21 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 2
  %22 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 4
  %tid3 = call i64 @pthread_self()
  %_4.i25 = ptrtoint ptr %20 to i64
  %index.i26 = and i64 %_4.i25, 65535
  %23 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i26
  %prev_tid.i27 = load i64, ptr %23, align 8, !noundef !7
  %24 = icmp eq i64 %prev_tid.i27, 0
  br i1 %24, label %bb2.i34, label %bb4.i28

bb2.i34:                                          ; preds = %log_load.exit24
  %_8.i35 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %20, i64 noundef %tid3) #14
  br label %log_load.exit36

bb4.i28:                                          ; preds = %log_load.exit24
  %_11.i29 = icmp eq i64 %prev_tid.i27, %tid3
  br i1 %_11.i29, label %bb5.i32, label %bb7.i30

bb7.i30:                                          ; preds = %bb4.i28
  %_15.i31 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %20, i64 noundef %tid3, i64 noundef %prev_tid.i27) #14
  br label %log_load.exit36

bb5.i32:                                          ; preds = %bb4.i28
  %_12.i33 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %20, i64 noundef %tid3) #14
  br label %log_load.exit36

log_load.exit36:                                  ; preds = %bb2.i34, %bb7.i30, %bb5.i32
  %25 = load i32, ptr %20, align 8, !tbaa !8
  %26 = icmp sgt i32 %25, 0
  br i1 %26, label %28, label %156

27:                                               ; preds = %log_load.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.15, ptr noundef nonnull @.str.1, i32 noundef 96, ptr noundef nonnull @__PRETTY_FUNCTION__.matrixmult_map) #15
  unreachable

28:                                               ; preds = %152, %log_load.exit36
  %29 = phi i32 [ %153, %152 ], [ %25, %log_load.exit36 ]
  %30 = phi i64 [ %154, %152 ], [ 0, %log_load.exit36 ]
  %tid4 = call i64 @pthread_self()
  %_4.i37 = ptrtoint ptr %8 to i64
  %index.i38 = and i64 %_4.i37, 65535
  %31 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i38
  %prev_tid.i39 = load i64, ptr %31, align 8, !noundef !7
  %32 = icmp eq i64 %prev_tid.i39, 0
  br i1 %32, label %bb2.i46, label %bb4.i40

bb2.i46:                                          ; preds = %28
  %_8.i47 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %8, i64 noundef %tid4) #14
  br label %log_load.exit48

bb4.i40:                                          ; preds = %28
  %_11.i41 = icmp eq i64 %prev_tid.i39, %tid4
  br i1 %_11.i41, label %bb5.i44, label %bb7.i42

bb7.i42:                                          ; preds = %bb4.i40
  %_15.i43 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %8, i64 noundef %tid4, i64 noundef %prev_tid.i39) #14
  br label %log_load.exit48

bb5.i44:                                          ; preds = %bb4.i40
  %_12.i45 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %8, i64 noundef %tid4) #14
  br label %log_load.exit48

log_load.exit48:                                  ; preds = %bb2.i46, %bb7.i42, %bb5.i44
  %33 = load i32, ptr %8, align 8, !tbaa !18
  %34 = trunc i64 %30 to i32
  %35 = add nsw i32 %33, %34
  %36 = mul nsw i32 %35, %29
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, ptr %19, i64 %37
  %39 = icmp sgt i32 %29, 0
  br i1 %39, label %40, label %152

40:                                               ; preds = %log_load.exit48
  %tid5 = call i64 @pthread_self()
  %_4.i49 = ptrtoint ptr %21 to i64
  %index.i50 = and i64 %_4.i49, 65535
  %41 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i50
  %prev_tid.i51 = load i64, ptr %41, align 8, !noundef !7
  %42 = icmp eq i64 %prev_tid.i51, 0
  br i1 %42, label %bb2.i58, label %bb4.i52

bb2.i58:                                          ; preds = %40
  %_8.i59 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %21, i64 noundef %tid5) #14
  br label %log_load.exit60

bb4.i52:                                          ; preds = %40
  %_11.i53 = icmp eq i64 %prev_tid.i51, %tid5
  br i1 %_11.i53, label %bb5.i56, label %bb7.i54

bb7.i54:                                          ; preds = %bb4.i52
  %_15.i55 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %21, i64 noundef %tid5, i64 noundef %prev_tid.i51) #14
  br label %log_load.exit60

bb5.i56:                                          ; preds = %bb4.i52
  %_12.i57 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %21, i64 noundef %tid5) #14
  br label %log_load.exit60

log_load.exit60:                                  ; preds = %bb2.i58, %bb7.i54, %bb5.i56
  %43 = load ptr, ptr %21, align 8, !tbaa !15
  %tid6 = call i64 @pthread_self()
  %_4.i61 = ptrtoint ptr %22 to i64
  %index.i62 = and i64 %_4.i61, 65535
  %44 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i62
  %prev_tid.i63 = load i64, ptr %44, align 8, !noundef !7
  %45 = icmp eq i64 %prev_tid.i63, 0
  br i1 %45, label %bb2.i70, label %bb4.i64

bb2.i70:                                          ; preds = %log_load.exit60
  %_8.i71 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %22, i64 noundef %tid6) #14
  br label %log_load.exit72

bb4.i64:                                          ; preds = %log_load.exit60
  %_11.i65 = icmp eq i64 %prev_tid.i63, %tid6
  br i1 %_11.i65, label %bb5.i68, label %bb7.i66

bb7.i66:                                          ; preds = %bb4.i64
  %_15.i67 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %22, i64 noundef %tid6, i64 noundef %prev_tid.i63) #14
  br label %log_load.exit72

bb5.i68:                                          ; preds = %bb4.i64
  %_12.i69 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %22, i64 noundef %tid6) #14
  br label %log_load.exit72

log_load.exit72:                                  ; preds = %bb2.i70, %bb7.i66, %bb5.i68
  %46 = load ptr, ptr %22, align 8, !tbaa !16
  br label %47

47:                                               ; preds = %log_load.exit218, %log_load.exit72
  %48 = phi i64 [ 0, %log_load.exit72 ], [ %146, %log_load.exit218 ]
  %49 = phi i32 [ %29, %log_load.exit72 ], [ %149, %log_load.exit218 ]
  %50 = icmp sgt i32 %49, 0
  br i1 %50, label %51, label %134

51:                                               ; preds = %47
  %52 = getelementptr inbounds i32, ptr %43, i64 %48
  %53 = zext i32 %49 to i64
  %54 = zext i32 %49 to i64
  %55 = and i64 %54, 3
  %56 = icmp ult i32 %49, 4
  br i1 %56, label %110, label %57

57:                                               ; preds = %51
  %58 = and i64 %54, 4294967292
  br label %59

59:                                               ; preds = %log_load.exit168, %57
  %60 = phi i64 [ 0, %57 ], [ %107, %log_load.exit168 ]
  %61 = phi ptr [ %52, %57 ], [ %106, %log_load.exit168 ]
  %62 = phi i32 [ 0, %57 ], [ %105, %log_load.exit168 ]
  %63 = phi i64 [ 0, %57 ], [ %108, %log_load.exit168 ]
  %64 = getelementptr inbounds i32, ptr %38, i64 %60
  %tid7 = call i64 @pthread_self()
  %_4.i73 = ptrtoint ptr %64 to i64
  %index.i74 = and i64 %_4.i73, 65535
  %65 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i74
  %prev_tid.i75 = load i64, ptr %65, align 8, !noundef !7
  %66 = icmp eq i64 %prev_tid.i75, 0
  br i1 %66, label %bb2.i82, label %bb4.i76

bb2.i82:                                          ; preds = %59
  %_8.i83 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %64, i64 noundef %tid7) #14
  br label %log_load.exit84

bb4.i76:                                          ; preds = %59
  %_11.i77 = icmp eq i64 %prev_tid.i75, %tid7
  br i1 %_11.i77, label %bb5.i80, label %bb7.i78

bb7.i78:                                          ; preds = %bb4.i76
  %_15.i79 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %64, i64 noundef %tid7, i64 noundef %prev_tid.i75) #14
  br label %log_load.exit84

bb5.i80:                                          ; preds = %bb4.i76
  %_12.i81 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %64, i64 noundef %tid7) #14
  br label %log_load.exit84

log_load.exit84:                                  ; preds = %bb2.i82, %bb7.i78, %bb5.i80
  %67 = load i32, ptr %64, align 4, !tbaa !26
  %tid8 = call i64 @pthread_self()
  %_4.i85 = ptrtoint ptr %61 to i64
  %index.i86 = and i64 %_4.i85, 65535
  %68 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i86
  %prev_tid.i87 = load i64, ptr %68, align 8, !noundef !7
  %69 = icmp eq i64 %prev_tid.i87, 0
  br i1 %69, label %bb2.i94, label %bb4.i88

bb2.i94:                                          ; preds = %log_load.exit84
  %_8.i95 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %61, i64 noundef %tid8) #14
  br label %log_load.exit96

bb4.i88:                                          ; preds = %log_load.exit84
  %_11.i89 = icmp eq i64 %prev_tid.i87, %tid8
  br i1 %_11.i89, label %bb5.i92, label %bb7.i90

bb7.i90:                                          ; preds = %bb4.i88
  %_15.i91 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %61, i64 noundef %tid8, i64 noundef %prev_tid.i87) #14
  br label %log_load.exit96

bb5.i92:                                          ; preds = %bb4.i88
  %_12.i93 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %61, i64 noundef %tid8) #14
  br label %log_load.exit96

log_load.exit96:                                  ; preds = %bb2.i94, %bb7.i90, %bb5.i92
  %70 = load i32, ptr %61, align 4, !tbaa !26
  %71 = mul nsw i32 %70, %67
  %72 = add nsw i32 %71, %62
  %73 = getelementptr inbounds i32, ptr %61, i64 %53
  %74 = or i64 %60, 1
  %75 = getelementptr inbounds i32, ptr %38, i64 %74
  %tid9 = call i64 @pthread_self()
  %_4.i97 = ptrtoint ptr %75 to i64
  %index.i98 = and i64 %_4.i97, 65535
  %76 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i98
  %prev_tid.i99 = load i64, ptr %76, align 8, !noundef !7
  %77 = icmp eq i64 %prev_tid.i99, 0
  br i1 %77, label %bb2.i106, label %bb4.i100

bb2.i106:                                         ; preds = %log_load.exit96
  %_8.i107 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %75, i64 noundef %tid9) #14
  br label %log_load.exit108

bb4.i100:                                         ; preds = %log_load.exit96
  %_11.i101 = icmp eq i64 %prev_tid.i99, %tid9
  br i1 %_11.i101, label %bb5.i104, label %bb7.i102

bb7.i102:                                         ; preds = %bb4.i100
  %_15.i103 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %75, i64 noundef %tid9, i64 noundef %prev_tid.i99) #14
  br label %log_load.exit108

bb5.i104:                                         ; preds = %bb4.i100
  %_12.i105 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %75, i64 noundef %tid9) #14
  br label %log_load.exit108

log_load.exit108:                                 ; preds = %bb2.i106, %bb7.i102, %bb5.i104
  %78 = load i32, ptr %75, align 4, !tbaa !26
  %tid10 = call i64 @pthread_self()
  %_4.i109 = ptrtoint ptr %73 to i64
  %index.i110 = and i64 %_4.i109, 65535
  %79 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i110
  %prev_tid.i111 = load i64, ptr %79, align 8, !noundef !7
  %80 = icmp eq i64 %prev_tid.i111, 0
  br i1 %80, label %bb2.i118, label %bb4.i112

bb2.i118:                                         ; preds = %log_load.exit108
  %_8.i119 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %73, i64 noundef %tid10) #14
  br label %log_load.exit120

bb4.i112:                                         ; preds = %log_load.exit108
  %_11.i113 = icmp eq i64 %prev_tid.i111, %tid10
  br i1 %_11.i113, label %bb5.i116, label %bb7.i114

bb7.i114:                                         ; preds = %bb4.i112
  %_15.i115 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %73, i64 noundef %tid10, i64 noundef %prev_tid.i111) #14
  br label %log_load.exit120

bb5.i116:                                         ; preds = %bb4.i112
  %_12.i117 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %73, i64 noundef %tid10) #14
  br label %log_load.exit120

log_load.exit120:                                 ; preds = %bb2.i118, %bb7.i114, %bb5.i116
  %81 = load i32, ptr %73, align 4, !tbaa !26
  %82 = mul nsw i32 %81, %78
  %83 = add nsw i32 %82, %72
  %84 = getelementptr inbounds i32, ptr %73, i64 %53
  %85 = or i64 %60, 2
  %86 = getelementptr inbounds i32, ptr %38, i64 %85
  %tid11 = call i64 @pthread_self()
  %_4.i121 = ptrtoint ptr %86 to i64
  %index.i122 = and i64 %_4.i121, 65535
  %87 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i122
  %prev_tid.i123 = load i64, ptr %87, align 8, !noundef !7
  %88 = icmp eq i64 %prev_tid.i123, 0
  br i1 %88, label %bb2.i130, label %bb4.i124

bb2.i130:                                         ; preds = %log_load.exit120
  %_8.i131 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %86, i64 noundef %tid11) #14
  br label %log_load.exit132

bb4.i124:                                         ; preds = %log_load.exit120
  %_11.i125 = icmp eq i64 %prev_tid.i123, %tid11
  br i1 %_11.i125, label %bb5.i128, label %bb7.i126

bb7.i126:                                         ; preds = %bb4.i124
  %_15.i127 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %86, i64 noundef %tid11, i64 noundef %prev_tid.i123) #14
  br label %log_load.exit132

bb5.i128:                                         ; preds = %bb4.i124
  %_12.i129 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %86, i64 noundef %tid11) #14
  br label %log_load.exit132

log_load.exit132:                                 ; preds = %bb2.i130, %bb7.i126, %bb5.i128
  %89 = load i32, ptr %86, align 4, !tbaa !26
  %tid12 = call i64 @pthread_self()
  %_4.i133 = ptrtoint ptr %84 to i64
  %index.i134 = and i64 %_4.i133, 65535
  %90 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i134
  %prev_tid.i135 = load i64, ptr %90, align 8, !noundef !7
  %91 = icmp eq i64 %prev_tid.i135, 0
  br i1 %91, label %bb2.i142, label %bb4.i136

bb2.i142:                                         ; preds = %log_load.exit132
  %_8.i143 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %84, i64 noundef %tid12) #14
  br label %log_load.exit144

bb4.i136:                                         ; preds = %log_load.exit132
  %_11.i137 = icmp eq i64 %prev_tid.i135, %tid12
  br i1 %_11.i137, label %bb5.i140, label %bb7.i138

bb7.i138:                                         ; preds = %bb4.i136
  %_15.i139 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %84, i64 noundef %tid12, i64 noundef %prev_tid.i135) #14
  br label %log_load.exit144

bb5.i140:                                         ; preds = %bb4.i136
  %_12.i141 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %84, i64 noundef %tid12) #14
  br label %log_load.exit144

log_load.exit144:                                 ; preds = %bb2.i142, %bb7.i138, %bb5.i140
  %92 = load i32, ptr %84, align 4, !tbaa !26
  %93 = mul nsw i32 %92, %89
  %94 = add nsw i32 %93, %83
  %95 = getelementptr inbounds i32, ptr %84, i64 %53
  %96 = or i64 %60, 3
  %97 = getelementptr inbounds i32, ptr %38, i64 %96
  %tid13 = call i64 @pthread_self()
  %_4.i145 = ptrtoint ptr %97 to i64
  %index.i146 = and i64 %_4.i145, 65535
  %98 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i146
  %prev_tid.i147 = load i64, ptr %98, align 8, !noundef !7
  %99 = icmp eq i64 %prev_tid.i147, 0
  br i1 %99, label %bb2.i154, label %bb4.i148

bb2.i154:                                         ; preds = %log_load.exit144
  %_8.i155 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %97, i64 noundef %tid13) #14
  br label %log_load.exit156

bb4.i148:                                         ; preds = %log_load.exit144
  %_11.i149 = icmp eq i64 %prev_tid.i147, %tid13
  br i1 %_11.i149, label %bb5.i152, label %bb7.i150

bb7.i150:                                         ; preds = %bb4.i148
  %_15.i151 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %97, i64 noundef %tid13, i64 noundef %prev_tid.i147) #14
  br label %log_load.exit156

bb5.i152:                                         ; preds = %bb4.i148
  %_12.i153 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %97, i64 noundef %tid13) #14
  br label %log_load.exit156

log_load.exit156:                                 ; preds = %bb2.i154, %bb7.i150, %bb5.i152
  %100 = load i32, ptr %97, align 4, !tbaa !26
  %tid14 = call i64 @pthread_self()
  %_4.i157 = ptrtoint ptr %95 to i64
  %index.i158 = and i64 %_4.i157, 65535
  %101 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i158
  %prev_tid.i159 = load i64, ptr %101, align 8, !noundef !7
  %102 = icmp eq i64 %prev_tid.i159, 0
  br i1 %102, label %bb2.i166, label %bb4.i160

bb2.i166:                                         ; preds = %log_load.exit156
  %_8.i167 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %95, i64 noundef %tid14) #14
  br label %log_load.exit168

bb4.i160:                                         ; preds = %log_load.exit156
  %_11.i161 = icmp eq i64 %prev_tid.i159, %tid14
  br i1 %_11.i161, label %bb5.i164, label %bb7.i162

bb7.i162:                                         ; preds = %bb4.i160
  %_15.i163 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %95, i64 noundef %tid14, i64 noundef %prev_tid.i159) #14
  br label %log_load.exit168

bb5.i164:                                         ; preds = %bb4.i160
  %_12.i165 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %95, i64 noundef %tid14) #14
  br label %log_load.exit168

log_load.exit168:                                 ; preds = %bb2.i166, %bb7.i162, %bb5.i164
  %103 = load i32, ptr %95, align 4, !tbaa !26
  %104 = mul nsw i32 %103, %100
  %105 = add nsw i32 %104, %94
  %106 = getelementptr inbounds i32, ptr %95, i64 %53
  %107 = add nuw nsw i64 %60, 4
  %108 = add nuw i64 %63, 4
  %109 = icmp eq i64 %108, %58
  br i1 %109, label %110, label %59, !llvm.loop !28

110:                                              ; preds = %log_load.exit168, %51
  %111 = phi i32 [ undef, %51 ], [ %105, %log_load.exit168 ]
  %112 = phi i64 [ 0, %51 ], [ %107, %log_load.exit168 ]
  %113 = phi ptr [ %52, %51 ], [ %106, %log_load.exit168 ]
  %114 = phi i32 [ 0, %51 ], [ %105, %log_load.exit168 ]
  %115 = icmp eq i64 %55, 0
  br i1 %115, label %134, label %116

116:                                              ; preds = %log_load.exit192, %110
  %117 = phi i64 [ %131, %log_load.exit192 ], [ %112, %110 ]
  %118 = phi ptr [ %130, %log_load.exit192 ], [ %113, %110 ]
  %119 = phi i32 [ %129, %log_load.exit192 ], [ %114, %110 ]
  %120 = phi i64 [ %132, %log_load.exit192 ], [ 0, %110 ]
  %121 = getelementptr inbounds i32, ptr %38, i64 %117
  %tid15 = call i64 @pthread_self()
  %_4.i169 = ptrtoint ptr %121 to i64
  %index.i170 = and i64 %_4.i169, 65535
  %122 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i170
  %prev_tid.i171 = load i64, ptr %122, align 8, !noundef !7
  %123 = icmp eq i64 %prev_tid.i171, 0
  br i1 %123, label %bb2.i178, label %bb4.i172

bb2.i178:                                         ; preds = %116
  %_8.i179 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %121, i64 noundef %tid15) #14
  br label %log_load.exit180

bb4.i172:                                         ; preds = %116
  %_11.i173 = icmp eq i64 %prev_tid.i171, %tid15
  br i1 %_11.i173, label %bb5.i176, label %bb7.i174

bb7.i174:                                         ; preds = %bb4.i172
  %_15.i175 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %121, i64 noundef %tid15, i64 noundef %prev_tid.i171) #14
  br label %log_load.exit180

bb5.i176:                                         ; preds = %bb4.i172
  %_12.i177 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %121, i64 noundef %tid15) #14
  br label %log_load.exit180

log_load.exit180:                                 ; preds = %bb2.i178, %bb7.i174, %bb5.i176
  %124 = load i32, ptr %121, align 4, !tbaa !26
  %tid16 = call i64 @pthread_self()
  %_4.i181 = ptrtoint ptr %118 to i64
  %index.i182 = and i64 %_4.i181, 65535
  %125 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i182
  %prev_tid.i183 = load i64, ptr %125, align 8, !noundef !7
  %126 = icmp eq i64 %prev_tid.i183, 0
  br i1 %126, label %bb2.i190, label %bb4.i184

bb2.i190:                                         ; preds = %log_load.exit180
  %_8.i191 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %118, i64 noundef %tid16) #14
  br label %log_load.exit192

bb4.i184:                                         ; preds = %log_load.exit180
  %_11.i185 = icmp eq i64 %prev_tid.i183, %tid16
  br i1 %_11.i185, label %bb5.i188, label %bb7.i186

bb7.i186:                                         ; preds = %bb4.i184
  %_15.i187 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %118, i64 noundef %tid16, i64 noundef %prev_tid.i183) #14
  br label %log_load.exit192

bb5.i188:                                         ; preds = %bb4.i184
  %_12.i189 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %118, i64 noundef %tid16) #14
  br label %log_load.exit192

log_load.exit192:                                 ; preds = %bb2.i190, %bb7.i186, %bb5.i188
  %127 = load i32, ptr %118, align 4, !tbaa !26
  %128 = mul nsw i32 %127, %124
  %129 = add nsw i32 %128, %119
  %130 = getelementptr inbounds i32, ptr %118, i64 %53
  %131 = add nuw nsw i64 %117, 1
  %132 = add i64 %120, 1
  %133 = icmp eq i64 %132, %55
  br i1 %133, label %134, label %116, !llvm.loop !29

134:                                              ; preds = %log_load.exit192, %110, %47
  %135 = phi i32 [ 0, %47 ], [ %111, %110 ], [ %129, %log_load.exit192 ]
  %tid17 = call i64 @pthread_self()
  %_4.i193 = ptrtoint ptr %8 to i64
  %index.i194 = and i64 %_4.i193, 65535
  %136 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i194
  %prev_tid.i195 = load i64, ptr %136, align 8, !noundef !7
  %137 = icmp eq i64 %prev_tid.i195, 0
  br i1 %137, label %bb2.i202, label %bb4.i196

bb2.i202:                                         ; preds = %134
  %_8.i203 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %8, i64 noundef %tid17) #14
  br label %log_load.exit204

bb4.i196:                                         ; preds = %134
  %_11.i197 = icmp eq i64 %prev_tid.i195, %tid17
  br i1 %_11.i197, label %bb5.i200, label %bb7.i198

bb7.i198:                                         ; preds = %bb4.i196
  %_15.i199 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %8, i64 noundef %tid17, i64 noundef %prev_tid.i195) #14
  br label %log_load.exit204

bb5.i200:                                         ; preds = %bb4.i196
  %_12.i201 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %8, i64 noundef %tid17) #14
  br label %log_load.exit204

log_load.exit204:                                 ; preds = %bb2.i202, %bb7.i198, %bb5.i200
  %138 = load i32, ptr %8, align 8, !tbaa !18
  %139 = add nsw i32 %138, %34
  %140 = mul nsw i32 %139, %49
  %141 = trunc i64 %48 to i32
  %142 = add nsw i32 %140, %141
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds i32, ptr %46, i64 %143
  %tid18 = call i64 @pthread_self()
  %_4.i205 = ptrtoint ptr %144 to i64
  %index.i206 = and i64 %_4.i205, 65535
  %145 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i206
  store i64 %tid18, ptr %145, align 8
  %_7.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %144, i64 noundef %tid18) #14
  store i32 %135, ptr %144, align 4, !tbaa !26
  %146 = add nuw nsw i64 %48, 1
  %tid19 = call i64 @pthread_self()
  %_4.i207 = ptrtoint ptr %20 to i64
  %index.i208 = and i64 %_4.i207, 65535
  %147 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i208
  %prev_tid.i209 = load i64, ptr %147, align 8, !noundef !7
  %148 = icmp eq i64 %prev_tid.i209, 0
  br i1 %148, label %bb2.i216, label %bb4.i210

bb2.i216:                                         ; preds = %log_load.exit204
  %_8.i217 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %20, i64 noundef %tid19) #14
  br label %log_load.exit218

bb4.i210:                                         ; preds = %log_load.exit204
  %_11.i211 = icmp eq i64 %prev_tid.i209, %tid19
  br i1 %_11.i211, label %bb5.i214, label %bb7.i212

bb7.i212:                                         ; preds = %bb4.i210
  %_15.i213 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %20, i64 noundef %tid19, i64 noundef %prev_tid.i209) #14
  br label %log_load.exit218

bb5.i214:                                         ; preds = %bb4.i210
  %_12.i215 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %20, i64 noundef %tid19) #14
  br label %log_load.exit218

log_load.exit218:                                 ; preds = %bb2.i216, %bb7.i212, %bb5.i214
  %149 = load i32, ptr %20, align 8, !tbaa !8
  %150 = sext i32 %149 to i64
  %151 = icmp slt i64 %146, %150
  br i1 %151, label %47, label %152, !llvm.loop !31

152:                                              ; preds = %log_load.exit218, %log_load.exit48
  %153 = phi i32 [ %29, %log_load.exit48 ], [ %149, %log_load.exit218 ]
  %154 = add nuw nsw i64 %30, 1
  %155 = icmp eq i64 %154, %13
  br i1 %155, label %156, label %28, !llvm.loop !32

156:                                              ; preds = %152, %log_load.exit36, %log_load.exit12
  tail call void @free(ptr noundef nonnull %8) #14
  tail call void @free(ptr noundef nonnull %0) #14
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
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %3) #14
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %4) #14
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %5) #14
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6) #14
  %9 = tail call i64 @time(ptr noundef null) #14
  %10 = trunc i64 %9 to i32
  tail call void @srand(i32 noundef %10) #14
  %11 = icmp slt i32 %0, 4
  br i1 %11, label %12, label %15

12:                                               ; preds = %2
  %tid = call i64 @pthread_self()
  call void @log_load(i64 %tid, ptr %1)
  %13 = load ptr, ptr %1, align 8, !tbaa !17
  %14 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.16, ptr noundef %13)
  tail call void @exit(i32 noundef 1) #15
  unreachable

15:                                               ; preds = %2
  %16 = getelementptr inbounds ptr, ptr %1, i64 1
  %tid1 = call i64 @pthread_self()
  %_4.i = ptrtoint ptr %16 to i64
  %index.i = and i64 %_4.i, 65535
  %17 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i
  %prev_tid.i = load i64, ptr %17, align 8, !noundef !7
  %18 = icmp eq i64 %prev_tid.i, 0
  br i1 %18, label %bb2.i, label %bb4.i

bb2.i:                                            ; preds = %15
  %_8.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %16, i64 noundef %tid1) #14
  br label %log_load.exit

bb4.i:                                            ; preds = %15
  %_11.i = icmp eq i64 %prev_tid.i, %tid1
  br i1 %_11.i, label %bb5.i, label %bb7.i

bb7.i:                                            ; preds = %bb4.i
  %_15.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %16, i64 noundef %tid1, i64 noundef %prev_tid.i) #14
  br label %log_load.exit

bb5.i:                                            ; preds = %bb4.i
  %_12.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %16, i64 noundef %tid1) #14
  br label %log_load.exit

log_load.exit:                                    ; preds = %bb2.i, %bb7.i, %bb5.i
  %19 = load ptr, ptr %16, align 8, !tbaa !17
  %20 = tail call i64 @strtol(ptr nocapture noundef nonnull %19, ptr noundef null, i32 noundef 10) #14
  %21 = trunc i64 %20 to i32
  %22 = icmp slt i32 %21, 1
  br i1 %22, label %23, label %31

23:                                               ; preds = %log_load.exit
  tail call void @perror(ptr noundef nonnull @.str.20) #17
  %tid2 = call i64 @pthread_self()
  %_4.i1 = ptrtoint ptr %16 to i64
  %index.i2 = and i64 %_4.i1, 65535
  %24 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i2
  %prev_tid.i3 = load i64, ptr %24, align 8, !noundef !7
  %25 = icmp eq i64 %prev_tid.i3, 0
  br i1 %25, label %bb2.i10, label %bb4.i4

bb2.i10:                                          ; preds = %23
  %_8.i11 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %16, i64 noundef %tid2) #14
  br label %log_load.exit12

bb4.i4:                                           ; preds = %23
  %_11.i5 = icmp eq i64 %prev_tid.i3, %tid2
  br i1 %_11.i5, label %bb5.i8, label %bb7.i6

bb7.i6:                                           ; preds = %bb4.i4
  %_15.i7 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %16, i64 noundef %tid2, i64 noundef %prev_tid.i3) #14
  br label %log_load.exit12

bb5.i8:                                           ; preds = %bb4.i4
  %_12.i9 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %16, i64 noundef %tid2) #14
  br label %log_load.exit12

log_load.exit12:                                  ; preds = %bb2.i10, %bb7.i6, %bb5.i8
  %26 = load ptr, ptr %16, align 8, !tbaa !17
  %27 = tail call i64 @strtol(ptr nocapture noundef nonnull %26, ptr noundef null, i32 noundef 10) #14
  %28 = trunc i64 %27 to i32
  %29 = icmp sgt i32 %28, 0
  br i1 %29, label %31, label %30

30:                                               ; preds = %log_load.exit12
  tail call void @__assert_fail(ptr noundef nonnull @.str.21, ptr noundef nonnull @.str.1, i32 noundef 149, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

31:                                               ; preds = %log_load.exit12, %log_load.exit
  %32 = phi i32 [ %28, %log_load.exit12 ], [ %21, %log_load.exit ]
  %33 = getelementptr inbounds ptr, ptr %1, i64 2
  %tid3 = call i64 @pthread_self()
  %_4.i13 = ptrtoint ptr %33 to i64
  %index.i14 = and i64 %_4.i13, 65535
  %34 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i14
  %prev_tid.i15 = load i64, ptr %34, align 8, !noundef !7
  %35 = icmp eq i64 %prev_tid.i15, 0
  br i1 %35, label %bb2.i22, label %bb4.i16

bb2.i22:                                          ; preds = %31
  %_8.i23 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %33, i64 noundef %tid3) #14
  br label %log_load.exit24

bb4.i16:                                          ; preds = %31
  %_11.i17 = icmp eq i64 %prev_tid.i15, %tid3
  br i1 %_11.i17, label %bb5.i20, label %bb7.i18

bb7.i18:                                          ; preds = %bb4.i16
  %_15.i19 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %33, i64 noundef %tid3, i64 noundef %prev_tid.i15) #14
  br label %log_load.exit24

bb5.i20:                                          ; preds = %bb4.i16
  %_12.i21 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %33, i64 noundef %tid3) #14
  br label %log_load.exit24

log_load.exit24:                                  ; preds = %bb2.i22, %bb7.i18, %bb5.i20
  %36 = load ptr, ptr %33, align 8, !tbaa !17
  %37 = tail call i64 @strtol(ptr nocapture noundef nonnull %36, ptr noundef null, i32 noundef 10) #14
  %38 = getelementptr inbounds ptr, ptr %1, i64 3
  %tid4 = call i64 @pthread_self()
  %_4.i25 = ptrtoint ptr %38 to i64
  %index.i26 = and i64 %_4.i25, 65535
  %39 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i26
  %prev_tid.i27 = load i64, ptr %39, align 8, !noundef !7
  %40 = icmp eq i64 %prev_tid.i27, 0
  br i1 %40, label %bb2.i34, label %bb4.i28

bb2.i34:                                          ; preds = %log_load.exit24
  %_8.i35 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %38, i64 noundef %tid4) #14
  br label %log_load.exit36

bb4.i28:                                          ; preds = %log_load.exit24
  %_11.i29 = icmp eq i64 %prev_tid.i27, %tid4
  br i1 %_11.i29, label %bb5.i32, label %bb7.i30

bb7.i30:                                          ; preds = %bb4.i28
  %_15.i31 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %38, i64 noundef %tid4, i64 noundef %prev_tid.i27) #14
  br label %log_load.exit36

bb5.i32:                                          ; preds = %bb4.i28
  %_12.i33 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %38, i64 noundef %tid4) #14
  br label %log_load.exit36

log_load.exit36:                                  ; preds = %bb2.i34, %bb7.i30, %bb5.i32
  %41 = load ptr, ptr %38, align 8, !tbaa !17
  %42 = tail call i64 @strtol(ptr nocapture noundef nonnull %41, ptr noundef null, i32 noundef 10) #14
  %43 = trunc i64 %42 to i32
  %44 = mul i32 %32, %32
  %45 = zext i32 %44 to i64
  %46 = shl nuw nsw i64 %45, 2
  %47 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.22, i32 noundef %32)
  %48 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.23, i32 noundef %43)
  %49 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.19, i32 noundef 66, i32 noundef 448) #14
  %50 = icmp slt i32 %49, 0
  br i1 %50, label %51, label %55

51:                                               ; preds = %log_load.exit36
  tail call void @perror(ptr noundef nonnull @.str.24) #17
  %52 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.19, i32 noundef 66, i32 noundef 448) #14
  %53 = icmp sgt i32 %52, -1
  br i1 %53, label %55, label %54

54:                                               ; preds = %51
  tail call void @__assert_fail(ptr noundef nonnull @.str.25, ptr noundef nonnull @.str.1, i32 noundef 157, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

55:                                               ; preds = %51, %log_load.exit36
  %56 = phi i32 [ %52, %51 ], [ %49, %log_load.exit36 ]
  %57 = and i64 %37, 4294967295
  %58 = icmp eq i64 %57, 0
  br i1 %58, label %120, label %59

59:                                               ; preds = %55
  %tid5 = call i64 @pthread_self()
  %prev_tid.i37 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %60 = icmp eq i64 %prev_tid.i37, 0
  br i1 %60, label %bb2.i44, label %bb4.i38

bb2.i44:                                          ; preds = %59
  %_8.i45 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid5) #14
  br label %log_load.exit46

bb4.i38:                                          ; preds = %59
  %_11.i39 = icmp eq i64 %prev_tid.i37, %tid5
  br i1 %_11.i39, label %bb5.i42, label %bb7.i40

bb7.i40:                                          ; preds = %bb4.i38
  %_15.i41 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid5, i64 noundef %prev_tid.i37) #14
  br label %log_load.exit46

bb5.i42:                                          ; preds = %bb4.i38
  %_12.i43 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid5) #14
  br label %log_load.exit46

log_load.exit46:                                  ; preds = %bb2.i44, %bb7.i40, %bb5.i42
  %61 = load ptr, ptr @stdout, align 8, !tbaa !17
  %62 = tail call i64 @fwrite(ptr nonnull @.str.26, i64 21, i64 1, ptr %61)
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %7) #14
  %63 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 66, i32 noundef 448) #14
  %64 = icmp slt i32 %63, 0
  br i1 %64, label %65, label %69

65:                                               ; preds = %log_load.exit46
  tail call void @perror(ptr noundef nonnull @.str.27) #17
  %66 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 66, i32 noundef 448) #14
  %67 = icmp sgt i32 %66, -1
  br i1 %67, label %69, label %68

68:                                               ; preds = %65
  tail call void @__assert_fail(ptr noundef nonnull @.str.28, ptr noundef nonnull @.str.1, i32 noundef 163, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

69:                                               ; preds = %65, %log_load.exit46
  %70 = phi i32 [ %66, %65 ], [ %63, %log_load.exit46 ]
  %71 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 66, i32 noundef 448) #14
  %72 = icmp slt i32 %71, 0
  br i1 %72, label %73, label %77

73:                                               ; preds = %69
  tail call void @perror(ptr noundef nonnull @.str.29) #17
  %74 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 66, i32 noundef 448) #14
  %75 = icmp sgt i32 %74, -1
  br i1 %75, label %77, label %76

76:                                               ; preds = %73
  tail call void @__assert_fail(ptr noundef nonnull @.str.30, ptr noundef nonnull @.str.1, i32 noundef 164, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

77:                                               ; preds = %73, %69
  %78 = phi i32 [ %74, %73 ], [ %71, %69 ]
  br label %79

79:                                               ; preds = %89, %77
  %80 = phi i32 [ %90, %89 ], [ 0, %77 ]
  br label %81

81:                                               ; preds = %81, %79
  %82 = phi i32 [ 0, %79 ], [ %87, %81 ]
  %83 = tail call i32 @rand() #14
  %84 = srem i32 %83, 11
  %tid6 = call i64 @pthread_self()
  %_4.i47 = ptrtoint ptr %7 to i64
  %index.i48 = and i64 %_4.i47, 65535
  %85 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i48
  store i64 %tid6, ptr %85, align 8
  %_7.i = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %7, i64 noundef %tid6) #14
  store i32 %84, ptr %7, align 4, !tbaa !26
  %86 = call i64 @write(i32 noundef %70, ptr noundef nonnull %7, i64 noundef 4) #14
  %87 = add nuw nsw i32 %82, 1
  %88 = icmp eq i32 %87, %32
  br i1 %88, label %89, label %81, !llvm.loop !34

89:                                               ; preds = %81
  %90 = add nuw nsw i32 %80, 1
  %91 = icmp eq i32 %90, %32
  br i1 %91, label %92, label %79, !llvm.loop !35

92:                                               ; preds = %102, %89
  %93 = phi i32 [ %103, %102 ], [ 0, %89 ]
  br label %94

94:                                               ; preds = %94, %92
  %95 = phi i32 [ 0, %92 ], [ %100, %94 ]
  %96 = tail call i32 @rand() #14
  %97 = srem i32 %96, 11
  %tid7 = call i64 @pthread_self()
  %_4.i49 = ptrtoint ptr %7 to i64
  %index.i50 = and i64 %_4.i49, 65535
  %98 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i50
  store i64 %tid7, ptr %98, align 8
  %_7.i51 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %7, i64 noundef %tid7) #14
  store i32 %97, ptr %7, align 4, !tbaa !26
  %99 = call i64 @write(i32 noundef %78, ptr noundef nonnull %7, i64 noundef 4) #14
  %100 = add nuw nsw i32 %95, 1
  %101 = icmp eq i32 %100, %32
  br i1 %101, label %102, label %94, !llvm.loop !36

102:                                              ; preds = %94
  %103 = add nuw nsw i32 %93, 1
  %104 = icmp eq i32 %103, %32
  br i1 %104, label %105, label %92, !llvm.loop !37

105:                                              ; preds = %102
  %106 = tail call i32 @close(i32 noundef %70) #14
  %107 = icmp slt i32 %106, 0
  br i1 %107, label %108, label %112

108:                                              ; preds = %105
  tail call void @perror(ptr noundef nonnull @.str.31) #17
  %109 = tail call i32 @close(i32 noundef %70) #14
  %110 = icmp sgt i32 %109, -1
  br i1 %110, label %112, label %111

111:                                              ; preds = %108
  tail call void @__assert_fail(ptr noundef nonnull @.str.32, ptr noundef nonnull @.str.1, i32 noundef 180, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

112:                                              ; preds = %108, %105
  %113 = tail call i32 @close(i32 noundef %78) #14
  %114 = icmp slt i32 %113, 0
  br i1 %114, label %115, label %119

115:                                              ; preds = %112
  tail call void @perror(ptr noundef nonnull @.str.33) #17
  %116 = tail call i32 @close(i32 noundef %78) #14
  %117 = icmp sgt i32 %116, -1
  br i1 %117, label %119, label %118

118:                                              ; preds = %115
  tail call void @__assert_fail(ptr noundef nonnull @.str.34, ptr noundef nonnull @.str.1, i32 noundef 181, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

119:                                              ; preds = %115, %112
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %7) #14
  br label %120

120:                                              ; preds = %119, %55
  %121 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 0) #14
  %122 = icmp slt i32 %121, 0
  br i1 %122, label %123, label %127

123:                                              ; preds = %120
  tail call void @perror(ptr noundef nonnull @.str.35) #17
  %124 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.17, i32 noundef 0) #14
  %125 = icmp sgt i32 %124, -1
  br i1 %125, label %127, label %126

126:                                              ; preds = %123
  tail call void @__assert_fail(ptr noundef nonnull @.str.36, ptr noundef nonnull @.str.1, i32 noundef 184, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

127:                                              ; preds = %123, %120
  %128 = phi i32 [ %124, %123 ], [ %121, %120 ]
  %129 = call i32 @fstat(i32 noundef %128, ptr noundef nonnull %3) #14
  %130 = icmp slt i32 %129, 0
  br i1 %130, label %131, label %135

131:                                              ; preds = %127
  tail call void @perror(ptr noundef nonnull @.str.37) #17
  %132 = call i32 @fstat(i32 noundef %128, ptr noundef nonnull %3) #14
  %133 = icmp sgt i32 %132, -1
  br i1 %133, label %135, label %134

134:                                              ; preds = %131
  tail call void @__assert_fail(ptr noundef nonnull @.str.38, ptr noundef nonnull @.str.1, i32 noundef 185, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

135:                                              ; preds = %131, %127
  %136 = shl i64 %45, 34
  %137 = ashr exact i64 %136, 32
  %138 = or i64 %137, 1
  %139 = tail call ptr @mmap(ptr noundef null, i64 noundef %138, i32 noundef 3, i32 noundef 2, i32 noundef %128, i64 noundef 0) #14
  %140 = icmp eq ptr %139, null
  br i1 %140, label %141, label %145

141:                                              ; preds = %135
  tail call void @perror(ptr noundef nonnull @.str.39) #17
  %142 = tail call ptr @mmap(ptr noundef null, i64 noundef %138, i32 noundef 3, i32 noundef 2, i32 noundef %128, i64 noundef 0) #14
  %143 = icmp eq ptr %142, null
  br i1 %143, label %144, label %145

144:                                              ; preds = %141
  tail call void @__assert_fail(ptr noundef nonnull @.str.40, ptr noundef nonnull @.str.1, i32 noundef 186, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

145:                                              ; preds = %141, %135
  %146 = phi ptr [ %142, %141 ], [ %139, %135 ]
  %147 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 0) #14
  %148 = icmp slt i32 %147, 0
  br i1 %148, label %149, label %153

149:                                              ; preds = %145
  tail call void @perror(ptr noundef nonnull @.str.41) #17
  %150 = tail call i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.18, i32 noundef 0) #14
  %151 = icmp sgt i32 %150, -1
  br i1 %151, label %153, label %152

152:                                              ; preds = %149
  tail call void @__assert_fail(ptr noundef nonnull @.str.42, ptr noundef nonnull @.str.1, i32 noundef 188, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

153:                                              ; preds = %149, %145
  %154 = phi i32 [ %150, %149 ], [ %147, %145 ]
  %155 = call i32 @fstat(i32 noundef %154, ptr noundef nonnull %4) #14
  %156 = icmp slt i32 %155, 0
  br i1 %156, label %157, label %161

157:                                              ; preds = %153
  tail call void @perror(ptr noundef nonnull @.str.43) #17
  %158 = call i32 @fstat(i32 noundef %154, ptr noundef nonnull %4) #14
  %159 = icmp sgt i32 %158, -1
  br i1 %159, label %161, label %160

160:                                              ; preds = %157
  tail call void @__assert_fail(ptr noundef nonnull @.str.44, ptr noundef nonnull @.str.1, i32 noundef 189, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

161:                                              ; preds = %157, %153
  %162 = tail call ptr @mmap(ptr noundef null, i64 noundef %138, i32 noundef 3, i32 noundef 2, i32 noundef %154, i64 noundef 0) #14
  %163 = icmp eq ptr %162, null
  br i1 %163, label %164, label %168

164:                                              ; preds = %161
  tail call void @perror(ptr noundef nonnull @.str.45) #17
  %165 = tail call ptr @mmap(ptr noundef null, i64 noundef %138, i32 noundef 3, i32 noundef 2, i32 noundef %154, i64 noundef 0) #14
  %166 = icmp eq ptr %165, null
  br i1 %166, label %167, label %168

167:                                              ; preds = %164
  tail call void @__assert_fail(ptr noundef nonnull @.str.46, ptr noundef nonnull @.str.1, i32 noundef 190, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

168:                                              ; preds = %164, %161
  %169 = phi ptr [ %165, %164 ], [ %162, %161 ]
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %8) #14
  %170 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 3
  %tid8 = call i64 @pthread_self()
  %_4.i52 = ptrtoint ptr %170 to i64
  %index.i53 = and i64 %_4.i52, 65535
  %171 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i53
  store i64 %tid8, ptr %171, align 8
  %_7.i54 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %170, i64 noundef %tid8) #14
  store i32 %32, ptr %170, align 8, !tbaa !8
  %172 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 1
  %173 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 2
  %tid9 = call i64 @pthread_self()
  %_4.i55 = ptrtoint ptr %8 to i64
  %index.i56 = and i64 %_4.i55, 65535
  %174 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i56
  store i64 %tid9, ptr %174, align 8
  %_7.i57 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %8, i64 noundef %tid9) #14
  store i32 0, ptr %8, align 8, !tbaa !18
  %175 = tail call noalias ptr @malloc(i64 noundef %46) #16
  %176 = getelementptr inbounds %struct.mm_data_t, ptr %8, i64 0, i32 4
  %tid10 = call i64 @pthread_self()
  %_4.i58 = ptrtoint ptr %176 to i64
  %index.i59 = and i64 %_4.i58, 65535
  %177 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i59
  store i64 %tid10, ptr %177, align 8
  %_7.i60 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %176, i64 noundef %tid10) #14
  store ptr %175, ptr %176, align 8, !tbaa !16
  %tid11 = call i64 @pthread_self()
  %_4.i61 = ptrtoint ptr %172 to i64
  %index.i62 = and i64 %_4.i61, 65535
  %178 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i62
  store i64 %tid11, ptr %178, align 8
  %_7.i63 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %172, i64 noundef %tid11) #14
  store ptr %146, ptr %172, align 8, !tbaa !14
  %tid12 = call i64 @pthread_self()
  %_4.i64 = ptrtoint ptr %173 to i64
  %index.i65 = and i64 %_4.i64, 65535
  %179 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i65
  store i64 %tid12, ptr %179, align 8
  %_7.i66 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %173, i64 noundef %tid12) #14
  store ptr %169, ptr %173, align 8, !tbaa !15
  %180 = call i32 @gettimeofday(ptr noundef nonnull %5, ptr noundef null) #14
  call void @matrixmult_splitter(ptr noundef nonnull %8, i32 noundef %43)
  %181 = call i32 @gettimeofday(ptr noundef nonnull %6, ptr noundef null) #14
  %tid13 = call i64 @pthread_self()
  %_4.i67 = ptrtoint ptr %6 to i64
  %index.i68 = and i64 %_4.i67, 65535
  %182 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i68
  %prev_tid.i69 = load i64, ptr %182, align 8, !noundef !7
  %183 = icmp eq i64 %prev_tid.i69, 0
  br i1 %183, label %bb2.i76, label %bb4.i70

bb2.i76:                                          ; preds = %168
  %_8.i77 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %6, i64 noundef %tid13) #14
  br label %log_load.exit78

bb4.i70:                                          ; preds = %168
  %_11.i71 = icmp eq i64 %prev_tid.i69, %tid13
  br i1 %_11.i71, label %bb5.i74, label %bb7.i72

bb7.i72:                                          ; preds = %bb4.i70
  %_15.i73 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %6, i64 noundef %tid13, i64 noundef %prev_tid.i69) #14
  br label %log_load.exit78

bb5.i74:                                          ; preds = %bb4.i70
  %_12.i75 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %6, i64 noundef %tid13) #14
  br label %log_load.exit78

log_load.exit78:                                  ; preds = %bb2.i76, %bb7.i72, %bb5.i74
  %184 = load i64, ptr %6, align 8, !tbaa !38
  %tid14 = call i64 @pthread_self()
  %_4.i79 = ptrtoint ptr %5 to i64
  %index.i80 = and i64 %_4.i79, 65535
  %185 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i80
  %prev_tid.i81 = load i64, ptr %185, align 8, !noundef !7
  %186 = icmp eq i64 %prev_tid.i81, 0
  br i1 %186, label %bb2.i88, label %bb4.i82

bb2.i88:                                          ; preds = %log_load.exit78
  %_8.i89 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %5, i64 noundef %tid14) #14
  br label %log_load.exit90

bb4.i82:                                          ; preds = %log_load.exit78
  %_11.i83 = icmp eq i64 %prev_tid.i81, %tid14
  br i1 %_11.i83, label %bb5.i86, label %bb7.i84

bb7.i84:                                          ; preds = %bb4.i82
  %_15.i85 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %5, i64 noundef %tid14, i64 noundef %prev_tid.i81) #14
  br label %log_load.exit90

bb5.i86:                                          ; preds = %bb4.i82
  %_12.i87 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %5, i64 noundef %tid14) #14
  br label %log_load.exit90

log_load.exit90:                                  ; preds = %bb2.i88, %bb7.i84, %bb5.i86
  %187 = load i64, ptr %5, align 8, !tbaa !38
  %188 = sub nsw i64 %184, %187
  %189 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.47, i64 noundef %188)
  %190 = icmp eq i32 %32, 0
  br i1 %190, label %216, label %191

191:                                              ; preds = %log_load.exit90
  %192 = call i32 @llvm.umax.i32(i32 %44, i32 1)
  %193 = zext i32 %192 to i64
  br label %194

194:                                              ; preds = %log_load.exit134, %191
  %195 = phi i64 [ 0, %191 ], [ %214, %log_load.exit134 ]
  %196 = trunc i64 %195 to i32
  %197 = srem i32 %196, %32
  %198 = icmp eq i32 %197, 0
  br i1 %198, label %199, label %203

199:                                              ; preds = %194
  %tid15 = call i64 @pthread_self()
  %prev_tid.i91 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %200 = icmp eq i64 %prev_tid.i91, 0
  br i1 %200, label %bb2.i98, label %bb4.i92

bb2.i98:                                          ; preds = %199
  %_8.i99 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid15) #14
  br label %log_load.exit100

bb4.i92:                                          ; preds = %199
  %_11.i93 = icmp eq i64 %prev_tid.i91, %tid15
  br i1 %_11.i93, label %bb5.i96, label %bb7.i94

bb7.i94:                                          ; preds = %bb4.i92
  %_15.i95 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid15, i64 noundef %prev_tid.i91) #14
  br label %log_load.exit100

bb5.i96:                                          ; preds = %bb4.i92
  %_12.i97 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid15) #14
  br label %log_load.exit100

log_load.exit100:                                 ; preds = %bb2.i98, %bb7.i94, %bb5.i96
  %201 = load ptr, ptr @stdout, align 8, !tbaa !17
  %202 = call i32 @fputc(i32 10, ptr %201)
  br label %203

203:                                              ; preds = %log_load.exit100, %194
  %tid16 = call i64 @pthread_self()
  %prev_tid.i101 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %204 = icmp eq i64 %prev_tid.i101, 0
  br i1 %204, label %bb2.i108, label %bb4.i102

bb2.i108:                                         ; preds = %203
  %_8.i109 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid16) #14
  br label %log_load.exit110

bb4.i102:                                         ; preds = %203
  %_11.i103 = icmp eq i64 %prev_tid.i101, %tid16
  br i1 %_11.i103, label %bb5.i106, label %bb7.i104

bb7.i104:                                         ; preds = %bb4.i102
  %_15.i105 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid16, i64 noundef %prev_tid.i101) #14
  br label %log_load.exit110

bb5.i106:                                         ; preds = %bb4.i102
  %_12.i107 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid16) #14
  br label %log_load.exit110

log_load.exit110:                                 ; preds = %bb2.i108, %bb7.i104, %bb5.i106
  %205 = load ptr, ptr @stdout, align 8, !tbaa !17
  %tid17 = call i64 @pthread_self()
  %_4.i111 = ptrtoint ptr %176 to i64
  %index.i112 = and i64 %_4.i111, 65535
  %206 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i112
  %prev_tid.i113 = load i64, ptr %206, align 8, !noundef !7
  %207 = icmp eq i64 %prev_tid.i113, 0
  br i1 %207, label %bb2.i120, label %bb4.i114

bb2.i120:                                         ; preds = %log_load.exit110
  %_8.i121 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %176, i64 noundef %tid17) #14
  br label %log_load.exit122

bb4.i114:                                         ; preds = %log_load.exit110
  %_11.i115 = icmp eq i64 %prev_tid.i113, %tid17
  br i1 %_11.i115, label %bb5.i118, label %bb7.i116

bb7.i116:                                         ; preds = %bb4.i114
  %_15.i117 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %176, i64 noundef %tid17, i64 noundef %prev_tid.i113) #14
  br label %log_load.exit122

bb5.i118:                                         ; preds = %bb4.i114
  %_12.i119 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %176, i64 noundef %tid17) #14
  br label %log_load.exit122

log_load.exit122:                                 ; preds = %bb2.i120, %bb7.i116, %bb5.i118
  %208 = load ptr, ptr %176, align 8, !tbaa !16
  %209 = getelementptr inbounds i32, ptr %208, i64 %195
  %tid18 = call i64 @pthread_self()
  %_4.i123 = ptrtoint ptr %209 to i64
  %index.i124 = and i64 %_4.i123, 65535
  %210 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i124
  %prev_tid.i125 = load i64, ptr %210, align 8, !noundef !7
  %211 = icmp eq i64 %prev_tid.i125, 0
  br i1 %211, label %bb2.i132, label %bb4.i126

bb2.i132:                                         ; preds = %log_load.exit122
  %_8.i133 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %209, i64 noundef %tid18) #14
  br label %log_load.exit134

bb4.i126:                                         ; preds = %log_load.exit122
  %_11.i127 = icmp eq i64 %prev_tid.i125, %tid18
  br i1 %_11.i127, label %bb5.i130, label %bb7.i128

bb7.i128:                                         ; preds = %bb4.i126
  %_15.i129 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %209, i64 noundef %tid18, i64 noundef %prev_tid.i125) #14
  br label %log_load.exit134

bb5.i130:                                         ; preds = %bb4.i126
  %_12.i131 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %209, i64 noundef %tid18) #14
  br label %log_load.exit134

log_load.exit134:                                 ; preds = %bb2.i132, %bb7.i128, %bb5.i130
  %212 = load i32, ptr %209, align 4, !tbaa !26
  %213 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %205, ptr noundef nonnull @.str.49, i32 noundef %212)
  %214 = add nuw nsw i64 %195, 1
  %215 = icmp eq i64 %214, %193
  br i1 %215, label %216, label %194, !llvm.loop !40

216:                                              ; preds = %log_load.exit134, %log_load.exit90
  %tid19 = call i64 @pthread_self()
  %prev_tid.i135 = load i64, ptr getelementptr inbounds (i64, ptr @LAST_WRITES, i64 and (i64 ptrtoint (ptr @stdout to i64), i64 65535)), align 8, !noundef !7
  %217 = icmp eq i64 %prev_tid.i135, 0
  br i1 %217, label %bb2.i142, label %bb4.i136

bb2.i142:                                         ; preds = %216
  %_8.i143 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef @stdout, i64 noundef %tid19) #14
  br label %log_load.exit144

bb4.i136:                                         ; preds = %216
  %_11.i137 = icmp eq i64 %prev_tid.i135, %tid19
  br i1 %_11.i137, label %bb5.i140, label %bb7.i138

bb7.i138:                                         ; preds = %bb4.i136
  %_15.i139 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef @stdout, i64 noundef %tid19, i64 noundef %prev_tid.i135) #14
  br label %log_load.exit144

bb5.i140:                                         ; preds = %bb4.i136
  %_12.i141 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef @stdout, i64 noundef %tid19) #14
  br label %log_load.exit144

log_load.exit144:                                 ; preds = %bb2.i142, %bb7.i138, %bb5.i140
  %218 = load ptr, ptr @stdout, align 8, !tbaa !17
  %219 = call i32 @fputc(i32 10, ptr %218)
  %tid20 = call i64 @pthread_self()
  %_4.i145 = ptrtoint ptr %176 to i64
  %index.i146 = and i64 %_4.i145, 65535
  %220 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index.i146
  %prev_tid.i147 = load i64, ptr %220, align 8, !noundef !7
  %221 = icmp eq i64 %prev_tid.i147, 0
  br i1 %221, label %bb2.i154, label %bb4.i148

bb2.i154:                                         ; preds = %log_load.exit144
  %_8.i155 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %176, i64 noundef %tid20) #14
  br label %log_load.exit156

bb4.i148:                                         ; preds = %log_load.exit144
  %_11.i149 = icmp eq i64 %prev_tid.i147, %tid20
  br i1 %_11.i149, label %bb5.i152, label %bb7.i150

bb7.i150:                                         ; preds = %bb4.i148
  %_15.i151 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %176, i64 noundef %tid20, i64 noundef %prev_tid.i147) #14
  br label %log_load.exit156

bb5.i152:                                         ; preds = %bb4.i148
  %_12.i153 = call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %176, i64 noundef %tid20) #14
  br label %log_load.exit156

log_load.exit156:                                 ; preds = %bb2.i154, %bb7.i150, %bb5.i152
  %222 = load ptr, ptr %176, align 8, !tbaa !16
  call void @free(ptr noundef %222) #14
  %223 = call i32 @munmap(ptr noundef %146, i64 noundef %138) #14
  %224 = icmp slt i32 %223, 0
  br i1 %224, label %225, label %229

225:                                              ; preds = %log_load.exit156
  call void @perror(ptr noundef nonnull @.str.50) #17
  %226 = call i32 @munmap(ptr noundef %146, i64 noundef %138) #14
  %227 = icmp sgt i32 %226, -1
  br i1 %227, label %229, label %228

228:                                              ; preds = %225
  call void @__assert_fail(ptr noundef nonnull @.str.51, ptr noundef nonnull @.str.1, i32 noundef 216, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

229:                                              ; preds = %225, %log_load.exit156
  %230 = call i32 @close(i32 noundef %128) #14
  %231 = icmp slt i32 %230, 0
  br i1 %231, label %232, label %236

232:                                              ; preds = %229
  call void @perror(ptr noundef nonnull @.str.31) #17
  %233 = call i32 @close(i32 noundef %128) #14
  %234 = icmp sgt i32 %233, -1
  br i1 %234, label %236, label %235

235:                                              ; preds = %232
  call void @__assert_fail(ptr noundef nonnull @.str.32, ptr noundef nonnull @.str.1, i32 noundef 217, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

236:                                              ; preds = %232, %229
  %237 = call i32 @munmap(ptr noundef %169, i64 noundef %138) #14
  %238 = icmp slt i32 %237, 0
  br i1 %238, label %239, label %243

239:                                              ; preds = %236
  call void @perror(ptr noundef nonnull @.str.52) #17
  %240 = call i32 @munmap(ptr noundef %169, i64 noundef %138) #14
  %241 = icmp sgt i32 %240, -1
  br i1 %241, label %243, label %242

242:                                              ; preds = %239
  call void @__assert_fail(ptr noundef nonnull @.str.53, ptr noundef nonnull @.str.1, i32 noundef 218, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

243:                                              ; preds = %239, %236
  %244 = call i32 @close(i32 noundef %154) #14
  %245 = icmp slt i32 %244, 0
  br i1 %245, label %246, label %250

246:                                              ; preds = %243
  call void @perror(ptr noundef nonnull @.str.33) #17
  %247 = call i32 @close(i32 noundef %154) #14
  %248 = icmp sgt i32 %247, -1
  br i1 %248, label %250, label %249

249:                                              ; preds = %246
  call void @__assert_fail(ptr noundef nonnull @.str.34, ptr noundef nonnull @.str.1, i32 noundef 219, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

250:                                              ; preds = %246, %243
  %251 = call i32 @close(i32 noundef %56) #14
  %252 = icmp slt i32 %251, 0
  br i1 %252, label %253, label %257

253:                                              ; preds = %250
  call void @perror(ptr noundef nonnull @.str.54) #17
  %254 = call i32 @close(i32 noundef %56) #14
  %255 = icmp sgt i32 %254, -1
  br i1 %255, label %257, label %256

256:                                              ; preds = %253
  call void @__assert_fail(ptr noundef nonnull @.str.55, ptr noundef nonnull @.str.1, i32 noundef 220, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15
  unreachable

257:                                              ; preds = %253, %250
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %8) #14
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6) #14
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %5) #14
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %4) #14
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %3) #14
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

; Function Attrs: nofree nounwind nonlazybind
define void @log_store(i64 noundef %tid, ptr noundef %addr) #13 {
start:
  %_4 = ptrtoint ptr %addr to i64
  %index = and i64 %_4, 65535
  %0 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index
  store i64 %tid, ptr %0, align 8
  %_7 = tail call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_f4edb16977186e9ae4559a0ffa645764, ptr noundef %addr, i64 noundef %tid) #14
  ret void
}

; Function Attrs: nofree nounwind nonlazybind
define void @log_load(i64 noundef %tid, ptr noundef %addr) #13 {
start:
  %_4 = ptrtoint ptr %addr to i64
  %index = and i64 %_4, 65535
  %0 = getelementptr inbounds i64, ptr @LAST_WRITES, i64 %index
  %prev_tid = load i64, ptr %0, align 8, !noundef !7
  %1 = icmp eq i64 %prev_tid, 0
  br i1 %1, label %bb2, label %bb4

bb2:                                              ; preds = %start
  %_8 = tail call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_eaa8d86eb8418cd1619ec8c976029920, ptr noundef %addr, i64 noundef %tid) #14
  br label %bb10

bb4:                                              ; preds = %start
  %_11 = icmp eq i64 %prev_tid, %tid
  br i1 %_11, label %bb5, label %bb7

bb10:                                             ; preds = %bb5, %bb7, %bb2
  ret void

bb7:                                              ; preds = %bb4
  %_15 = tail call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_495169d419c395796b86eab1ffe3ce6c, ptr noundef %addr, i64 noundef %tid, i64 noundef %prev_tid) #14
  br label %bb10

bb5:                                              ; preds = %bb4
  %_12 = tail call noundef i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @alloc_2c7ab4da309e7a77ecad0a4e9c550e6d, ptr noundef %addr, i64 noundef %tid) #14
  br label %bb10
}

attributes #0 = { nounwind uwtable "no-trapping-math"="true" "probe-stack"="inline-asm" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
attributes #13 = { nofree nounwind nonlazybind "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #14 = { nounwind }
attributes #15 = { noreturn nounwind }
attributes #16 = { nounwind allocsize(0) }
attributes #17 = { cold }

!llvm.ident = !{!0, !1}
!llvm.module.flags = !{!2, !3, !4, !5, !6}

!0 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!1 = !{!"rustc version 1.85.0 (4d91de4e4 2025-02-17)"}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"PIE Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{i32 2, !"RtLibUseGOT", i32 1}
!7 = !{}
!8 = !{!9, !10, i64 24}
!9 = !{!"", !10, i64 0, !13, i64 8, !13, i64 16, !10, i64 24, !13, i64 32}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!"any pointer", !11, i64 0}
!14 = !{!9, !13, i64 8}
!15 = !{!9, !13, i64 16}
!16 = !{!9, !13, i64 32}
!17 = !{!13, !13, i64 0}
!18 = !{!9, !10, i64 0}
!19 = !{!20, !21, i64 0}
!20 = !{!"", !21, i64 0, !13, i64 8}
!21 = !{!"long", !11, i64 0}
!22 = !{!20, !13, i64 8}
!23 = distinct !{!23, !24}
!24 = !{!"llvm.loop.mustprogress"}
!25 = !{!21, !21, i64 0}
!26 = !{!10, !10, i64 0}
!27 = distinct !{!27, !24}
!28 = distinct !{!28, !24}
!29 = distinct !{!29, !30}
!30 = !{!"llvm.loop.unroll.disable"}
!31 = distinct !{!31, !24}
!32 = distinct !{!32, !24, !33}
!33 = !{!"llvm.loop.unswitch.partial.disable"}
!34 = distinct !{!34, !24}
!35 = distinct !{!35, !24}
!36 = distinct !{!36, !24}
!37 = distinct !{!37, !24}
!38 = !{!39, !21, i64 0}
!39 = !{!"timeval", !21, i64 0, !21, i64 8}
!40 = distinct !{!40, !24}

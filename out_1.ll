; ModuleID = '/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/linear_regression/linear_regression-pthread.ll'
source_filename = "linear_regression-pthread.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.lreg_args = type { i64, ptr, i32, i64, i64, i64, i64, i64 }
%struct.POINT_T = type { i8, i8 }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [36 x i8] c"USAGE: %s <filename> <num_threads>\0A\00", align 1, !dbg !0
@stderr = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [22 x i8] c"Invalid thread count\0A\00", align 1, !dbg !7
@.str.2 = private unnamed_addr constant [59 x i8] c"Error at line\0A\09(fd = open(fname, O_RDONLY)) < 0\0ASystem Msg\00", align 1, !dbg !12
@.str.3 = private unnamed_addr constant [34 x i8] c"((fd = open(fname, 00)) < 0) == 0\00", align 1, !dbg !17
@.str.4 = private unnamed_addr constant [28 x i8] c"linear_regression-pthread.c\00", align 1, !dbg !22
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1, !dbg !27
@.str.5 = private unnamed_addr constant [48 x i8] c"Error at line\0A\09fstat(fd, &finfo) < 0\0ASystem Msg\00", align 1, !dbg !33
@.str.6 = private unnamed_addr constant [29 x i8] c"(fstat(fd, &finfo) < 0) == 0\00", align 1, !dbg !38
@.str.7 = private unnamed_addr constant [115 x i8] c"Error at line\0A\09(fdata = mmap(0, finfo.st_size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0)) == NULL\0ASystem Msg\00", align 1, !dbg !43
@.str.8 = private unnamed_addr constant [82 x i8] c"((fdata = mmap(0, finfo.st_size + 1, 0x1 | 0x2, 0x02, fd, 0)) == ((void*)0)) == 0\00", align 1, !dbg !48
@.str.9 = private unnamed_addr constant [57 x i8] c"Linear Regression P-Threads: Running with %d threads...\0A\00", align 1, !dbg !53
@.str.10 = private unnamed_addr constant [119 x i8] c"Error at line\0A\09pthread_create(&tid_args[i].tid, &attr, linear_regression_pthread, (void*)&tid_args[i]) != 0\0ASystem Msg\00", align 1, !dbg !58
@.str.11 = private unnamed_addr constant [100 x i8] c"(pthread_create(&tid_args[i].tid, &attr, linear_regression_pthread, (void*)&tid_args[i]) != 0) == 0\00", align 1, !dbg !63
@.str.12 = private unnamed_addr constant [87 x i8] c"Error at line\0A\09pthread_join(tid_args[i].tid, (void **)(void*)&ret_val) != 0\0ASystem Msg\00", align 1, !dbg !68
@.str.13 = private unnamed_addr constant [68 x i8] c"(pthread_join(tid_args[i].tid, (void **)(void*)&ret_val) != 0) == 0\00", align 1, !dbg !73
@.str.14 = private unnamed_addr constant [39 x i8] c"Error at line\0A\09ret_val != 0\0ASystem Msg\00", align 1, !dbg !78
@.str.15 = private unnamed_addr constant [20 x i8] c"(ret_val != 0) == 0\00", align 1, !dbg !83
@.str.17 = private unnamed_addr constant [13 x i8] c"\09a    = %lf\0A\00", align 1, !dbg !88
@.str.18 = private unnamed_addr constant [13 x i8] c"\09b    = %lf\0A\00", align 1, !dbg !93
@.str.19 = private unnamed_addr constant [13 x i8] c"\09xbar = %lf\0A\00", align 1, !dbg !95
@.str.20 = private unnamed_addr constant [13 x i8] c"\09ybar = %lf\0A\00", align 1, !dbg !97
@.str.21 = private unnamed_addr constant [13 x i8] c"\09r2   = %lf\0A\00", align 1, !dbg !99
@.str.22 = private unnamed_addr constant [14 x i8] c"\09SX   = %lld\0A\00", align 1, !dbg !101
@.str.23 = private unnamed_addr constant [14 x i8] c"\09SY   = %lld\0A\00", align 1, !dbg !106
@.str.24 = private unnamed_addr constant [14 x i8] c"\09SXX  = %lld\0A\00", align 1, !dbg !108
@.str.25 = private unnamed_addr constant [14 x i8] c"\09SYY  = %lld\0A\00", align 1, !dbg !110
@.str.26 = private unnamed_addr constant [14 x i8] c"\09SXY  = %lld\0A\00", align 1, !dbg !112
@.str.27 = private unnamed_addr constant [58 x i8] c"Error at line\0A\09pthread_attr_destroy(&attr) < 0\0ASystem Msg\00", align 1, !dbg !114
@.str.28 = private unnamed_addr constant [39 x i8] c"(pthread_attr_destroy(&attr) < 0) == 0\00", align 1, !dbg !119
@.str.29 = private unnamed_addr constant [63 x i8] c"Error at line\0A\09munmap(fdata, finfo.st_size + 1) < 0\0ASystem Msg\00", align 1, !dbg !121
@.str.30 = private unnamed_addr constant [44 x i8] c"(munmap(fdata, finfo.st_size + 1) < 0) == 0\00", align 1, !dbg !126
@.str.31 = private unnamed_addr constant [40 x i8] c"Error at line\0A\09close(fd) < 0\0ASystem Msg\00", align 1, !dbg !131
@.str.32 = private unnamed_addr constant [21 x i8] c"(close(fd) < 0) == 0\00", align 1, !dbg !136
@.str.33 = private unnamed_addr constant [5 x i8] c"temp\00", align 1, !dbg !141
@.str.34 = private unnamed_addr constant [27 x i8] c"../../include/stddefines.h\00", align 1, !dbg !147
@__PRETTY_FUNCTION__.CALLOC = private unnamed_addr constant [29 x i8] c"void *CALLOC(size_t, size_t)\00", align 1, !dbg !152
@str = private unnamed_addr constant [37 x i8] c"Linear Regression P-Threads Results:\00", align 1

; Function Attrs: nofree noinline nosync nounwind memory(read, argmem: readwrite, inaccessiblemem: none) uwtable
define noalias ptr @linear_regression_pthread(ptr nocapture noundef %0) #0 !dbg !203 {
  call void @llvm.dbg.value(metadata ptr %0, metadata !207, metadata !DIExpression()), !dbg !210
  call void @llvm.dbg.value(metadata ptr %0, metadata !208, metadata !DIExpression()), !dbg !210
  %2 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 3, !dbg !211
  %3 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 5, !dbg !212
  %4 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 4, !dbg !213
  %5 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 6, !dbg !214
  %6 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 7, !dbg !215
  call void @llvm.dbg.value(metadata i32 0, metadata !209, metadata !DIExpression()), !dbg !210
  %7 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 2
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %2, i8 0, i64 40, i1 false), !dbg !216
  %tid = call i64 @get_thread_id()
  call void @log_load(i64 %tid, ptr %7)
  %8 = load i32, ptr %7, align 8, !tbaa !217
  call void @llvm.dbg.value(metadata i32 0, metadata !209, metadata !DIExpression()), !dbg !210
  %9 = icmp sgt i32 %8, 0, !dbg !225
  br i1 %9, label %10, label %47, !dbg !228

10:                                               ; preds = %1
  %11 = getelementptr inbounds %struct.lreg_args, ptr %0, i64 0, i32 1
  %tid1 = call i64 @get_thread_id()
  call void @log_load(i64 %tid1, ptr %11)
  %12 = load ptr, ptr %11, align 8, !tbaa !229
  %tid2 = call i64 @get_thread_id()
  call void @log_load(i64 %tid2, ptr %2)
  %13 = load i64, ptr %2, align 8, !tbaa !230
  %tid3 = call i64 @get_thread_id()
  call void @log_load(i64 %tid3, ptr %3)
  %14 = load i64, ptr %3, align 8, !tbaa !231
  %tid4 = call i64 @get_thread_id()
  call void @log_load(i64 %tid4, ptr %4)
  %15 = load i64, ptr %4, align 8, !tbaa !232
  %tid5 = call i64 @get_thread_id()
  call void @log_load(i64 %tid5, ptr %5)
  %16 = load i64, ptr %5, align 8, !tbaa !233
  %tid6 = call i64 @get_thread_id()
  call void @log_load(i64 %tid6, ptr %6)
  %17 = load i64, ptr %6, align 8, !tbaa !234
  %18 = zext i32 %8 to i64, !dbg !225
  br label %19, !dbg !228

19:                                               ; preds = %19, %10
  %20 = phi i64 [ 0, %10 ], [ %44, %19 ], !dbg !210
  %21 = phi i64 [ %17, %10 ], [ %43, %19 ], !dbg !210
  %22 = phi i64 [ %16, %10 ], [ %41, %19 ], !dbg !210
  %23 = phi i64 [ %15, %10 ], [ %37, %19 ], !dbg !210
  %24 = phi i64 [ %14, %10 ], [ %33, %19 ], !dbg !210
  %25 = phi i64 [ %13, %10 ], [ %29, %19 ], !dbg !210
  call void @llvm.dbg.value(metadata i64 %20, metadata !209, metadata !DIExpression()), !dbg !210
  %26 = getelementptr inbounds %struct.POINT_T, ptr %12, i64 %20, !dbg !235
  %tid7 = call i64 @get_thread_id(), !dbg !237
  call void @log_load(i64 %tid7, ptr %26), !dbg !237
  %27 = load i8, ptr %26, align 1, !dbg !237, !tbaa !238
  %28 = sext i8 %27 to i64, !dbg !235
  %29 = add nsw i64 %25, %28, !dbg !240
  %30 = sext i8 %27 to i32, !dbg !241
  %31 = mul nsw i32 %30, %30, !dbg !242
  %32 = zext i32 %31 to i64, !dbg !241
  %33 = add nsw i64 %24, %32, !dbg !243
  %34 = getelementptr inbounds %struct.POINT_T, ptr %12, i64 %20, i32 1, !dbg !244
  %tid8 = call i64 @get_thread_id(), !dbg !244
  call void @log_load(i64 %tid8, ptr %34), !dbg !244
  %35 = load i8, ptr %34, align 1, !dbg !244, !tbaa !245
  %36 = sext i8 %35 to i64, !dbg !246
  %37 = add nsw i64 %23, %36, !dbg !247
  %38 = sext i8 %35 to i32, !dbg !248
  %39 = mul nsw i32 %38, %38, !dbg !249
  %40 = zext i32 %39 to i64, !dbg !248
  %41 = add nsw i64 %22, %40, !dbg !250
  %42 = mul nsw i64 %36, %28, !dbg !251
  %43 = add nsw i64 %21, %42, !dbg !252
  %44 = add nuw nsw i64 %20, 1, !dbg !253
  call void @llvm.dbg.value(metadata i64 %44, metadata !209, metadata !DIExpression()), !dbg !210
  %45 = icmp eq i64 %44, %18, !dbg !225
  br i1 %45, label %46, label %19, !dbg !228, !llvm.loop !254

46:                                               ; preds = %19
  %tid9 = call i64 @get_thread_id(), !dbg !240
  call void @log_store(i64 %tid9, ptr %2), !dbg !240
  store i64 %29, ptr %2, align 8, !dbg !240, !tbaa !230
  %tid10 = call i64 @get_thread_id(), !dbg !243
  call void @log_store(i64 %tid10, ptr %3), !dbg !243
  store i64 %33, ptr %3, align 8, !dbg !243, !tbaa !231
  %tid11 = call i64 @get_thread_id(), !dbg !247
  call void @log_store(i64 %tid11, ptr %4), !dbg !247
  store i64 %37, ptr %4, align 8, !dbg !247, !tbaa !232
  %tid12 = call i64 @get_thread_id(), !dbg !250
  call void @log_store(i64 %tid12, ptr %5), !dbg !250
  store i64 %41, ptr %5, align 8, !dbg !250, !tbaa !233
  %tid13 = call i64 @get_thread_id(), !dbg !252
  call void @log_store(i64 %tid13, ptr %6), !dbg !252
  store i64 %43, ptr %6, align 8, !dbg !252, !tbaa !234
  br label %47, !dbg !228

47:                                               ; preds = %46, %1
  ret ptr null, !dbg !258
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #2 !dbg !259 {
  %3 = alloca %struct.stat, align 8, !DIAssignID !344
  call void @llvm.dbg.assign(metadata i1 undef, metadata !270, metadata !DIExpression(), metadata !344, metadata ptr %3, metadata !DIExpression()), !dbg !345
  %4 = alloca %union.pthread_attr_t, align 8, !DIAssignID !346
  call void @llvm.dbg.assign(metadata i1 undef, metadata !313, metadata !DIExpression(), metadata !346, metadata ptr %4, metadata !DIExpression()), !dbg !345
  %5 = alloca i32, align 4, !DIAssignID !347
  call void @llvm.dbg.assign(metadata i1 undef, metadata !330, metadata !DIExpression(), metadata !347, metadata ptr %5, metadata !DIExpression()), !dbg !348
  call void @llvm.dbg.value(metadata i32 %0, metadata !265, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata ptr %1, metadata !266, metadata !DIExpression()), !dbg !345
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %3) #14, !dbg !349
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %4) #14, !dbg !350
  %6 = icmp slt i32 %0, 3, !dbg !351
  br i1 %6, label %7, label %10, !dbg !353

7:                                                ; preds = %2
  %tid = call i64 @get_thread_id(), !dbg !354
  call void @log_load(i64 %tid, ptr %1), !dbg !354
  %8 = load ptr, ptr %1, align 8, !dbg !354, !tbaa !356
  %9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, ptr noundef %8), !dbg !357
  tail call void @exit(i32 noundef 1) #15, !dbg !358
  unreachable, !dbg !358

10:                                               ; preds = %2
  %11 = getelementptr inbounds ptr, ptr %1, i64 1, !dbg !359
  %tid1 = call i64 @get_thread_id(), !dbg !359
  call void @log_load(i64 %tid1, ptr %11), !dbg !359
  %12 = load ptr, ptr %11, align 8, !dbg !359, !tbaa !356
  call void @llvm.dbg.value(metadata ptr %12, metadata !269, metadata !DIExpression()), !dbg !345
  %13 = getelementptr inbounds ptr, ptr %1, i64 2, !dbg !360
  %tid2 = call i64 @get_thread_id(), !dbg !360
  call void @log_load(i64 %tid2, ptr %13), !dbg !360
  %14 = load ptr, ptr %13, align 8, !dbg !360, !tbaa !356
  %15 = tail call i32 @atoi(ptr nocapture noundef %14) #16, !dbg !361
  call void @llvm.dbg.value(metadata i32 %15, metadata !311, metadata !DIExpression()), !dbg !345
  %16 = icmp slt i32 %15, 1, !dbg !362
  br i1 %16, label %17, label %20, !dbg !364

17:                                               ; preds = %10
  %tid3 = call i64 @get_thread_id(), !dbg !365
  call void @log_load(i64 %tid3, ptr @stderr), !dbg !365
  %18 = load ptr, ptr @stderr, align 8, !dbg !365, !tbaa !356
  %19 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 21, i64 1, ptr %18) #17, !dbg !367
  tail call void @exit(i32 noundef 1) #15, !dbg !368
  unreachable, !dbg !368

20:                                               ; preds = %10
  %21 = tail call i32 (ptr, i32, ...) @open(ptr noundef %12, i32 noundef 0) #14, !dbg !369
  call void @llvm.dbg.value(metadata i32 %21, metadata !267, metadata !DIExpression()), !dbg !345
  %22 = icmp slt i32 %21, 0, !dbg !369
  br i1 %22, label %23, label %27, !dbg !371

23:                                               ; preds = %20
  tail call void @perror(ptr noundef nonnull @.str.2) #17, !dbg !372
  %24 = tail call i32 (ptr, i32, ...) @open(ptr noundef %12, i32 noundef 0) #14, !dbg !374
  call void @llvm.dbg.value(metadata i32 %24, metadata !267, metadata !DIExpression()), !dbg !345
  %25 = icmp sgt i32 %24, -1, !dbg !374
  br i1 %25, label %27, label %26, !dbg !377

26:                                               ; preds = %23
  tail call void @__assert_fail(ptr noundef nonnull @.str.3, ptr noundef nonnull @.str.4, i32 noundef 91, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !374
  unreachable, !dbg !374

27:                                               ; preds = %23, %20
  %28 = phi i32 [ %24, %23 ], [ %21, %20 ], !dbg !369
  call void @llvm.dbg.value(metadata i32 %28, metadata !267, metadata !DIExpression()), !dbg !345
  %29 = call i32 @fstat(i32 noundef %28, ptr noundef nonnull %3) #14, !dbg !378
  %30 = icmp slt i32 %29, 0, !dbg !378
  br i1 %30, label %31, label %35, !dbg !380

31:                                               ; preds = %27
  tail call void @perror(ptr noundef nonnull @.str.5) #17, !dbg !381
  %32 = call i32 @fstat(i32 noundef %28, ptr noundef nonnull %3) #14, !dbg !383
  %33 = icmp sgt i32 %32, -1, !dbg !383
  br i1 %33, label %35, label %34, !dbg !386

34:                                               ; preds = %31
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.4, i32 noundef 92, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !383
  unreachable, !dbg !383

35:                                               ; preds = %31, %27
  %36 = getelementptr inbounds %struct.stat, ptr %3, i64 0, i32 8, !dbg !387
  %tid4 = call i64 @get_thread_id(), !dbg !387
  call void @log_load(i64 %tid4, ptr %36), !dbg !387
  %37 = load i64, ptr %36, align 8, !dbg !387, !tbaa !389
  %38 = add nsw i64 %37, 1, !dbg !387
  %39 = tail call ptr @mmap(ptr noundef null, i64 noundef %38, i32 noundef 3, i32 noundef 2, i32 noundef %28, i64 noundef 0) #14, !dbg !387
  call void @llvm.dbg.value(metadata ptr %39, metadata !268, metadata !DIExpression()), !dbg !345
  %40 = icmp eq ptr %39, null, !dbg !387
  br i1 %40, label %41, label %45, !dbg !392

41:                                               ; preds = %35
  tail call void @perror(ptr noundef nonnull @.str.7) #17, !dbg !393
  %42 = tail call ptr @mmap(ptr noundef null, i64 noundef %38, i32 noundef 3, i32 noundef 2, i32 noundef %28, i64 noundef 0) #14, !dbg !395
  call void @llvm.dbg.value(metadata ptr %42, metadata !268, metadata !DIExpression()), !dbg !345
  %43 = icmp eq ptr %42, null, !dbg !395
  br i1 %43, label %44, label %45, !dbg !398

44:                                               ; preds = %41
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.4, i32 noundef 94, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !395
  unreachable, !dbg !395

45:                                               ; preds = %41, %35
  %46 = phi ptr [ %42, %41 ], [ %39, %35 ], !dbg !387
  call void @llvm.dbg.value(metadata ptr %46, metadata !268, metadata !DIExpression()), !dbg !345
  %47 = call i32 @pthread_attr_init(ptr noundef nonnull %4) #14, !dbg !399
  %48 = call i32 @pthread_attr_setscope(ptr noundef nonnull %4, i32 noundef 0) #14, !dbg !400
  %49 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, i32 noundef %15), !dbg !401
  call void @llvm.dbg.value(metadata ptr %46, metadata !323, metadata !DIExpression()), !dbg !345
  %50 = lshr i64 %37, 1, !dbg !402
  call void @llvm.dbg.value(metadata i64 %50, metadata !324, metadata !DIExpression()), !dbg !345
  %51 = zext i32 %15 to i64
  %52 = udiv i64 %50, %51, !dbg !403
  %53 = trunc i64 %52 to i32, !dbg !404
  call void @llvm.dbg.value(metadata i32 %53, metadata !310, metadata !DIExpression()), !dbg !345
  %54 = call fastcc ptr @CALLOC(i64 noundef %51), !dbg !405
  call void @llvm.dbg.value(metadata ptr %54, metadata !322, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i32 0, metadata !312, metadata !DIExpression()), !dbg !345
  %55 = icmp sgt i32 %15, 0, !dbg !406
  br i1 %55, label %56, label %63, !dbg !409

56:                                               ; preds = %45
  %57 = add nsw i32 %15, -1
  %58 = trunc i64 %50 to i32
  %59 = shl i64 %52, 32, !dbg !409
  %60 = ashr exact i64 %59, 32, !dbg !409
  %61 = zext i32 %57 to i64, !dbg !409
  %62 = zext i32 %15 to i64, !dbg !406
  br label %67, !dbg !409

63:                                               ; preds = %84, %45
  call void @llvm.dbg.value(metadata i32 0, metadata !312, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 0, metadata !325, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 0, metadata !326, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 0, metadata !327, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 0, metadata !328, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 0, metadata !329, metadata !DIExpression()), !dbg !345
  %64 = icmp sgt i32 %15, 0, !dbg !410
  br i1 %64, label %65, label %128, !dbg !411

65:                                               ; preds = %63
  %66 = zext i32 %15 to i64, !dbg !410
  br label %87, !dbg !411

67:                                               ; preds = %84, %56
  %68 = phi i64 [ 0, %56 ], [ %85, %84 ]
  call void @llvm.dbg.value(metadata i64 %68, metadata !312, metadata !DIExpression()), !dbg !345
  %69 = mul nsw i64 %68, %60, !dbg !412
  %70 = getelementptr inbounds %struct.POINT_T, ptr %46, i64 %69, !dbg !414
  %71 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %68, !dbg !415
  %72 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %68, i32 1, !dbg !416
  %tid5 = call i64 @get_thread_id(), !dbg !417
  call void @log_store(i64 %tid5, ptr %72), !dbg !417
  store ptr %70, ptr %72, align 8, !dbg !417, !tbaa !229
  %73 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %68, i32 2, !dbg !418
  %74 = icmp eq i64 %68, %61, !dbg !419
  %75 = trunc i64 %69 to i32, !dbg !421
  %76 = sub i32 %58, %75, !dbg !421
  %77 = select i1 %74, i32 %76, i32 %53, !dbg !421
  %tid6 = call i64 @get_thread_id(), !dbg !422
  call void @log_store(i64 %tid6, ptr %73), !dbg !422
  store i32 %77, ptr %73, align 8, !dbg !422, !tbaa !217
  %78 = call i32 @pthread_create(ptr noundef %71, ptr noundef nonnull %4, ptr noundef nonnull @linear_regression_pthread, ptr noundef %71) #14, !dbg !423
  %79 = icmp eq i32 %78, 0, !dbg !423
  br i1 %79, label %84, label %80, !dbg !425

80:                                               ; preds = %67
  call void @perror(ptr noundef nonnull @.str.10) #17, !dbg !426
  %81 = call i32 @pthread_create(ptr noundef %71, ptr noundef nonnull %4, ptr noundef nonnull @linear_regression_pthread, ptr noundef %71) #14, !dbg !428
  %82 = icmp eq i32 %81, 0, !dbg !428
  br i1 %82, label %84, label %83, !dbg !431

83:                                               ; preds = %80
  call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.4, i32 noundef 114, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !428
  unreachable, !dbg !428

84:                                               ; preds = %80, %67
  %85 = add nuw nsw i64 %68, 1, !dbg !432
  call void @llvm.dbg.value(metadata i64 %85, metadata !312, metadata !DIExpression()), !dbg !345
  %86 = icmp eq i64 %85, %62, !dbg !406
  br i1 %86, label %63, label %67, !dbg !409, !llvm.loop !433

87:                                               ; preds = %110, %65
  %88 = phi i64 [ 0, %65 ], [ %126, %110 ]
  %89 = phi i64 [ 0, %65 ], [ %113, %110 ]
  %90 = phi i64 [ 0, %65 ], [ %116, %110 ]
  %91 = phi i64 [ 0, %65 ], [ %119, %110 ]
  %92 = phi i64 [ 0, %65 ], [ %122, %110 ]
  %93 = phi i64 [ 0, %65 ], [ %125, %110 ]
  call void @llvm.dbg.value(metadata i64 %88, metadata !312, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 %89, metadata !325, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 %90, metadata !326, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 %91, metadata !327, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 %92, metadata !328, metadata !DIExpression()), !dbg !345
  call void @llvm.dbg.value(metadata i64 %93, metadata !329, metadata !DIExpression()), !dbg !345
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5) #14, !dbg !435
  %94 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, !dbg !436
  %tid7 = call i64 @get_thread_id(), !dbg !436
  call void @log_load(i64 %tid7, ptr %94), !dbg !436
  %95 = load i64, ptr %94, align 8, !dbg !436, !tbaa !438
  %96 = call i32 @pthread_join(i64 noundef %95, ptr noundef nonnull %5) #14, !dbg !436
  %97 = icmp eq i32 %96, 0, !dbg !436
  br i1 %97, label %103, label %98, !dbg !439

98:                                               ; preds = %87
  call void @perror(ptr noundef nonnull @.str.12) #17, !dbg !440
  %tid8 = call i64 @get_thread_id(), !dbg !442
  call void @log_load(i64 %tid8, ptr %94), !dbg !442
  %99 = load i64, ptr %94, align 8, !dbg !442, !tbaa !438
  %100 = call i32 @pthread_join(i64 noundef %99, ptr noundef nonnull %5) #14, !dbg !442
  %101 = icmp eq i32 %100, 0, !dbg !442
  br i1 %101, label %103, label %102, !dbg !445

102:                                              ; preds = %98
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.4, i32 noundef 121, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !442
  unreachable, !dbg !442

103:                                              ; preds = %98, %87
  %tid9 = call i64 @get_thread_id(), !dbg !446
  call void @log_load(i64 %tid9, ptr %5), !dbg !446
  %104 = load i32, ptr %5, align 4, !dbg !446, !tbaa !448
  %105 = icmp eq i32 %104, 0, !dbg !446
  br i1 %105, label %110, label %106, !dbg !449

106:                                              ; preds = %103
  call void @perror(ptr noundef nonnull @.str.14) #17, !dbg !450
  %tid10 = call i64 @get_thread_id(), !dbg !452
  call void @log_load(i64 %tid10, ptr %5), !dbg !452
  %107 = load i32, ptr %5, align 4, !dbg !452, !tbaa !448
  %108 = icmp eq i32 %107, 0, !dbg !452
  br i1 %108, label %110, label %109, !dbg !455

109:                                              ; preds = %106
  call void @__assert_fail(ptr noundef nonnull @.str.15, ptr noundef nonnull @.str.4, i32 noundef 122, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !452
  unreachable, !dbg !452

110:                                              ; preds = %106, %103
  %111 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, i32 3, !dbg !456
  %tid11 = call i64 @get_thread_id(), !dbg !456
  call void @log_load(i64 %tid11, ptr %111), !dbg !456
  %112 = load i64, ptr %111, align 8, !dbg !456, !tbaa !230
  %113 = add nsw i64 %112, %89, !dbg !457
  call void @llvm.dbg.value(metadata i64 %113, metadata !325, metadata !DIExpression()), !dbg !345
  %114 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, i32 4, !dbg !458
  %tid12 = call i64 @get_thread_id(), !dbg !458
  call void @log_load(i64 %tid12, ptr %114), !dbg !458
  %115 = load i64, ptr %114, align 8, !dbg !458, !tbaa !232
  %116 = add nsw i64 %115, %90, !dbg !459
  call void @llvm.dbg.value(metadata i64 %116, metadata !326, metadata !DIExpression()), !dbg !345
  %117 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, i32 5, !dbg !460
  %tid13 = call i64 @get_thread_id(), !dbg !460
  call void @log_load(i64 %tid13, ptr %117), !dbg !460
  %118 = load i64, ptr %117, align 8, !dbg !460, !tbaa !231
  %119 = add nsw i64 %118, %91, !dbg !461
  call void @llvm.dbg.value(metadata i64 %119, metadata !327, metadata !DIExpression()), !dbg !345
  %120 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, i32 6, !dbg !462
  %tid14 = call i64 @get_thread_id(), !dbg !462
  call void @log_load(i64 %tid14, ptr %120), !dbg !462
  %121 = load i64, ptr %120, align 8, !dbg !462, !tbaa !233
  %122 = add nsw i64 %121, %92, !dbg !463
  call void @llvm.dbg.value(metadata i64 %122, metadata !328, metadata !DIExpression()), !dbg !345
  %123 = getelementptr inbounds %struct.lreg_args, ptr %54, i64 %88, i32 7, !dbg !464
  %tid15 = call i64 @get_thread_id(), !dbg !464
  call void @log_load(i64 %tid15, ptr %123), !dbg !464
  %124 = load i64, ptr %123, align 8, !dbg !464, !tbaa !234
  %125 = add nsw i64 %124, %93, !dbg !465
  call void @llvm.dbg.value(metadata i64 %125, metadata !329, metadata !DIExpression()), !dbg !345
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5) #14, !dbg !466
  %126 = add nuw nsw i64 %88, 1, !dbg !467
  call void @llvm.dbg.value(metadata i64 %126, metadata !312, metadata !DIExpression()), !dbg !345
  %127 = icmp eq i64 %126, %66, !dbg !410
  br i1 %127, label %128, label %87, !dbg !411, !llvm.loop !468

128:                                              ; preds = %110, %63
  %129 = phi i64 [ 0, %63 ], [ %125, %110 ], !dbg !345
  %130 = phi i64 [ 0, %63 ], [ %122, %110 ], !dbg !345
  %131 = phi i64 [ 0, %63 ], [ %119, %110 ], !dbg !345
  %132 = phi i64 [ 0, %63 ], [ %116, %110 ], !dbg !345
  %133 = phi i64 [ 0, %63 ], [ %113, %110 ], !dbg !345
  call void @free(ptr noundef %54) #14, !dbg !470
  %134 = sitofp i64 %133 to double, !dbg !471
  call void @llvm.dbg.value(metadata double %134, metadata !339, metadata !DIExpression()), !dbg !345
  %135 = sitofp i64 %132 to double, !dbg !472
  call void @llvm.dbg.value(metadata double %135, metadata !340, metadata !DIExpression()), !dbg !345
  %136 = sitofp i64 %131 to double, !dbg !473
  call void @llvm.dbg.value(metadata double %136, metadata !341, metadata !DIExpression()), !dbg !345
  %137 = sitofp i64 %130 to double, !dbg !474
  call void @llvm.dbg.value(metadata double %137, metadata !342, metadata !DIExpression()), !dbg !345
  %138 = sitofp i64 %129 to double, !dbg !475
  call void @llvm.dbg.value(metadata double %138, metadata !343, metadata !DIExpression()), !dbg !345
  %139 = sitofp i64 %50 to double, !dbg !476
  %140 = fneg double %134, !dbg !477
  %141 = fmul double %135, %140, !dbg !477
  %142 = call double @llvm.fmuladd.f64(double %139, double %138, double %141), !dbg !477
  %143 = fmul double %140, %134, !dbg !478
  %144 = call double @llvm.fmuladd.f64(double %139, double %136, double %143), !dbg !478
  %145 = fdiv double %142, %144, !dbg !479
  call void @llvm.dbg.value(metadata double %145, metadata !335, metadata !DIExpression()), !dbg !345
  %146 = fneg double %145, !dbg !480
  %147 = call double @llvm.fmuladd.f64(double %146, double %134, double %135), !dbg !480
  %148 = fdiv double %147, %139, !dbg !481
  call void @llvm.dbg.value(metadata double %148, metadata !334, metadata !DIExpression()), !dbg !345
  %149 = fdiv double %134, %139, !dbg !482
  call void @llvm.dbg.value(metadata double %149, metadata !336, metadata !DIExpression()), !dbg !345
  %150 = fdiv double %135, %139, !dbg !483
  call void @llvm.dbg.value(metadata double %150, metadata !337, metadata !DIExpression()), !dbg !345
  %151 = fmul double %142, %142, !dbg !484
  %152 = fneg double %135, !dbg !485
  %153 = fmul double %152, %135, !dbg !485
  %154 = call double @llvm.fmuladd.f64(double %139, double %137, double %153), !dbg !485
  %155 = fmul double %154, %144, !dbg !486
  %156 = fdiv double %151, %155, !dbg !487
  call void @llvm.dbg.value(metadata double %156, metadata !338, metadata !DIExpression()), !dbg !345
  %157 = call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !488
  %158 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.17, double noundef %148), !dbg !489
  %159 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.18, double noundef %145), !dbg !490
  %160 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.19, double noundef %149), !dbg !491
  %161 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.20, double noundef %150), !dbg !492
  %162 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.21, double noundef %156), !dbg !493
  %163 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.22, i64 noundef %133), !dbg !494
  %164 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.23, i64 noundef %132), !dbg !495
  %165 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.24, i64 noundef %131), !dbg !496
  %166 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.25, i64 noundef %130), !dbg !497
  %167 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.26, i64 noundef %129), !dbg !498
  %168 = call i32 @pthread_attr_destroy(ptr noundef nonnull %4) #14, !dbg !499
  %169 = icmp slt i32 %168, 0, !dbg !499
  br i1 %169, label %170, label %174, !dbg !501

170:                                              ; preds = %128
  call void @perror(ptr noundef nonnull @.str.27) #17, !dbg !502
  %171 = call i32 @pthread_attr_destroy(ptr noundef nonnull %4) #14, !dbg !504
  %172 = icmp sgt i32 %171, -1, !dbg !504
  br i1 %172, label %174, label %173, !dbg !507

173:                                              ; preds = %170
  call void @__assert_fail(ptr noundef nonnull @.str.28, ptr noundef nonnull @.str.4, i32 noundef 158, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !504
  unreachable, !dbg !504

174:                                              ; preds = %170, %128
  %175 = call i32 @munmap(ptr noundef %46, i64 noundef %38) #14, !dbg !508
  %176 = icmp slt i32 %175, 0, !dbg !508
  br i1 %176, label %177, label %181, !dbg !510

177:                                              ; preds = %174
  call void @perror(ptr noundef nonnull @.str.29) #17, !dbg !511
  %178 = call i32 @munmap(ptr noundef %46, i64 noundef %38) #14, !dbg !513
  %179 = icmp sgt i32 %178, -1, !dbg !513
  br i1 %179, label %181, label %180, !dbg !516

180:                                              ; preds = %177
  call void @__assert_fail(ptr noundef nonnull @.str.30, ptr noundef nonnull @.str.4, i32 noundef 159, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !513
  unreachable, !dbg !513

181:                                              ; preds = %177, %174
  %182 = call i32 @close(i32 noundef %28) #14, !dbg !517
  %183 = icmp slt i32 %182, 0, !dbg !517
  br i1 %183, label %184, label %188, !dbg !519

184:                                              ; preds = %181
  call void @perror(ptr noundef nonnull @.str.31) #17, !dbg !520
  %185 = call i32 @close(i32 noundef %28) #14, !dbg !522
  %186 = icmp sgt i32 %185, -1, !dbg !522
  br i1 %186, label %188, label %187, !dbg !525

187:                                              ; preds = %184
  call void @__assert_fail(ptr noundef nonnull @.str.32, ptr noundef nonnull @.str.4, i32 noundef 160, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #15, !dbg !522
  unreachable, !dbg !522

188:                                              ; preds = %184, %181
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %4) #14, !dbg !526
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %3) #14, !dbg !526
  ret i32 0, !dbg !527
}

; Function Attrs: nofree nounwind
declare !dbg !528 noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare !dbg !534 void @exit(i32 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nofree nounwind willreturn memory(read)
declare !dbg !538 i32 @atoi(ptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree
declare !dbg !541 noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !545 void @perror(ptr nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: noreturn nounwind
declare !dbg !548 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare !dbg !552 noundef i32 @fstat(i32 noundef, ptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind
declare !dbg !557 ptr @mmap(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) local_unnamed_addr #7

; Function Attrs: nounwind
declare !dbg !563 i32 @pthread_attr_init(ptr noundef) local_unnamed_addr #7

; Function Attrs: nounwind
declare !dbg !567 i32 @pthread_attr_setscope(ptr noundef, i32 noundef) local_unnamed_addr #7

; Function Attrs: noinline nounwind uwtable
define internal fastcc noalias ptr @CALLOC(i64 noundef %0) unnamed_addr #2 !dbg !570 {
  call void @llvm.dbg.value(metadata i64 64, metadata !574, metadata !DIExpression()), !dbg !577
  call void @llvm.dbg.value(metadata i64 %0, metadata !575, metadata !DIExpression()), !dbg !577
  %2 = tail call noalias ptr @calloc(i64 noundef 64, i64 noundef %0) #18, !dbg !578
  call void @llvm.dbg.value(metadata ptr %2, metadata !576, metadata !DIExpression()), !dbg !577
  %3 = icmp eq ptr %2, null, !dbg !579
  br i1 %3, label %4, label %5, !dbg !582

4:                                                ; preds = %1
  tail call void @__assert_fail(ptr noundef nonnull @.str.33, ptr noundef nonnull @.str.34, i32 noundef 59, ptr noundef nonnull @__PRETTY_FUNCTION__.CALLOC) #15, !dbg !579
  unreachable, !dbg !579

5:                                                ; preds = %1
  ret ptr %2, !dbg !583
}

; Function Attrs: nounwind
declare !dbg !584 i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #7

declare !dbg !594 i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !597 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #10

; Function Attrs: nounwind
declare !dbg !600 i32 @pthread_attr_destroy(ptr noundef) local_unnamed_addr #7

; Function Attrs: nounwind
declare !dbg !601 i32 @munmap(ptr noundef, i64 noundef) local_unnamed_addr #7

declare !dbg !604 i32 @close(i32 noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare !dbg !608 noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #10

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #13

declare webkit_jscc i64 @get_thread_id()

declare webkit_jscc void @log_store(i64, ptr)

declare webkit_jscc void @log_load(i64, ptr)

attributes #0 = { nofree noinline nosync nounwind memory(read, argmem: readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { noinline nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress nofree nounwind willreturn memory(read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #11 = { mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nofree nounwind }
attributes #13 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #14 = { nounwind }
attributes #15 = { noreturn nounwind }
attributes #16 = { nounwind willreturn memory(read) }
attributes #17 = { cold }
attributes #18 = { nounwind allocsize(0,1) }

!llvm.dbg.cu = !{!155}
!llvm.module.flags = !{!196, !197, !198, !199, !200, !201}
!llvm.ident = !{!202}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 80, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "linear_regression-pthread.c", directory: "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/linear_regression", checksumkind: CSK_MD5, checksum: "30905de8c192310485322f8cf2645ebb")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 288, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 36)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 87, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 176, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 22)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 91, type: !14, isLocal: true, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 472, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 59)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(scope: null, file: !2, line: 91, type: !19, isLocal: true, isDefinition: true)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 272, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 34)
!22 = !DIGlobalVariableExpression(var: !23, expr: !DIExpression())
!23 = distinct !DIGlobalVariable(scope: null, file: !2, line: 91, type: !24, isLocal: true, isDefinition: true)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 224, elements: !25)
!25 = !{!26}
!26 = !DISubrange(count: 28)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(scope: null, file: !2, line: 91, type: !29, isLocal: true, isDefinition: true)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 184, elements: !31)
!30 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!31 = !{!32}
!32 = !DISubrange(count: 23)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(scope: null, file: !2, line: 92, type: !35, isLocal: true, isDefinition: true)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 384, elements: !36)
!36 = !{!37}
!37 = !DISubrange(count: 48)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(scope: null, file: !2, line: 92, type: !40, isLocal: true, isDefinition: true)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 232, elements: !41)
!41 = !{!42}
!42 = !DISubrange(count: 29)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(scope: null, file: !2, line: 93, type: !45, isLocal: true, isDefinition: true)
!45 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 920, elements: !46)
!46 = !{!47}
!47 = !DISubrange(count: 115)
!48 = !DIGlobalVariableExpression(var: !49, expr: !DIExpression())
!49 = distinct !DIGlobalVariable(scope: null, file: !2, line: 93, type: !50, isLocal: true, isDefinition: true)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 656, elements: !51)
!51 = !{!52}
!52 = !DISubrange(count: 82)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(scope: null, file: !2, line: 99, type: !55, isLocal: true, isDefinition: true)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 456, elements: !56)
!56 = !{!57}
!57 = !DISubrange(count: 57)
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression())
!59 = distinct !DIGlobalVariable(scope: null, file: !2, line: 114, type: !60, isLocal: true, isDefinition: true)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 952, elements: !61)
!61 = !{!62}
!62 = !DISubrange(count: 119)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(scope: null, file: !2, line: 114, type: !65, isLocal: true, isDefinition: true)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 800, elements: !66)
!66 = !{!67}
!67 = !DISubrange(count: 100)
!68 = !DIGlobalVariableExpression(var: !69, expr: !DIExpression())
!69 = distinct !DIGlobalVariable(scope: null, file: !2, line: 121, type: !70, isLocal: true, isDefinition: true)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 696, elements: !71)
!71 = !{!72}
!72 = !DISubrange(count: 87)
!73 = !DIGlobalVariableExpression(var: !74, expr: !DIExpression())
!74 = distinct !DIGlobalVariable(scope: null, file: !2, line: 121, type: !75, isLocal: true, isDefinition: true)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 544, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 68)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(scope: null, file: !2, line: 122, type: !80, isLocal: true, isDefinition: true)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 312, elements: !81)
!81 = !{!82}
!82 = !DISubrange(count: 39)
!83 = !DIGlobalVariableExpression(var: !84, expr: !DIExpression())
!84 = distinct !DIGlobalVariable(scope: null, file: !2, line: 122, type: !85, isLocal: true, isDefinition: true)
!85 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !86)
!86 = !{!87}
!87 = !DISubrange(count: 20)
!88 = !DIGlobalVariableExpression(var: !89, expr: !DIExpression())
!89 = distinct !DIGlobalVariable(scope: null, file: !2, line: 147, type: !90, isLocal: true, isDefinition: true)
!90 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !91)
!91 = !{!92}
!92 = !DISubrange(count: 13)
!93 = !DIGlobalVariableExpression(var: !94, expr: !DIExpression())
!94 = distinct !DIGlobalVariable(scope: null, file: !2, line: 148, type: !90, isLocal: true, isDefinition: true)
!95 = !DIGlobalVariableExpression(var: !96, expr: !DIExpression())
!96 = distinct !DIGlobalVariable(scope: null, file: !2, line: 149, type: !90, isLocal: true, isDefinition: true)
!97 = !DIGlobalVariableExpression(var: !98, expr: !DIExpression())
!98 = distinct !DIGlobalVariable(scope: null, file: !2, line: 150, type: !90, isLocal: true, isDefinition: true)
!99 = !DIGlobalVariableExpression(var: !100, expr: !DIExpression())
!100 = distinct !DIGlobalVariable(scope: null, file: !2, line: 151, type: !90, isLocal: true, isDefinition: true)
!101 = !DIGlobalVariableExpression(var: !102, expr: !DIExpression())
!102 = distinct !DIGlobalVariable(scope: null, file: !2, line: 152, type: !103, isLocal: true, isDefinition: true)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !104)
!104 = !{!105}
!105 = !DISubrange(count: 14)
!106 = !DIGlobalVariableExpression(var: !107, expr: !DIExpression())
!107 = distinct !DIGlobalVariable(scope: null, file: !2, line: 153, type: !103, isLocal: true, isDefinition: true)
!108 = !DIGlobalVariableExpression(var: !109, expr: !DIExpression())
!109 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !103, isLocal: true, isDefinition: true)
!110 = !DIGlobalVariableExpression(var: !111, expr: !DIExpression())
!111 = distinct !DIGlobalVariable(scope: null, file: !2, line: 155, type: !103, isLocal: true, isDefinition: true)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(scope: null, file: !2, line: 156, type: !103, isLocal: true, isDefinition: true)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(scope: null, file: !2, line: 158, type: !116, isLocal: true, isDefinition: true)
!116 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 464, elements: !117)
!117 = !{!118}
!118 = !DISubrange(count: 58)
!119 = !DIGlobalVariableExpression(var: !120, expr: !DIExpression())
!120 = distinct !DIGlobalVariable(scope: null, file: !2, line: 158, type: !80, isLocal: true, isDefinition: true)
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(scope: null, file: !2, line: 159, type: !123, isLocal: true, isDefinition: true)
!123 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 504, elements: !124)
!124 = !{!125}
!125 = !DISubrange(count: 63)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(scope: null, file: !2, line: 159, type: !128, isLocal: true, isDefinition: true)
!128 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 352, elements: !129)
!129 = !{!130}
!130 = !DISubrange(count: 44)
!131 = !DIGlobalVariableExpression(var: !132, expr: !DIExpression())
!132 = distinct !DIGlobalVariable(scope: null, file: !2, line: 160, type: !133, isLocal: true, isDefinition: true)
!133 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 320, elements: !134)
!134 = !{!135}
!135 = !DISubrange(count: 40)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(scope: null, file: !2, line: 160, type: !138, isLocal: true, isDefinition: true)
!138 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !139)
!139 = !{!140}
!140 = !DISubrange(count: 21)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(scope: null, file: !143, line: 59, type: !144, isLocal: true, isDefinition: true)
!143 = !DIFile(filename: "../../include/stddefines.h", directory: "/home/dongin/llvm-plugin-rs/phoenix/phoenix-2.0/tests/linear_regression", checksumkind: CSK_MD5, checksum: "37e83e2cff648952843f52d64aa409e1")
!144 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 40, elements: !145)
!145 = !{!146}
!146 = !DISubrange(count: 5)
!147 = !DIGlobalVariableExpression(var: !148, expr: !DIExpression())
!148 = distinct !DIGlobalVariable(scope: null, file: !143, line: 59, type: !149, isLocal: true, isDefinition: true)
!149 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !150)
!150 = !{!151}
!151 = !DISubrange(count: 27)
!152 = !DIGlobalVariableExpression(var: !153, expr: !DIExpression())
!153 = distinct !DIGlobalVariable(scope: null, file: !143, line: 59, type: !154, isLocal: true, isDefinition: true)
!154 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 232, elements: !41)
!155 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !156, retainedTypes: !163, globals: !190, splitDebugInlining: false, nameTableKind: None)
!156 = !{!157}
!157 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !158, line: 134, baseType: !159, size: 32, elements: !160)
!158 = !DIFile(filename: "/usr/include/pthread.h", directory: "", checksumkind: CSK_MD5, checksum: "5205981c6f80cc3dc1e81231df63d8ef")
!159 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!160 = !{!161, !162}
!161 = !DIEnumerator(name: "PTHREAD_SCOPE_SYSTEM", value: 0)
!162 = !DIEnumerator(name: "PTHREAD_SCOPE_PROCESS", value: 1)
!163 = !{!164, !187, !173, !182, !188, !189}
!164 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !165, size: 64)
!165 = !DIDerivedType(tag: DW_TAG_typedef, name: "lreg_args", file: !2, line: 45, baseType: !166)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !2, line: 36, size: 512, elements: !167)
!167 = !{!168, !172, !179, !181, !183, !184, !185, !186}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "tid", scope: !166, file: !2, line: 37, baseType: !169, size: 64)
!169 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !170, line: 27, baseType: !171)
!170 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "735e3bf264ff9d8f5d95898b1692fbdb")
!171 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "points", scope: !166, file: !2, line: 38, baseType: !173, size: 64, offset: 64)
!173 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !174, size: 64)
!174 = !DIDerivedType(tag: DW_TAG_typedef, name: "POINT_T", file: !2, line: 34, baseType: !175)
!175 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !2, line: 31, size: 16, elements: !176)
!176 = !{!177, !178}
!177 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !175, file: !2, line: 32, baseType: !4, size: 8)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !175, file: !2, line: 33, baseType: !4, size: 8, offset: 8)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "num_elems", scope: !166, file: !2, line: 39, baseType: !180, size: 32, offset: 128)
!180 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "SX", scope: !166, file: !2, line: 40, baseType: !182, size: 64, offset: 192)
!182 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "SY", scope: !166, file: !2, line: 41, baseType: !182, size: 64, offset: 256)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "SXX", scope: !166, file: !2, line: 42, baseType: !182, size: 64, offset: 320)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "SYY", scope: !166, file: !2, line: 43, baseType: !182, size: 64, offset: 384)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "SXY", scope: !166, file: !2, line: 44, baseType: !182, size: 64, offset: 448)
!187 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!188 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !187, size: 64)
!189 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!190 = !{!0, !7, !12, !17, !22, !27, !33, !38, !43, !48, !53, !58, !63, !68, !73, !78, !83, !191, !88, !93, !95, !97, !99, !101, !106, !108, !110, !112, !114, !119, !121, !126, !131, !136, !141, !147, !152}
!191 = !DIGlobalVariableExpression(var: !192, expr: !DIExpression())
!192 = distinct !DIGlobalVariable(scope: null, file: !2, line: 146, type: !193, isLocal: true, isDefinition: true)
!193 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 304, elements: !194)
!194 = !{!195}
!195 = !DISubrange(count: 38)
!196 = !{i32 7, !"Dwarf Version", i32 5}
!197 = !{i32 2, !"Debug Info Version", i32 3}
!198 = !{i32 1, !"wchar_size", i32 4}
!199 = !{i32 8, !"PIC Level", i32 2}
!200 = !{i32 7, !"uwtable", i32 2}
!201 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!202 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!203 = distinct !DISubprogram(name: "linear_regression_pthread", scope: !2, file: !2, line: 47, type: !204, scopeLine: 47, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !155, retainedNodes: !206)
!204 = !DISubroutineType(types: !205)
!205 = !{!187, !187}
!206 = !{!207, !208, !209}
!207 = !DILocalVariable(name: "args_in", arg: 1, scope: !203, file: !2, line: 47, type: !187)
!208 = !DILocalVariable(name: "args", scope: !203, file: !2, line: 48, type: !164)
!209 = !DILocalVariable(name: "i", scope: !203, file: !2, line: 49, type: !180)
!210 = !DILocation(line: 0, scope: !203)
!211 = !DILocation(line: 51, column: 12, scope: !203)
!212 = !DILocation(line: 52, column: 12, scope: !203)
!213 = !DILocation(line: 53, column: 12, scope: !203)
!214 = !DILocation(line: 54, column: 12, scope: !203)
!215 = !DILocation(line: 55, column: 12, scope: !203)
!216 = !DILocation(line: 52, column: 16, scope: !203)
!217 = !{!218, !223, i64 16}
!218 = !{!"", !219, i64 0, !222, i64 8, !223, i64 16, !224, i64 24, !224, i64 32, !224, i64 40, !224, i64 48, !224, i64 56}
!219 = !{!"long", !220, i64 0}
!220 = !{!"omnipotent char", !221, i64 0}
!221 = !{!"Simple C/C++ TBAA"}
!222 = !{!"any pointer", !220, i64 0}
!223 = !{!"int", !220, i64 0}
!224 = !{!"long long", !220, i64 0}
!225 = !DILocation(line: 57, column: 20, scope: !226)
!226 = distinct !DILexicalBlock(scope: !227, file: !2, line: 57, column: 6)
!227 = distinct !DILexicalBlock(scope: !203, file: !2, line: 57, column: 6)
!228 = !DILocation(line: 57, column: 6, scope: !227)
!229 = !{!218, !222, i64 8}
!230 = !{!218, !224, i64 24}
!231 = !{!218, !224, i64 40}
!232 = !{!218, !224, i64 32}
!233 = !{!218, !224, i64 48}
!234 = !{!218, !224, i64 56}
!235 = !DILocation(line: 58, column: 23, scope: !236)
!236 = distinct !DILexicalBlock(scope: !226, file: !2, line: 57, column: 44)
!237 = !DILocation(line: 58, column: 39, scope: !236)
!238 = !{!239, !220, i64 0}
!239 = !{!"", !220, i64 0, !220, i64 1}
!240 = !DILocation(line: 58, column: 20, scope: !236)
!241 = !DILocation(line: 59, column: 23, scope: !236)
!242 = !DILocation(line: 59, column: 41, scope: !236)
!243 = !DILocation(line: 59, column: 20, scope: !236)
!244 = !DILocation(line: 60, column: 39, scope: !236)
!245 = !{!239, !220, i64 1}
!246 = !DILocation(line: 60, column: 23, scope: !236)
!247 = !DILocation(line: 60, column: 20, scope: !236)
!248 = !DILocation(line: 61, column: 23, scope: !236)
!249 = !DILocation(line: 61, column: 41, scope: !236)
!250 = !DILocation(line: 61, column: 20, scope: !236)
!251 = !DILocation(line: 62, column: 41, scope: !236)
!252 = !DILocation(line: 62, column: 20, scope: !236)
!253 = !DILocation(line: 57, column: 40, scope: !226)
!254 = distinct !{!254, !228, !255, !256, !257}
!255 = !DILocation(line: 63, column: 6, scope: !227)
!256 = !{!"llvm.loop.mustprogress"}
!257 = !{!"llvm.loop.unroll.disable"}
!258 = !DILocation(line: 65, column: 6, scope: !203)
!259 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 68, type: !260, scopeLine: 68, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !155, retainedNodes: !264)
!260 = !DISubroutineType(types: !261)
!261 = !{!180, !180, !262}
!262 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !263, size: 64)
!263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!264 = !{!265, !266, !267, !268, !269, !270, !310, !311, !312, !313, !322, !323, !324, !325, !326, !327, !328, !329, !330, !334, !335, !336, !337, !338, !339, !340, !341, !342, !343}
!265 = !DILocalVariable(name: "argc", arg: 1, scope: !259, file: !2, line: 68, type: !180)
!266 = !DILocalVariable(name: "argv", arg: 2, scope: !259, file: !2, line: 68, type: !262)
!267 = !DILocalVariable(name: "fd", scope: !259, file: !2, line: 69, type: !180)
!268 = !DILocalVariable(name: "fdata", scope: !259, file: !2, line: 70, type: !263)
!269 = !DILocalVariable(name: "fname", scope: !259, file: !2, line: 71, type: !263)
!270 = !DILocalVariable(name: "finfo", scope: !259, file: !2, line: 72, type: !271)
!271 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !272, line: 26, size: 1152, elements: !273)
!272 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/struct_stat.h", directory: "", checksumkind: CSK_MD5, checksum: "3ba283bc334370fe631cbc82f5229ed7")
!273 = !{!274, !277, !279, !281, !283, !285, !287, !288, !289, !292, !294, !296, !304, !305, !306}
!274 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !271, file: !272, line: 31, baseType: !275, size: 64)
!275 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !276, line: 145, baseType: !171)
!276 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!277 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !271, file: !272, line: 36, baseType: !278, size: 64, offset: 64)
!278 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !276, line: 148, baseType: !171)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !271, file: !272, line: 44, baseType: !280, size: 64, offset: 128)
!280 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !276, line: 151, baseType: !171)
!281 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !271, file: !272, line: 45, baseType: !282, size: 32, offset: 192)
!282 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !276, line: 150, baseType: !159)
!283 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !271, file: !272, line: 47, baseType: !284, size: 32, offset: 224)
!284 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !276, line: 146, baseType: !159)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !271, file: !272, line: 48, baseType: !286, size: 32, offset: 256)
!286 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !276, line: 147, baseType: !159)
!287 = !DIDerivedType(tag: DW_TAG_member, name: "__pad0", scope: !271, file: !272, line: 50, baseType: !180, size: 32, offset: 288)
!288 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !271, file: !272, line: 52, baseType: !275, size: 64, offset: 320)
!289 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !271, file: !272, line: 57, baseType: !290, size: 64, offset: 384)
!290 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !276, line: 152, baseType: !291)
!291 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!292 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !271, file: !272, line: 61, baseType: !293, size: 64, offset: 448)
!293 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !276, line: 175, baseType: !291)
!294 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !271, file: !272, line: 63, baseType: !295, size: 64, offset: 512)
!295 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !276, line: 180, baseType: !291)
!296 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !271, file: !272, line: 74, baseType: !297, size: 128, offset: 576)
!297 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !298, line: 11, size: 128, elements: !299)
!298 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h", directory: "", checksumkind: CSK_MD5, checksum: "55dc154df3f21a5aa944dcafba9b43f6")
!299 = !{!300, !302}
!300 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !297, file: !298, line: 16, baseType: !301, size: 64)
!301 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !276, line: 160, baseType: !291)
!302 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !297, file: !298, line: 21, baseType: !303, size: 64, offset: 64)
!303 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !276, line: 197, baseType: !291)
!304 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !271, file: !272, line: 75, baseType: !297, size: 128, offset: 704)
!305 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !271, file: !272, line: 76, baseType: !297, size: 128, offset: 832)
!306 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !271, file: !272, line: 89, baseType: !307, size: 192, offset: 960)
!307 = !DICompositeType(tag: DW_TAG_array_type, baseType: !303, size: 192, elements: !308)
!308 = !{!309}
!309 = !DISubrange(count: 3)
!310 = !DILocalVariable(name: "req_units", scope: !259, file: !2, line: 74, type: !180)
!311 = !DILocalVariable(name: "num_threads", scope: !259, file: !2, line: 74, type: !180)
!312 = !DILocalVariable(name: "i", scope: !259, file: !2, line: 74, type: !180)
!313 = !DILocalVariable(name: "attr", scope: !259, file: !2, line: 75, type: !314)
!314 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_attr_t", file: !170, line: 62, baseType: !315)
!315 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "pthread_attr_t", file: !170, line: 56, size: 448, elements: !316)
!316 = !{!317, !321}
!317 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !315, file: !170, line: 58, baseType: !318, size: 448)
!318 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 448, elements: !319)
!319 = !{!320}
!320 = !DISubrange(count: 56)
!321 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !315, file: !170, line: 59, baseType: !291, size: 64)
!322 = !DILocalVariable(name: "tid_args", scope: !259, file: !2, line: 76, type: !164)
!323 = !DILocalVariable(name: "points", scope: !259, file: !2, line: 101, type: !173)
!324 = !DILocalVariable(name: "n", scope: !259, file: !2, line: 102, type: !182)
!325 = !DILocalVariable(name: "SX_ll", scope: !259, file: !2, line: 117, type: !182)
!326 = !DILocalVariable(name: "SY_ll", scope: !259, file: !2, line: 117, type: !182)
!327 = !DILocalVariable(name: "SXX_ll", scope: !259, file: !2, line: 117, type: !182)
!328 = !DILocalVariable(name: "SYY_ll", scope: !259, file: !2, line: 117, type: !182)
!329 = !DILocalVariable(name: "SXY_ll", scope: !259, file: !2, line: 117, type: !182)
!330 = !DILocalVariable(name: "ret_val", scope: !331, file: !2, line: 120, type: !180)
!331 = distinct !DILexicalBlock(scope: !332, file: !2, line: 119, column: 40)
!332 = distinct !DILexicalBlock(scope: !333, file: !2, line: 119, column: 6)
!333 = distinct !DILexicalBlock(scope: !259, file: !2, line: 119, column: 6)
!334 = !DILocalVariable(name: "a", scope: !259, file: !2, line: 133, type: !189)
!335 = !DILocalVariable(name: "b", scope: !259, file: !2, line: 133, type: !189)
!336 = !DILocalVariable(name: "xbar", scope: !259, file: !2, line: 133, type: !189)
!337 = !DILocalVariable(name: "ybar", scope: !259, file: !2, line: 133, type: !189)
!338 = !DILocalVariable(name: "r2", scope: !259, file: !2, line: 133, type: !189)
!339 = !DILocalVariable(name: "SX", scope: !259, file: !2, line: 134, type: !189)
!340 = !DILocalVariable(name: "SY", scope: !259, file: !2, line: 135, type: !189)
!341 = !DILocalVariable(name: "SXX", scope: !259, file: !2, line: 136, type: !189)
!342 = !DILocalVariable(name: "SYY", scope: !259, file: !2, line: 137, type: !189)
!343 = !DILocalVariable(name: "SXY", scope: !259, file: !2, line: 138, type: !189)
!344 = distinct !DIAssignID()
!345 = !DILocation(line: 0, scope: !259)
!346 = distinct !DIAssignID()
!347 = distinct !DIAssignID()
!348 = !DILocation(line: 0, scope: !331)
!349 = !DILocation(line: 72, column: 6, scope: !259)
!350 = !DILocation(line: 75, column: 6, scope: !259)
!351 = !DILocation(line: 79, column: 15, scope: !352)
!352 = distinct !DILexicalBlock(scope: !259, file: !2, line: 79, column: 10)
!353 = !DILocation(line: 79, column: 10, scope: !259)
!354 = !DILocation(line: 80, column: 57, scope: !355)
!355 = distinct !DILexicalBlock(scope: !352, file: !2, line: 79, column: 20)
!356 = !{!222, !222, i64 0}
!357 = !DILocation(line: 80, column: 10, scope: !355)
!358 = !DILocation(line: 81, column: 10, scope: !355)
!359 = !DILocation(line: 84, column: 14, scope: !259)
!360 = !DILocation(line: 85, column: 25, scope: !259)
!361 = !DILocation(line: 85, column: 20, scope: !259)
!362 = !DILocation(line: 86, column: 22, scope: !363)
!363 = distinct !DILexicalBlock(scope: !259, file: !2, line: 86, column: 10)
!364 = !DILocation(line: 86, column: 10, scope: !259)
!365 = !DILocation(line: 87, column: 18, scope: !366)
!366 = distinct !DILexicalBlock(scope: !363, file: !2, line: 86, column: 28)
!367 = !DILocation(line: 87, column: 10, scope: !366)
!368 = !DILocation(line: 88, column: 10, scope: !366)
!369 = !DILocation(line: 91, column: 6, scope: !370)
!370 = distinct !DILexicalBlock(scope: !259, file: !2, line: 91, column: 6)
!371 = !DILocation(line: 91, column: 6, scope: !259)
!372 = !DILocation(line: 91, column: 6, scope: !373)
!373 = distinct !DILexicalBlock(scope: !370, file: !2, line: 91, column: 6)
!374 = !DILocation(line: 91, column: 6, scope: !375)
!375 = distinct !DILexicalBlock(scope: !376, file: !2, line: 91, column: 6)
!376 = distinct !DILexicalBlock(scope: !373, file: !2, line: 91, column: 6)
!377 = !DILocation(line: 91, column: 6, scope: !376)
!378 = !DILocation(line: 92, column: 6, scope: !379)
!379 = distinct !DILexicalBlock(scope: !259, file: !2, line: 92, column: 6)
!380 = !DILocation(line: 92, column: 6, scope: !259)
!381 = !DILocation(line: 92, column: 6, scope: !382)
!382 = distinct !DILexicalBlock(scope: !379, file: !2, line: 92, column: 6)
!383 = !DILocation(line: 92, column: 6, scope: !384)
!384 = distinct !DILexicalBlock(scope: !385, file: !2, line: 92, column: 6)
!385 = distinct !DILexicalBlock(scope: !382, file: !2, line: 92, column: 6)
!386 = !DILocation(line: 92, column: 6, scope: !385)
!387 = !DILocation(line: 93, column: 6, scope: !388)
!388 = distinct !DILexicalBlock(scope: !259, file: !2, line: 93, column: 6)
!389 = !{!390, !219, i64 48}
!390 = !{!"stat", !219, i64 0, !219, i64 8, !219, i64 16, !223, i64 24, !223, i64 28, !223, i64 32, !223, i64 36, !219, i64 40, !219, i64 48, !219, i64 56, !219, i64 64, !391, i64 72, !391, i64 88, !391, i64 104, !220, i64 120}
!391 = !{!"timespec", !219, i64 0, !219, i64 8}
!392 = !DILocation(line: 93, column: 6, scope: !259)
!393 = !DILocation(line: 93, column: 6, scope: !394)
!394 = distinct !DILexicalBlock(scope: !388, file: !2, line: 93, column: 6)
!395 = !DILocation(line: 93, column: 6, scope: !396)
!396 = distinct !DILexicalBlock(scope: !397, file: !2, line: 93, column: 6)
!397 = distinct !DILexicalBlock(scope: !394, file: !2, line: 93, column: 6)
!398 = !DILocation(line: 93, column: 6, scope: !397)
!399 = !DILocation(line: 96, column: 6, scope: !259)
!400 = !DILocation(line: 97, column: 6, scope: !259)
!401 = !DILocation(line: 99, column: 6, scope: !259)
!402 = !DILocation(line: 102, column: 45, scope: !259)
!403 = !DILocation(line: 104, column: 20, scope: !259)
!404 = !DILocation(line: 104, column: 18, scope: !259)
!405 = !DILocation(line: 105, column: 30, scope: !259)
!406 = !DILocation(line: 107, column: 20, scope: !407)
!407 = distinct !DILexicalBlock(scope: !408, file: !2, line: 107, column: 6)
!408 = distinct !DILexicalBlock(scope: !259, file: !2, line: 107, column: 6)
!409 = !DILocation(line: 107, column: 6, scope: !408)
!410 = !DILocation(line: 119, column: 20, scope: !332)
!411 = !DILocation(line: 119, column: 6, scope: !333)
!412 = !DILocation(line: 108, column: 41, scope: !413)
!413 = distinct !DILexicalBlock(scope: !407, file: !2, line: 107, column: 40)
!414 = !DILocation(line: 108, column: 32, scope: !413)
!415 = !DILocation(line: 108, column: 10, scope: !413)
!416 = !DILocation(line: 108, column: 22, scope: !413)
!417 = !DILocation(line: 108, column: 29, scope: !413)
!418 = !DILocation(line: 109, column: 22, scope: !413)
!419 = !DILocation(line: 110, column: 16, scope: !420)
!420 = distinct !DILexicalBlock(scope: !413, file: !2, line: 110, column: 14)
!421 = !DILocation(line: 110, column: 14, scope: !413)
!422 = !DILocation(line: 0, scope: !413)
!423 = !DILocation(line: 114, column: 10, scope: !424)
!424 = distinct !DILexicalBlock(scope: !413, file: !2, line: 114, column: 10)
!425 = !DILocation(line: 114, column: 10, scope: !413)
!426 = !DILocation(line: 114, column: 10, scope: !427)
!427 = distinct !DILexicalBlock(scope: !424, file: !2, line: 114, column: 10)
!428 = !DILocation(line: 114, column: 10, scope: !429)
!429 = distinct !DILexicalBlock(scope: !430, file: !2, line: 114, column: 10)
!430 = distinct !DILexicalBlock(scope: !427, file: !2, line: 114, column: 10)
!431 = !DILocation(line: 114, column: 10, scope: !430)
!432 = !DILocation(line: 107, column: 36, scope: !407)
!433 = distinct !{!433, !409, !434, !256, !257}
!434 = !DILocation(line: 115, column: 6, scope: !408)
!435 = !DILocation(line: 120, column: 10, scope: !331)
!436 = !DILocation(line: 121, column: 10, scope: !437)
!437 = distinct !DILexicalBlock(scope: !331, file: !2, line: 121, column: 10)
!438 = !{!218, !219, i64 0}
!439 = !DILocation(line: 121, column: 10, scope: !331)
!440 = !DILocation(line: 121, column: 10, scope: !441)
!441 = distinct !DILexicalBlock(scope: !437, file: !2, line: 121, column: 10)
!442 = !DILocation(line: 121, column: 10, scope: !443)
!443 = distinct !DILexicalBlock(scope: !444, file: !2, line: 121, column: 10)
!444 = distinct !DILexicalBlock(scope: !441, file: !2, line: 121, column: 10)
!445 = !DILocation(line: 121, column: 10, scope: !444)
!446 = !DILocation(line: 122, column: 10, scope: !447)
!447 = distinct !DILexicalBlock(scope: !331, file: !2, line: 122, column: 10)
!448 = !{!223, !223, i64 0}
!449 = !DILocation(line: 122, column: 10, scope: !331)
!450 = !DILocation(line: 122, column: 10, scope: !451)
!451 = distinct !DILexicalBlock(scope: !447, file: !2, line: 122, column: 10)
!452 = !DILocation(line: 122, column: 10, scope: !453)
!453 = distinct !DILexicalBlock(scope: !454, file: !2, line: 122, column: 10)
!454 = distinct !DILexicalBlock(scope: !451, file: !2, line: 122, column: 10)
!455 = !DILocation(line: 122, column: 10, scope: !454)
!456 = !DILocation(line: 124, column: 32, scope: !331)
!457 = !DILocation(line: 124, column: 17, scope: !331)
!458 = !DILocation(line: 125, column: 32, scope: !331)
!459 = !DILocation(line: 125, column: 17, scope: !331)
!460 = !DILocation(line: 126, column: 32, scope: !331)
!461 = !DILocation(line: 126, column: 17, scope: !331)
!462 = !DILocation(line: 127, column: 32, scope: !331)
!463 = !DILocation(line: 127, column: 17, scope: !331)
!464 = !DILocation(line: 128, column: 32, scope: !331)
!465 = !DILocation(line: 128, column: 17, scope: !331)
!466 = !DILocation(line: 129, column: 6, scope: !332)
!467 = !DILocation(line: 119, column: 36, scope: !332)
!468 = distinct !{!468, !411, !469, !256, !257}
!469 = !DILocation(line: 129, column: 6, scope: !333)
!470 = !DILocation(line: 131, column: 6, scope: !259)
!471 = !DILocation(line: 134, column: 18, scope: !259)
!472 = !DILocation(line: 135, column: 18, scope: !259)
!473 = !DILocation(line: 136, column: 19, scope: !259)
!474 = !DILocation(line: 137, column: 19, scope: !259)
!475 = !DILocation(line: 138, column: 19, scope: !259)
!476 = !DILocation(line: 140, column: 19, scope: !259)
!477 = !DILocation(line: 140, column: 27, scope: !259)
!478 = !DILocation(line: 140, column: 49, scope: !259)
!479 = !DILocation(line: 140, column: 38, scope: !259)
!480 = !DILocation(line: 141, column: 17, scope: !259)
!481 = !DILocation(line: 141, column: 30, scope: !259)
!482 = !DILocation(line: 142, column: 27, scope: !259)
!483 = !DILocation(line: 143, column: 27, scope: !259)
!484 = !DILocation(line: 144, column: 39, scope: !259)
!485 = !DILocation(line: 144, column: 95, scope: !259)
!486 = !DILocation(line: 144, column: 84, scope: !259)
!487 = !DILocation(line: 144, column: 61, scope: !259)
!488 = !DILocation(line: 146, column: 6, scope: !259)
!489 = !DILocation(line: 147, column: 6, scope: !259)
!490 = !DILocation(line: 148, column: 6, scope: !259)
!491 = !DILocation(line: 149, column: 6, scope: !259)
!492 = !DILocation(line: 150, column: 6, scope: !259)
!493 = !DILocation(line: 151, column: 6, scope: !259)
!494 = !DILocation(line: 152, column: 6, scope: !259)
!495 = !DILocation(line: 153, column: 6, scope: !259)
!496 = !DILocation(line: 154, column: 6, scope: !259)
!497 = !DILocation(line: 155, column: 6, scope: !259)
!498 = !DILocation(line: 156, column: 6, scope: !259)
!499 = !DILocation(line: 158, column: 6, scope: !500)
!500 = distinct !DILexicalBlock(scope: !259, file: !2, line: 158, column: 6)
!501 = !DILocation(line: 158, column: 6, scope: !259)
!502 = !DILocation(line: 158, column: 6, scope: !503)
!503 = distinct !DILexicalBlock(scope: !500, file: !2, line: 158, column: 6)
!504 = !DILocation(line: 158, column: 6, scope: !505)
!505 = distinct !DILexicalBlock(scope: !506, file: !2, line: 158, column: 6)
!506 = distinct !DILexicalBlock(scope: !503, file: !2, line: 158, column: 6)
!507 = !DILocation(line: 158, column: 6, scope: !506)
!508 = !DILocation(line: 159, column: 6, scope: !509)
!509 = distinct !DILexicalBlock(scope: !259, file: !2, line: 159, column: 6)
!510 = !DILocation(line: 159, column: 6, scope: !259)
!511 = !DILocation(line: 159, column: 6, scope: !512)
!512 = distinct !DILexicalBlock(scope: !509, file: !2, line: 159, column: 6)
!513 = !DILocation(line: 159, column: 6, scope: !514)
!514 = distinct !DILexicalBlock(scope: !515, file: !2, line: 159, column: 6)
!515 = distinct !DILexicalBlock(scope: !512, file: !2, line: 159, column: 6)
!516 = !DILocation(line: 159, column: 6, scope: !515)
!517 = !DILocation(line: 160, column: 6, scope: !518)
!518 = distinct !DILexicalBlock(scope: !259, file: !2, line: 160, column: 6)
!519 = !DILocation(line: 160, column: 6, scope: !259)
!520 = !DILocation(line: 160, column: 6, scope: !521)
!521 = distinct !DILexicalBlock(scope: !518, file: !2, line: 160, column: 6)
!522 = !DILocation(line: 160, column: 6, scope: !523)
!523 = distinct !DILexicalBlock(scope: !524, file: !2, line: 160, column: 6)
!524 = distinct !DILexicalBlock(scope: !521, file: !2, line: 160, column: 6)
!525 = !DILocation(line: 160, column: 6, scope: !524)
!526 = !DILocation(line: 162, column: 2, scope: !259)
!527 = !DILocation(line: 161, column: 6, scope: !259)
!528 = !DISubprogram(name: "printf", scope: !529, file: !529, line: 356, type: !530, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!529 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "f31eefcc3f15835fc5a4023a625cf609")
!530 = !DISubroutineType(types: !531)
!531 = !{!180, !532, null}
!532 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !533)
!533 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!534 = !DISubprogram(name: "exit", scope: !535, file: !535, line: 624, type: !536, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!535 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "02258fad21adf111bb9df9825e61954a")
!536 = !DISubroutineType(types: !537)
!537 = !{null, !180}
!538 = !DISubprogram(name: "atoi", scope: !535, file: !535, line: 105, type: !539, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!539 = !DISubroutineType(types: !540)
!540 = !{!180, !533}
!541 = !DISubprogram(name: "open", scope: !542, file: !542, line: 181, type: !543, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!542 = !DIFile(filename: "/usr/include/fcntl.h", directory: "", checksumkind: CSK_MD5, checksum: "1a9bb91818c37dc7bc291ca6e49fc221")
!543 = !DISubroutineType(types: !544)
!544 = !{!180, !533, !180, null}
!545 = !DISubprogram(name: "perror", scope: !529, file: !529, line: 804, type: !546, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!546 = !DISubroutineType(types: !547)
!547 = !{null, !533}
!548 = !DISubprogram(name: "__assert_fail", scope: !549, file: !549, line: 69, type: !550, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!549 = !DIFile(filename: "/usr/include/assert.h", directory: "", checksumkind: CSK_MD5, checksum: "ab7dc6991d501750085448b20099a5a0")
!550 = !DISubroutineType(types: !551)
!551 = !{null, !533, !533, !159, !533}
!552 = !DISubprogram(name: "fstat", scope: !553, file: !553, line: 210, type: !554, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!553 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/stat.h", directory: "", checksumkind: CSK_MD5, checksum: "1e5cd132abb12ea0c79aeae3bfa4573e")
!554 = !DISubroutineType(types: !555)
!555 = !{!180, !180, !556}
!556 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !271, size: 64)
!557 = !DISubprogram(name: "mmap", scope: !558, file: !558, line: 57, type: !559, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!558 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/mman.h", directory: "", checksumkind: CSK_MD5, checksum: "93a87cc3b0558893646eb0c257165272")
!559 = !DISubroutineType(types: !560)
!560 = !{!187, !187, !561, !180, !180, !180, !290}
!561 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !562, line: 46, baseType: !171)
!562 = !DIFile(filename: "/usr/lib/llvm-17/lib/clang/17/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "d1776268f398bd1ca997c840ad581432")
!563 = !DISubprogram(name: "pthread_attr_init", scope: !158, file: !158, line: 285, type: !564, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!564 = !DISubroutineType(types: !565)
!565 = !{!180, !566}
!566 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !314, size: 64)
!567 = !DISubprogram(name: "pthread_attr_setscope", scope: !158, file: !158, line: 349, type: !568, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!568 = !DISubroutineType(types: !569)
!569 = !{!180, !566, !180}
!570 = distinct !DISubprogram(name: "CALLOC", scope: !143, file: !143, line: 56, type: !571, scopeLine: 57, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !155, retainedNodes: !573)
!571 = !DISubroutineType(cc: DW_CC_nocall, types: !572)
!572 = !{!187, !561, !561}
!573 = !{!574, !575, !576}
!574 = !DILocalVariable(name: "num", arg: 1, scope: !570, file: !143, line: 56, type: !561)
!575 = !DILocalVariable(name: "size", arg: 2, scope: !570, file: !143, line: 56, type: !561)
!576 = !DILocalVariable(name: "temp", scope: !570, file: !143, line: 58, type: !187)
!577 = !DILocation(line: 0, scope: !570)
!578 = !DILocation(line: 58, column: 18, scope: !570)
!579 = !DILocation(line: 59, column: 4, scope: !580)
!580 = distinct !DILexicalBlock(scope: !581, file: !143, line: 59, column: 4)
!581 = distinct !DILexicalBlock(scope: !570, file: !143, line: 59, column: 4)
!582 = !DILocation(line: 59, column: 4, scope: !581)
!583 = !DILocation(line: 60, column: 4, scope: !570)
!584 = !DISubprogram(name: "pthread_create", scope: !158, file: !158, line: 202, type: !585, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!585 = !DISubroutineType(types: !586)
!586 = !{!180, !587, !589, !592, !593}
!587 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !588)
!588 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !169, size: 64)
!589 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !590)
!590 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !591, size: 64)
!591 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !314)
!592 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !204, size: 64)
!593 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !187)
!594 = !DISubprogram(name: "pthread_join", scope: !158, file: !158, line: 219, type: !595, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!595 = !DISubroutineType(types: !596)
!596 = !{!180, !169, !188}
!597 = !DISubprogram(name: "free", scope: !535, file: !535, line: 555, type: !598, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!598 = !DISubroutineType(types: !599)
!599 = !{null, !187}
!600 = !DISubprogram(name: "pthread_attr_destroy", scope: !158, file: !158, line: 288, type: !564, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!601 = !DISubprogram(name: "munmap", scope: !558, file: !558, line: 76, type: !602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!602 = !DISubroutineType(types: !603)
!603 = !{!180, !187, !561}
!604 = !DISubprogram(name: "close", scope: !605, file: !605, line: 358, type: !606, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!605 = !DIFile(filename: "/usr/include/unistd.h", directory: "", checksumkind: CSK_MD5, checksum: "ed37c2e6f30ba31a8b41e4d70547c39c")
!606 = !DISubroutineType(types: !607)
!607 = !{!180, !180}
!608 = !DISubprogram(name: "calloc", scope: !535, file: !535, line: 543, type: !609, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!609 = !DISubroutineType(types: !572)

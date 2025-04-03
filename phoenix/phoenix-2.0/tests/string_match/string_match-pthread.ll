; ModuleID = 'string_match-pthread.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }
%struct.str_data_t = type { i32, i32, i64, ptr, ptr }
%struct.str_map_data_t = type { ptr, ptr, i32 }
%struct.map_args_t = type { i64, ptr }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [11 x i8] c"Helloworld\00", align 1
@key1 = dso_local local_unnamed_addr global ptr @.str, align 8
@.str.1 = private unnamed_addr constant [10 x i8] c"howareyou\00", align 1
@key2 = dso_local local_unnamed_addr global ptr @.str.1, align 8
@.str.2 = private unnamed_addr constant [8 x i8] c"ferrari\00", align 1
@key3 = dso_local local_unnamed_addr global ptr @.str.2, align 8
@.str.3 = private unnamed_addr constant [10 x i8] c"whotheman\00", align 1
@key4 = dso_local local_unnamed_addr global ptr @.str.3, align 8
@key1_final = dso_local local_unnamed_addr global ptr null, align 8
@key2_final = dso_local local_unnamed_addr global ptr null, align 8
@key3_final = dso_local local_unnamed_addr global ptr null, align 8
@key4_final = dso_local local_unnamed_addr global ptr null, align 8
@.str.4 = private unnamed_addr constant [8 x i8] c"data_in\00", align 1
@.str.5 = private unnamed_addr constant [23 x i8] c"string_match-pthread.c\00", align 1
@__PRETTY_FUNCTION__.string_match_splitter = private unnamed_addr constant [40 x i8] c"void string_match_splitter(void *, int)\00", align 1
@.str.6 = private unnamed_addr constant [100 x i8] c"Error at line\0A\09pthread_create(&tid[i], &attr, string_match_map, (void*)(&(out[i]))) != 0\0ASystem Msg\00", align 1
@.str.7 = private unnamed_addr constant [81 x i8] c"(pthread_create(&tid[i], &attr, string_match_map, (void*)(&(out[i]))) != 0) == 0\00", align 1
@.str.8 = private unnamed_addr constant [78 x i8] c"Error at line\0A\09pthread_join(tid[i], (void **)(void*)&ret_val) != 0\0ASystem Msg\00", align 1
@.str.9 = private unnamed_addr constant [59 x i8] c"(pthread_join(tid[i], (void **)(void*)&ret_val) != 0) == 0\00", align 1
@.str.10 = private unnamed_addr constant [39 x i8] c"Error at line\0A\09ret_val != 0\0ASystem Msg\00", align 1
@.str.11 = private unnamed_addr constant [20 x i8] c"(ret_val != 0) == 0\00", align 1
@.str.12 = private unnamed_addr constant [5 x i8] c"args\00", align 1
@__PRETTY_FUNCTION__.string_match_map = private unnamed_addr constant [31 x i8] c"void *string_match_map(void *)\00", align 1
@stdout = external local_unnamed_addr global ptr, align 8
@.str.13 = private unnamed_addr constant [19 x i8] c"FOUND: WORD IS %s\0A\00", align 1
@.str.14 = private unnamed_addr constant [41 x i8] c"USAGE: %s <keys filename> <num_threads>\0A\00", align 1
@.str.15 = private unnamed_addr constant [68 x i8] c"Error at line\0A\09(fd_keys = open(fname_keys,O_RDONLY)) < 0\0ASystem Msg\00", align 1
@.str.16 = private unnamed_addr constant [43 x i8] c"((fd_keys = open(fname_keys,00)) < 0) == 0\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@.str.17 = private unnamed_addr constant [58 x i8] c"Error at line\0A\09fstat(fd_keys, &finfo_keys) < 0\0ASystem Msg\00", align 1
@.str.18 = private unnamed_addr constant [39 x i8] c"(fstat(fd_keys, &finfo_keys) < 0) == 0\00", align 1
@.str.19 = private unnamed_addr constant [129 x i8] c"Error at line\0A\09(fdata_keys= mmap(0, finfo_keys.st_size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd_keys, 0)) == NULL\0ASystem Msg\00", align 1
@.str.20 = private unnamed_addr constant [96 x i8] c"((fdata_keys= mmap(0, finfo_keys.st_size + 1, 0x1 | 0x2, 0x02, fd_keys, 0)) == ((void*)0)) == 0\00", align 1
@.str.21 = private unnamed_addr constant [18 x i8] c"Keys Size is %ld\0A\00", align 1
@.str.22 = private unnamed_addr constant [61 x i8] c"String Match: Calling Parallel String Match with %d threads\0A\00", align 1
@.str.23 = private unnamed_addr constant [29 x i8] c"String Match: Completed %ld\0A\00", align 1
@.str.24 = private unnamed_addr constant [73 x i8] c"Error at line\0A\09munmap(fdata_keys, finfo_keys.st_size + 1) < 0\0ASystem Msg\00", align 1
@.str.25 = private unnamed_addr constant [54 x i8] c"(munmap(fdata_keys, finfo_keys.st_size + 1) < 0) == 0\00", align 1
@.str.26 = private unnamed_addr constant [45 x i8] c"Error at line\0A\09close(fd_keys) < 0\0ASystem Msg\00", align 1
@.str.27 = private unnamed_addr constant [26 x i8] c"(close(fd_keys) < 0) == 0\00", align 1
@.str.28 = private unnamed_addr constant [5 x i8] c"temp\00", align 1
@.str.29 = private unnamed_addr constant [27 x i8] c"../../include/stddefines.h\00", align 1
@__PRETTY_FUNCTION__.MALLOC = private unnamed_addr constant [21 x i8] c"void *MALLOC(size_t)\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local i32 @getnextline(ptr nocapture noundef writeonly %0, i32 noundef %1, ptr nocapture noundef readonly %2) local_unnamed_addr #0 {
  %4 = add i32 %1, -1
  %5 = icmp sgt i32 %1, 1
  br i1 %5, label %6, label %26

6:                                                ; preds = %3
  %7 = zext i32 %4 to i64
  br label %8

8:                                                ; preds = %6, %22
  %9 = phi i64 [ 0, %6 ], [ %24, %22 ]
  %10 = getelementptr inbounds i8, ptr %2, i64 %9
  %11 = load i8, ptr %10, align 1, !tbaa !5
  switch i8 %11, label %22 [
    i8 0, label %12
    i8 13, label %16
    i8 10, label %19
  ]

12:                                               ; preds = %8
  %13 = trunc i64 %9 to i32
  %14 = icmp eq i32 %13, 0
  %15 = select i1 %14, i32 -1, i32 %13
  br label %26

16:                                               ; preds = %8
  %17 = trunc i64 %9 to i32
  %18 = add nuw nsw i32 %17, 2
  br label %26

19:                                               ; preds = %8
  %20 = trunc i64 %9 to i32
  %21 = add nuw nsw i32 %20, 1
  br label %26

22:                                               ; preds = %8
  %23 = getelementptr inbounds i8, ptr %0, i64 %9
  store i8 %11, ptr %23, align 1, !tbaa !5
  %24 = add nuw nsw i64 %9, 1
  %25 = icmp eq i64 %24, %7
  br i1 %25, label %26, label %8, !llvm.loop !8

26:                                               ; preds = %22, %3, %19, %16, %12
  %27 = phi i32 [ %15, %12 ], [ %18, %16 ], [ %21, %19 ], [ 0, %3 ], [ %4, %22 ]
  ret i32 %27
}

; Function Attrs: nofree nounwind memory(argmem: readwrite) uwtable
define dso_local void @compute_hashes(ptr nocapture noundef readonly %0, ptr nocapture noundef writeonly %1) local_unnamed_addr #1 {
  %3 = load i8, ptr %0, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %14, label %5

5:                                                ; preds = %2, %5
  %6 = phi i64 [ %11, %5 ], [ 0, %2 ]
  %7 = getelementptr inbounds i8, ptr %0, i64 %6
  %8 = load i8, ptr %7, align 1, !tbaa !5
  %9 = add i8 %8, 5
  %10 = getelementptr inbounds i8, ptr %1, i64 %6
  store i8 %9, ptr %10, align 1, !tbaa !5
  %11 = add nuw nsw i64 %6, 1
  %12 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %0) #16
  %13 = icmp ugt i64 %12, %11
  br i1 %13, label %5, label %14, !llvm.loop !10

14:                                               ; preds = %5, %2
  %15 = phi i64 [ 0, %2 ], [ %11, %5 ]
  %16 = getelementptr inbounds i8, ptr %1, i64 %15
  store i8 0, ptr %16, align 1, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare i64 @strlen(ptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @string_match_splitter(ptr noundef %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = alloca %union.pthread_attr_t, align 8
  %4 = alloca i32, align 4
  %5 = load ptr, ptr @key1, align 8, !tbaa !11
  %6 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %5) #16
  %7 = add i64 %6, 1
  %8 = tail call noalias ptr @malloc(i64 noundef %7) #17
  store ptr %8, ptr @key1_final, align 8, !tbaa !11
  %9 = load ptr, ptr @key2, align 8, !tbaa !11
  %10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %9) #16
  %11 = add i64 %10, 1
  %12 = tail call noalias ptr @malloc(i64 noundef %11) #17
  store ptr %12, ptr @key2_final, align 8, !tbaa !11
  %13 = load ptr, ptr @key3, align 8, !tbaa !11
  %14 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %13) #16
  %15 = add i64 %14, 1
  %16 = tail call noalias ptr @malloc(i64 noundef %15) #17
  store ptr %16, ptr @key3_final, align 8, !tbaa !11
  %17 = load ptr, ptr @key4, align 8, !tbaa !11
  %18 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %17) #16
  %19 = add i64 %18, 1
  %20 = tail call noalias ptr @malloc(i64 noundef %19) #17
  store ptr %20, ptr @key4_final, align 8, !tbaa !11
  %21 = load i8, ptr %5, align 1
  %22 = icmp eq i8 %21, 0
  br i1 %22, label %32, label %23

23:                                               ; preds = %2, %23
  %24 = phi i64 [ %29, %23 ], [ 0, %2 ]
  %25 = getelementptr inbounds i8, ptr %5, i64 %24
  %26 = load i8, ptr %25, align 1, !tbaa !5
  %27 = add i8 %26, 5
  %28 = getelementptr inbounds i8, ptr %8, i64 %24
  store i8 %27, ptr %28, align 1, !tbaa !5
  %29 = add nuw nsw i64 %24, 1
  %30 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %5) #16
  %31 = icmp ugt i64 %30, %29
  br i1 %31, label %23, label %32, !llvm.loop !10

32:                                               ; preds = %23, %2
  %33 = phi i64 [ 0, %2 ], [ %29, %23 ]
  %34 = getelementptr inbounds i8, ptr %8, i64 %33
  store i8 0, ptr %34, align 1, !tbaa !5
  %35 = load i8, ptr %9, align 1
  %36 = icmp eq i8 %35, 0
  br i1 %36, label %46, label %37

37:                                               ; preds = %32, %37
  %38 = phi i64 [ %43, %37 ], [ 0, %32 ]
  %39 = getelementptr inbounds i8, ptr %9, i64 %38
  %40 = load i8, ptr %39, align 1, !tbaa !5
  %41 = add i8 %40, 5
  %42 = getelementptr inbounds i8, ptr %12, i64 %38
  store i8 %41, ptr %42, align 1, !tbaa !5
  %43 = add nuw nsw i64 %38, 1
  %44 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %9) #16
  %45 = icmp ugt i64 %44, %43
  br i1 %45, label %37, label %46, !llvm.loop !10

46:                                               ; preds = %37, %32
  %47 = phi i64 [ 0, %32 ], [ %43, %37 ]
  %48 = getelementptr inbounds i8, ptr %12, i64 %47
  store i8 0, ptr %48, align 1, !tbaa !5
  %49 = load i8, ptr %13, align 1
  %50 = icmp eq i8 %49, 0
  br i1 %50, label %60, label %51

51:                                               ; preds = %46, %51
  %52 = phi i64 [ %57, %51 ], [ 0, %46 ]
  %53 = getelementptr inbounds i8, ptr %13, i64 %52
  %54 = load i8, ptr %53, align 1, !tbaa !5
  %55 = add i8 %54, 5
  %56 = getelementptr inbounds i8, ptr %16, i64 %52
  store i8 %55, ptr %56, align 1, !tbaa !5
  %57 = add nuw nsw i64 %52, 1
  %58 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %13) #16
  %59 = icmp ugt i64 %58, %57
  br i1 %59, label %51, label %60, !llvm.loop !10

60:                                               ; preds = %51, %46
  %61 = phi i64 [ 0, %46 ], [ %57, %51 ]
  %62 = getelementptr inbounds i8, ptr %16, i64 %61
  store i8 0, ptr %62, align 1, !tbaa !5
  %63 = load i8, ptr %17, align 1
  %64 = icmp eq i8 %63, 0
  br i1 %64, label %74, label %65

65:                                               ; preds = %60, %65
  %66 = phi i64 [ %71, %65 ], [ 0, %60 ]
  %67 = getelementptr inbounds i8, ptr %17, i64 %66
  %68 = load i8, ptr %67, align 1, !tbaa !5
  %69 = add i8 %68, 5
  %70 = getelementptr inbounds i8, ptr %20, i64 %66
  store i8 %69, ptr %70, align 1, !tbaa !5
  %71 = add nuw nsw i64 %66, 1
  %72 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %17) #16
  %73 = icmp ugt i64 %72, %71
  br i1 %73, label %65, label %74, !llvm.loop !10

74:                                               ; preds = %65, %60
  %75 = phi i64 [ 0, %60 ], [ %71, %65 ]
  %76 = getelementptr inbounds i8, ptr %20, i64 %75
  store i8 0, ptr %76, align 1, !tbaa !5
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %3) #18
  %77 = icmp eq ptr %0, null
  br i1 %77, label %78, label %79

78:                                               ; preds = %74
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.5, i32 noundef 98, ptr noundef nonnull @__PRETTY_FUNCTION__.string_match_splitter) #19
  unreachable

79:                                               ; preds = %74
  %80 = sext i32 %1 to i64
  %81 = shl nsw i64 %80, 3
  %82 = tail call noalias ptr @malloc(i64 noundef %81) #17
  %83 = icmp eq ptr %82, null
  br i1 %83, label %84, label %85

84:                                               ; preds = %79
  tail call void @__assert_fail(ptr noundef nonnull @.str.28, ptr noundef nonnull @.str.29, i32 noundef 52, ptr noundef nonnull @__PRETTY_FUNCTION__.MALLOC) #19
  unreachable

85:                                               ; preds = %79
  %86 = call i32 @pthread_attr_init(ptr noundef nonnull %3) #18
  %87 = call i32 @pthread_attr_setscope(ptr noundef nonnull %3, i32 noundef 0) #18
  %88 = load i32, ptr %0, align 8, !tbaa !13
  %89 = sdiv i32 %88, %1
  %90 = mul nsw i64 %80, 24
  %91 = call noalias ptr @malloc(i64 noundef %90) #17
  %92 = shl nsw i64 %80, 4
  %93 = call noalias ptr @malloc(i64 noundef %92) #17
  %94 = icmp sgt i32 %1, 0
  br i1 %94, label %95, label %180

95:                                               ; preds = %85
  %96 = getelementptr inbounds %struct.str_data_t, ptr %0, i64 0, i32 4
  %97 = getelementptr inbounds %struct.str_data_t, ptr %0, i64 0, i32 3
  %98 = getelementptr inbounds %struct.str_data_t, ptr %0, i64 0, i32 2
  %99 = zext i32 %1 to i64
  br label %103

100:                                              ; preds = %156
  br i1 %94, label %101, label %180

101:                                              ; preds = %100
  %102 = zext i32 %1 to i64
  br label %159

103:                                              ; preds = %95, %156
  %104 = phi i64 [ 0, %95 ], [ %157, %156 ]
  %105 = load ptr, ptr %96, align 8, !tbaa !17
  %106 = getelementptr inbounds %struct.str_map_data_t, ptr %91, i64 %104
  %107 = getelementptr inbounds %struct.str_map_data_t, ptr %91, i64 %104, i32 1
  store ptr %105, ptr %107, align 8, !tbaa !18
  %108 = load ptr, ptr %97, align 8, !tbaa !20
  %109 = load i64, ptr %98, align 8, !tbaa !21
  %110 = getelementptr inbounds i8, ptr %108, i64 %109
  store ptr %110, ptr %106, align 8, !tbaa !22
  %111 = getelementptr inbounds %struct.str_map_data_t, ptr %91, i64 %104, i32 2
  %112 = trunc i64 %104 to i32
  store i32 %112, ptr %111, align 8, !tbaa !23
  %113 = load i32, ptr %0, align 8, !tbaa !13
  %114 = trunc i64 %109 to i32
  %115 = sub i32 %113, %114
  %116 = call i32 @llvm.smax.i32(i32 %115, i32 0)
  %117 = call i32 @llvm.smin.i32(i32 %89, i32 %116)
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds %struct.map_args_t, ptr %93, i64 %104
  store i64 %118, ptr %119, align 8, !tbaa !24
  %120 = getelementptr inbounds %struct.map_args_t, ptr %93, i64 %104, i32 1
  store ptr %106, ptr %120, align 8, !tbaa !26
  %121 = getelementptr inbounds i8, ptr %110, i64 %118
  %122 = add i32 %117, %114
  %123 = icmp sgt i32 %122, %113
  br i1 %123, label %134, label %124

124:                                              ; preds = %103
  %125 = add i32 %113, 1
  br label %126

126:                                              ; preds = %124, %130
  %127 = phi i32 [ %131, %130 ], [ %122, %124 ]
  %128 = phi ptr [ %132, %130 ], [ %121, %124 ]
  %129 = load i8, ptr %128, align 1, !tbaa !5
  switch i8 %129, label %130 [
    i8 10, label %138
    i8 13, label %138
    i8 0, label %138
  ]

130:                                              ; preds = %126
  %131 = add i32 %127, 1
  %132 = getelementptr inbounds i8, ptr %128, i64 1
  %133 = icmp eq i32 %127, %113
  br i1 %133, label %134, label %126, !llvm.loop !27

134:                                              ; preds = %130, %103
  %135 = phi ptr [ %121, %103 ], [ %132, %130 ]
  %136 = phi i32 [ %122, %103 ], [ %125, %130 ]
  %137 = load i8, ptr %135, align 1, !tbaa !5
  br label %138

138:                                              ; preds = %126, %126, %126, %134
  %139 = phi i32 [ %136, %134 ], [ %127, %126 ], [ %127, %126 ], [ %127, %126 ]
  %140 = phi i8 [ %137, %134 ], [ %129, %126 ], [ %129, %126 ], [ %129, %126 ]
  switch i8 %140, label %145 [
    i8 13, label %141
    i8 10, label %143
  ]

141:                                              ; preds = %138
  %142 = add nsw i32 %139, 2
  br label %145

143:                                              ; preds = %138
  %144 = add nsw i32 %139, 1
  br label %145

145:                                              ; preds = %138, %143, %141
  %146 = phi i32 [ %142, %141 ], [ %144, %143 ], [ %139, %138 ]
  %147 = sext i32 %146 to i64
  %148 = sub nsw i64 %147, %109
  store i64 %148, ptr %119, align 8, !tbaa !24
  store i64 %147, ptr %98, align 8, !tbaa !21
  %149 = getelementptr inbounds i64, ptr %82, i64 %104
  %150 = call i32 @pthread_create(ptr noundef nonnull %149, ptr noundef nonnull %3, ptr noundef nonnull @string_match_map, ptr noundef nonnull %119) #18
  %151 = icmp eq i32 %150, 0
  br i1 %151, label %156, label %152

152:                                              ; preds = %145
  call void @perror(ptr noundef nonnull @.str.6) #20
  %153 = call i32 @pthread_create(ptr noundef nonnull %149, ptr noundef nonnull %3, ptr noundef nonnull @string_match_map, ptr noundef nonnull %119) #18
  %154 = icmp eq i32 %153, 0
  br i1 %154, label %156, label %155

155:                                              ; preds = %152
  call void @__assert_fail(ptr noundef nonnull @.str.7, ptr noundef nonnull @.str.5, i32 noundef 137, ptr noundef nonnull @__PRETTY_FUNCTION__.string_match_splitter) #19
  unreachable

156:                                              ; preds = %152, %145
  %157 = add nuw nsw i64 %104, 1
  %158 = icmp eq i64 %157, %99
  br i1 %158, label %100, label %103, !llvm.loop !28

159:                                              ; preds = %101, %177
  %160 = phi i64 [ 0, %101 ], [ %178, %177 ]
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #18
  %161 = getelementptr inbounds i64, ptr %82, i64 %160
  %162 = load i64, ptr %161, align 8, !tbaa !29
  %163 = call i32 @pthread_join(i64 noundef %162, ptr noundef nonnull %4) #18
  %164 = icmp eq i32 %163, 0
  br i1 %164, label %170, label %165

165:                                              ; preds = %159
  call void @perror(ptr noundef nonnull @.str.8) #20
  %166 = load i64, ptr %161, align 8, !tbaa !29
  %167 = call i32 @pthread_join(i64 noundef %166, ptr noundef nonnull %4) #18
  %168 = icmp eq i32 %167, 0
  br i1 %168, label %170, label %169

169:                                              ; preds = %165
  call void @__assert_fail(ptr noundef nonnull @.str.9, ptr noundef nonnull @.str.5, i32 noundef 142, ptr noundef nonnull @__PRETTY_FUNCTION__.string_match_splitter) #19
  unreachable

170:                                              ; preds = %165, %159
  %171 = load i32, ptr %4, align 4, !tbaa !30
  %172 = icmp eq i32 %171, 0
  br i1 %172, label %177, label %173

173:                                              ; preds = %170
  call void @perror(ptr noundef nonnull @.str.10) #20
  %174 = load i32, ptr %4, align 4, !tbaa !30
  %175 = icmp eq i32 %174, 0
  br i1 %175, label %177, label %176

176:                                              ; preds = %173
  call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.5, i32 noundef 143, ptr noundef nonnull @__PRETTY_FUNCTION__.string_match_splitter) #19
  unreachable

177:                                              ; preds = %173, %170
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #18
  %178 = add nuw nsw i64 %160, 1
  %179 = icmp eq i64 %178, %102
  br i1 %179, label %180, label %159, !llvm.loop !31

180:                                              ; preds = %177, %85, %100
  %181 = call i32 @pthread_attr_destroy(ptr noundef nonnull %3) #18
  call void @free(ptr noundef %82) #18
  %182 = load ptr, ptr @key1_final, align 8, !tbaa !11
  call void @free(ptr noundef %182) #18
  %183 = load ptr, ptr @key2_final, align 8, !tbaa !11
  call void @free(ptr noundef %183) #18
  %184 = load ptr, ptr @key3_final, align 8, !tbaa !11
  call void @free(ptr noundef %184) #18
  %185 = load ptr, ptr @key4_final, align 8, !tbaa !11
  call void @free(ptr noundef %185) #18
  call void @free(ptr noundef %93) #18
  call void @free(ptr noundef %91) #18
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %3) #18
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #6

; Function Attrs: nounwind
declare i32 @pthread_attr_init(ptr noundef) local_unnamed_addr #7

; Function Attrs: nounwind
declare i32 @pthread_attr_setscope(ptr noundef, i32 noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #8

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @string_match_map(ptr noundef readonly %0) #3 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %3, label %4

3:                                                ; preds = %1
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.5, i32 noundef 157, ptr noundef nonnull @__PRETTY_FUNCTION__.string_match_map) #19
  unreachable

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.map_args_t, ptr %0, i64 0, i32 1
  %6 = load ptr, ptr %5, align 8, !tbaa !26
  %7 = load ptr, ptr %6, align 8, !tbaa !22
  %8 = tail call dereferenceable_or_null(1024) ptr @calloc(i64 1, i64 1024)
  %9 = tail call dereferenceable_or_null(1024) ptr @calloc(i64 1, i64 1024)
  %10 = load i64, ptr %0, align 8, !tbaa !24
  %11 = icmp sgt i64 %10, 0
  br i1 %11, label %12, label %137

12:                                               ; preds = %4, %130
  %13 = phi i32 [ %133, %130 ], [ 0, %4 ]
  %14 = phi ptr [ %132, %130 ], [ %7, %4 ]
  br label %15

15:                                               ; preds = %41, %12
  %16 = phi i64 [ 0, %12 ], [ %43, %41 ]
  %17 = getelementptr inbounds i8, ptr %14, i64 %16
  %18 = load i8, ptr %17, align 1, !tbaa !5
  switch i8 %18, label %31 [
    i8 0, label %19
    i8 13, label %23
    i8 10, label %27
  ]

19:                                               ; preds = %36, %31, %15
  %20 = phi i64 [ %16, %15 ], [ %33, %31 ], [ %38, %36 ]
  %21 = trunc i64 %20 to i32
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %137, label %45

23:                                               ; preds = %36, %31, %15
  %24 = phi i64 [ %16, %15 ], [ %33, %31 ], [ %38, %36 ]
  %25 = trunc i64 %24 to i32
  %26 = add nuw nsw i32 %25, 2
  br label %45

27:                                               ; preds = %36, %31, %15
  %28 = phi i64 [ %16, %15 ], [ %33, %31 ], [ %38, %36 ]
  %29 = trunc i64 %28 to i32
  %30 = add nuw nsw i32 %29, 1
  br label %45

31:                                               ; preds = %15
  %32 = getelementptr inbounds i8, ptr %8, i64 %16
  store i8 %18, ptr %32, align 1, !tbaa !5
  %33 = add nuw nsw i64 %16, 1
  %34 = getelementptr inbounds i8, ptr %14, i64 %33
  %35 = load i8, ptr %34, align 1, !tbaa !5
  switch i8 %35, label %36 [
    i8 0, label %19
    i8 13, label %23
    i8 10, label %27
  ]

36:                                               ; preds = %31
  %37 = getelementptr inbounds i8, ptr %8, i64 %33
  store i8 %35, ptr %37, align 1, !tbaa !5
  %38 = add nuw nsw i64 %16, 2
  %39 = getelementptr inbounds i8, ptr %14, i64 %38
  %40 = load i8, ptr %39, align 1, !tbaa !5
  switch i8 %40, label %41 [
    i8 0, label %19
    i8 13, label %23
    i8 10, label %27
  ]

41:                                               ; preds = %36
  %42 = getelementptr inbounds i8, ptr %8, i64 %38
  store i8 %40, ptr %42, align 1, !tbaa !5
  %43 = add nuw nsw i64 %16, 3
  %44 = icmp eq i64 %43, 1023
  br i1 %44, label %48, label %15, !llvm.loop !8

45:                                               ; preds = %19, %23, %27
  %46 = phi i32 [ %21, %19 ], [ %26, %23 ], [ %30, %27 ]
  %47 = icmp sgt i32 %46, -1
  br i1 %47, label %48, label %137

48:                                               ; preds = %41, %45
  %49 = phi i32 [ %46, %45 ], [ 1023, %41 ]
  %50 = load i8, ptr %8, align 1
  %51 = icmp eq i8 %50, 0
  br i1 %51, label %100, label %52

52:                                               ; preds = %48
  %53 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %8) #16
  %54 = tail call i64 @llvm.umax.i64(i64 %53, i64 1)
  %55 = icmp ult i64 %54, 8
  br i1 %55, label %90, label %56

56:                                               ; preds = %52
  %57 = icmp ult i64 %54, 32
  br i1 %57, label %77, label %58

58:                                               ; preds = %56
  %59 = and i64 %54, -32
  br label %60

60:                                               ; preds = %60, %58
  %61 = phi i64 [ 0, %58 ], [ %70, %60 ]
  %62 = getelementptr inbounds i8, ptr %8, i64 %61
  %63 = load <16 x i8>, ptr %62, align 1, !tbaa !5
  %64 = getelementptr inbounds i8, ptr %62, i64 16
  %65 = load <16 x i8>, ptr %64, align 1, !tbaa !5
  %66 = add <16 x i8> %63, <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>
  %67 = add <16 x i8> %65, <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>
  %68 = getelementptr inbounds i8, ptr %9, i64 %61
  store <16 x i8> %66, ptr %68, align 1, !tbaa !5
  %69 = getelementptr inbounds i8, ptr %68, i64 16
  store <16 x i8> %67, ptr %69, align 1, !tbaa !5
  %70 = add nuw i64 %61, 32
  %71 = icmp eq i64 %70, %59
  br i1 %71, label %72, label %60, !llvm.loop !32

72:                                               ; preds = %60
  %73 = icmp eq i64 %54, %59
  br i1 %73, label %100, label %74

74:                                               ; preds = %72
  %75 = and i64 %54, 24
  %76 = icmp eq i64 %75, 0
  br i1 %76, label %90, label %77

77:                                               ; preds = %56, %74
  %78 = phi i64 [ %59, %74 ], [ 0, %56 ]
  %79 = and i64 %54, -8
  br label %80

80:                                               ; preds = %80, %77
  %81 = phi i64 [ %78, %77 ], [ %86, %80 ]
  %82 = getelementptr inbounds i8, ptr %8, i64 %81
  %83 = load <8 x i8>, ptr %82, align 1, !tbaa !5
  %84 = add <8 x i8> %83, <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>
  %85 = getelementptr inbounds i8, ptr %9, i64 %81
  store <8 x i8> %84, ptr %85, align 1, !tbaa !5
  %86 = add nuw i64 %81, 8
  %87 = icmp eq i64 %86, %79
  br i1 %87, label %88, label %80, !llvm.loop !35

88:                                               ; preds = %80
  %89 = icmp eq i64 %54, %79
  br i1 %89, label %100, label %90

90:                                               ; preds = %52, %74, %88
  %91 = phi i64 [ 0, %52 ], [ %59, %74 ], [ %79, %88 ]
  br label %92

92:                                               ; preds = %90, %92
  %93 = phi i64 [ %98, %92 ], [ %91, %90 ]
  %94 = getelementptr inbounds i8, ptr %8, i64 %93
  %95 = load i8, ptr %94, align 1, !tbaa !5
  %96 = add i8 %95, 5
  %97 = getelementptr inbounds i8, ptr %9, i64 %93
  store i8 %96, ptr %97, align 1, !tbaa !5
  %98 = add nuw nsw i64 %93, 1
  %99 = icmp eq i64 %98, %54
  br i1 %99, label %100, label %92, !llvm.loop !36

100:                                              ; preds = %92, %72, %88, %48
  %101 = phi i64 [ 0, %48 ], [ %54, %88 ], [ %54, %72 ], [ %54, %92 ]
  %102 = getelementptr inbounds i8, ptr %9, i64 %101
  store i8 0, ptr %102, align 1, !tbaa !5
  %103 = load ptr, ptr @key1_final, align 8, !tbaa !11
  %104 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %103, ptr noundef nonnull dereferenceable(1) %9) #16
  %105 = icmp eq i32 %104, 0
  br i1 %105, label %106, label %109

106:                                              ; preds = %100
  %107 = load ptr, ptr @stdout, align 8, !tbaa !11
  %108 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %107, ptr noundef nonnull @.str.13, ptr noundef nonnull %8)
  br label %109

109:                                              ; preds = %106, %100
  %110 = load ptr, ptr @key2_final, align 8, !tbaa !11
  %111 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %110, ptr noundef nonnull dereferenceable(1) %9) #16
  %112 = icmp eq i32 %111, 0
  br i1 %112, label %113, label %116

113:                                              ; preds = %109
  %114 = load ptr, ptr @stdout, align 8, !tbaa !11
  %115 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %114, ptr noundef nonnull @.str.13, ptr noundef nonnull %8)
  br label %116

116:                                              ; preds = %113, %109
  %117 = load ptr, ptr @key3_final, align 8, !tbaa !11
  %118 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %117, ptr noundef nonnull dereferenceable(1) %9) #16
  %119 = icmp eq i32 %118, 0
  br i1 %119, label %120, label %123

120:                                              ; preds = %116
  %121 = load ptr, ptr @stdout, align 8, !tbaa !11
  %122 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %121, ptr noundef nonnull @.str.13, ptr noundef nonnull %8)
  br label %123

123:                                              ; preds = %120, %116
  %124 = load ptr, ptr @key4_final, align 8, !tbaa !11
  %125 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %124, ptr noundef nonnull dereferenceable(1) %9) #16
  %126 = icmp eq i32 %125, 0
  br i1 %126, label %127, label %130

127:                                              ; preds = %123
  %128 = load ptr, ptr @stdout, align 8, !tbaa !11
  %129 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %128, ptr noundef nonnull @.str.13, ptr noundef nonnull %8)
  br label %130

130:                                              ; preds = %127, %123
  %131 = zext i32 %49 to i64
  %132 = getelementptr inbounds i8, ptr %14, i64 %131
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1024) %8, i8 0, i64 1024, i1 false)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1024) %9, i8 0, i64 1024, i1 false)
  %133 = add nsw i32 %49, %13
  %134 = sext i32 %133 to i64
  %135 = load i64, ptr %0, align 8, !tbaa !24
  %136 = icmp sgt i64 %135, %134
  br i1 %136, label %12, label %137, !llvm.loop !37

137:                                              ; preds = %45, %130, %19, %4
  tail call void @free(ptr noundef %8) #18
  tail call void @free(ptr noundef %9) #18
  ret ptr null
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare void @perror(ptr nocapture noundef readonly) local_unnamed_addr #9

declare i32 @pthread_join(i64 noundef, ptr noundef) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind
declare i32 @pthread_attr_destroy(ptr noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #11

; Function Attrs: nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #12

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare i32 @strcmp(ptr nocapture noundef, ptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #9

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #13

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #3 {
  %3 = alloca %struct.stat, align 8
  %4 = alloca %struct.timespec, align 8
  %5 = alloca %struct.timespec, align 8
  %6 = alloca %struct.str_data_t, align 8
  call void @llvm.lifetime.start.p0(i64 144, ptr nonnull %3) #18
  %7 = icmp slt i32 %0, 3
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load ptr, ptr %1, align 8, !tbaa !11
  %10 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.14, ptr noundef %9)
  tail call void @exit(i32 noundef 1) #19
  unreachable

11:                                               ; preds = %2
  %12 = getelementptr inbounds ptr, ptr %1, i64 1
  %13 = load ptr, ptr %12, align 8, !tbaa !11
  %14 = getelementptr inbounds ptr, ptr %1, i64 2
  %15 = load ptr, ptr %14, align 8, !tbaa !11
  %16 = tail call i64 @strtol(ptr nocapture noundef nonnull %15, ptr noundef null, i32 noundef 10) #18
  %17 = trunc i64 %16 to i32
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4) #18
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %5) #18
  %18 = tail call i64 @time(ptr noundef null) #18
  %19 = trunc i64 %18 to i32
  tail call void @srand(i32 noundef %19) #18
  %20 = tail call i32 (ptr, i32, ...) @open(ptr noundef %13, i32 noundef 0) #18
  %21 = icmp slt i32 %20, 0
  br i1 %21, label %22, label %26

22:                                               ; preds = %11
  tail call void @perror(ptr noundef nonnull @.str.15) #20
  %23 = tail call i32 (ptr, i32, ...) @open(ptr noundef %13, i32 noundef 0) #18
  %24 = icmp sgt i32 %23, -1
  br i1 %24, label %26, label %25

25:                                               ; preds = %22
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.5, i32 noundef 211, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19
  unreachable

26:                                               ; preds = %22, %11
  %27 = phi i32 [ %23, %22 ], [ %20, %11 ]
  %28 = call i32 @fstat(i32 noundef %27, ptr noundef nonnull %3) #18
  %29 = icmp slt i32 %28, 0
  br i1 %29, label %30, label %34

30:                                               ; preds = %26
  tail call void @perror(ptr noundef nonnull @.str.17) #20
  %31 = call i32 @fstat(i32 noundef %27, ptr noundef nonnull %3) #18
  %32 = icmp sgt i32 %31, -1
  br i1 %32, label %34, label %33

33:                                               ; preds = %30
  tail call void @__assert_fail(ptr noundef nonnull @.str.18, ptr noundef nonnull @.str.5, i32 noundef 212, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19
  unreachable

34:                                               ; preds = %30, %26
  %35 = getelementptr inbounds %struct.stat, ptr %3, i64 0, i32 8
  %36 = load i64, ptr %35, align 8, !tbaa !38
  %37 = add nsw i64 %36, 1
  %38 = tail call ptr @mmap(ptr noundef null, i64 noundef %37, i32 noundef 3, i32 noundef 2, i32 noundef %27, i64 noundef 0) #18
  %39 = icmp eq ptr %38, null
  br i1 %39, label %40, label %44

40:                                               ; preds = %34
  tail call void @perror(ptr noundef nonnull @.str.19) #20
  %41 = tail call ptr @mmap(ptr noundef null, i64 noundef %37, i32 noundef 3, i32 noundef 2, i32 noundef %27, i64 noundef 0) #18
  %42 = icmp eq ptr %41, null
  br i1 %42, label %43, label %44

43:                                               ; preds = %40
  tail call void @__assert_fail(ptr noundef nonnull @.str.20, ptr noundef nonnull @.str.5, i32 noundef 214, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19
  unreachable

44:                                               ; preds = %40, %34
  %45 = phi ptr [ %41, %40 ], [ %38, %34 ]
  %46 = load ptr, ptr @stdout, align 8, !tbaa !11
  %47 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %46, ptr noundef nonnull @.str.21, i64 noundef %36)
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %6) #18
  %48 = trunc i64 %36 to i32
  store i32 %48, ptr %6, align 8, !tbaa !13
  %49 = getelementptr inbounds %struct.str_data_t, ptr %6, i64 0, i32 1
  store i32 0, ptr %49, align 4, !tbaa !41
  %50 = getelementptr inbounds %struct.str_data_t, ptr %6, i64 0, i32 2
  store i64 0, ptr %50, align 8, !tbaa !21
  %51 = getelementptr inbounds %struct.str_data_t, ptr %6, i64 0, i32 3
  store ptr %45, ptr %51, align 8, !tbaa !20
  %52 = getelementptr inbounds %struct.str_data_t, ptr %6, i64 0, i32 4
  store ptr null, ptr %52, align 8, !tbaa !17
  %53 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.22, i32 noundef %17)
  %54 = call i32 @gettimeofday(ptr noundef nonnull %4, ptr noundef null) #18
  call void @string_match_splitter(ptr noundef nonnull %6, i32 noundef %17)
  %55 = call i32 @gettimeofday(ptr noundef nonnull %5, ptr noundef null) #18
  %56 = load i64, ptr %5, align 8, !tbaa !42
  %57 = load i64, ptr %4, align 8, !tbaa !42
  %58 = sub nsw i64 %56, %57
  %59 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.23, i64 noundef %58)
  %60 = call i32 @munmap(ptr noundef nonnull %45, i64 noundef %37) #18
  %61 = icmp slt i32 %60, 0
  br i1 %61, label %62, label %66

62:                                               ; preds = %44
  call void @perror(ptr noundef nonnull @.str.24) #20
  %63 = call i32 @munmap(ptr noundef nonnull %45, i64 noundef %37) #18
  %64 = icmp sgt i32 %63, -1
  br i1 %64, label %66, label %65

65:                                               ; preds = %62
  call void @__assert_fail(ptr noundef nonnull @.str.25, ptr noundef nonnull @.str.5, i32 noundef 234, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19
  unreachable

66:                                               ; preds = %62, %44
  %67 = call i32 @close(i32 noundef %27) #18
  %68 = icmp slt i32 %67, 0
  br i1 %68, label %69, label %73

69:                                               ; preds = %66
  call void @perror(ptr noundef nonnull @.str.26) #20
  %70 = call i32 @close(i32 noundef %27) #18
  %71 = icmp sgt i32 %70, -1
  br i1 %71, label %73, label %72

72:                                               ; preds = %69
  call void @__assert_fail(ptr noundef nonnull @.str.27, ptr noundef nonnull @.str.5, i32 noundef 235, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19
  unreachable

73:                                               ; preds = %69, %66
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %6) #18
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %5) #18
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4) #18
  call void @llvm.lifetime.end.p0(i64 144, ptr nonnull %3) #18
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #9

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #14

; Function Attrs: nounwind
declare i64 @time(ptr noundef) local_unnamed_addr #7

; Function Attrs: nounwind
declare void @srand(i32 noundef) local_unnamed_addr #7

; Function Attrs: nofree
declare noundef i32 @open(ptr nocapture noundef readonly, i32 noundef, ...) local_unnamed_addr #15

; Function Attrs: nofree nounwind
declare noundef i32 @fstat(i32 noundef, ptr nocapture noundef) local_unnamed_addr #9

; Function Attrs: nounwind
declare ptr @mmap(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare noundef i32 @gettimeofday(ptr nocapture noundef, ptr nocapture noundef) local_unnamed_addr #9

; Function Attrs: nounwind
declare i32 @munmap(ptr noundef, i64 noundef) local_unnamed_addr #7

declare i32 @close(i32 noundef) local_unnamed_addr #10

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #13 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #14 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #15 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #16 = { nounwind willreturn memory(read) }
attributes #17 = { nounwind allocsize(0) }
attributes #18 = { nounwind }
attributes #19 = { noreturn nounwind }
attributes #20 = { cold }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Ubuntu clang version 17.0.6 (++20231209124227+6009708b4367-1~exp1~20231209124336.77)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !9}
!11 = !{!12, !12, i64 0}
!12 = !{!"any pointer", !6, i64 0}
!13 = !{!14, !15, i64 0}
!14 = !{!"", !15, i64 0, !15, i64 4, !16, i64 8, !12, i64 16, !12, i64 24}
!15 = !{!"int", !6, i64 0}
!16 = !{!"long", !6, i64 0}
!17 = !{!14, !12, i64 24}
!18 = !{!19, !12, i64 8}
!19 = !{!"", !12, i64 0, !12, i64 8, !15, i64 16}
!20 = !{!14, !12, i64 16}
!21 = !{!14, !16, i64 8}
!22 = !{!19, !12, i64 0}
!23 = !{!19, !15, i64 16}
!24 = !{!25, !16, i64 0}
!25 = !{!"", !16, i64 0, !12, i64 8}
!26 = !{!25, !12, i64 8}
!27 = distinct !{!27, !9}
!28 = distinct !{!28, !9}
!29 = !{!16, !16, i64 0}
!30 = !{!15, !15, i64 0}
!31 = distinct !{!31, !9}
!32 = distinct !{!32, !9, !33, !34}
!33 = !{!"llvm.loop.isvectorized", i32 1}
!34 = !{!"llvm.loop.unroll.runtime.disable"}
!35 = distinct !{!35, !9, !33, !34}
!36 = distinct !{!36, !9, !34, !33}
!37 = distinct !{!37, !9}
!38 = !{!39, !16, i64 48}
!39 = !{!"stat", !16, i64 0, !16, i64 8, !16, i64 16, !15, i64 24, !15, i64 28, !15, i64 32, !15, i64 36, !16, i64 40, !16, i64 48, !16, i64 56, !16, i64 64, !40, i64 72, !40, i64 88, !40, i64 104, !6, i64 120}
!40 = !{!"timespec", !16, i64 0, !16, i64 8}
!41 = !{!14, !15, i64 4}
!42 = !{!43, !16, i64 0}
!43 = !{!"timeval", !16, i64 0, !16, i64 8}

; ModuleID = 'cpu/cpu.bpf.c'
source_filename = "cpu/cpu.bpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [6 x i32]*, [1 x i32]*, i32*, %struct.unwind_state* }
%struct.unwind_state = type { i64, i64, i64, i32, %struct.stack_trace_t }
%struct.stack_trace_t = type { i64, [115 x i64] }
%struct.anon.0 = type { [3 x i32]*, [1 x i32]*, i32*, i32* }
%struct.anon.1 = type { [1 x i32]*, [32 x i32]*, i32*, i8* }
%struct.anon.2 = type { [1 x i32]*, [10240 x i32]*, %struct.stack_count_key*, i64* }
%struct.stack_count_key = type { i32, i32, i32, i32, i32 }
%struct.anon.3 = type { [7 x i32]*, [1024 x i32]*, i32*, [115 x i64]* }
%struct.anon.4 = type { [1 x i32]*, [1024 x i32]*, i32*, %struct.stack_trace_t* }
%struct.anon.5 = type { [1 x i32]*, [2 x i32]*, %struct.unwind_tables_key*, %struct.stack_unwind_table_t* }
%struct.unwind_tables_key = type { i32, i32 }
%struct.stack_unwind_table_t = type { i64, i64, i64, i64, [250000 x %struct.stack_unwind_row] }
%struct.stack_unwind_row = type { i64, i16, i8, i8, i16, i16 }
%struct.anon.6 = type { [6 x i32]*, [10 x i32]*, i32*, i32* }
%struct.bpf_perf_event_data = type { %struct.pt_regs, i64, i64 }
%struct.pt_regs = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@heap = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@programs = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !188
@VERSION = dso_local global i32 1, section "version", align 4, !dbg !34
@LICENSE = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !36
@debug_pids = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !42
@stack_counts = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !63
@stack_traces = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !88
@dwarf_stack_traces = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !112
@unwind_tables = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !127
@percpu_stats = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !172
@llvm.compiler.used = appending global [12 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @LICENSE, i32 0, i32 0), i8* bitcast (i32* @VERSION to i8*), i8* bitcast (%struct.anon.1* @debug_pids to i8*), i8* bitcast (%struct.anon.4* @dwarf_stack_traces to i8*), i8* bitcast (%struct.anon* @heap to i8*), i8* bitcast (%struct.anon.6* @percpu_stats to i8*), i8* bitcast (i32 (%struct.bpf_perf_event_data*)* @profile_cpu to i8*), i8* bitcast (%struct.anon.0* @programs to i8*), i8* bitcast (%struct.anon.2* @stack_counts to i8*), i8* bitcast (%struct.anon.3* @stack_traces to i8*), i8* bitcast (%struct.anon.5* @unwind_tables to i8*), i8* bitcast (i32 (%struct.bpf_perf_event_data*)* @walk_user_stacktrace_impl to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @walk_user_stacktrace_impl(%struct.bpf_perf_event_data* noundef %0) #0 section "perf_event" !dbg !254 {
  %2 = alloca i64, align 8
  %3 = alloca %struct.stack_count_key, align 4
  %4 = alloca %struct.unwind_tables_key, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !289, metadata !DIExpression()), !dbg !324
  %8 = tail call i64 inttoptr (i64 14 to i64 ()*)() #6, !dbg !325
  call void @llvm.dbg.value(metadata i64 %8, metadata !290, metadata !DIExpression()), !dbg !324
  %9 = trunc i64 %8 to i32, !dbg !326
  call void @llvm.dbg.value(metadata i32 %9, metadata !291, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i8 0, metadata !292, metadata !DIExpression()), !dbg !324
  %10 = bitcast i64* %5 to i8*, !dbg !327
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %10) #6, !dbg !327
  call void @llvm.dbg.value(metadata i64 0, metadata !295, metadata !DIExpression()), !dbg !324
  store i64 0, i64* %5, align 8, !dbg !328, !tbaa !329
  call void @llvm.dbg.value(metadata i64* %5, metadata !295, metadata !DIExpression(DW_OP_deref)), !dbg !324
  %11 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @heap to i8*), i8* noundef nonnull %10) #6, !dbg !333
  call void @llvm.dbg.value(metadata i8* %11, metadata !296, metadata !DIExpression()), !dbg !324
  %12 = icmp eq i8* %11, null, !dbg !334
  br i1 %12, label %2850, label %13, !dbg !336

13:                                               ; preds = %1
  %14 = bitcast i8* %11 to i64*
  %15 = bitcast %struct.unwind_tables_key* %4 to i8*
  %16 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %4, i64 0, i32 0
  %17 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %4, i64 0, i32 1
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 0, metadata !297, metadata !DIExpression()), !dbg !337
  %18 = getelementptr inbounds i8, i8* %11, i64 32
  %19 = bitcast i8* %18 to i64*
  %20 = getelementptr inbounds i8, i8* %11, i64 40
  %21 = bitcast i8* %20 to [115 x i64]*
  %22 = getelementptr inbounds i8, i8* %11, i64 8
  %23 = bitcast i8* %22 to i64*
  %24 = getelementptr inbounds i8, i8* %11, i64 16
  %25 = bitcast i8* %24 to i64*
  %26 = bitcast i64* %6 to i8*
  %27 = bitcast i64* %7 to i8*
  call void @llvm.dbg.value(metadata i32 0, metadata !297, metadata !DIExpression()), !dbg !337
  %28 = load i64, i64* %14, align 8, !dbg !338, !tbaa !339
  call void @llvm.dbg.value(metadata i32 %9, metadata !343, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 %28, metadata !350, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #6, !dbg !359
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %4, metadata !351, metadata !DIExpression()) #6, !dbg !360
  store i32 %9, i32* %16, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 0, i32* %17, align 4, !dbg !365, !tbaa !366
  %29 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %29, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %30 = icmp eq i8* %29, null, !dbg !369
  br i1 %30, label %40, label %31, !dbg !371

31:                                               ; preds = %13
  %32 = bitcast i8* %29 to i64*, !dbg !372
  %33 = load i64, i64* %32, align 8, !dbg !372, !tbaa !375
  %34 = icmp ugt i64 %33, %28, !dbg !377
  br i1 %34, label %40, label %35, !dbg !378

35:                                               ; preds = %31
  %36 = getelementptr inbounds i8, i8* %29, i64 8, !dbg !379
  %37 = bitcast i8* %36 to i64*, !dbg !379
  %38 = load i64, i64* %37, align 8, !dbg !379, !tbaa !380
  %39 = icmp ult i64 %38, %28, !dbg !381
  br i1 %39, label %40, label %103, !dbg !382

40:                                               ; preds = %35, %31, %13
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 1, i32* %17, align 4, !dbg !365, !tbaa !366
  %41 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %41, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %42 = icmp eq i8* %41, null, !dbg !369
  br i1 %42, label %52, label %43, !dbg !371

43:                                               ; preds = %40
  %44 = bitcast i8* %41 to i64*, !dbg !372
  %45 = load i64, i64* %44, align 8, !dbg !372, !tbaa !375
  %46 = icmp ugt i64 %45, %28, !dbg !377
  br i1 %46, label %52, label %47, !dbg !378

47:                                               ; preds = %43
  %48 = getelementptr inbounds i8, i8* %41, i64 8, !dbg !379
  %49 = bitcast i8* %48 to i64*, !dbg !379
  %50 = load i64, i64* %49, align 8, !dbg !379, !tbaa !380
  %51 = icmp ult i64 %50, %28, !dbg !381
  br i1 %51, label %52, label %103, !dbg !382

52:                                               ; preds = %47, %43, %40
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 2, i32* %17, align 4, !dbg !365, !tbaa !366
  %53 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %53, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %54 = icmp eq i8* %53, null, !dbg !369
  br i1 %54, label %64, label %55, !dbg !371

55:                                               ; preds = %52
  %56 = bitcast i8* %53 to i64*, !dbg !372
  %57 = load i64, i64* %56, align 8, !dbg !372, !tbaa !375
  %58 = icmp ugt i64 %57, %28, !dbg !377
  br i1 %58, label %64, label %59, !dbg !378

59:                                               ; preds = %55
  %60 = getelementptr inbounds i8, i8* %53, i64 8, !dbg !379
  %61 = bitcast i8* %60 to i64*, !dbg !379
  %62 = load i64, i64* %61, align 8, !dbg !379, !tbaa !380
  %63 = icmp ult i64 %62, %28, !dbg !381
  br i1 %63, label %64, label %103, !dbg !382

64:                                               ; preds = %59, %55, %52
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 3, i32* %17, align 4, !dbg !365, !tbaa !366
  %65 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %65, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %66 = icmp eq i8* %65, null, !dbg !369
  br i1 %66, label %76, label %67, !dbg !371

67:                                               ; preds = %64
  %68 = bitcast i8* %65 to i64*, !dbg !372
  %69 = load i64, i64* %68, align 8, !dbg !372, !tbaa !375
  %70 = icmp ugt i64 %69, %28, !dbg !377
  br i1 %70, label %76, label %71, !dbg !378

71:                                               ; preds = %67
  %72 = getelementptr inbounds i8, i8* %65, i64 8, !dbg !379
  %73 = bitcast i8* %72 to i64*, !dbg !379
  %74 = load i64, i64* %73, align 8, !dbg !379, !tbaa !380
  %75 = icmp ult i64 %74, %28, !dbg !381
  br i1 %75, label %76, label %103, !dbg !382

76:                                               ; preds = %71, %67, %64
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 4, i32* %17, align 4, !dbg !365, !tbaa !366
  %77 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %77, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %78 = icmp eq i8* %77, null, !dbg !369
  br i1 %78, label %88, label %79, !dbg !371

79:                                               ; preds = %76
  %80 = bitcast i8* %77 to i64*, !dbg !372
  %81 = load i64, i64* %80, align 8, !dbg !372, !tbaa !375
  %82 = icmp ugt i64 %81, %28, !dbg !377
  br i1 %82, label %88, label %83, !dbg !378

83:                                               ; preds = %79
  %84 = getelementptr inbounds i8, i8* %77, i64 8, !dbg !379
  %85 = bitcast i8* %84 to i64*, !dbg !379
  %86 = load i64, i64* %85, align 8, !dbg !379, !tbaa !380
  %87 = icmp ult i64 %86, %28, !dbg !381
  br i1 %87, label %88, label %103, !dbg !382

88:                                               ; preds = %83, %79, %76
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 5, i32* %17, align 4, !dbg !365, !tbaa !366
  %89 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %89, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %90 = icmp eq i8* %89, null, !dbg !369
  br i1 %90, label %100, label %91, !dbg !371

91:                                               ; preds = %88
  %92 = bitcast i8* %89 to i64*, !dbg !372
  %93 = load i64, i64* %92, align 8, !dbg !372, !tbaa !375
  %94 = icmp ugt i64 %93, %28, !dbg !377
  br i1 %94, label %100, label %95, !dbg !378

95:                                               ; preds = %91
  %96 = getelementptr inbounds i8, i8* %89, i64 8, !dbg !379
  %97 = bitcast i8* %96 to i64*, !dbg !379
  %98 = load i64, i64* %97, align 8, !dbg !379, !tbaa !380
  %99 = icmp ult i64 %98, %28, !dbg !381
  br i1 %99, label %100, label %103, !dbg !382

100:                                              ; preds = %1948, %1944, %1941, %1486, %1482, %1479, %1024, %1020, %1017, %562, %558, %555, %95, %91, %88
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %105, metadata !299, metadata !DIExpression()), !dbg !384
  %101 = load i64, i64* %25, align 8, !dbg !385, !tbaa !389
  %102 = icmp eq i64 %101, 0, !dbg !390
  br i1 %102, label %2344, label %2850, !dbg !391

103:                                              ; preds = %35, %47, %59, %71, %83, %95
  %104 = phi i8* [ %29, %35 ], [ %41, %47 ], [ %53, %59 ], [ %65, %71 ], [ %77, %83 ], [ %89, %95 ], !dbg !367
  %105 = bitcast i8* %104 to %struct.stack_unwind_table_t*, !dbg !367
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %105, metadata !299, metadata !DIExpression()), !dbg !384
  %106 = load i64, i64* %14, align 8, !dbg !392, !tbaa !339
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %105, metadata !393, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %106, metadata !398, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 0, metadata !399, metadata !DIExpression()), !dbg !407
  %107 = getelementptr inbounds i8, i8* %104, i64 16, !dbg !409
  %108 = bitcast i8* %107 to i64*, !dbg !409
  %109 = load i64, i64* %108, align 8, !dbg !409, !tbaa !410
  call void @llvm.dbg.value(metadata i32 0, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 16431834, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %109, metadata !400, metadata !DIExpression()), !dbg !407
  %110 = icmp eq i64 %109, 0, !dbg !412
  br i1 %110, label %420, label %111, !dbg !414

111:                                              ; preds = %103
  %112 = lshr i64 %109, 1, !dbg !415
  %113 = trunc i64 %112 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %113, metadata !404, metadata !DIExpression()), !dbg !417
  %114 = icmp ugt i32 %113, 249999
  br i1 %114, label %420, label %115, !dbg !418

115:                                              ; preds = %111
  %116 = and i64 %112, 4294967295, !dbg !420
  %117 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %116, i32 0, !dbg !422
  %118 = load i64, i64* %117, align 8, !dbg !422, !tbaa !423
  %119 = icmp ugt i64 %118, %106, !dbg !426
  %120 = add nuw i64 %112, 1, !dbg !427
  %121 = and i64 %120, 4294967295, !dbg !427
  %122 = select i1 %119, i64 0, i64 %121, !dbg !427
  %123 = select i1 %119, i64 %116, i64 %109, !dbg !427
  %124 = select i1 %119, i64 16431834, i64 %116, !dbg !427
  call void @llvm.dbg.value(metadata i32 1, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %124, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %123, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %122, metadata !399, metadata !DIExpression()), !dbg !407
  %125 = icmp ult i64 %122, %123, !dbg !412
  br i1 %125, label %126, label %420, !dbg !414

126:                                              ; preds = %115
  %127 = add i64 %123, %122, !dbg !428
  %128 = lshr i64 %127, 1, !dbg !415
  %129 = trunc i64 %128 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %129, metadata !404, metadata !DIExpression()), !dbg !417
  %130 = icmp ugt i32 %129, 249999
  br i1 %130, label %420, label %131, !dbg !418

131:                                              ; preds = %126
  %132 = and i64 %128, 4294967295, !dbg !420
  %133 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %132, i32 0, !dbg !422
  %134 = load i64, i64* %133, align 8, !dbg !422, !tbaa !423
  %135 = icmp ugt i64 %134, %106, !dbg !426
  %136 = add nuw i64 %128, 1, !dbg !427
  %137 = and i64 %136, 4294967295, !dbg !427
  %138 = select i1 %135, i64 %122, i64 %137, !dbg !427
  %139 = select i1 %135, i64 %132, i64 %123, !dbg !427
  %140 = select i1 %135, i64 %124, i64 %132, !dbg !427
  call void @llvm.dbg.value(metadata i32 2, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %140, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %139, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %138, metadata !399, metadata !DIExpression()), !dbg !407
  %141 = icmp ult i64 %138, %139, !dbg !412
  br i1 %141, label %142, label %420, !dbg !414

142:                                              ; preds = %131
  %143 = add i64 %139, %138, !dbg !428
  %144 = lshr i64 %143, 1, !dbg !415
  %145 = trunc i64 %144 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %145, metadata !404, metadata !DIExpression()), !dbg !417
  %146 = icmp ugt i32 %145, 249999
  br i1 %146, label %420, label %147, !dbg !418

147:                                              ; preds = %142
  %148 = and i64 %144, 4294967295, !dbg !420
  %149 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %148, i32 0, !dbg !422
  %150 = load i64, i64* %149, align 8, !dbg !422, !tbaa !423
  %151 = icmp ugt i64 %150, %106, !dbg !426
  %152 = add nuw i64 %144, 1, !dbg !427
  %153 = and i64 %152, 4294967295, !dbg !427
  %154 = select i1 %151, i64 %138, i64 %153, !dbg !427
  %155 = select i1 %151, i64 %148, i64 %139, !dbg !427
  %156 = select i1 %151, i64 %140, i64 %148, !dbg !427
  call void @llvm.dbg.value(metadata i32 3, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %156, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %155, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %154, metadata !399, metadata !DIExpression()), !dbg !407
  %157 = icmp ult i64 %154, %155, !dbg !412
  br i1 %157, label %158, label %420, !dbg !414

158:                                              ; preds = %147
  %159 = add i64 %155, %154, !dbg !428
  %160 = lshr i64 %159, 1, !dbg !415
  %161 = trunc i64 %160 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %161, metadata !404, metadata !DIExpression()), !dbg !417
  %162 = icmp ugt i32 %161, 249999
  br i1 %162, label %420, label %163, !dbg !418

163:                                              ; preds = %158
  %164 = and i64 %160, 4294967295, !dbg !420
  %165 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %164, i32 0, !dbg !422
  %166 = load i64, i64* %165, align 8, !dbg !422, !tbaa !423
  %167 = icmp ugt i64 %166, %106, !dbg !426
  %168 = add nuw i64 %160, 1, !dbg !427
  %169 = and i64 %168, 4294967295, !dbg !427
  %170 = select i1 %167, i64 %154, i64 %169, !dbg !427
  %171 = select i1 %167, i64 %164, i64 %155, !dbg !427
  %172 = select i1 %167, i64 %156, i64 %164, !dbg !427
  call void @llvm.dbg.value(metadata i32 4, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %172, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %171, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %170, metadata !399, metadata !DIExpression()), !dbg !407
  %173 = icmp ult i64 %170, %171, !dbg !412
  br i1 %173, label %174, label %420, !dbg !414

174:                                              ; preds = %163
  %175 = add i64 %171, %170, !dbg !428
  %176 = lshr i64 %175, 1, !dbg !415
  %177 = trunc i64 %176 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %177, metadata !404, metadata !DIExpression()), !dbg !417
  %178 = icmp ugt i32 %177, 249999
  br i1 %178, label %420, label %179, !dbg !418

179:                                              ; preds = %174
  %180 = and i64 %176, 4294967295, !dbg !420
  %181 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %180, i32 0, !dbg !422
  %182 = load i64, i64* %181, align 8, !dbg !422, !tbaa !423
  %183 = icmp ugt i64 %182, %106, !dbg !426
  %184 = add nuw i64 %176, 1, !dbg !427
  %185 = and i64 %184, 4294967295, !dbg !427
  %186 = select i1 %183, i64 %170, i64 %185, !dbg !427
  %187 = select i1 %183, i64 %180, i64 %171, !dbg !427
  %188 = select i1 %183, i64 %172, i64 %180, !dbg !427
  call void @llvm.dbg.value(metadata i32 5, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %188, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %187, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %186, metadata !399, metadata !DIExpression()), !dbg !407
  %189 = icmp ult i64 %186, %187, !dbg !412
  br i1 %189, label %190, label %420, !dbg !414

190:                                              ; preds = %179
  %191 = add i64 %187, %186, !dbg !428
  %192 = lshr i64 %191, 1, !dbg !415
  %193 = trunc i64 %192 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %193, metadata !404, metadata !DIExpression()), !dbg !417
  %194 = icmp ugt i32 %193, 249999
  br i1 %194, label %420, label %195, !dbg !418

195:                                              ; preds = %190
  %196 = and i64 %192, 4294967295, !dbg !420
  %197 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %196, i32 0, !dbg !422
  %198 = load i64, i64* %197, align 8, !dbg !422, !tbaa !423
  %199 = icmp ugt i64 %198, %106, !dbg !426
  %200 = add nuw i64 %192, 1, !dbg !427
  %201 = and i64 %200, 4294967295, !dbg !427
  %202 = select i1 %199, i64 %186, i64 %201, !dbg !427
  %203 = select i1 %199, i64 %196, i64 %187, !dbg !427
  %204 = select i1 %199, i64 %188, i64 %196, !dbg !427
  call void @llvm.dbg.value(metadata i32 6, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %204, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %203, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %202, metadata !399, metadata !DIExpression()), !dbg !407
  %205 = icmp ult i64 %202, %203, !dbg !412
  br i1 %205, label %206, label %420, !dbg !414

206:                                              ; preds = %195
  %207 = add i64 %203, %202, !dbg !428
  %208 = lshr i64 %207, 1, !dbg !415
  %209 = trunc i64 %208 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %209, metadata !404, metadata !DIExpression()), !dbg !417
  %210 = icmp ugt i32 %209, 249999
  br i1 %210, label %420, label %211, !dbg !418

211:                                              ; preds = %206
  %212 = and i64 %208, 4294967295, !dbg !420
  %213 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %212, i32 0, !dbg !422
  %214 = load i64, i64* %213, align 8, !dbg !422, !tbaa !423
  %215 = icmp ugt i64 %214, %106, !dbg !426
  %216 = add nuw i64 %208, 1, !dbg !427
  %217 = and i64 %216, 4294967295, !dbg !427
  %218 = select i1 %215, i64 %202, i64 %217, !dbg !427
  %219 = select i1 %215, i64 %212, i64 %203, !dbg !427
  %220 = select i1 %215, i64 %204, i64 %212, !dbg !427
  call void @llvm.dbg.value(metadata i32 7, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %220, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %219, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %218, metadata !399, metadata !DIExpression()), !dbg !407
  %221 = icmp ult i64 %218, %219, !dbg !412
  br i1 %221, label %222, label %420, !dbg !414

222:                                              ; preds = %211
  %223 = add i64 %219, %218, !dbg !428
  %224 = lshr i64 %223, 1, !dbg !415
  %225 = trunc i64 %224 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %225, metadata !404, metadata !DIExpression()), !dbg !417
  %226 = icmp ugt i32 %225, 249999
  br i1 %226, label %420, label %227, !dbg !418

227:                                              ; preds = %222
  %228 = and i64 %224, 4294967295, !dbg !420
  %229 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %228, i32 0, !dbg !422
  %230 = load i64, i64* %229, align 8, !dbg !422, !tbaa !423
  %231 = icmp ugt i64 %230, %106, !dbg !426
  %232 = add nuw i64 %224, 1, !dbg !427
  %233 = and i64 %232, 4294967295, !dbg !427
  %234 = select i1 %231, i64 %218, i64 %233, !dbg !427
  %235 = select i1 %231, i64 %228, i64 %219, !dbg !427
  %236 = select i1 %231, i64 %220, i64 %228, !dbg !427
  call void @llvm.dbg.value(metadata i32 8, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %236, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %235, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %234, metadata !399, metadata !DIExpression()), !dbg !407
  %237 = icmp ult i64 %234, %235, !dbg !412
  br i1 %237, label %238, label %420, !dbg !414

238:                                              ; preds = %227
  %239 = add i64 %235, %234, !dbg !428
  %240 = lshr i64 %239, 1, !dbg !415
  %241 = trunc i64 %240 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %241, metadata !404, metadata !DIExpression()), !dbg !417
  %242 = icmp ugt i32 %241, 249999
  br i1 %242, label %420, label %243, !dbg !418

243:                                              ; preds = %238
  %244 = and i64 %240, 4294967295, !dbg !420
  %245 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %244, i32 0, !dbg !422
  %246 = load i64, i64* %245, align 8, !dbg !422, !tbaa !423
  %247 = icmp ugt i64 %246, %106, !dbg !426
  %248 = add nuw i64 %240, 1, !dbg !427
  %249 = and i64 %248, 4294967295, !dbg !427
  %250 = select i1 %247, i64 %234, i64 %249, !dbg !427
  %251 = select i1 %247, i64 %244, i64 %235, !dbg !427
  %252 = select i1 %247, i64 %236, i64 %244, !dbg !427
  call void @llvm.dbg.value(metadata i32 9, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %252, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %251, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %250, metadata !399, metadata !DIExpression()), !dbg !407
  %253 = icmp ult i64 %250, %251, !dbg !412
  br i1 %253, label %254, label %420, !dbg !414

254:                                              ; preds = %243
  %255 = add i64 %251, %250, !dbg !428
  %256 = lshr i64 %255, 1, !dbg !415
  %257 = trunc i64 %256 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %257, metadata !404, metadata !DIExpression()), !dbg !417
  %258 = icmp ugt i32 %257, 249999
  br i1 %258, label %420, label %259, !dbg !418

259:                                              ; preds = %254
  %260 = and i64 %256, 4294967295, !dbg !420
  %261 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %260, i32 0, !dbg !422
  %262 = load i64, i64* %261, align 8, !dbg !422, !tbaa !423
  %263 = icmp ugt i64 %262, %106, !dbg !426
  %264 = add nuw i64 %256, 1, !dbg !427
  %265 = and i64 %264, 4294967295, !dbg !427
  %266 = select i1 %263, i64 %250, i64 %265, !dbg !427
  %267 = select i1 %263, i64 %260, i64 %251, !dbg !427
  %268 = select i1 %263, i64 %252, i64 %260, !dbg !427
  call void @llvm.dbg.value(metadata i32 10, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %268, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %267, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %266, metadata !399, metadata !DIExpression()), !dbg !407
  %269 = icmp ult i64 %266, %267, !dbg !412
  br i1 %269, label %270, label %420, !dbg !414

270:                                              ; preds = %259
  %271 = add i64 %267, %266, !dbg !428
  %272 = lshr i64 %271, 1, !dbg !415
  %273 = trunc i64 %272 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %273, metadata !404, metadata !DIExpression()), !dbg !417
  %274 = icmp ugt i32 %273, 249999
  br i1 %274, label %420, label %275, !dbg !418

275:                                              ; preds = %270
  %276 = and i64 %272, 4294967295, !dbg !420
  %277 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %276, i32 0, !dbg !422
  %278 = load i64, i64* %277, align 8, !dbg !422, !tbaa !423
  %279 = icmp ugt i64 %278, %106, !dbg !426
  %280 = add nuw i64 %272, 1, !dbg !427
  %281 = and i64 %280, 4294967295, !dbg !427
  %282 = select i1 %279, i64 %266, i64 %281, !dbg !427
  %283 = select i1 %279, i64 %276, i64 %267, !dbg !427
  %284 = select i1 %279, i64 %268, i64 %276, !dbg !427
  call void @llvm.dbg.value(metadata i32 11, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %284, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %283, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %282, metadata !399, metadata !DIExpression()), !dbg !407
  %285 = icmp ult i64 %282, %283, !dbg !412
  br i1 %285, label %286, label %420, !dbg !414

286:                                              ; preds = %275
  %287 = add i64 %283, %282, !dbg !428
  %288 = lshr i64 %287, 1, !dbg !415
  %289 = trunc i64 %288 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %289, metadata !404, metadata !DIExpression()), !dbg !417
  %290 = icmp ugt i32 %289, 249999
  br i1 %290, label %420, label %291, !dbg !418

291:                                              ; preds = %286
  %292 = and i64 %288, 4294967295, !dbg !420
  %293 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %292, i32 0, !dbg !422
  %294 = load i64, i64* %293, align 8, !dbg !422, !tbaa !423
  %295 = icmp ugt i64 %294, %106, !dbg !426
  %296 = add nuw i64 %288, 1, !dbg !427
  %297 = and i64 %296, 4294967295, !dbg !427
  %298 = select i1 %295, i64 %282, i64 %297, !dbg !427
  %299 = select i1 %295, i64 %292, i64 %283, !dbg !427
  %300 = select i1 %295, i64 %284, i64 %292, !dbg !427
  call void @llvm.dbg.value(metadata i32 12, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %300, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %299, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %298, metadata !399, metadata !DIExpression()), !dbg !407
  %301 = icmp ult i64 %298, %299, !dbg !412
  br i1 %301, label %302, label %420, !dbg !414

302:                                              ; preds = %291
  %303 = add i64 %299, %298, !dbg !428
  %304 = lshr i64 %303, 1, !dbg !415
  %305 = trunc i64 %304 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %305, metadata !404, metadata !DIExpression()), !dbg !417
  %306 = icmp ugt i32 %305, 249999
  br i1 %306, label %420, label %307, !dbg !418

307:                                              ; preds = %302
  %308 = and i64 %304, 4294967295, !dbg !420
  %309 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %308, i32 0, !dbg !422
  %310 = load i64, i64* %309, align 8, !dbg !422, !tbaa !423
  %311 = icmp ugt i64 %310, %106, !dbg !426
  %312 = add nuw i64 %304, 1, !dbg !427
  %313 = and i64 %312, 4294967295, !dbg !427
  %314 = select i1 %311, i64 %298, i64 %313, !dbg !427
  %315 = select i1 %311, i64 %308, i64 %299, !dbg !427
  %316 = select i1 %311, i64 %300, i64 %308, !dbg !427
  call void @llvm.dbg.value(metadata i32 13, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %316, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %315, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %314, metadata !399, metadata !DIExpression()), !dbg !407
  %317 = icmp ult i64 %314, %315, !dbg !412
  br i1 %317, label %318, label %420, !dbg !414

318:                                              ; preds = %307
  %319 = add i64 %315, %314, !dbg !428
  %320 = lshr i64 %319, 1, !dbg !415
  %321 = trunc i64 %320 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %321, metadata !404, metadata !DIExpression()), !dbg !417
  %322 = icmp ugt i32 %321, 249999
  br i1 %322, label %420, label %323, !dbg !418

323:                                              ; preds = %318
  %324 = and i64 %320, 4294967295, !dbg !420
  %325 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %324, i32 0, !dbg !422
  %326 = load i64, i64* %325, align 8, !dbg !422, !tbaa !423
  %327 = icmp ugt i64 %326, %106, !dbg !426
  %328 = add nuw i64 %320, 1, !dbg !427
  %329 = and i64 %328, 4294967295, !dbg !427
  %330 = select i1 %327, i64 %314, i64 %329, !dbg !427
  %331 = select i1 %327, i64 %324, i64 %315, !dbg !427
  %332 = select i1 %327, i64 %316, i64 %324, !dbg !427
  call void @llvm.dbg.value(metadata i32 14, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %332, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %331, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %330, metadata !399, metadata !DIExpression()), !dbg !407
  %333 = icmp ult i64 %330, %331, !dbg !412
  br i1 %333, label %334, label %420, !dbg !414

334:                                              ; preds = %323
  %335 = add i64 %331, %330, !dbg !428
  %336 = lshr i64 %335, 1, !dbg !415
  %337 = trunc i64 %336 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %337, metadata !404, metadata !DIExpression()), !dbg !417
  %338 = icmp ugt i32 %337, 249999
  br i1 %338, label %420, label %339, !dbg !418

339:                                              ; preds = %334
  %340 = and i64 %336, 4294967295, !dbg !420
  %341 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %340, i32 0, !dbg !422
  %342 = load i64, i64* %341, align 8, !dbg !422, !tbaa !423
  %343 = icmp ugt i64 %342, %106, !dbg !426
  %344 = add nuw i64 %336, 1, !dbg !427
  %345 = and i64 %344, 4294967295, !dbg !427
  %346 = select i1 %343, i64 %330, i64 %345, !dbg !427
  %347 = select i1 %343, i64 %340, i64 %331, !dbg !427
  %348 = select i1 %343, i64 %332, i64 %340, !dbg !427
  call void @llvm.dbg.value(metadata i32 15, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %348, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %347, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %346, metadata !399, metadata !DIExpression()), !dbg !407
  %349 = icmp ult i64 %346, %347, !dbg !412
  br i1 %349, label %350, label %420, !dbg !414

350:                                              ; preds = %339
  %351 = add i64 %347, %346, !dbg !428
  %352 = lshr i64 %351, 1, !dbg !415
  %353 = trunc i64 %352 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %353, metadata !404, metadata !DIExpression()), !dbg !417
  %354 = icmp ugt i32 %353, 249999
  br i1 %354, label %420, label %355, !dbg !418

355:                                              ; preds = %350
  %356 = and i64 %352, 4294967295, !dbg !420
  %357 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %356, i32 0, !dbg !422
  %358 = load i64, i64* %357, align 8, !dbg !422, !tbaa !423
  %359 = icmp ugt i64 %358, %106, !dbg !426
  %360 = add nuw i64 %352, 1, !dbg !427
  %361 = and i64 %360, 4294967295, !dbg !427
  %362 = select i1 %359, i64 %346, i64 %361, !dbg !427
  %363 = select i1 %359, i64 %356, i64 %347, !dbg !427
  %364 = select i1 %359, i64 %348, i64 %356, !dbg !427
  call void @llvm.dbg.value(metadata i32 16, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %364, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %363, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %362, metadata !399, metadata !DIExpression()), !dbg !407
  %365 = icmp ult i64 %362, %363, !dbg !412
  br i1 %365, label %366, label %420, !dbg !414

366:                                              ; preds = %355
  %367 = add i64 %363, %362, !dbg !428
  %368 = lshr i64 %367, 1, !dbg !415
  %369 = trunc i64 %368 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %369, metadata !404, metadata !DIExpression()), !dbg !417
  %370 = icmp ugt i32 %369, 249999
  br i1 %370, label %420, label %371, !dbg !418

371:                                              ; preds = %366
  %372 = and i64 %368, 4294967295, !dbg !420
  %373 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %372, i32 0, !dbg !422
  %374 = load i64, i64* %373, align 8, !dbg !422, !tbaa !423
  %375 = icmp ugt i64 %374, %106, !dbg !426
  %376 = add nuw i64 %368, 1, !dbg !427
  %377 = and i64 %376, 4294967295, !dbg !427
  %378 = select i1 %375, i64 %362, i64 %377, !dbg !427
  %379 = select i1 %375, i64 %372, i64 %363, !dbg !427
  %380 = select i1 %375, i64 %364, i64 %372, !dbg !427
  call void @llvm.dbg.value(metadata i32 17, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %380, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %379, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %378, metadata !399, metadata !DIExpression()), !dbg !407
  %381 = icmp ult i64 %378, %379, !dbg !412
  br i1 %381, label %382, label %420, !dbg !414

382:                                              ; preds = %371
  %383 = add i64 %379, %378, !dbg !428
  %384 = lshr i64 %383, 1, !dbg !415
  %385 = trunc i64 %384 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %385, metadata !404, metadata !DIExpression()), !dbg !417
  %386 = icmp ugt i32 %385, 249999
  br i1 %386, label %420, label %387, !dbg !418

387:                                              ; preds = %382
  %388 = and i64 %384, 4294967295, !dbg !420
  %389 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %388, i32 0, !dbg !422
  %390 = load i64, i64* %389, align 8, !dbg !422, !tbaa !423
  %391 = icmp ugt i64 %390, %106, !dbg !426
  %392 = add nuw i64 %384, 1, !dbg !427
  %393 = and i64 %392, 4294967295, !dbg !427
  %394 = select i1 %391, i64 %378, i64 %393, !dbg !427
  %395 = select i1 %391, i64 %388, i64 %379, !dbg !427
  %396 = select i1 %391, i64 %380, i64 %388, !dbg !427
  call void @llvm.dbg.value(metadata i32 18, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %396, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %395, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %394, metadata !399, metadata !DIExpression()), !dbg !407
  %397 = icmp ult i64 %394, %395, !dbg !412
  br i1 %397, label %398, label %420, !dbg !414

398:                                              ; preds = %387
  %399 = add i64 %395, %394, !dbg !428
  %400 = lshr i64 %399, 1, !dbg !415
  %401 = trunc i64 %400 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %401, metadata !404, metadata !DIExpression()), !dbg !417
  %402 = icmp ugt i32 %401, 249999
  br i1 %402, label %420, label %403, !dbg !418

403:                                              ; preds = %398
  %404 = and i64 %400, 4294967295, !dbg !420
  %405 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %105, i64 0, i32 4, i64 %404, i32 0, !dbg !422
  %406 = load i64, i64* %405, align 8, !dbg !422, !tbaa !423
  %407 = icmp ugt i64 %406, %106, !dbg !426
  %408 = add nuw i64 %400, 1, !dbg !427
  %409 = and i64 %408, 4294967295, !dbg !427
  %410 = select i1 %407, i64 %394, i64 %409, !dbg !427
  %411 = select i1 %407, i64 %404, i64 %395, !dbg !427
  %412 = select i1 %407, i64 %396, i64 %404, !dbg !427
  call void @llvm.dbg.value(metadata i32 19, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %412, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %411, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %410, metadata !399, metadata !DIExpression()), !dbg !407
  %413 = icmp ult i64 %410, %411, !dbg !412
  br i1 %413, label %414, label %420, !dbg !414

414:                                              ; preds = %403
  %415 = add i64 %411, %410, !dbg !428
  %416 = lshr i64 %415, 1, !dbg !415
  %417 = trunc i64 %416 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %417, metadata !404, metadata !DIExpression()), !dbg !417
  %418 = icmp ugt i32 %417, 249999
  br i1 %418, label %420, label %419, !dbg !418

419:                                              ; preds = %414
  call void @llvm.dbg.value(metadata i64 undef, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !399, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i32 20, metadata !402, metadata !DIExpression()), !dbg !411
  br label %420

420:                                              ; preds = %103, %111, %115, %126, %131, %142, %147, %158, %163, %174, %179, %190, %195, %206, %211, %222, %227, %238, %243, %254, %259, %270, %275, %286, %291, %302, %307, %318, %323, %334, %339, %350, %355, %366, %371, %382, %387, %398, %403, %414, %419
  %421 = phi i64 [ 16431834, %103 ], [ 3735928559, %111 ], [ %124, %115 ], [ 3735928559, %126 ], [ %140, %131 ], [ 3735928559, %142 ], [ %156, %147 ], [ 3735928559, %158 ], [ %172, %163 ], [ 3735928559, %174 ], [ %188, %179 ], [ 3735928559, %190 ], [ %204, %195 ], [ 3735928559, %206 ], [ %220, %211 ], [ 3735928559, %222 ], [ %236, %227 ], [ 3735928559, %238 ], [ %252, %243 ], [ 3735928559, %254 ], [ %268, %259 ], [ 3735928559, %270 ], [ %284, %275 ], [ 3735928559, %286 ], [ %300, %291 ], [ 3735928559, %302 ], [ %316, %307 ], [ 3735928559, %318 ], [ %332, %323 ], [ 3735928559, %334 ], [ %348, %339 ], [ 3735928559, %350 ], [ %364, %355 ], [ 3735928559, %366 ], [ %380, %371 ], [ 3735928559, %382 ], [ %396, %387 ], [ 3735928559, %398 ], [ %412, %403 ], [ 3735928559, %414 ], [ 12246957, %419 ]
  call void @llvm.dbg.value(metadata i64 %421, metadata !302, metadata !DIExpression()), !dbg !384
  %422 = icmp eq i64 %421, 16431834, !dbg !429
  %423 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %422)
  %424 = freeze i1 %423, !dbg !431
  br i1 %424, label %2850, label %425, !dbg !431

425:                                              ; preds = %420
  switch i64 %421, label %426 [
    i64 3735928559, label %2850
    i64 12246957, label %2850
  ], !dbg !431

426:                                              ; preds = %425
  %427 = load i64, i64* %19, align 8, !dbg !432, !tbaa !433
  call void @llvm.dbg.value(metadata i64 %427, metadata !303, metadata !DIExpression()), !dbg !384
  %428 = icmp ult i64 %427, 115
  br i1 %428, label %429, label %431, !dbg !434

429:                                              ; preds = %426
  %430 = getelementptr inbounds [115 x i64], [115 x i64]* %21, i64 0, i64 %427, !dbg !436
  store i64 %106, i64* %430, align 8, !dbg !438, !tbaa !329
  br label %431, !dbg !439

431:                                              ; preds = %429, %426
  call void @llvm.dbg.value(metadata i64 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !384
  call void @llvm.dbg.value(metadata i16 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  %432 = getelementptr inbounds i8, i8* %104, i64 4000027, !dbg !440
  %433 = load i8, i8* %432, align 1, !dbg !440, !tbaa.struct !441
  call void @llvm.dbg.value(metadata i8 %433, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 88, 8)), !dbg !384
  %434 = getelementptr inbounds i8, i8* %104, i64 4000028, !dbg !440
  %435 = bitcast i8* %434 to i16*, !dbg !440
  %436 = load i16, i16* %435, align 4, !dbg !440, !tbaa.struct !444
  call void @llvm.dbg.value(metadata i16 %436, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !384
  %437 = getelementptr inbounds i8, i8* %104, i64 4000030, !dbg !440
  %438 = bitcast i8* %437 to i16*, !dbg !440
  %439 = load i16, i16* %438, align 2, !dbg !440, !tbaa.struct !445
  call void @llvm.dbg.value(metadata i16 %439, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i64 undef, metadata !305, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 %433, metadata !307, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %436, metadata !308, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %439, metadata !309, metadata !DIExpression()), !dbg !384
  %440 = icmp eq i8 %433, 2, !dbg !446
  %441 = icmp eq i8 %433, 3
  %442 = call i1 @llvm.bpf.passthrough.i1.i1(i32 1, i1 %440)
  %443 = select i1 %442, i1 true, i1 %441, !dbg !448
  br i1 %443, label %2850, label %444, !dbg !448

444:                                              ; preds = %431
  %445 = getelementptr inbounds i8, i8* %104, i64 4000026, !dbg !440
  %446 = load i8, i8* %445, align 2, !dbg !440, !tbaa.struct !449
  call void @llvm.dbg.value(metadata i8 %446, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  call void @llvm.dbg.value(metadata i8 %446, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i64 0, metadata !310, metadata !DIExpression()), !dbg !384
  switch i8 %446, label %2850 [
    i8 1, label %447
    i8 2, label %451
    i8 3, label %455
  ], !dbg !450

447:                                              ; preds = %444
  %448 = load i64, i64* %25, align 8, !dbg !451, !tbaa !389
  %449 = sext i16 %436 to i64, !dbg !453
  %450 = add i64 %448, %449, !dbg !454
  call void @llvm.dbg.value(metadata i64 %450, metadata !310, metadata !DIExpression()), !dbg !384
  br label %466, !dbg !455

451:                                              ; preds = %444
  %452 = load i64, i64* %23, align 8, !dbg !456, !tbaa !458
  %453 = sext i16 %436 to i64, !dbg !459
  %454 = add i64 %452, %453, !dbg !460
  call void @llvm.dbg.value(metadata i64 %454, metadata !310, metadata !DIExpression()), !dbg !384
  br label %466, !dbg !461

455:                                              ; preds = %444
  switch i16 %436, label %2850 [
    i16 2, label %456
    i16 1, label %457
  ], !dbg !462

456:                                              ; preds = %455
  call void @llvm.dbg.value(metadata i64 10, metadata !311, metadata !DIExpression()), !dbg !463
  br label %457, !dbg !464

457:                                              ; preds = %455, %456
  %458 = phi i64 [ 11, %455 ], [ 10, %456 ]
  call void @llvm.dbg.value(metadata i64 0, metadata !311, metadata !DIExpression()), !dbg !463
  %459 = load i64, i64* %23, align 8, !dbg !468, !tbaa !458
  %460 = add i64 %459, 8, !dbg !469
  %461 = load i64, i64* %14, align 8, !dbg !470, !tbaa !339
  %462 = and i64 %461, 15, !dbg !471
  %463 = icmp ult i64 %462, %458, !dbg !472
  %464 = select i1 %463, i64 0, i64 8, !dbg !473
  %465 = add i64 %460, %464, !dbg !474
  call void @llvm.dbg.value(metadata i64 %465, metadata !310, metadata !DIExpression()), !dbg !384
  br label %466

466:                                              ; preds = %457, %451, %447
  %467 = phi i64 [ %450, %447 ], [ %454, %451 ], [ %465, %457 ], !dbg !384
  call void @llvm.dbg.value(metadata i64 %467, metadata !310, metadata !DIExpression()), !dbg !384
  %468 = icmp eq i64 %467, 0, !dbg !475
  br i1 %468, label %2850, label %469, !dbg !477

469:                                              ; preds = %466
  %470 = add i64 %467, -8, !dbg !478
  call void @llvm.dbg.value(metadata i64 %470, metadata !316, metadata !DIExpression()), !dbg !384
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %26) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 0, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %6, align 8, !dbg !480, !tbaa !329
  %471 = inttoptr i64 %470 to i8*, !dbg !481
  call void @llvm.dbg.value(metadata i64* %6, metadata !317, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %472 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %26, i32 noundef 8, i8* noundef %471) #6, !dbg !482
  call void @llvm.dbg.value(metadata i64 %472, metadata !318, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !384
  %473 = load i64, i64* %6, align 8, !dbg !483, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %473, metadata !317, metadata !DIExpression()), !dbg !384
  %474 = icmp eq i64 %473, 0, !dbg !485
  br i1 %474, label %475, label %476, !dbg !486

475:                                              ; preds = %2319, %1857, %1395, %933, %469
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  br label %2850

476:                                              ; preds = %469
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #6, !dbg !488
  call void @llvm.dbg.value(metadata i64 0, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %7, align 8, !dbg !489, !tbaa !329
  %477 = icmp eq i8 %433, 0, !dbg !490
  br i1 %477, label %478, label %480, !dbg !491

478:                                              ; preds = %476
  %479 = load i64, i64* %25, align 8, !dbg !492, !tbaa !389
  call void @llvm.dbg.value(metadata i64 %479, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %479, i64* %7, align 8, !dbg !494, !tbaa !329
  br label %490, !dbg !495

480:                                              ; preds = %476
  %481 = sext i16 %439 to i64, !dbg !496
  %482 = add i64 %467, %481, !dbg !497
  call void @llvm.dbg.value(metadata i64 %482, metadata !320, metadata !DIExpression()), !dbg !498
  %483 = inttoptr i64 %482 to i8*, !dbg !499
  call void @llvm.dbg.value(metadata i64* %7, metadata !319, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %484 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %27, i32 noundef 8, i8* noundef %483) #6, !dbg !500
  %485 = trunc i64 %484 to i32, !dbg !500
  call void @llvm.dbg.value(metadata i32 %485, metadata !323, metadata !DIExpression()), !dbg !498
  %486 = icmp eq i32 %485, 0, !dbg !501
  br i1 %486, label %487, label %489

487:                                              ; preds = %480
  %488 = load i64, i64* %6, align 8, !dbg !503, !tbaa !329
  br label %490

489:                                              ; preds = %2327, %1865, %1403, %941, %480
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  br label %2850

490:                                              ; preds = %487, %478
  %491 = phi i64 [ %488, %487 ], [ %473, %478 ], !dbg !503
  call void @llvm.dbg.value(metadata i64 %491, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 %491, i64* %14, align 8, !dbg !504, !tbaa !339
  store i64 %467, i64* %23, align 8, !dbg !505, !tbaa !458
  %492 = load i64, i64* %7, align 8, !dbg !506, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %492, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %492, i64* %25, align 8, !dbg !507, !tbaa !389
  %493 = load i64, i64* %19, align 8, !dbg !508, !tbaa !433
  %494 = add i64 %493, 1, !dbg !508
  store i64 %494, i64* %19, align 8, !dbg !508, !tbaa !433
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 1, metadata !297, metadata !DIExpression()), !dbg !337
  call void @llvm.dbg.value(metadata i32 1, metadata !297, metadata !DIExpression()), !dbg !337
  %495 = load i64, i64* %14, align 8, !dbg !338, !tbaa !339
  call void @llvm.dbg.value(metadata i32 %9, metadata !343, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 %495, metadata !350, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #6, !dbg !359
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %4, metadata !351, metadata !DIExpression()) #6, !dbg !360
  store i32 %9, i32* %16, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 0, i32* %17, align 4, !dbg !365, !tbaa !366
  %496 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %496, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %497 = icmp eq i8* %496, null, !dbg !369
  br i1 %497, label %507, label %498, !dbg !371

498:                                              ; preds = %490
  %499 = bitcast i8* %496 to i64*, !dbg !372
  %500 = load i64, i64* %499, align 8, !dbg !372, !tbaa !375
  %501 = icmp ugt i64 %500, %495, !dbg !377
  br i1 %501, label %507, label %502, !dbg !378

502:                                              ; preds = %498
  %503 = getelementptr inbounds i8, i8* %496, i64 8, !dbg !379
  %504 = bitcast i8* %503 to i64*, !dbg !379
  %505 = load i64, i64* %504, align 8, !dbg !379, !tbaa !380
  %506 = icmp ult i64 %505, %495, !dbg !381
  br i1 %506, label %507, label %567, !dbg !382

507:                                              ; preds = %502, %498, %490
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 1, i32* %17, align 4, !dbg !365, !tbaa !366
  %508 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %508, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %509 = icmp eq i8* %508, null, !dbg !369
  br i1 %509, label %519, label %510, !dbg !371

510:                                              ; preds = %507
  %511 = bitcast i8* %508 to i64*, !dbg !372
  %512 = load i64, i64* %511, align 8, !dbg !372, !tbaa !375
  %513 = icmp ugt i64 %512, %495, !dbg !377
  br i1 %513, label %519, label %514, !dbg !378

514:                                              ; preds = %510
  %515 = getelementptr inbounds i8, i8* %508, i64 8, !dbg !379
  %516 = bitcast i8* %515 to i64*, !dbg !379
  %517 = load i64, i64* %516, align 8, !dbg !379, !tbaa !380
  %518 = icmp ult i64 %517, %495, !dbg !381
  br i1 %518, label %519, label %567, !dbg !382

519:                                              ; preds = %514, %510, %507
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 2, i32* %17, align 4, !dbg !365, !tbaa !366
  %520 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %520, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %521 = icmp eq i8* %520, null, !dbg !369
  br i1 %521, label %531, label %522, !dbg !371

522:                                              ; preds = %519
  %523 = bitcast i8* %520 to i64*, !dbg !372
  %524 = load i64, i64* %523, align 8, !dbg !372, !tbaa !375
  %525 = icmp ugt i64 %524, %495, !dbg !377
  br i1 %525, label %531, label %526, !dbg !378

526:                                              ; preds = %522
  %527 = getelementptr inbounds i8, i8* %520, i64 8, !dbg !379
  %528 = bitcast i8* %527 to i64*, !dbg !379
  %529 = load i64, i64* %528, align 8, !dbg !379, !tbaa !380
  %530 = icmp ult i64 %529, %495, !dbg !381
  br i1 %530, label %531, label %567, !dbg !382

531:                                              ; preds = %526, %522, %519
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 3, i32* %17, align 4, !dbg !365, !tbaa !366
  %532 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %532, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %533 = icmp eq i8* %532, null, !dbg !369
  br i1 %533, label %543, label %534, !dbg !371

534:                                              ; preds = %531
  %535 = bitcast i8* %532 to i64*, !dbg !372
  %536 = load i64, i64* %535, align 8, !dbg !372, !tbaa !375
  %537 = icmp ugt i64 %536, %495, !dbg !377
  br i1 %537, label %543, label %538, !dbg !378

538:                                              ; preds = %534
  %539 = getelementptr inbounds i8, i8* %532, i64 8, !dbg !379
  %540 = bitcast i8* %539 to i64*, !dbg !379
  %541 = load i64, i64* %540, align 8, !dbg !379, !tbaa !380
  %542 = icmp ult i64 %541, %495, !dbg !381
  br i1 %542, label %543, label %567, !dbg !382

543:                                              ; preds = %538, %534, %531
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 4, i32* %17, align 4, !dbg !365, !tbaa !366
  %544 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %544, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %545 = icmp eq i8* %544, null, !dbg !369
  br i1 %545, label %555, label %546, !dbg !371

546:                                              ; preds = %543
  %547 = bitcast i8* %544 to i64*, !dbg !372
  %548 = load i64, i64* %547, align 8, !dbg !372, !tbaa !375
  %549 = icmp ugt i64 %548, %495, !dbg !377
  br i1 %549, label %555, label %550, !dbg !378

550:                                              ; preds = %546
  %551 = getelementptr inbounds i8, i8* %544, i64 8, !dbg !379
  %552 = bitcast i8* %551 to i64*, !dbg !379
  %553 = load i64, i64* %552, align 8, !dbg !379, !tbaa !380
  %554 = icmp ult i64 %553, %495, !dbg !381
  br i1 %554, label %555, label %567, !dbg !382

555:                                              ; preds = %550, %546, %543
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 5, i32* %17, align 4, !dbg !365, !tbaa !366
  %556 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %556, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %557 = icmp eq i8* %556, null, !dbg !369
  br i1 %557, label %100, label %558, !dbg !371

558:                                              ; preds = %555
  %559 = bitcast i8* %556 to i64*, !dbg !372
  %560 = load i64, i64* %559, align 8, !dbg !372, !tbaa !375
  %561 = icmp ugt i64 %560, %495, !dbg !377
  br i1 %561, label %100, label %562, !dbg !378

562:                                              ; preds = %558
  %563 = getelementptr inbounds i8, i8* %556, i64 8, !dbg !379
  %564 = bitcast i8* %563 to i64*, !dbg !379
  %565 = load i64, i64* %564, align 8, !dbg !379, !tbaa !380
  %566 = icmp ult i64 %565, %495, !dbg !381
  br i1 %566, label %100, label %567, !dbg !382

567:                                              ; preds = %562, %550, %538, %526, %514, %502
  %568 = phi i8* [ %496, %502 ], [ %508, %514 ], [ %520, %526 ], [ %532, %538 ], [ %544, %550 ], [ %556, %562 ], !dbg !367
  %569 = bitcast i8* %568 to %struct.stack_unwind_table_t*, !dbg !367
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %569, metadata !299, metadata !DIExpression()), !dbg !384
  %570 = load i64, i64* %14, align 8, !dbg !392, !tbaa !339
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %569, metadata !393, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %570, metadata !398, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 0, metadata !399, metadata !DIExpression()), !dbg !407
  %571 = getelementptr inbounds i8, i8* %568, i64 16, !dbg !409
  %572 = bitcast i8* %571 to i64*, !dbg !409
  %573 = load i64, i64* %572, align 8, !dbg !409, !tbaa !410
  call void @llvm.dbg.value(metadata i32 0, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 16431834, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %573, metadata !400, metadata !DIExpression()), !dbg !407
  %574 = icmp eq i64 %573, 0, !dbg !412
  br i1 %574, label %884, label %575, !dbg !414

575:                                              ; preds = %567
  %576 = lshr i64 %573, 1, !dbg !415
  %577 = trunc i64 %576 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %577, metadata !404, metadata !DIExpression()), !dbg !417
  %578 = icmp ugt i32 %577, 249999
  br i1 %578, label %884, label %579, !dbg !418

579:                                              ; preds = %575
  %580 = and i64 %576, 4294967295, !dbg !420
  %581 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %580, i32 0, !dbg !422
  %582 = load i64, i64* %581, align 8, !dbg !422, !tbaa !423
  %583 = icmp ugt i64 %582, %570, !dbg !426
  %584 = add nuw i64 %576, 1, !dbg !427
  %585 = and i64 %584, 4294967295, !dbg !427
  %586 = select i1 %583, i64 0, i64 %585, !dbg !427
  %587 = select i1 %583, i64 %580, i64 %573, !dbg !427
  %588 = select i1 %583, i64 16431834, i64 %580, !dbg !427
  call void @llvm.dbg.value(metadata i32 1, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %588, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %587, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %586, metadata !399, metadata !DIExpression()), !dbg !407
  %589 = icmp ult i64 %586, %587, !dbg !412
  br i1 %589, label %590, label %884, !dbg !414

590:                                              ; preds = %579
  %591 = add i64 %587, %586, !dbg !428
  %592 = lshr i64 %591, 1, !dbg !415
  %593 = trunc i64 %592 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %593, metadata !404, metadata !DIExpression()), !dbg !417
  %594 = icmp ugt i32 %593, 249999
  br i1 %594, label %884, label %595, !dbg !418

595:                                              ; preds = %590
  %596 = and i64 %592, 4294967295, !dbg !420
  %597 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %596, i32 0, !dbg !422
  %598 = load i64, i64* %597, align 8, !dbg !422, !tbaa !423
  %599 = icmp ugt i64 %598, %570, !dbg !426
  %600 = add nuw i64 %592, 1, !dbg !427
  %601 = and i64 %600, 4294967295, !dbg !427
  %602 = select i1 %599, i64 %586, i64 %601, !dbg !427
  %603 = select i1 %599, i64 %596, i64 %587, !dbg !427
  %604 = select i1 %599, i64 %588, i64 %596, !dbg !427
  call void @llvm.dbg.value(metadata i32 2, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %604, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %603, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %602, metadata !399, metadata !DIExpression()), !dbg !407
  %605 = icmp ult i64 %602, %603, !dbg !412
  br i1 %605, label %606, label %884, !dbg !414

606:                                              ; preds = %595
  %607 = add i64 %603, %602, !dbg !428
  %608 = lshr i64 %607, 1, !dbg !415
  %609 = trunc i64 %608 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %609, metadata !404, metadata !DIExpression()), !dbg !417
  %610 = icmp ugt i32 %609, 249999
  br i1 %610, label %884, label %611, !dbg !418

611:                                              ; preds = %606
  %612 = and i64 %608, 4294967295, !dbg !420
  %613 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %612, i32 0, !dbg !422
  %614 = load i64, i64* %613, align 8, !dbg !422, !tbaa !423
  %615 = icmp ugt i64 %614, %570, !dbg !426
  %616 = add nuw i64 %608, 1, !dbg !427
  %617 = and i64 %616, 4294967295, !dbg !427
  %618 = select i1 %615, i64 %602, i64 %617, !dbg !427
  %619 = select i1 %615, i64 %612, i64 %603, !dbg !427
  %620 = select i1 %615, i64 %604, i64 %612, !dbg !427
  call void @llvm.dbg.value(metadata i32 3, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %620, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %619, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %618, metadata !399, metadata !DIExpression()), !dbg !407
  %621 = icmp ult i64 %618, %619, !dbg !412
  br i1 %621, label %622, label %884, !dbg !414

622:                                              ; preds = %611
  %623 = add i64 %619, %618, !dbg !428
  %624 = lshr i64 %623, 1, !dbg !415
  %625 = trunc i64 %624 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %625, metadata !404, metadata !DIExpression()), !dbg !417
  %626 = icmp ugt i32 %625, 249999
  br i1 %626, label %884, label %627, !dbg !418

627:                                              ; preds = %622
  %628 = and i64 %624, 4294967295, !dbg !420
  %629 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %628, i32 0, !dbg !422
  %630 = load i64, i64* %629, align 8, !dbg !422, !tbaa !423
  %631 = icmp ugt i64 %630, %570, !dbg !426
  %632 = add nuw i64 %624, 1, !dbg !427
  %633 = and i64 %632, 4294967295, !dbg !427
  %634 = select i1 %631, i64 %618, i64 %633, !dbg !427
  %635 = select i1 %631, i64 %628, i64 %619, !dbg !427
  %636 = select i1 %631, i64 %620, i64 %628, !dbg !427
  call void @llvm.dbg.value(metadata i32 4, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %636, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %635, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %634, metadata !399, metadata !DIExpression()), !dbg !407
  %637 = icmp ult i64 %634, %635, !dbg !412
  br i1 %637, label %638, label %884, !dbg !414

638:                                              ; preds = %627
  %639 = add i64 %635, %634, !dbg !428
  %640 = lshr i64 %639, 1, !dbg !415
  %641 = trunc i64 %640 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %641, metadata !404, metadata !DIExpression()), !dbg !417
  %642 = icmp ugt i32 %641, 249999
  br i1 %642, label %884, label %643, !dbg !418

643:                                              ; preds = %638
  %644 = and i64 %640, 4294967295, !dbg !420
  %645 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %644, i32 0, !dbg !422
  %646 = load i64, i64* %645, align 8, !dbg !422, !tbaa !423
  %647 = icmp ugt i64 %646, %570, !dbg !426
  %648 = add nuw i64 %640, 1, !dbg !427
  %649 = and i64 %648, 4294967295, !dbg !427
  %650 = select i1 %647, i64 %634, i64 %649, !dbg !427
  %651 = select i1 %647, i64 %644, i64 %635, !dbg !427
  %652 = select i1 %647, i64 %636, i64 %644, !dbg !427
  call void @llvm.dbg.value(metadata i32 5, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %652, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %651, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %650, metadata !399, metadata !DIExpression()), !dbg !407
  %653 = icmp ult i64 %650, %651, !dbg !412
  br i1 %653, label %654, label %884, !dbg !414

654:                                              ; preds = %643
  %655 = add i64 %651, %650, !dbg !428
  %656 = lshr i64 %655, 1, !dbg !415
  %657 = trunc i64 %656 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %657, metadata !404, metadata !DIExpression()), !dbg !417
  %658 = icmp ugt i32 %657, 249999
  br i1 %658, label %884, label %659, !dbg !418

659:                                              ; preds = %654
  %660 = and i64 %656, 4294967295, !dbg !420
  %661 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %660, i32 0, !dbg !422
  %662 = load i64, i64* %661, align 8, !dbg !422, !tbaa !423
  %663 = icmp ugt i64 %662, %570, !dbg !426
  %664 = add nuw i64 %656, 1, !dbg !427
  %665 = and i64 %664, 4294967295, !dbg !427
  %666 = select i1 %663, i64 %650, i64 %665, !dbg !427
  %667 = select i1 %663, i64 %660, i64 %651, !dbg !427
  %668 = select i1 %663, i64 %652, i64 %660, !dbg !427
  call void @llvm.dbg.value(metadata i32 6, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %668, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %667, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %666, metadata !399, metadata !DIExpression()), !dbg !407
  %669 = icmp ult i64 %666, %667, !dbg !412
  br i1 %669, label %670, label %884, !dbg !414

670:                                              ; preds = %659
  %671 = add i64 %667, %666, !dbg !428
  %672 = lshr i64 %671, 1, !dbg !415
  %673 = trunc i64 %672 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %673, metadata !404, metadata !DIExpression()), !dbg !417
  %674 = icmp ugt i32 %673, 249999
  br i1 %674, label %884, label %675, !dbg !418

675:                                              ; preds = %670
  %676 = and i64 %672, 4294967295, !dbg !420
  %677 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %676, i32 0, !dbg !422
  %678 = load i64, i64* %677, align 8, !dbg !422, !tbaa !423
  %679 = icmp ugt i64 %678, %570, !dbg !426
  %680 = add nuw i64 %672, 1, !dbg !427
  %681 = and i64 %680, 4294967295, !dbg !427
  %682 = select i1 %679, i64 %666, i64 %681, !dbg !427
  %683 = select i1 %679, i64 %676, i64 %667, !dbg !427
  %684 = select i1 %679, i64 %668, i64 %676, !dbg !427
  call void @llvm.dbg.value(metadata i32 7, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %684, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %683, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %682, metadata !399, metadata !DIExpression()), !dbg !407
  %685 = icmp ult i64 %682, %683, !dbg !412
  br i1 %685, label %686, label %884, !dbg !414

686:                                              ; preds = %675
  %687 = add i64 %683, %682, !dbg !428
  %688 = lshr i64 %687, 1, !dbg !415
  %689 = trunc i64 %688 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %689, metadata !404, metadata !DIExpression()), !dbg !417
  %690 = icmp ugt i32 %689, 249999
  br i1 %690, label %884, label %691, !dbg !418

691:                                              ; preds = %686
  %692 = and i64 %688, 4294967295, !dbg !420
  %693 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %692, i32 0, !dbg !422
  %694 = load i64, i64* %693, align 8, !dbg !422, !tbaa !423
  %695 = icmp ugt i64 %694, %570, !dbg !426
  %696 = add nuw i64 %688, 1, !dbg !427
  %697 = and i64 %696, 4294967295, !dbg !427
  %698 = select i1 %695, i64 %682, i64 %697, !dbg !427
  %699 = select i1 %695, i64 %692, i64 %683, !dbg !427
  %700 = select i1 %695, i64 %684, i64 %692, !dbg !427
  call void @llvm.dbg.value(metadata i32 8, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %700, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %699, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %698, metadata !399, metadata !DIExpression()), !dbg !407
  %701 = icmp ult i64 %698, %699, !dbg !412
  br i1 %701, label %702, label %884, !dbg !414

702:                                              ; preds = %691
  %703 = add i64 %699, %698, !dbg !428
  %704 = lshr i64 %703, 1, !dbg !415
  %705 = trunc i64 %704 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %705, metadata !404, metadata !DIExpression()), !dbg !417
  %706 = icmp ugt i32 %705, 249999
  br i1 %706, label %884, label %707, !dbg !418

707:                                              ; preds = %702
  %708 = and i64 %704, 4294967295, !dbg !420
  %709 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %708, i32 0, !dbg !422
  %710 = load i64, i64* %709, align 8, !dbg !422, !tbaa !423
  %711 = icmp ugt i64 %710, %570, !dbg !426
  %712 = add nuw i64 %704, 1, !dbg !427
  %713 = and i64 %712, 4294967295, !dbg !427
  %714 = select i1 %711, i64 %698, i64 %713, !dbg !427
  %715 = select i1 %711, i64 %708, i64 %699, !dbg !427
  %716 = select i1 %711, i64 %700, i64 %708, !dbg !427
  call void @llvm.dbg.value(metadata i32 9, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %716, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %715, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %714, metadata !399, metadata !DIExpression()), !dbg !407
  %717 = icmp ult i64 %714, %715, !dbg !412
  br i1 %717, label %718, label %884, !dbg !414

718:                                              ; preds = %707
  %719 = add i64 %715, %714, !dbg !428
  %720 = lshr i64 %719, 1, !dbg !415
  %721 = trunc i64 %720 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %721, metadata !404, metadata !DIExpression()), !dbg !417
  %722 = icmp ugt i32 %721, 249999
  br i1 %722, label %884, label %723, !dbg !418

723:                                              ; preds = %718
  %724 = and i64 %720, 4294967295, !dbg !420
  %725 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %724, i32 0, !dbg !422
  %726 = load i64, i64* %725, align 8, !dbg !422, !tbaa !423
  %727 = icmp ugt i64 %726, %570, !dbg !426
  %728 = add nuw i64 %720, 1, !dbg !427
  %729 = and i64 %728, 4294967295, !dbg !427
  %730 = select i1 %727, i64 %714, i64 %729, !dbg !427
  %731 = select i1 %727, i64 %724, i64 %715, !dbg !427
  %732 = select i1 %727, i64 %716, i64 %724, !dbg !427
  call void @llvm.dbg.value(metadata i32 10, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %732, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %731, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %730, metadata !399, metadata !DIExpression()), !dbg !407
  %733 = icmp ult i64 %730, %731, !dbg !412
  br i1 %733, label %734, label %884, !dbg !414

734:                                              ; preds = %723
  %735 = add i64 %731, %730, !dbg !428
  %736 = lshr i64 %735, 1, !dbg !415
  %737 = trunc i64 %736 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %737, metadata !404, metadata !DIExpression()), !dbg !417
  %738 = icmp ugt i32 %737, 249999
  br i1 %738, label %884, label %739, !dbg !418

739:                                              ; preds = %734
  %740 = and i64 %736, 4294967295, !dbg !420
  %741 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %740, i32 0, !dbg !422
  %742 = load i64, i64* %741, align 8, !dbg !422, !tbaa !423
  %743 = icmp ugt i64 %742, %570, !dbg !426
  %744 = add nuw i64 %736, 1, !dbg !427
  %745 = and i64 %744, 4294967295, !dbg !427
  %746 = select i1 %743, i64 %730, i64 %745, !dbg !427
  %747 = select i1 %743, i64 %740, i64 %731, !dbg !427
  %748 = select i1 %743, i64 %732, i64 %740, !dbg !427
  call void @llvm.dbg.value(metadata i32 11, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %748, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %747, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %746, metadata !399, metadata !DIExpression()), !dbg !407
  %749 = icmp ult i64 %746, %747, !dbg !412
  br i1 %749, label %750, label %884, !dbg !414

750:                                              ; preds = %739
  %751 = add i64 %747, %746, !dbg !428
  %752 = lshr i64 %751, 1, !dbg !415
  %753 = trunc i64 %752 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %753, metadata !404, metadata !DIExpression()), !dbg !417
  %754 = icmp ugt i32 %753, 249999
  br i1 %754, label %884, label %755, !dbg !418

755:                                              ; preds = %750
  %756 = and i64 %752, 4294967295, !dbg !420
  %757 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %756, i32 0, !dbg !422
  %758 = load i64, i64* %757, align 8, !dbg !422, !tbaa !423
  %759 = icmp ugt i64 %758, %570, !dbg !426
  %760 = add nuw i64 %752, 1, !dbg !427
  %761 = and i64 %760, 4294967295, !dbg !427
  %762 = select i1 %759, i64 %746, i64 %761, !dbg !427
  %763 = select i1 %759, i64 %756, i64 %747, !dbg !427
  %764 = select i1 %759, i64 %748, i64 %756, !dbg !427
  call void @llvm.dbg.value(metadata i32 12, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %764, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %763, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %762, metadata !399, metadata !DIExpression()), !dbg !407
  %765 = icmp ult i64 %762, %763, !dbg !412
  br i1 %765, label %766, label %884, !dbg !414

766:                                              ; preds = %755
  %767 = add i64 %763, %762, !dbg !428
  %768 = lshr i64 %767, 1, !dbg !415
  %769 = trunc i64 %768 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %769, metadata !404, metadata !DIExpression()), !dbg !417
  %770 = icmp ugt i32 %769, 249999
  br i1 %770, label %884, label %771, !dbg !418

771:                                              ; preds = %766
  %772 = and i64 %768, 4294967295, !dbg !420
  %773 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %772, i32 0, !dbg !422
  %774 = load i64, i64* %773, align 8, !dbg !422, !tbaa !423
  %775 = icmp ugt i64 %774, %570, !dbg !426
  %776 = add nuw i64 %768, 1, !dbg !427
  %777 = and i64 %776, 4294967295, !dbg !427
  %778 = select i1 %775, i64 %762, i64 %777, !dbg !427
  %779 = select i1 %775, i64 %772, i64 %763, !dbg !427
  %780 = select i1 %775, i64 %764, i64 %772, !dbg !427
  call void @llvm.dbg.value(metadata i32 13, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %780, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %779, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %778, metadata !399, metadata !DIExpression()), !dbg !407
  %781 = icmp ult i64 %778, %779, !dbg !412
  br i1 %781, label %782, label %884, !dbg !414

782:                                              ; preds = %771
  %783 = add i64 %779, %778, !dbg !428
  %784 = lshr i64 %783, 1, !dbg !415
  %785 = trunc i64 %784 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %785, metadata !404, metadata !DIExpression()), !dbg !417
  %786 = icmp ugt i32 %785, 249999
  br i1 %786, label %884, label %787, !dbg !418

787:                                              ; preds = %782
  %788 = and i64 %784, 4294967295, !dbg !420
  %789 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %788, i32 0, !dbg !422
  %790 = load i64, i64* %789, align 8, !dbg !422, !tbaa !423
  %791 = icmp ugt i64 %790, %570, !dbg !426
  %792 = add nuw i64 %784, 1, !dbg !427
  %793 = and i64 %792, 4294967295, !dbg !427
  %794 = select i1 %791, i64 %778, i64 %793, !dbg !427
  %795 = select i1 %791, i64 %788, i64 %779, !dbg !427
  %796 = select i1 %791, i64 %780, i64 %788, !dbg !427
  call void @llvm.dbg.value(metadata i32 14, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %796, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %795, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %794, metadata !399, metadata !DIExpression()), !dbg !407
  %797 = icmp ult i64 %794, %795, !dbg !412
  br i1 %797, label %798, label %884, !dbg !414

798:                                              ; preds = %787
  %799 = add i64 %795, %794, !dbg !428
  %800 = lshr i64 %799, 1, !dbg !415
  %801 = trunc i64 %800 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %801, metadata !404, metadata !DIExpression()), !dbg !417
  %802 = icmp ugt i32 %801, 249999
  br i1 %802, label %884, label %803, !dbg !418

803:                                              ; preds = %798
  %804 = and i64 %800, 4294967295, !dbg !420
  %805 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %804, i32 0, !dbg !422
  %806 = load i64, i64* %805, align 8, !dbg !422, !tbaa !423
  %807 = icmp ugt i64 %806, %570, !dbg !426
  %808 = add nuw i64 %800, 1, !dbg !427
  %809 = and i64 %808, 4294967295, !dbg !427
  %810 = select i1 %807, i64 %794, i64 %809, !dbg !427
  %811 = select i1 %807, i64 %804, i64 %795, !dbg !427
  %812 = select i1 %807, i64 %796, i64 %804, !dbg !427
  call void @llvm.dbg.value(metadata i32 15, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %812, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %811, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %810, metadata !399, metadata !DIExpression()), !dbg !407
  %813 = icmp ult i64 %810, %811, !dbg !412
  br i1 %813, label %814, label %884, !dbg !414

814:                                              ; preds = %803
  %815 = add i64 %811, %810, !dbg !428
  %816 = lshr i64 %815, 1, !dbg !415
  %817 = trunc i64 %816 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %817, metadata !404, metadata !DIExpression()), !dbg !417
  %818 = icmp ugt i32 %817, 249999
  br i1 %818, label %884, label %819, !dbg !418

819:                                              ; preds = %814
  %820 = and i64 %816, 4294967295, !dbg !420
  %821 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %820, i32 0, !dbg !422
  %822 = load i64, i64* %821, align 8, !dbg !422, !tbaa !423
  %823 = icmp ugt i64 %822, %570, !dbg !426
  %824 = add nuw i64 %816, 1, !dbg !427
  %825 = and i64 %824, 4294967295, !dbg !427
  %826 = select i1 %823, i64 %810, i64 %825, !dbg !427
  %827 = select i1 %823, i64 %820, i64 %811, !dbg !427
  %828 = select i1 %823, i64 %812, i64 %820, !dbg !427
  call void @llvm.dbg.value(metadata i32 16, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %828, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %827, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %826, metadata !399, metadata !DIExpression()), !dbg !407
  %829 = icmp ult i64 %826, %827, !dbg !412
  br i1 %829, label %830, label %884, !dbg !414

830:                                              ; preds = %819
  %831 = add i64 %827, %826, !dbg !428
  %832 = lshr i64 %831, 1, !dbg !415
  %833 = trunc i64 %832 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %833, metadata !404, metadata !DIExpression()), !dbg !417
  %834 = icmp ugt i32 %833, 249999
  br i1 %834, label %884, label %835, !dbg !418

835:                                              ; preds = %830
  %836 = and i64 %832, 4294967295, !dbg !420
  %837 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %836, i32 0, !dbg !422
  %838 = load i64, i64* %837, align 8, !dbg !422, !tbaa !423
  %839 = icmp ugt i64 %838, %570, !dbg !426
  %840 = add nuw i64 %832, 1, !dbg !427
  %841 = and i64 %840, 4294967295, !dbg !427
  %842 = select i1 %839, i64 %826, i64 %841, !dbg !427
  %843 = select i1 %839, i64 %836, i64 %827, !dbg !427
  %844 = select i1 %839, i64 %828, i64 %836, !dbg !427
  call void @llvm.dbg.value(metadata i32 17, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %844, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %843, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %842, metadata !399, metadata !DIExpression()), !dbg !407
  %845 = icmp ult i64 %842, %843, !dbg !412
  br i1 %845, label %846, label %884, !dbg !414

846:                                              ; preds = %835
  %847 = add i64 %843, %842, !dbg !428
  %848 = lshr i64 %847, 1, !dbg !415
  %849 = trunc i64 %848 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %849, metadata !404, metadata !DIExpression()), !dbg !417
  %850 = icmp ugt i32 %849, 249999
  br i1 %850, label %884, label %851, !dbg !418

851:                                              ; preds = %846
  %852 = and i64 %848, 4294967295, !dbg !420
  %853 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %852, i32 0, !dbg !422
  %854 = load i64, i64* %853, align 8, !dbg !422, !tbaa !423
  %855 = icmp ugt i64 %854, %570, !dbg !426
  %856 = add nuw i64 %848, 1, !dbg !427
  %857 = and i64 %856, 4294967295, !dbg !427
  %858 = select i1 %855, i64 %842, i64 %857, !dbg !427
  %859 = select i1 %855, i64 %852, i64 %843, !dbg !427
  %860 = select i1 %855, i64 %844, i64 %852, !dbg !427
  call void @llvm.dbg.value(metadata i32 18, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %860, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %859, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %858, metadata !399, metadata !DIExpression()), !dbg !407
  %861 = icmp ult i64 %858, %859, !dbg !412
  br i1 %861, label %862, label %884, !dbg !414

862:                                              ; preds = %851
  %863 = add i64 %859, %858, !dbg !428
  %864 = lshr i64 %863, 1, !dbg !415
  %865 = trunc i64 %864 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %865, metadata !404, metadata !DIExpression()), !dbg !417
  %866 = icmp ugt i32 %865, 249999
  br i1 %866, label %884, label %867, !dbg !418

867:                                              ; preds = %862
  %868 = and i64 %864, 4294967295, !dbg !420
  %869 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %569, i64 0, i32 4, i64 %868, i32 0, !dbg !422
  %870 = load i64, i64* %869, align 8, !dbg !422, !tbaa !423
  %871 = icmp ugt i64 %870, %570, !dbg !426
  %872 = add nuw i64 %864, 1, !dbg !427
  %873 = and i64 %872, 4294967295, !dbg !427
  %874 = select i1 %871, i64 %858, i64 %873, !dbg !427
  %875 = select i1 %871, i64 %868, i64 %859, !dbg !427
  %876 = select i1 %871, i64 %860, i64 %868, !dbg !427
  call void @llvm.dbg.value(metadata i32 19, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %876, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %875, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %874, metadata !399, metadata !DIExpression()), !dbg !407
  %877 = icmp ult i64 %874, %875, !dbg !412
  br i1 %877, label %878, label %884, !dbg !414

878:                                              ; preds = %867
  %879 = add i64 %875, %874, !dbg !428
  %880 = lshr i64 %879, 1, !dbg !415
  %881 = trunc i64 %880 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %881, metadata !404, metadata !DIExpression()), !dbg !417
  %882 = icmp ugt i32 %881, 249999
  br i1 %882, label %884, label %883, !dbg !418

883:                                              ; preds = %878
  call void @llvm.dbg.value(metadata i64 undef, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !399, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i32 20, metadata !402, metadata !DIExpression()), !dbg !411
  br label %884

884:                                              ; preds = %883, %878, %867, %862, %851, %846, %835, %830, %819, %814, %803, %798, %787, %782, %771, %766, %755, %750, %739, %734, %723, %718, %707, %702, %691, %686, %675, %670, %659, %654, %643, %638, %627, %622, %611, %606, %595, %590, %579, %575, %567
  %885 = phi i64 [ 16431834, %567 ], [ 3735928559, %575 ], [ %588, %579 ], [ 3735928559, %590 ], [ %604, %595 ], [ 3735928559, %606 ], [ %620, %611 ], [ 3735928559, %622 ], [ %636, %627 ], [ 3735928559, %638 ], [ %652, %643 ], [ 3735928559, %654 ], [ %668, %659 ], [ 3735928559, %670 ], [ %684, %675 ], [ 3735928559, %686 ], [ %700, %691 ], [ 3735928559, %702 ], [ %716, %707 ], [ 3735928559, %718 ], [ %732, %723 ], [ 3735928559, %734 ], [ %748, %739 ], [ 3735928559, %750 ], [ %764, %755 ], [ 3735928559, %766 ], [ %780, %771 ], [ 3735928559, %782 ], [ %796, %787 ], [ 3735928559, %798 ], [ %812, %803 ], [ 3735928559, %814 ], [ %828, %819 ], [ 3735928559, %830 ], [ %844, %835 ], [ 3735928559, %846 ], [ %860, %851 ], [ 3735928559, %862 ], [ %876, %867 ], [ 3735928559, %878 ], [ 12246957, %883 ]
  call void @llvm.dbg.value(metadata i64 %885, metadata !302, metadata !DIExpression()), !dbg !384
  %886 = icmp eq i64 %885, 16431834, !dbg !429
  %887 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %886)
  %888 = freeze i1 %887, !dbg !431
  br i1 %888, label %2850, label %889, !dbg !431

889:                                              ; preds = %884
  switch i64 %885, label %890 [
    i64 3735928559, label %2850
    i64 12246957, label %2850
  ], !dbg !431

890:                                              ; preds = %889
  %891 = load i64, i64* %19, align 8, !dbg !432, !tbaa !433
  call void @llvm.dbg.value(metadata i64 %891, metadata !303, metadata !DIExpression()), !dbg !384
  %892 = icmp ult i64 %891, 115
  br i1 %892, label %893, label %895, !dbg !434

893:                                              ; preds = %890
  %894 = getelementptr inbounds [115 x i64], [115 x i64]* %21, i64 0, i64 %891, !dbg !436
  store i64 %570, i64* %894, align 8, !dbg !438, !tbaa !329
  br label %895, !dbg !439

895:                                              ; preds = %893, %890
  call void @llvm.dbg.value(metadata i64 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !384
  call void @llvm.dbg.value(metadata i16 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  %896 = getelementptr inbounds i8, i8* %568, i64 4000027, !dbg !440
  %897 = load i8, i8* %896, align 1, !dbg !440, !tbaa.struct !441
  call void @llvm.dbg.value(metadata i8 %897, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 88, 8)), !dbg !384
  %898 = getelementptr inbounds i8, i8* %568, i64 4000028, !dbg !440
  %899 = bitcast i8* %898 to i16*, !dbg !440
  %900 = load i16, i16* %899, align 4, !dbg !440, !tbaa.struct !444
  call void @llvm.dbg.value(metadata i16 %900, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !384
  %901 = getelementptr inbounds i8, i8* %568, i64 4000030, !dbg !440
  %902 = bitcast i8* %901 to i16*, !dbg !440
  %903 = load i16, i16* %902, align 2, !dbg !440, !tbaa.struct !445
  call void @llvm.dbg.value(metadata i16 %903, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i64 undef, metadata !305, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 %897, metadata !307, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %900, metadata !308, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %903, metadata !309, metadata !DIExpression()), !dbg !384
  %904 = icmp eq i8 %897, 2, !dbg !446
  %905 = icmp eq i8 %897, 3
  %906 = call i1 @llvm.bpf.passthrough.i1.i1(i32 1, i1 %904)
  %907 = select i1 %906, i1 true, i1 %905, !dbg !448
  br i1 %907, label %2850, label %908, !dbg !448

908:                                              ; preds = %895
  %909 = getelementptr inbounds i8, i8* %568, i64 4000026, !dbg !440
  %910 = load i8, i8* %909, align 2, !dbg !440, !tbaa.struct !449
  call void @llvm.dbg.value(metadata i8 %910, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  call void @llvm.dbg.value(metadata i8 %910, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i64 0, metadata !310, metadata !DIExpression()), !dbg !384
  switch i8 %910, label %2850 [
    i8 1, label %926
    i8 2, label %922
    i8 3, label %911
  ], !dbg !450

911:                                              ; preds = %908
  switch i16 %900, label %2850 [
    i16 2, label %912
    i16 1, label %913
  ], !dbg !462

912:                                              ; preds = %911
  call void @llvm.dbg.value(metadata i64 10, metadata !311, metadata !DIExpression()), !dbg !463
  br label %913, !dbg !464

913:                                              ; preds = %912, %911
  %914 = phi i64 [ 11, %911 ], [ 10, %912 ]
  call void @llvm.dbg.value(metadata i64 0, metadata !311, metadata !DIExpression()), !dbg !463
  %915 = load i64, i64* %23, align 8, !dbg !468, !tbaa !458
  %916 = add i64 %915, 8, !dbg !469
  %917 = load i64, i64* %14, align 8, !dbg !470, !tbaa !339
  %918 = and i64 %917, 15, !dbg !471
  %919 = icmp ult i64 %918, %914, !dbg !472
  %920 = select i1 %919, i64 0, i64 8, !dbg !473
  %921 = add i64 %916, %920, !dbg !474
  call void @llvm.dbg.value(metadata i64 %921, metadata !310, metadata !DIExpression()), !dbg !384
  br label %930

922:                                              ; preds = %908
  %923 = load i64, i64* %23, align 8, !dbg !456, !tbaa !458
  %924 = sext i16 %900 to i64, !dbg !459
  %925 = add i64 %923, %924, !dbg !460
  call void @llvm.dbg.value(metadata i64 %925, metadata !310, metadata !DIExpression()), !dbg !384
  br label %930, !dbg !461

926:                                              ; preds = %908
  %927 = load i64, i64* %25, align 8, !dbg !451, !tbaa !389
  %928 = sext i16 %900 to i64, !dbg !453
  %929 = add i64 %927, %928, !dbg !454
  call void @llvm.dbg.value(metadata i64 %929, metadata !310, metadata !DIExpression()), !dbg !384
  br label %930, !dbg !455

930:                                              ; preds = %926, %922, %913
  %931 = phi i64 [ %929, %926 ], [ %925, %922 ], [ %921, %913 ], !dbg !384
  call void @llvm.dbg.value(metadata i64 %931, metadata !310, metadata !DIExpression()), !dbg !384
  %932 = icmp eq i64 %931, 0, !dbg !475
  br i1 %932, label %2850, label %933, !dbg !477

933:                                              ; preds = %930
  %934 = add i64 %931, -8, !dbg !478
  call void @llvm.dbg.value(metadata i64 %934, metadata !316, metadata !DIExpression()), !dbg !384
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %26) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 0, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %6, align 8, !dbg !480, !tbaa !329
  %935 = inttoptr i64 %934 to i8*, !dbg !481
  call void @llvm.dbg.value(metadata i64* %6, metadata !317, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %936 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %26, i32 noundef 8, i8* noundef %935) #6, !dbg !482
  call void @llvm.dbg.value(metadata i64 %936, metadata !318, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !384
  %937 = load i64, i64* %6, align 8, !dbg !483, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %937, metadata !317, metadata !DIExpression()), !dbg !384
  %938 = icmp eq i64 %937, 0, !dbg !485
  br i1 %938, label %475, label %939, !dbg !486

939:                                              ; preds = %933
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #6, !dbg !488
  call void @llvm.dbg.value(metadata i64 0, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %7, align 8, !dbg !489, !tbaa !329
  %940 = icmp eq i8 %897, 0, !dbg !490
  br i1 %940, label %950, label %941, !dbg !491

941:                                              ; preds = %939
  %942 = sext i16 %903 to i64, !dbg !496
  %943 = add i64 %931, %942, !dbg !497
  call void @llvm.dbg.value(metadata i64 %943, metadata !320, metadata !DIExpression()), !dbg !498
  %944 = inttoptr i64 %943 to i8*, !dbg !499
  call void @llvm.dbg.value(metadata i64* %7, metadata !319, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %945 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %27, i32 noundef 8, i8* noundef %944) #6, !dbg !500
  %946 = trunc i64 %945 to i32, !dbg !500
  call void @llvm.dbg.value(metadata i32 %946, metadata !323, metadata !DIExpression()), !dbg !498
  %947 = icmp eq i32 %946, 0, !dbg !501
  br i1 %947, label %948, label %489

948:                                              ; preds = %941
  %949 = load i64, i64* %6, align 8, !dbg !503, !tbaa !329
  br label %952

950:                                              ; preds = %939
  %951 = load i64, i64* %25, align 8, !dbg !492, !tbaa !389
  call void @llvm.dbg.value(metadata i64 %951, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %951, i64* %7, align 8, !dbg !494, !tbaa !329
  br label %952, !dbg !495

952:                                              ; preds = %948, %950
  %953 = phi i64 [ %949, %948 ], [ %937, %950 ], !dbg !503
  call void @llvm.dbg.value(metadata i64 %953, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 %953, i64* %14, align 8, !dbg !504, !tbaa !339
  store i64 %931, i64* %23, align 8, !dbg !505, !tbaa !458
  %954 = load i64, i64* %7, align 8, !dbg !506, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %954, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %954, i64* %25, align 8, !dbg !507, !tbaa !389
  %955 = load i64, i64* %19, align 8, !dbg !508, !tbaa !433
  %956 = add i64 %955, 1, !dbg !508
  store i64 %956, i64* %19, align 8, !dbg !508, !tbaa !433
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 2, metadata !297, metadata !DIExpression()), !dbg !337
  call void @llvm.dbg.value(metadata i32 2, metadata !297, metadata !DIExpression()), !dbg !337
  %957 = load i64, i64* %14, align 8, !dbg !338, !tbaa !339
  call void @llvm.dbg.value(metadata i32 %9, metadata !343, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 %957, metadata !350, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #6, !dbg !359
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %4, metadata !351, metadata !DIExpression()) #6, !dbg !360
  store i32 %9, i32* %16, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 0, i32* %17, align 4, !dbg !365, !tbaa !366
  %958 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %958, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %959 = icmp eq i8* %958, null, !dbg !369
  br i1 %959, label %969, label %960, !dbg !371

960:                                              ; preds = %952
  %961 = bitcast i8* %958 to i64*, !dbg !372
  %962 = load i64, i64* %961, align 8, !dbg !372, !tbaa !375
  %963 = icmp ugt i64 %962, %957, !dbg !377
  br i1 %963, label %969, label %964, !dbg !378

964:                                              ; preds = %960
  %965 = getelementptr inbounds i8, i8* %958, i64 8, !dbg !379
  %966 = bitcast i8* %965 to i64*, !dbg !379
  %967 = load i64, i64* %966, align 8, !dbg !379, !tbaa !380
  %968 = icmp ult i64 %967, %957, !dbg !381
  br i1 %968, label %969, label %1029, !dbg !382

969:                                              ; preds = %964, %960, %952
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 1, i32* %17, align 4, !dbg !365, !tbaa !366
  %970 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %970, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %971 = icmp eq i8* %970, null, !dbg !369
  br i1 %971, label %981, label %972, !dbg !371

972:                                              ; preds = %969
  %973 = bitcast i8* %970 to i64*, !dbg !372
  %974 = load i64, i64* %973, align 8, !dbg !372, !tbaa !375
  %975 = icmp ugt i64 %974, %957, !dbg !377
  br i1 %975, label %981, label %976, !dbg !378

976:                                              ; preds = %972
  %977 = getelementptr inbounds i8, i8* %970, i64 8, !dbg !379
  %978 = bitcast i8* %977 to i64*, !dbg !379
  %979 = load i64, i64* %978, align 8, !dbg !379, !tbaa !380
  %980 = icmp ult i64 %979, %957, !dbg !381
  br i1 %980, label %981, label %1029, !dbg !382

981:                                              ; preds = %976, %972, %969
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 2, i32* %17, align 4, !dbg !365, !tbaa !366
  %982 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %982, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %983 = icmp eq i8* %982, null, !dbg !369
  br i1 %983, label %993, label %984, !dbg !371

984:                                              ; preds = %981
  %985 = bitcast i8* %982 to i64*, !dbg !372
  %986 = load i64, i64* %985, align 8, !dbg !372, !tbaa !375
  %987 = icmp ugt i64 %986, %957, !dbg !377
  br i1 %987, label %993, label %988, !dbg !378

988:                                              ; preds = %984
  %989 = getelementptr inbounds i8, i8* %982, i64 8, !dbg !379
  %990 = bitcast i8* %989 to i64*, !dbg !379
  %991 = load i64, i64* %990, align 8, !dbg !379, !tbaa !380
  %992 = icmp ult i64 %991, %957, !dbg !381
  br i1 %992, label %993, label %1029, !dbg !382

993:                                              ; preds = %988, %984, %981
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 3, i32* %17, align 4, !dbg !365, !tbaa !366
  %994 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %994, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %995 = icmp eq i8* %994, null, !dbg !369
  br i1 %995, label %1005, label %996, !dbg !371

996:                                              ; preds = %993
  %997 = bitcast i8* %994 to i64*, !dbg !372
  %998 = load i64, i64* %997, align 8, !dbg !372, !tbaa !375
  %999 = icmp ugt i64 %998, %957, !dbg !377
  br i1 %999, label %1005, label %1000, !dbg !378

1000:                                             ; preds = %996
  %1001 = getelementptr inbounds i8, i8* %994, i64 8, !dbg !379
  %1002 = bitcast i8* %1001 to i64*, !dbg !379
  %1003 = load i64, i64* %1002, align 8, !dbg !379, !tbaa !380
  %1004 = icmp ult i64 %1003, %957, !dbg !381
  br i1 %1004, label %1005, label %1029, !dbg !382

1005:                                             ; preds = %1000, %996, %993
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 4, i32* %17, align 4, !dbg !365, !tbaa !366
  %1006 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1006, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1007 = icmp eq i8* %1006, null, !dbg !369
  br i1 %1007, label %1017, label %1008, !dbg !371

1008:                                             ; preds = %1005
  %1009 = bitcast i8* %1006 to i64*, !dbg !372
  %1010 = load i64, i64* %1009, align 8, !dbg !372, !tbaa !375
  %1011 = icmp ugt i64 %1010, %957, !dbg !377
  br i1 %1011, label %1017, label %1012, !dbg !378

1012:                                             ; preds = %1008
  %1013 = getelementptr inbounds i8, i8* %1006, i64 8, !dbg !379
  %1014 = bitcast i8* %1013 to i64*, !dbg !379
  %1015 = load i64, i64* %1014, align 8, !dbg !379, !tbaa !380
  %1016 = icmp ult i64 %1015, %957, !dbg !381
  br i1 %1016, label %1017, label %1029, !dbg !382

1017:                                             ; preds = %1012, %1008, %1005
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 5, i32* %17, align 4, !dbg !365, !tbaa !366
  %1018 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1018, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1019 = icmp eq i8* %1018, null, !dbg !369
  br i1 %1019, label %100, label %1020, !dbg !371

1020:                                             ; preds = %1017
  %1021 = bitcast i8* %1018 to i64*, !dbg !372
  %1022 = load i64, i64* %1021, align 8, !dbg !372, !tbaa !375
  %1023 = icmp ugt i64 %1022, %957, !dbg !377
  br i1 %1023, label %100, label %1024, !dbg !378

1024:                                             ; preds = %1020
  %1025 = getelementptr inbounds i8, i8* %1018, i64 8, !dbg !379
  %1026 = bitcast i8* %1025 to i64*, !dbg !379
  %1027 = load i64, i64* %1026, align 8, !dbg !379, !tbaa !380
  %1028 = icmp ult i64 %1027, %957, !dbg !381
  br i1 %1028, label %100, label %1029, !dbg !382

1029:                                             ; preds = %1024, %1012, %1000, %988, %976, %964
  %1030 = phi i8* [ %958, %964 ], [ %970, %976 ], [ %982, %988 ], [ %994, %1000 ], [ %1006, %1012 ], [ %1018, %1024 ], !dbg !367
  %1031 = bitcast i8* %1030 to %struct.stack_unwind_table_t*, !dbg !367
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1031, metadata !299, metadata !DIExpression()), !dbg !384
  %1032 = load i64, i64* %14, align 8, !dbg !392, !tbaa !339
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1031, metadata !393, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1032, metadata !398, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 0, metadata !399, metadata !DIExpression()), !dbg !407
  %1033 = getelementptr inbounds i8, i8* %1030, i64 16, !dbg !409
  %1034 = bitcast i8* %1033 to i64*, !dbg !409
  %1035 = load i64, i64* %1034, align 8, !dbg !409, !tbaa !410
  call void @llvm.dbg.value(metadata i32 0, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 16431834, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1035, metadata !400, metadata !DIExpression()), !dbg !407
  %1036 = icmp eq i64 %1035, 0, !dbg !412
  br i1 %1036, label %1346, label %1037, !dbg !414

1037:                                             ; preds = %1029
  %1038 = lshr i64 %1035, 1, !dbg !415
  %1039 = trunc i64 %1038 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1039, metadata !404, metadata !DIExpression()), !dbg !417
  %1040 = icmp ugt i32 %1039, 249999
  br i1 %1040, label %1346, label %1041, !dbg !418

1041:                                             ; preds = %1037
  %1042 = and i64 %1038, 4294967295, !dbg !420
  %1043 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1042, i32 0, !dbg !422
  %1044 = load i64, i64* %1043, align 8, !dbg !422, !tbaa !423
  %1045 = icmp ugt i64 %1044, %1032, !dbg !426
  %1046 = add nuw i64 %1038, 1, !dbg !427
  %1047 = and i64 %1046, 4294967295, !dbg !427
  %1048 = select i1 %1045, i64 0, i64 %1047, !dbg !427
  %1049 = select i1 %1045, i64 %1042, i64 %1035, !dbg !427
  %1050 = select i1 %1045, i64 16431834, i64 %1042, !dbg !427
  call void @llvm.dbg.value(metadata i32 1, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1050, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1049, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1048, metadata !399, metadata !DIExpression()), !dbg !407
  %1051 = icmp ult i64 %1048, %1049, !dbg !412
  br i1 %1051, label %1052, label %1346, !dbg !414

1052:                                             ; preds = %1041
  %1053 = add i64 %1049, %1048, !dbg !428
  %1054 = lshr i64 %1053, 1, !dbg !415
  %1055 = trunc i64 %1054 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1055, metadata !404, metadata !DIExpression()), !dbg !417
  %1056 = icmp ugt i32 %1055, 249999
  br i1 %1056, label %1346, label %1057, !dbg !418

1057:                                             ; preds = %1052
  %1058 = and i64 %1054, 4294967295, !dbg !420
  %1059 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1058, i32 0, !dbg !422
  %1060 = load i64, i64* %1059, align 8, !dbg !422, !tbaa !423
  %1061 = icmp ugt i64 %1060, %1032, !dbg !426
  %1062 = add nuw i64 %1054, 1, !dbg !427
  %1063 = and i64 %1062, 4294967295, !dbg !427
  %1064 = select i1 %1061, i64 %1048, i64 %1063, !dbg !427
  %1065 = select i1 %1061, i64 %1058, i64 %1049, !dbg !427
  %1066 = select i1 %1061, i64 %1050, i64 %1058, !dbg !427
  call void @llvm.dbg.value(metadata i32 2, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1066, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1065, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1064, metadata !399, metadata !DIExpression()), !dbg !407
  %1067 = icmp ult i64 %1064, %1065, !dbg !412
  br i1 %1067, label %1068, label %1346, !dbg !414

1068:                                             ; preds = %1057
  %1069 = add i64 %1065, %1064, !dbg !428
  %1070 = lshr i64 %1069, 1, !dbg !415
  %1071 = trunc i64 %1070 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1071, metadata !404, metadata !DIExpression()), !dbg !417
  %1072 = icmp ugt i32 %1071, 249999
  br i1 %1072, label %1346, label %1073, !dbg !418

1073:                                             ; preds = %1068
  %1074 = and i64 %1070, 4294967295, !dbg !420
  %1075 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1074, i32 0, !dbg !422
  %1076 = load i64, i64* %1075, align 8, !dbg !422, !tbaa !423
  %1077 = icmp ugt i64 %1076, %1032, !dbg !426
  %1078 = add nuw i64 %1070, 1, !dbg !427
  %1079 = and i64 %1078, 4294967295, !dbg !427
  %1080 = select i1 %1077, i64 %1064, i64 %1079, !dbg !427
  %1081 = select i1 %1077, i64 %1074, i64 %1065, !dbg !427
  %1082 = select i1 %1077, i64 %1066, i64 %1074, !dbg !427
  call void @llvm.dbg.value(metadata i32 3, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1082, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1081, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1080, metadata !399, metadata !DIExpression()), !dbg !407
  %1083 = icmp ult i64 %1080, %1081, !dbg !412
  br i1 %1083, label %1084, label %1346, !dbg !414

1084:                                             ; preds = %1073
  %1085 = add i64 %1081, %1080, !dbg !428
  %1086 = lshr i64 %1085, 1, !dbg !415
  %1087 = trunc i64 %1086 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1087, metadata !404, metadata !DIExpression()), !dbg !417
  %1088 = icmp ugt i32 %1087, 249999
  br i1 %1088, label %1346, label %1089, !dbg !418

1089:                                             ; preds = %1084
  %1090 = and i64 %1086, 4294967295, !dbg !420
  %1091 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1090, i32 0, !dbg !422
  %1092 = load i64, i64* %1091, align 8, !dbg !422, !tbaa !423
  %1093 = icmp ugt i64 %1092, %1032, !dbg !426
  %1094 = add nuw i64 %1086, 1, !dbg !427
  %1095 = and i64 %1094, 4294967295, !dbg !427
  %1096 = select i1 %1093, i64 %1080, i64 %1095, !dbg !427
  %1097 = select i1 %1093, i64 %1090, i64 %1081, !dbg !427
  %1098 = select i1 %1093, i64 %1082, i64 %1090, !dbg !427
  call void @llvm.dbg.value(metadata i32 4, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1098, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1097, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1096, metadata !399, metadata !DIExpression()), !dbg !407
  %1099 = icmp ult i64 %1096, %1097, !dbg !412
  br i1 %1099, label %1100, label %1346, !dbg !414

1100:                                             ; preds = %1089
  %1101 = add i64 %1097, %1096, !dbg !428
  %1102 = lshr i64 %1101, 1, !dbg !415
  %1103 = trunc i64 %1102 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1103, metadata !404, metadata !DIExpression()), !dbg !417
  %1104 = icmp ugt i32 %1103, 249999
  br i1 %1104, label %1346, label %1105, !dbg !418

1105:                                             ; preds = %1100
  %1106 = and i64 %1102, 4294967295, !dbg !420
  %1107 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1106, i32 0, !dbg !422
  %1108 = load i64, i64* %1107, align 8, !dbg !422, !tbaa !423
  %1109 = icmp ugt i64 %1108, %1032, !dbg !426
  %1110 = add nuw i64 %1102, 1, !dbg !427
  %1111 = and i64 %1110, 4294967295, !dbg !427
  %1112 = select i1 %1109, i64 %1096, i64 %1111, !dbg !427
  %1113 = select i1 %1109, i64 %1106, i64 %1097, !dbg !427
  %1114 = select i1 %1109, i64 %1098, i64 %1106, !dbg !427
  call void @llvm.dbg.value(metadata i32 5, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1114, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1113, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1112, metadata !399, metadata !DIExpression()), !dbg !407
  %1115 = icmp ult i64 %1112, %1113, !dbg !412
  br i1 %1115, label %1116, label %1346, !dbg !414

1116:                                             ; preds = %1105
  %1117 = add i64 %1113, %1112, !dbg !428
  %1118 = lshr i64 %1117, 1, !dbg !415
  %1119 = trunc i64 %1118 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1119, metadata !404, metadata !DIExpression()), !dbg !417
  %1120 = icmp ugt i32 %1119, 249999
  br i1 %1120, label %1346, label %1121, !dbg !418

1121:                                             ; preds = %1116
  %1122 = and i64 %1118, 4294967295, !dbg !420
  %1123 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1122, i32 0, !dbg !422
  %1124 = load i64, i64* %1123, align 8, !dbg !422, !tbaa !423
  %1125 = icmp ugt i64 %1124, %1032, !dbg !426
  %1126 = add nuw i64 %1118, 1, !dbg !427
  %1127 = and i64 %1126, 4294967295, !dbg !427
  %1128 = select i1 %1125, i64 %1112, i64 %1127, !dbg !427
  %1129 = select i1 %1125, i64 %1122, i64 %1113, !dbg !427
  %1130 = select i1 %1125, i64 %1114, i64 %1122, !dbg !427
  call void @llvm.dbg.value(metadata i32 6, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1130, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1129, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1128, metadata !399, metadata !DIExpression()), !dbg !407
  %1131 = icmp ult i64 %1128, %1129, !dbg !412
  br i1 %1131, label %1132, label %1346, !dbg !414

1132:                                             ; preds = %1121
  %1133 = add i64 %1129, %1128, !dbg !428
  %1134 = lshr i64 %1133, 1, !dbg !415
  %1135 = trunc i64 %1134 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1135, metadata !404, metadata !DIExpression()), !dbg !417
  %1136 = icmp ugt i32 %1135, 249999
  br i1 %1136, label %1346, label %1137, !dbg !418

1137:                                             ; preds = %1132
  %1138 = and i64 %1134, 4294967295, !dbg !420
  %1139 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1138, i32 0, !dbg !422
  %1140 = load i64, i64* %1139, align 8, !dbg !422, !tbaa !423
  %1141 = icmp ugt i64 %1140, %1032, !dbg !426
  %1142 = add nuw i64 %1134, 1, !dbg !427
  %1143 = and i64 %1142, 4294967295, !dbg !427
  %1144 = select i1 %1141, i64 %1128, i64 %1143, !dbg !427
  %1145 = select i1 %1141, i64 %1138, i64 %1129, !dbg !427
  %1146 = select i1 %1141, i64 %1130, i64 %1138, !dbg !427
  call void @llvm.dbg.value(metadata i32 7, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1146, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1145, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1144, metadata !399, metadata !DIExpression()), !dbg !407
  %1147 = icmp ult i64 %1144, %1145, !dbg !412
  br i1 %1147, label %1148, label %1346, !dbg !414

1148:                                             ; preds = %1137
  %1149 = add i64 %1145, %1144, !dbg !428
  %1150 = lshr i64 %1149, 1, !dbg !415
  %1151 = trunc i64 %1150 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1151, metadata !404, metadata !DIExpression()), !dbg !417
  %1152 = icmp ugt i32 %1151, 249999
  br i1 %1152, label %1346, label %1153, !dbg !418

1153:                                             ; preds = %1148
  %1154 = and i64 %1150, 4294967295, !dbg !420
  %1155 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1154, i32 0, !dbg !422
  %1156 = load i64, i64* %1155, align 8, !dbg !422, !tbaa !423
  %1157 = icmp ugt i64 %1156, %1032, !dbg !426
  %1158 = add nuw i64 %1150, 1, !dbg !427
  %1159 = and i64 %1158, 4294967295, !dbg !427
  %1160 = select i1 %1157, i64 %1144, i64 %1159, !dbg !427
  %1161 = select i1 %1157, i64 %1154, i64 %1145, !dbg !427
  %1162 = select i1 %1157, i64 %1146, i64 %1154, !dbg !427
  call void @llvm.dbg.value(metadata i32 8, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1162, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1161, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1160, metadata !399, metadata !DIExpression()), !dbg !407
  %1163 = icmp ult i64 %1160, %1161, !dbg !412
  br i1 %1163, label %1164, label %1346, !dbg !414

1164:                                             ; preds = %1153
  %1165 = add i64 %1161, %1160, !dbg !428
  %1166 = lshr i64 %1165, 1, !dbg !415
  %1167 = trunc i64 %1166 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1167, metadata !404, metadata !DIExpression()), !dbg !417
  %1168 = icmp ugt i32 %1167, 249999
  br i1 %1168, label %1346, label %1169, !dbg !418

1169:                                             ; preds = %1164
  %1170 = and i64 %1166, 4294967295, !dbg !420
  %1171 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1170, i32 0, !dbg !422
  %1172 = load i64, i64* %1171, align 8, !dbg !422, !tbaa !423
  %1173 = icmp ugt i64 %1172, %1032, !dbg !426
  %1174 = add nuw i64 %1166, 1, !dbg !427
  %1175 = and i64 %1174, 4294967295, !dbg !427
  %1176 = select i1 %1173, i64 %1160, i64 %1175, !dbg !427
  %1177 = select i1 %1173, i64 %1170, i64 %1161, !dbg !427
  %1178 = select i1 %1173, i64 %1162, i64 %1170, !dbg !427
  call void @llvm.dbg.value(metadata i32 9, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1178, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1177, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1176, metadata !399, metadata !DIExpression()), !dbg !407
  %1179 = icmp ult i64 %1176, %1177, !dbg !412
  br i1 %1179, label %1180, label %1346, !dbg !414

1180:                                             ; preds = %1169
  %1181 = add i64 %1177, %1176, !dbg !428
  %1182 = lshr i64 %1181, 1, !dbg !415
  %1183 = trunc i64 %1182 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1183, metadata !404, metadata !DIExpression()), !dbg !417
  %1184 = icmp ugt i32 %1183, 249999
  br i1 %1184, label %1346, label %1185, !dbg !418

1185:                                             ; preds = %1180
  %1186 = and i64 %1182, 4294967295, !dbg !420
  %1187 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1186, i32 0, !dbg !422
  %1188 = load i64, i64* %1187, align 8, !dbg !422, !tbaa !423
  %1189 = icmp ugt i64 %1188, %1032, !dbg !426
  %1190 = add nuw i64 %1182, 1, !dbg !427
  %1191 = and i64 %1190, 4294967295, !dbg !427
  %1192 = select i1 %1189, i64 %1176, i64 %1191, !dbg !427
  %1193 = select i1 %1189, i64 %1186, i64 %1177, !dbg !427
  %1194 = select i1 %1189, i64 %1178, i64 %1186, !dbg !427
  call void @llvm.dbg.value(metadata i32 10, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1194, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1193, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1192, metadata !399, metadata !DIExpression()), !dbg !407
  %1195 = icmp ult i64 %1192, %1193, !dbg !412
  br i1 %1195, label %1196, label %1346, !dbg !414

1196:                                             ; preds = %1185
  %1197 = add i64 %1193, %1192, !dbg !428
  %1198 = lshr i64 %1197, 1, !dbg !415
  %1199 = trunc i64 %1198 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1199, metadata !404, metadata !DIExpression()), !dbg !417
  %1200 = icmp ugt i32 %1199, 249999
  br i1 %1200, label %1346, label %1201, !dbg !418

1201:                                             ; preds = %1196
  %1202 = and i64 %1198, 4294967295, !dbg !420
  %1203 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1202, i32 0, !dbg !422
  %1204 = load i64, i64* %1203, align 8, !dbg !422, !tbaa !423
  %1205 = icmp ugt i64 %1204, %1032, !dbg !426
  %1206 = add nuw i64 %1198, 1, !dbg !427
  %1207 = and i64 %1206, 4294967295, !dbg !427
  %1208 = select i1 %1205, i64 %1192, i64 %1207, !dbg !427
  %1209 = select i1 %1205, i64 %1202, i64 %1193, !dbg !427
  %1210 = select i1 %1205, i64 %1194, i64 %1202, !dbg !427
  call void @llvm.dbg.value(metadata i32 11, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1210, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1209, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1208, metadata !399, metadata !DIExpression()), !dbg !407
  %1211 = icmp ult i64 %1208, %1209, !dbg !412
  br i1 %1211, label %1212, label %1346, !dbg !414

1212:                                             ; preds = %1201
  %1213 = add i64 %1209, %1208, !dbg !428
  %1214 = lshr i64 %1213, 1, !dbg !415
  %1215 = trunc i64 %1214 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1215, metadata !404, metadata !DIExpression()), !dbg !417
  %1216 = icmp ugt i32 %1215, 249999
  br i1 %1216, label %1346, label %1217, !dbg !418

1217:                                             ; preds = %1212
  %1218 = and i64 %1214, 4294967295, !dbg !420
  %1219 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1218, i32 0, !dbg !422
  %1220 = load i64, i64* %1219, align 8, !dbg !422, !tbaa !423
  %1221 = icmp ugt i64 %1220, %1032, !dbg !426
  %1222 = add nuw i64 %1214, 1, !dbg !427
  %1223 = and i64 %1222, 4294967295, !dbg !427
  %1224 = select i1 %1221, i64 %1208, i64 %1223, !dbg !427
  %1225 = select i1 %1221, i64 %1218, i64 %1209, !dbg !427
  %1226 = select i1 %1221, i64 %1210, i64 %1218, !dbg !427
  call void @llvm.dbg.value(metadata i32 12, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1226, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1225, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1224, metadata !399, metadata !DIExpression()), !dbg !407
  %1227 = icmp ult i64 %1224, %1225, !dbg !412
  br i1 %1227, label %1228, label %1346, !dbg !414

1228:                                             ; preds = %1217
  %1229 = add i64 %1225, %1224, !dbg !428
  %1230 = lshr i64 %1229, 1, !dbg !415
  %1231 = trunc i64 %1230 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1231, metadata !404, metadata !DIExpression()), !dbg !417
  %1232 = icmp ugt i32 %1231, 249999
  br i1 %1232, label %1346, label %1233, !dbg !418

1233:                                             ; preds = %1228
  %1234 = and i64 %1230, 4294967295, !dbg !420
  %1235 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1234, i32 0, !dbg !422
  %1236 = load i64, i64* %1235, align 8, !dbg !422, !tbaa !423
  %1237 = icmp ugt i64 %1236, %1032, !dbg !426
  %1238 = add nuw i64 %1230, 1, !dbg !427
  %1239 = and i64 %1238, 4294967295, !dbg !427
  %1240 = select i1 %1237, i64 %1224, i64 %1239, !dbg !427
  %1241 = select i1 %1237, i64 %1234, i64 %1225, !dbg !427
  %1242 = select i1 %1237, i64 %1226, i64 %1234, !dbg !427
  call void @llvm.dbg.value(metadata i32 13, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1242, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1241, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1240, metadata !399, metadata !DIExpression()), !dbg !407
  %1243 = icmp ult i64 %1240, %1241, !dbg !412
  br i1 %1243, label %1244, label %1346, !dbg !414

1244:                                             ; preds = %1233
  %1245 = add i64 %1241, %1240, !dbg !428
  %1246 = lshr i64 %1245, 1, !dbg !415
  %1247 = trunc i64 %1246 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1247, metadata !404, metadata !DIExpression()), !dbg !417
  %1248 = icmp ugt i32 %1247, 249999
  br i1 %1248, label %1346, label %1249, !dbg !418

1249:                                             ; preds = %1244
  %1250 = and i64 %1246, 4294967295, !dbg !420
  %1251 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1250, i32 0, !dbg !422
  %1252 = load i64, i64* %1251, align 8, !dbg !422, !tbaa !423
  %1253 = icmp ugt i64 %1252, %1032, !dbg !426
  %1254 = add nuw i64 %1246, 1, !dbg !427
  %1255 = and i64 %1254, 4294967295, !dbg !427
  %1256 = select i1 %1253, i64 %1240, i64 %1255, !dbg !427
  %1257 = select i1 %1253, i64 %1250, i64 %1241, !dbg !427
  %1258 = select i1 %1253, i64 %1242, i64 %1250, !dbg !427
  call void @llvm.dbg.value(metadata i32 14, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1258, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1257, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1256, metadata !399, metadata !DIExpression()), !dbg !407
  %1259 = icmp ult i64 %1256, %1257, !dbg !412
  br i1 %1259, label %1260, label %1346, !dbg !414

1260:                                             ; preds = %1249
  %1261 = add i64 %1257, %1256, !dbg !428
  %1262 = lshr i64 %1261, 1, !dbg !415
  %1263 = trunc i64 %1262 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1263, metadata !404, metadata !DIExpression()), !dbg !417
  %1264 = icmp ugt i32 %1263, 249999
  br i1 %1264, label %1346, label %1265, !dbg !418

1265:                                             ; preds = %1260
  %1266 = and i64 %1262, 4294967295, !dbg !420
  %1267 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1266, i32 0, !dbg !422
  %1268 = load i64, i64* %1267, align 8, !dbg !422, !tbaa !423
  %1269 = icmp ugt i64 %1268, %1032, !dbg !426
  %1270 = add nuw i64 %1262, 1, !dbg !427
  %1271 = and i64 %1270, 4294967295, !dbg !427
  %1272 = select i1 %1269, i64 %1256, i64 %1271, !dbg !427
  %1273 = select i1 %1269, i64 %1266, i64 %1257, !dbg !427
  %1274 = select i1 %1269, i64 %1258, i64 %1266, !dbg !427
  call void @llvm.dbg.value(metadata i32 15, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1274, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1273, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1272, metadata !399, metadata !DIExpression()), !dbg !407
  %1275 = icmp ult i64 %1272, %1273, !dbg !412
  br i1 %1275, label %1276, label %1346, !dbg !414

1276:                                             ; preds = %1265
  %1277 = add i64 %1273, %1272, !dbg !428
  %1278 = lshr i64 %1277, 1, !dbg !415
  %1279 = trunc i64 %1278 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1279, metadata !404, metadata !DIExpression()), !dbg !417
  %1280 = icmp ugt i32 %1279, 249999
  br i1 %1280, label %1346, label %1281, !dbg !418

1281:                                             ; preds = %1276
  %1282 = and i64 %1278, 4294967295, !dbg !420
  %1283 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1282, i32 0, !dbg !422
  %1284 = load i64, i64* %1283, align 8, !dbg !422, !tbaa !423
  %1285 = icmp ugt i64 %1284, %1032, !dbg !426
  %1286 = add nuw i64 %1278, 1, !dbg !427
  %1287 = and i64 %1286, 4294967295, !dbg !427
  %1288 = select i1 %1285, i64 %1272, i64 %1287, !dbg !427
  %1289 = select i1 %1285, i64 %1282, i64 %1273, !dbg !427
  %1290 = select i1 %1285, i64 %1274, i64 %1282, !dbg !427
  call void @llvm.dbg.value(metadata i32 16, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1290, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1289, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1288, metadata !399, metadata !DIExpression()), !dbg !407
  %1291 = icmp ult i64 %1288, %1289, !dbg !412
  br i1 %1291, label %1292, label %1346, !dbg !414

1292:                                             ; preds = %1281
  %1293 = add i64 %1289, %1288, !dbg !428
  %1294 = lshr i64 %1293, 1, !dbg !415
  %1295 = trunc i64 %1294 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1295, metadata !404, metadata !DIExpression()), !dbg !417
  %1296 = icmp ugt i32 %1295, 249999
  br i1 %1296, label %1346, label %1297, !dbg !418

1297:                                             ; preds = %1292
  %1298 = and i64 %1294, 4294967295, !dbg !420
  %1299 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1298, i32 0, !dbg !422
  %1300 = load i64, i64* %1299, align 8, !dbg !422, !tbaa !423
  %1301 = icmp ugt i64 %1300, %1032, !dbg !426
  %1302 = add nuw i64 %1294, 1, !dbg !427
  %1303 = and i64 %1302, 4294967295, !dbg !427
  %1304 = select i1 %1301, i64 %1288, i64 %1303, !dbg !427
  %1305 = select i1 %1301, i64 %1298, i64 %1289, !dbg !427
  %1306 = select i1 %1301, i64 %1290, i64 %1298, !dbg !427
  call void @llvm.dbg.value(metadata i32 17, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1306, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1305, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1304, metadata !399, metadata !DIExpression()), !dbg !407
  %1307 = icmp ult i64 %1304, %1305, !dbg !412
  br i1 %1307, label %1308, label %1346, !dbg !414

1308:                                             ; preds = %1297
  %1309 = add i64 %1305, %1304, !dbg !428
  %1310 = lshr i64 %1309, 1, !dbg !415
  %1311 = trunc i64 %1310 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1311, metadata !404, metadata !DIExpression()), !dbg !417
  %1312 = icmp ugt i32 %1311, 249999
  br i1 %1312, label %1346, label %1313, !dbg !418

1313:                                             ; preds = %1308
  %1314 = and i64 %1310, 4294967295, !dbg !420
  %1315 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1314, i32 0, !dbg !422
  %1316 = load i64, i64* %1315, align 8, !dbg !422, !tbaa !423
  %1317 = icmp ugt i64 %1316, %1032, !dbg !426
  %1318 = add nuw i64 %1310, 1, !dbg !427
  %1319 = and i64 %1318, 4294967295, !dbg !427
  %1320 = select i1 %1317, i64 %1304, i64 %1319, !dbg !427
  %1321 = select i1 %1317, i64 %1314, i64 %1305, !dbg !427
  %1322 = select i1 %1317, i64 %1306, i64 %1314, !dbg !427
  call void @llvm.dbg.value(metadata i32 18, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1322, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1321, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1320, metadata !399, metadata !DIExpression()), !dbg !407
  %1323 = icmp ult i64 %1320, %1321, !dbg !412
  br i1 %1323, label %1324, label %1346, !dbg !414

1324:                                             ; preds = %1313
  %1325 = add i64 %1321, %1320, !dbg !428
  %1326 = lshr i64 %1325, 1, !dbg !415
  %1327 = trunc i64 %1326 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1327, metadata !404, metadata !DIExpression()), !dbg !417
  %1328 = icmp ugt i32 %1327, 249999
  br i1 %1328, label %1346, label %1329, !dbg !418

1329:                                             ; preds = %1324
  %1330 = and i64 %1326, 4294967295, !dbg !420
  %1331 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1031, i64 0, i32 4, i64 %1330, i32 0, !dbg !422
  %1332 = load i64, i64* %1331, align 8, !dbg !422, !tbaa !423
  %1333 = icmp ugt i64 %1332, %1032, !dbg !426
  %1334 = add nuw i64 %1326, 1, !dbg !427
  %1335 = and i64 %1334, 4294967295, !dbg !427
  %1336 = select i1 %1333, i64 %1320, i64 %1335, !dbg !427
  %1337 = select i1 %1333, i64 %1330, i64 %1321, !dbg !427
  %1338 = select i1 %1333, i64 %1322, i64 %1330, !dbg !427
  call void @llvm.dbg.value(metadata i32 19, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1338, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1337, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1336, metadata !399, metadata !DIExpression()), !dbg !407
  %1339 = icmp ult i64 %1336, %1337, !dbg !412
  br i1 %1339, label %1340, label %1346, !dbg !414

1340:                                             ; preds = %1329
  %1341 = add i64 %1337, %1336, !dbg !428
  %1342 = lshr i64 %1341, 1, !dbg !415
  %1343 = trunc i64 %1342 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1343, metadata !404, metadata !DIExpression()), !dbg !417
  %1344 = icmp ugt i32 %1343, 249999
  br i1 %1344, label %1346, label %1345, !dbg !418

1345:                                             ; preds = %1340
  call void @llvm.dbg.value(metadata i64 undef, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !399, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i32 20, metadata !402, metadata !DIExpression()), !dbg !411
  br label %1346

1346:                                             ; preds = %1345, %1340, %1329, %1324, %1313, %1308, %1297, %1292, %1281, %1276, %1265, %1260, %1249, %1244, %1233, %1228, %1217, %1212, %1201, %1196, %1185, %1180, %1169, %1164, %1153, %1148, %1137, %1132, %1121, %1116, %1105, %1100, %1089, %1084, %1073, %1068, %1057, %1052, %1041, %1037, %1029
  %1347 = phi i64 [ 16431834, %1029 ], [ 3735928559, %1037 ], [ %1050, %1041 ], [ 3735928559, %1052 ], [ %1066, %1057 ], [ 3735928559, %1068 ], [ %1082, %1073 ], [ 3735928559, %1084 ], [ %1098, %1089 ], [ 3735928559, %1100 ], [ %1114, %1105 ], [ 3735928559, %1116 ], [ %1130, %1121 ], [ 3735928559, %1132 ], [ %1146, %1137 ], [ 3735928559, %1148 ], [ %1162, %1153 ], [ 3735928559, %1164 ], [ %1178, %1169 ], [ 3735928559, %1180 ], [ %1194, %1185 ], [ 3735928559, %1196 ], [ %1210, %1201 ], [ 3735928559, %1212 ], [ %1226, %1217 ], [ 3735928559, %1228 ], [ %1242, %1233 ], [ 3735928559, %1244 ], [ %1258, %1249 ], [ 3735928559, %1260 ], [ %1274, %1265 ], [ 3735928559, %1276 ], [ %1290, %1281 ], [ 3735928559, %1292 ], [ %1306, %1297 ], [ 3735928559, %1308 ], [ %1322, %1313 ], [ 3735928559, %1324 ], [ %1338, %1329 ], [ 3735928559, %1340 ], [ 12246957, %1345 ]
  call void @llvm.dbg.value(metadata i64 %1347, metadata !302, metadata !DIExpression()), !dbg !384
  %1348 = icmp eq i64 %1347, 16431834, !dbg !429
  %1349 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %1348)
  %1350 = freeze i1 %1349, !dbg !431
  br i1 %1350, label %2850, label %1351, !dbg !431

1351:                                             ; preds = %1346
  switch i64 %1347, label %1352 [
    i64 3735928559, label %2850
    i64 12246957, label %2850
  ], !dbg !431

1352:                                             ; preds = %1351
  %1353 = load i64, i64* %19, align 8, !dbg !432, !tbaa !433
  call void @llvm.dbg.value(metadata i64 %1353, metadata !303, metadata !DIExpression()), !dbg !384
  %1354 = icmp ult i64 %1353, 115
  br i1 %1354, label %1355, label %1357, !dbg !434

1355:                                             ; preds = %1352
  %1356 = getelementptr inbounds [115 x i64], [115 x i64]* %21, i64 0, i64 %1353, !dbg !436
  store i64 %1032, i64* %1356, align 8, !dbg !438, !tbaa !329
  br label %1357, !dbg !439

1357:                                             ; preds = %1355, %1352
  call void @llvm.dbg.value(metadata i64 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !384
  call void @llvm.dbg.value(metadata i16 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  %1358 = getelementptr inbounds i8, i8* %1030, i64 4000027, !dbg !440
  %1359 = load i8, i8* %1358, align 1, !dbg !440, !tbaa.struct !441
  call void @llvm.dbg.value(metadata i8 %1359, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 88, 8)), !dbg !384
  %1360 = getelementptr inbounds i8, i8* %1030, i64 4000028, !dbg !440
  %1361 = bitcast i8* %1360 to i16*, !dbg !440
  %1362 = load i16, i16* %1361, align 4, !dbg !440, !tbaa.struct !444
  call void @llvm.dbg.value(metadata i16 %1362, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !384
  %1363 = getelementptr inbounds i8, i8* %1030, i64 4000030, !dbg !440
  %1364 = bitcast i8* %1363 to i16*, !dbg !440
  %1365 = load i16, i16* %1364, align 2, !dbg !440, !tbaa.struct !445
  call void @llvm.dbg.value(metadata i16 %1365, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i64 undef, metadata !305, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 %1359, metadata !307, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %1362, metadata !308, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %1365, metadata !309, metadata !DIExpression()), !dbg !384
  %1366 = icmp eq i8 %1359, 2, !dbg !446
  %1367 = icmp eq i8 %1359, 3
  %1368 = call i1 @llvm.bpf.passthrough.i1.i1(i32 1, i1 %1366)
  %1369 = select i1 %1368, i1 true, i1 %1367, !dbg !448
  br i1 %1369, label %2850, label %1370, !dbg !448

1370:                                             ; preds = %1357
  %1371 = getelementptr inbounds i8, i8* %1030, i64 4000026, !dbg !440
  %1372 = load i8, i8* %1371, align 2, !dbg !440, !tbaa.struct !449
  call void @llvm.dbg.value(metadata i8 %1372, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  call void @llvm.dbg.value(metadata i8 %1372, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i64 0, metadata !310, metadata !DIExpression()), !dbg !384
  switch i8 %1372, label %2850 [
    i8 1, label %1388
    i8 2, label %1384
    i8 3, label %1373
  ], !dbg !450

1373:                                             ; preds = %1370
  switch i16 %1362, label %2850 [
    i16 2, label %1374
    i16 1, label %1375
  ], !dbg !462

1374:                                             ; preds = %1373
  call void @llvm.dbg.value(metadata i64 10, metadata !311, metadata !DIExpression()), !dbg !463
  br label %1375, !dbg !464

1375:                                             ; preds = %1374, %1373
  %1376 = phi i64 [ 11, %1373 ], [ 10, %1374 ]
  call void @llvm.dbg.value(metadata i64 0, metadata !311, metadata !DIExpression()), !dbg !463
  %1377 = load i64, i64* %23, align 8, !dbg !468, !tbaa !458
  %1378 = add i64 %1377, 8, !dbg !469
  %1379 = load i64, i64* %14, align 8, !dbg !470, !tbaa !339
  %1380 = and i64 %1379, 15, !dbg !471
  %1381 = icmp ult i64 %1380, %1376, !dbg !472
  %1382 = select i1 %1381, i64 0, i64 8, !dbg !473
  %1383 = add i64 %1378, %1382, !dbg !474
  call void @llvm.dbg.value(metadata i64 %1383, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1392

1384:                                             ; preds = %1370
  %1385 = load i64, i64* %23, align 8, !dbg !456, !tbaa !458
  %1386 = sext i16 %1362 to i64, !dbg !459
  %1387 = add i64 %1385, %1386, !dbg !460
  call void @llvm.dbg.value(metadata i64 %1387, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1392, !dbg !461

1388:                                             ; preds = %1370
  %1389 = load i64, i64* %25, align 8, !dbg !451, !tbaa !389
  %1390 = sext i16 %1362 to i64, !dbg !453
  %1391 = add i64 %1389, %1390, !dbg !454
  call void @llvm.dbg.value(metadata i64 %1391, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1392, !dbg !455

1392:                                             ; preds = %1388, %1384, %1375
  %1393 = phi i64 [ %1391, %1388 ], [ %1387, %1384 ], [ %1383, %1375 ], !dbg !384
  call void @llvm.dbg.value(metadata i64 %1393, metadata !310, metadata !DIExpression()), !dbg !384
  %1394 = icmp eq i64 %1393, 0, !dbg !475
  br i1 %1394, label %2850, label %1395, !dbg !477

1395:                                             ; preds = %1392
  %1396 = add i64 %1393, -8, !dbg !478
  call void @llvm.dbg.value(metadata i64 %1396, metadata !316, metadata !DIExpression()), !dbg !384
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %26) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 0, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %6, align 8, !dbg !480, !tbaa !329
  %1397 = inttoptr i64 %1396 to i8*, !dbg !481
  call void @llvm.dbg.value(metadata i64* %6, metadata !317, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %1398 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %26, i32 noundef 8, i8* noundef %1397) #6, !dbg !482
  call void @llvm.dbg.value(metadata i64 %1398, metadata !318, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !384
  %1399 = load i64, i64* %6, align 8, !dbg !483, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %1399, metadata !317, metadata !DIExpression()), !dbg !384
  %1400 = icmp eq i64 %1399, 0, !dbg !485
  br i1 %1400, label %475, label %1401, !dbg !486

1401:                                             ; preds = %1395
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #6, !dbg !488
  call void @llvm.dbg.value(metadata i64 0, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %7, align 8, !dbg !489, !tbaa !329
  %1402 = icmp eq i8 %1359, 0, !dbg !490
  br i1 %1402, label %1412, label %1403, !dbg !491

1403:                                             ; preds = %1401
  %1404 = sext i16 %1365 to i64, !dbg !496
  %1405 = add i64 %1393, %1404, !dbg !497
  call void @llvm.dbg.value(metadata i64 %1405, metadata !320, metadata !DIExpression()), !dbg !498
  %1406 = inttoptr i64 %1405 to i8*, !dbg !499
  call void @llvm.dbg.value(metadata i64* %7, metadata !319, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %1407 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %27, i32 noundef 8, i8* noundef %1406) #6, !dbg !500
  %1408 = trunc i64 %1407 to i32, !dbg !500
  call void @llvm.dbg.value(metadata i32 %1408, metadata !323, metadata !DIExpression()), !dbg !498
  %1409 = icmp eq i32 %1408, 0, !dbg !501
  br i1 %1409, label %1410, label %489

1410:                                             ; preds = %1403
  %1411 = load i64, i64* %6, align 8, !dbg !503, !tbaa !329
  br label %1414

1412:                                             ; preds = %1401
  %1413 = load i64, i64* %25, align 8, !dbg !492, !tbaa !389
  call void @llvm.dbg.value(metadata i64 %1413, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %1413, i64* %7, align 8, !dbg !494, !tbaa !329
  br label %1414, !dbg !495

1414:                                             ; preds = %1410, %1412
  %1415 = phi i64 [ %1411, %1410 ], [ %1399, %1412 ], !dbg !503
  call void @llvm.dbg.value(metadata i64 %1415, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 %1415, i64* %14, align 8, !dbg !504, !tbaa !339
  store i64 %1393, i64* %23, align 8, !dbg !505, !tbaa !458
  %1416 = load i64, i64* %7, align 8, !dbg !506, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %1416, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %1416, i64* %25, align 8, !dbg !507, !tbaa !389
  %1417 = load i64, i64* %19, align 8, !dbg !508, !tbaa !433
  %1418 = add i64 %1417, 1, !dbg !508
  store i64 %1418, i64* %19, align 8, !dbg !508, !tbaa !433
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 3, metadata !297, metadata !DIExpression()), !dbg !337
  call void @llvm.dbg.value(metadata i32 3, metadata !297, metadata !DIExpression()), !dbg !337
  %1419 = load i64, i64* %14, align 8, !dbg !338, !tbaa !339
  call void @llvm.dbg.value(metadata i32 %9, metadata !343, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 %1419, metadata !350, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #6, !dbg !359
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %4, metadata !351, metadata !DIExpression()) #6, !dbg !360
  store i32 %9, i32* %16, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 0, i32* %17, align 4, !dbg !365, !tbaa !366
  %1420 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1420, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1421 = icmp eq i8* %1420, null, !dbg !369
  br i1 %1421, label %1431, label %1422, !dbg !371

1422:                                             ; preds = %1414
  %1423 = bitcast i8* %1420 to i64*, !dbg !372
  %1424 = load i64, i64* %1423, align 8, !dbg !372, !tbaa !375
  %1425 = icmp ugt i64 %1424, %1419, !dbg !377
  br i1 %1425, label %1431, label %1426, !dbg !378

1426:                                             ; preds = %1422
  %1427 = getelementptr inbounds i8, i8* %1420, i64 8, !dbg !379
  %1428 = bitcast i8* %1427 to i64*, !dbg !379
  %1429 = load i64, i64* %1428, align 8, !dbg !379, !tbaa !380
  %1430 = icmp ult i64 %1429, %1419, !dbg !381
  br i1 %1430, label %1431, label %1491, !dbg !382

1431:                                             ; preds = %1426, %1422, %1414
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 1, i32* %17, align 4, !dbg !365, !tbaa !366
  %1432 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1432, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1433 = icmp eq i8* %1432, null, !dbg !369
  br i1 %1433, label %1443, label %1434, !dbg !371

1434:                                             ; preds = %1431
  %1435 = bitcast i8* %1432 to i64*, !dbg !372
  %1436 = load i64, i64* %1435, align 8, !dbg !372, !tbaa !375
  %1437 = icmp ugt i64 %1436, %1419, !dbg !377
  br i1 %1437, label %1443, label %1438, !dbg !378

1438:                                             ; preds = %1434
  %1439 = getelementptr inbounds i8, i8* %1432, i64 8, !dbg !379
  %1440 = bitcast i8* %1439 to i64*, !dbg !379
  %1441 = load i64, i64* %1440, align 8, !dbg !379, !tbaa !380
  %1442 = icmp ult i64 %1441, %1419, !dbg !381
  br i1 %1442, label %1443, label %1491, !dbg !382

1443:                                             ; preds = %1438, %1434, %1431
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 2, i32* %17, align 4, !dbg !365, !tbaa !366
  %1444 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1444, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1445 = icmp eq i8* %1444, null, !dbg !369
  br i1 %1445, label %1455, label %1446, !dbg !371

1446:                                             ; preds = %1443
  %1447 = bitcast i8* %1444 to i64*, !dbg !372
  %1448 = load i64, i64* %1447, align 8, !dbg !372, !tbaa !375
  %1449 = icmp ugt i64 %1448, %1419, !dbg !377
  br i1 %1449, label %1455, label %1450, !dbg !378

1450:                                             ; preds = %1446
  %1451 = getelementptr inbounds i8, i8* %1444, i64 8, !dbg !379
  %1452 = bitcast i8* %1451 to i64*, !dbg !379
  %1453 = load i64, i64* %1452, align 8, !dbg !379, !tbaa !380
  %1454 = icmp ult i64 %1453, %1419, !dbg !381
  br i1 %1454, label %1455, label %1491, !dbg !382

1455:                                             ; preds = %1450, %1446, %1443
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 3, i32* %17, align 4, !dbg !365, !tbaa !366
  %1456 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1456, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1457 = icmp eq i8* %1456, null, !dbg !369
  br i1 %1457, label %1467, label %1458, !dbg !371

1458:                                             ; preds = %1455
  %1459 = bitcast i8* %1456 to i64*, !dbg !372
  %1460 = load i64, i64* %1459, align 8, !dbg !372, !tbaa !375
  %1461 = icmp ugt i64 %1460, %1419, !dbg !377
  br i1 %1461, label %1467, label %1462, !dbg !378

1462:                                             ; preds = %1458
  %1463 = getelementptr inbounds i8, i8* %1456, i64 8, !dbg !379
  %1464 = bitcast i8* %1463 to i64*, !dbg !379
  %1465 = load i64, i64* %1464, align 8, !dbg !379, !tbaa !380
  %1466 = icmp ult i64 %1465, %1419, !dbg !381
  br i1 %1466, label %1467, label %1491, !dbg !382

1467:                                             ; preds = %1462, %1458, %1455
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 4, i32* %17, align 4, !dbg !365, !tbaa !366
  %1468 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1468, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1469 = icmp eq i8* %1468, null, !dbg !369
  br i1 %1469, label %1479, label %1470, !dbg !371

1470:                                             ; preds = %1467
  %1471 = bitcast i8* %1468 to i64*, !dbg !372
  %1472 = load i64, i64* %1471, align 8, !dbg !372, !tbaa !375
  %1473 = icmp ugt i64 %1472, %1419, !dbg !377
  br i1 %1473, label %1479, label %1474, !dbg !378

1474:                                             ; preds = %1470
  %1475 = getelementptr inbounds i8, i8* %1468, i64 8, !dbg !379
  %1476 = bitcast i8* %1475 to i64*, !dbg !379
  %1477 = load i64, i64* %1476, align 8, !dbg !379, !tbaa !380
  %1478 = icmp ult i64 %1477, %1419, !dbg !381
  br i1 %1478, label %1479, label %1491, !dbg !382

1479:                                             ; preds = %1474, %1470, %1467
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 5, i32* %17, align 4, !dbg !365, !tbaa !366
  %1480 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1480, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1481 = icmp eq i8* %1480, null, !dbg !369
  br i1 %1481, label %100, label %1482, !dbg !371

1482:                                             ; preds = %1479
  %1483 = bitcast i8* %1480 to i64*, !dbg !372
  %1484 = load i64, i64* %1483, align 8, !dbg !372, !tbaa !375
  %1485 = icmp ugt i64 %1484, %1419, !dbg !377
  br i1 %1485, label %100, label %1486, !dbg !378

1486:                                             ; preds = %1482
  %1487 = getelementptr inbounds i8, i8* %1480, i64 8, !dbg !379
  %1488 = bitcast i8* %1487 to i64*, !dbg !379
  %1489 = load i64, i64* %1488, align 8, !dbg !379, !tbaa !380
  %1490 = icmp ult i64 %1489, %1419, !dbg !381
  br i1 %1490, label %100, label %1491, !dbg !382

1491:                                             ; preds = %1486, %1474, %1462, %1450, %1438, %1426
  %1492 = phi i8* [ %1420, %1426 ], [ %1432, %1438 ], [ %1444, %1450 ], [ %1456, %1462 ], [ %1468, %1474 ], [ %1480, %1486 ], !dbg !367
  %1493 = bitcast i8* %1492 to %struct.stack_unwind_table_t*, !dbg !367
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1493, metadata !299, metadata !DIExpression()), !dbg !384
  %1494 = load i64, i64* %14, align 8, !dbg !392, !tbaa !339
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1493, metadata !393, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1494, metadata !398, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 0, metadata !399, metadata !DIExpression()), !dbg !407
  %1495 = getelementptr inbounds i8, i8* %1492, i64 16, !dbg !409
  %1496 = bitcast i8* %1495 to i64*, !dbg !409
  %1497 = load i64, i64* %1496, align 8, !dbg !409, !tbaa !410
  call void @llvm.dbg.value(metadata i32 0, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 16431834, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1497, metadata !400, metadata !DIExpression()), !dbg !407
  %1498 = icmp eq i64 %1497, 0, !dbg !412
  br i1 %1498, label %1808, label %1499, !dbg !414

1499:                                             ; preds = %1491
  %1500 = lshr i64 %1497, 1, !dbg !415
  %1501 = trunc i64 %1500 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1501, metadata !404, metadata !DIExpression()), !dbg !417
  %1502 = icmp ugt i32 %1501, 249999
  br i1 %1502, label %1808, label %1503, !dbg !418

1503:                                             ; preds = %1499
  %1504 = and i64 %1500, 4294967295, !dbg !420
  %1505 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1504, i32 0, !dbg !422
  %1506 = load i64, i64* %1505, align 8, !dbg !422, !tbaa !423
  %1507 = icmp ugt i64 %1506, %1494, !dbg !426
  %1508 = add nuw i64 %1500, 1, !dbg !427
  %1509 = and i64 %1508, 4294967295, !dbg !427
  %1510 = select i1 %1507, i64 0, i64 %1509, !dbg !427
  %1511 = select i1 %1507, i64 %1504, i64 %1497, !dbg !427
  %1512 = select i1 %1507, i64 16431834, i64 %1504, !dbg !427
  call void @llvm.dbg.value(metadata i32 1, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1512, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1511, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1510, metadata !399, metadata !DIExpression()), !dbg !407
  %1513 = icmp ult i64 %1510, %1511, !dbg !412
  br i1 %1513, label %1514, label %1808, !dbg !414

1514:                                             ; preds = %1503
  %1515 = add i64 %1511, %1510, !dbg !428
  %1516 = lshr i64 %1515, 1, !dbg !415
  %1517 = trunc i64 %1516 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1517, metadata !404, metadata !DIExpression()), !dbg !417
  %1518 = icmp ugt i32 %1517, 249999
  br i1 %1518, label %1808, label %1519, !dbg !418

1519:                                             ; preds = %1514
  %1520 = and i64 %1516, 4294967295, !dbg !420
  %1521 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1520, i32 0, !dbg !422
  %1522 = load i64, i64* %1521, align 8, !dbg !422, !tbaa !423
  %1523 = icmp ugt i64 %1522, %1494, !dbg !426
  %1524 = add nuw i64 %1516, 1, !dbg !427
  %1525 = and i64 %1524, 4294967295, !dbg !427
  %1526 = select i1 %1523, i64 %1510, i64 %1525, !dbg !427
  %1527 = select i1 %1523, i64 %1520, i64 %1511, !dbg !427
  %1528 = select i1 %1523, i64 %1512, i64 %1520, !dbg !427
  call void @llvm.dbg.value(metadata i32 2, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1528, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1527, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1526, metadata !399, metadata !DIExpression()), !dbg !407
  %1529 = icmp ult i64 %1526, %1527, !dbg !412
  br i1 %1529, label %1530, label %1808, !dbg !414

1530:                                             ; preds = %1519
  %1531 = add i64 %1527, %1526, !dbg !428
  %1532 = lshr i64 %1531, 1, !dbg !415
  %1533 = trunc i64 %1532 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1533, metadata !404, metadata !DIExpression()), !dbg !417
  %1534 = icmp ugt i32 %1533, 249999
  br i1 %1534, label %1808, label %1535, !dbg !418

1535:                                             ; preds = %1530
  %1536 = and i64 %1532, 4294967295, !dbg !420
  %1537 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1536, i32 0, !dbg !422
  %1538 = load i64, i64* %1537, align 8, !dbg !422, !tbaa !423
  %1539 = icmp ugt i64 %1538, %1494, !dbg !426
  %1540 = add nuw i64 %1532, 1, !dbg !427
  %1541 = and i64 %1540, 4294967295, !dbg !427
  %1542 = select i1 %1539, i64 %1526, i64 %1541, !dbg !427
  %1543 = select i1 %1539, i64 %1536, i64 %1527, !dbg !427
  %1544 = select i1 %1539, i64 %1528, i64 %1536, !dbg !427
  call void @llvm.dbg.value(metadata i32 3, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1544, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1543, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1542, metadata !399, metadata !DIExpression()), !dbg !407
  %1545 = icmp ult i64 %1542, %1543, !dbg !412
  br i1 %1545, label %1546, label %1808, !dbg !414

1546:                                             ; preds = %1535
  %1547 = add i64 %1543, %1542, !dbg !428
  %1548 = lshr i64 %1547, 1, !dbg !415
  %1549 = trunc i64 %1548 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1549, metadata !404, metadata !DIExpression()), !dbg !417
  %1550 = icmp ugt i32 %1549, 249999
  br i1 %1550, label %1808, label %1551, !dbg !418

1551:                                             ; preds = %1546
  %1552 = and i64 %1548, 4294967295, !dbg !420
  %1553 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1552, i32 0, !dbg !422
  %1554 = load i64, i64* %1553, align 8, !dbg !422, !tbaa !423
  %1555 = icmp ugt i64 %1554, %1494, !dbg !426
  %1556 = add nuw i64 %1548, 1, !dbg !427
  %1557 = and i64 %1556, 4294967295, !dbg !427
  %1558 = select i1 %1555, i64 %1542, i64 %1557, !dbg !427
  %1559 = select i1 %1555, i64 %1552, i64 %1543, !dbg !427
  %1560 = select i1 %1555, i64 %1544, i64 %1552, !dbg !427
  call void @llvm.dbg.value(metadata i32 4, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1560, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1559, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1558, metadata !399, metadata !DIExpression()), !dbg !407
  %1561 = icmp ult i64 %1558, %1559, !dbg !412
  br i1 %1561, label %1562, label %1808, !dbg !414

1562:                                             ; preds = %1551
  %1563 = add i64 %1559, %1558, !dbg !428
  %1564 = lshr i64 %1563, 1, !dbg !415
  %1565 = trunc i64 %1564 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1565, metadata !404, metadata !DIExpression()), !dbg !417
  %1566 = icmp ugt i32 %1565, 249999
  br i1 %1566, label %1808, label %1567, !dbg !418

1567:                                             ; preds = %1562
  %1568 = and i64 %1564, 4294967295, !dbg !420
  %1569 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1568, i32 0, !dbg !422
  %1570 = load i64, i64* %1569, align 8, !dbg !422, !tbaa !423
  %1571 = icmp ugt i64 %1570, %1494, !dbg !426
  %1572 = add nuw i64 %1564, 1, !dbg !427
  %1573 = and i64 %1572, 4294967295, !dbg !427
  %1574 = select i1 %1571, i64 %1558, i64 %1573, !dbg !427
  %1575 = select i1 %1571, i64 %1568, i64 %1559, !dbg !427
  %1576 = select i1 %1571, i64 %1560, i64 %1568, !dbg !427
  call void @llvm.dbg.value(metadata i32 5, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1576, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1575, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1574, metadata !399, metadata !DIExpression()), !dbg !407
  %1577 = icmp ult i64 %1574, %1575, !dbg !412
  br i1 %1577, label %1578, label %1808, !dbg !414

1578:                                             ; preds = %1567
  %1579 = add i64 %1575, %1574, !dbg !428
  %1580 = lshr i64 %1579, 1, !dbg !415
  %1581 = trunc i64 %1580 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1581, metadata !404, metadata !DIExpression()), !dbg !417
  %1582 = icmp ugt i32 %1581, 249999
  br i1 %1582, label %1808, label %1583, !dbg !418

1583:                                             ; preds = %1578
  %1584 = and i64 %1580, 4294967295, !dbg !420
  %1585 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1584, i32 0, !dbg !422
  %1586 = load i64, i64* %1585, align 8, !dbg !422, !tbaa !423
  %1587 = icmp ugt i64 %1586, %1494, !dbg !426
  %1588 = add nuw i64 %1580, 1, !dbg !427
  %1589 = and i64 %1588, 4294967295, !dbg !427
  %1590 = select i1 %1587, i64 %1574, i64 %1589, !dbg !427
  %1591 = select i1 %1587, i64 %1584, i64 %1575, !dbg !427
  %1592 = select i1 %1587, i64 %1576, i64 %1584, !dbg !427
  call void @llvm.dbg.value(metadata i32 6, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1592, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1591, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1590, metadata !399, metadata !DIExpression()), !dbg !407
  %1593 = icmp ult i64 %1590, %1591, !dbg !412
  br i1 %1593, label %1594, label %1808, !dbg !414

1594:                                             ; preds = %1583
  %1595 = add i64 %1591, %1590, !dbg !428
  %1596 = lshr i64 %1595, 1, !dbg !415
  %1597 = trunc i64 %1596 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1597, metadata !404, metadata !DIExpression()), !dbg !417
  %1598 = icmp ugt i32 %1597, 249999
  br i1 %1598, label %1808, label %1599, !dbg !418

1599:                                             ; preds = %1594
  %1600 = and i64 %1596, 4294967295, !dbg !420
  %1601 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1600, i32 0, !dbg !422
  %1602 = load i64, i64* %1601, align 8, !dbg !422, !tbaa !423
  %1603 = icmp ugt i64 %1602, %1494, !dbg !426
  %1604 = add nuw i64 %1596, 1, !dbg !427
  %1605 = and i64 %1604, 4294967295, !dbg !427
  %1606 = select i1 %1603, i64 %1590, i64 %1605, !dbg !427
  %1607 = select i1 %1603, i64 %1600, i64 %1591, !dbg !427
  %1608 = select i1 %1603, i64 %1592, i64 %1600, !dbg !427
  call void @llvm.dbg.value(metadata i32 7, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1608, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1607, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1606, metadata !399, metadata !DIExpression()), !dbg !407
  %1609 = icmp ult i64 %1606, %1607, !dbg !412
  br i1 %1609, label %1610, label %1808, !dbg !414

1610:                                             ; preds = %1599
  %1611 = add i64 %1607, %1606, !dbg !428
  %1612 = lshr i64 %1611, 1, !dbg !415
  %1613 = trunc i64 %1612 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1613, metadata !404, metadata !DIExpression()), !dbg !417
  %1614 = icmp ugt i32 %1613, 249999
  br i1 %1614, label %1808, label %1615, !dbg !418

1615:                                             ; preds = %1610
  %1616 = and i64 %1612, 4294967295, !dbg !420
  %1617 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1616, i32 0, !dbg !422
  %1618 = load i64, i64* %1617, align 8, !dbg !422, !tbaa !423
  %1619 = icmp ugt i64 %1618, %1494, !dbg !426
  %1620 = add nuw i64 %1612, 1, !dbg !427
  %1621 = and i64 %1620, 4294967295, !dbg !427
  %1622 = select i1 %1619, i64 %1606, i64 %1621, !dbg !427
  %1623 = select i1 %1619, i64 %1616, i64 %1607, !dbg !427
  %1624 = select i1 %1619, i64 %1608, i64 %1616, !dbg !427
  call void @llvm.dbg.value(metadata i32 8, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1624, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1623, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1622, metadata !399, metadata !DIExpression()), !dbg !407
  %1625 = icmp ult i64 %1622, %1623, !dbg !412
  br i1 %1625, label %1626, label %1808, !dbg !414

1626:                                             ; preds = %1615
  %1627 = add i64 %1623, %1622, !dbg !428
  %1628 = lshr i64 %1627, 1, !dbg !415
  %1629 = trunc i64 %1628 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1629, metadata !404, metadata !DIExpression()), !dbg !417
  %1630 = icmp ugt i32 %1629, 249999
  br i1 %1630, label %1808, label %1631, !dbg !418

1631:                                             ; preds = %1626
  %1632 = and i64 %1628, 4294967295, !dbg !420
  %1633 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1632, i32 0, !dbg !422
  %1634 = load i64, i64* %1633, align 8, !dbg !422, !tbaa !423
  %1635 = icmp ugt i64 %1634, %1494, !dbg !426
  %1636 = add nuw i64 %1628, 1, !dbg !427
  %1637 = and i64 %1636, 4294967295, !dbg !427
  %1638 = select i1 %1635, i64 %1622, i64 %1637, !dbg !427
  %1639 = select i1 %1635, i64 %1632, i64 %1623, !dbg !427
  %1640 = select i1 %1635, i64 %1624, i64 %1632, !dbg !427
  call void @llvm.dbg.value(metadata i32 9, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1640, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1639, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1638, metadata !399, metadata !DIExpression()), !dbg !407
  %1641 = icmp ult i64 %1638, %1639, !dbg !412
  br i1 %1641, label %1642, label %1808, !dbg !414

1642:                                             ; preds = %1631
  %1643 = add i64 %1639, %1638, !dbg !428
  %1644 = lshr i64 %1643, 1, !dbg !415
  %1645 = trunc i64 %1644 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1645, metadata !404, metadata !DIExpression()), !dbg !417
  %1646 = icmp ugt i32 %1645, 249999
  br i1 %1646, label %1808, label %1647, !dbg !418

1647:                                             ; preds = %1642
  %1648 = and i64 %1644, 4294967295, !dbg !420
  %1649 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1648, i32 0, !dbg !422
  %1650 = load i64, i64* %1649, align 8, !dbg !422, !tbaa !423
  %1651 = icmp ugt i64 %1650, %1494, !dbg !426
  %1652 = add nuw i64 %1644, 1, !dbg !427
  %1653 = and i64 %1652, 4294967295, !dbg !427
  %1654 = select i1 %1651, i64 %1638, i64 %1653, !dbg !427
  %1655 = select i1 %1651, i64 %1648, i64 %1639, !dbg !427
  %1656 = select i1 %1651, i64 %1640, i64 %1648, !dbg !427
  call void @llvm.dbg.value(metadata i32 10, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1656, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1655, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1654, metadata !399, metadata !DIExpression()), !dbg !407
  %1657 = icmp ult i64 %1654, %1655, !dbg !412
  br i1 %1657, label %1658, label %1808, !dbg !414

1658:                                             ; preds = %1647
  %1659 = add i64 %1655, %1654, !dbg !428
  %1660 = lshr i64 %1659, 1, !dbg !415
  %1661 = trunc i64 %1660 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1661, metadata !404, metadata !DIExpression()), !dbg !417
  %1662 = icmp ugt i32 %1661, 249999
  br i1 %1662, label %1808, label %1663, !dbg !418

1663:                                             ; preds = %1658
  %1664 = and i64 %1660, 4294967295, !dbg !420
  %1665 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1664, i32 0, !dbg !422
  %1666 = load i64, i64* %1665, align 8, !dbg !422, !tbaa !423
  %1667 = icmp ugt i64 %1666, %1494, !dbg !426
  %1668 = add nuw i64 %1660, 1, !dbg !427
  %1669 = and i64 %1668, 4294967295, !dbg !427
  %1670 = select i1 %1667, i64 %1654, i64 %1669, !dbg !427
  %1671 = select i1 %1667, i64 %1664, i64 %1655, !dbg !427
  %1672 = select i1 %1667, i64 %1656, i64 %1664, !dbg !427
  call void @llvm.dbg.value(metadata i32 11, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1672, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1671, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1670, metadata !399, metadata !DIExpression()), !dbg !407
  %1673 = icmp ult i64 %1670, %1671, !dbg !412
  br i1 %1673, label %1674, label %1808, !dbg !414

1674:                                             ; preds = %1663
  %1675 = add i64 %1671, %1670, !dbg !428
  %1676 = lshr i64 %1675, 1, !dbg !415
  %1677 = trunc i64 %1676 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1677, metadata !404, metadata !DIExpression()), !dbg !417
  %1678 = icmp ugt i32 %1677, 249999
  br i1 %1678, label %1808, label %1679, !dbg !418

1679:                                             ; preds = %1674
  %1680 = and i64 %1676, 4294967295, !dbg !420
  %1681 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1680, i32 0, !dbg !422
  %1682 = load i64, i64* %1681, align 8, !dbg !422, !tbaa !423
  %1683 = icmp ugt i64 %1682, %1494, !dbg !426
  %1684 = add nuw i64 %1676, 1, !dbg !427
  %1685 = and i64 %1684, 4294967295, !dbg !427
  %1686 = select i1 %1683, i64 %1670, i64 %1685, !dbg !427
  %1687 = select i1 %1683, i64 %1680, i64 %1671, !dbg !427
  %1688 = select i1 %1683, i64 %1672, i64 %1680, !dbg !427
  call void @llvm.dbg.value(metadata i32 12, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1688, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1687, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1686, metadata !399, metadata !DIExpression()), !dbg !407
  %1689 = icmp ult i64 %1686, %1687, !dbg !412
  br i1 %1689, label %1690, label %1808, !dbg !414

1690:                                             ; preds = %1679
  %1691 = add i64 %1687, %1686, !dbg !428
  %1692 = lshr i64 %1691, 1, !dbg !415
  %1693 = trunc i64 %1692 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1693, metadata !404, metadata !DIExpression()), !dbg !417
  %1694 = icmp ugt i32 %1693, 249999
  br i1 %1694, label %1808, label %1695, !dbg !418

1695:                                             ; preds = %1690
  %1696 = and i64 %1692, 4294967295, !dbg !420
  %1697 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1696, i32 0, !dbg !422
  %1698 = load i64, i64* %1697, align 8, !dbg !422, !tbaa !423
  %1699 = icmp ugt i64 %1698, %1494, !dbg !426
  %1700 = add nuw i64 %1692, 1, !dbg !427
  %1701 = and i64 %1700, 4294967295, !dbg !427
  %1702 = select i1 %1699, i64 %1686, i64 %1701, !dbg !427
  %1703 = select i1 %1699, i64 %1696, i64 %1687, !dbg !427
  %1704 = select i1 %1699, i64 %1688, i64 %1696, !dbg !427
  call void @llvm.dbg.value(metadata i32 13, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1704, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1703, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1702, metadata !399, metadata !DIExpression()), !dbg !407
  %1705 = icmp ult i64 %1702, %1703, !dbg !412
  br i1 %1705, label %1706, label %1808, !dbg !414

1706:                                             ; preds = %1695
  %1707 = add i64 %1703, %1702, !dbg !428
  %1708 = lshr i64 %1707, 1, !dbg !415
  %1709 = trunc i64 %1708 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1709, metadata !404, metadata !DIExpression()), !dbg !417
  %1710 = icmp ugt i32 %1709, 249999
  br i1 %1710, label %1808, label %1711, !dbg !418

1711:                                             ; preds = %1706
  %1712 = and i64 %1708, 4294967295, !dbg !420
  %1713 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1712, i32 0, !dbg !422
  %1714 = load i64, i64* %1713, align 8, !dbg !422, !tbaa !423
  %1715 = icmp ugt i64 %1714, %1494, !dbg !426
  %1716 = add nuw i64 %1708, 1, !dbg !427
  %1717 = and i64 %1716, 4294967295, !dbg !427
  %1718 = select i1 %1715, i64 %1702, i64 %1717, !dbg !427
  %1719 = select i1 %1715, i64 %1712, i64 %1703, !dbg !427
  %1720 = select i1 %1715, i64 %1704, i64 %1712, !dbg !427
  call void @llvm.dbg.value(metadata i32 14, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1720, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1719, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1718, metadata !399, metadata !DIExpression()), !dbg !407
  %1721 = icmp ult i64 %1718, %1719, !dbg !412
  br i1 %1721, label %1722, label %1808, !dbg !414

1722:                                             ; preds = %1711
  %1723 = add i64 %1719, %1718, !dbg !428
  %1724 = lshr i64 %1723, 1, !dbg !415
  %1725 = trunc i64 %1724 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1725, metadata !404, metadata !DIExpression()), !dbg !417
  %1726 = icmp ugt i32 %1725, 249999
  br i1 %1726, label %1808, label %1727, !dbg !418

1727:                                             ; preds = %1722
  %1728 = and i64 %1724, 4294967295, !dbg !420
  %1729 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1728, i32 0, !dbg !422
  %1730 = load i64, i64* %1729, align 8, !dbg !422, !tbaa !423
  %1731 = icmp ugt i64 %1730, %1494, !dbg !426
  %1732 = add nuw i64 %1724, 1, !dbg !427
  %1733 = and i64 %1732, 4294967295, !dbg !427
  %1734 = select i1 %1731, i64 %1718, i64 %1733, !dbg !427
  %1735 = select i1 %1731, i64 %1728, i64 %1719, !dbg !427
  %1736 = select i1 %1731, i64 %1720, i64 %1728, !dbg !427
  call void @llvm.dbg.value(metadata i32 15, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1736, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1735, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1734, metadata !399, metadata !DIExpression()), !dbg !407
  %1737 = icmp ult i64 %1734, %1735, !dbg !412
  br i1 %1737, label %1738, label %1808, !dbg !414

1738:                                             ; preds = %1727
  %1739 = add i64 %1735, %1734, !dbg !428
  %1740 = lshr i64 %1739, 1, !dbg !415
  %1741 = trunc i64 %1740 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1741, metadata !404, metadata !DIExpression()), !dbg !417
  %1742 = icmp ugt i32 %1741, 249999
  br i1 %1742, label %1808, label %1743, !dbg !418

1743:                                             ; preds = %1738
  %1744 = and i64 %1740, 4294967295, !dbg !420
  %1745 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1744, i32 0, !dbg !422
  %1746 = load i64, i64* %1745, align 8, !dbg !422, !tbaa !423
  %1747 = icmp ugt i64 %1746, %1494, !dbg !426
  %1748 = add nuw i64 %1740, 1, !dbg !427
  %1749 = and i64 %1748, 4294967295, !dbg !427
  %1750 = select i1 %1747, i64 %1734, i64 %1749, !dbg !427
  %1751 = select i1 %1747, i64 %1744, i64 %1735, !dbg !427
  %1752 = select i1 %1747, i64 %1736, i64 %1744, !dbg !427
  call void @llvm.dbg.value(metadata i32 16, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1752, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1751, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1750, metadata !399, metadata !DIExpression()), !dbg !407
  %1753 = icmp ult i64 %1750, %1751, !dbg !412
  br i1 %1753, label %1754, label %1808, !dbg !414

1754:                                             ; preds = %1743
  %1755 = add i64 %1751, %1750, !dbg !428
  %1756 = lshr i64 %1755, 1, !dbg !415
  %1757 = trunc i64 %1756 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1757, metadata !404, metadata !DIExpression()), !dbg !417
  %1758 = icmp ugt i32 %1757, 249999
  br i1 %1758, label %1808, label %1759, !dbg !418

1759:                                             ; preds = %1754
  %1760 = and i64 %1756, 4294967295, !dbg !420
  %1761 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1760, i32 0, !dbg !422
  %1762 = load i64, i64* %1761, align 8, !dbg !422, !tbaa !423
  %1763 = icmp ugt i64 %1762, %1494, !dbg !426
  %1764 = add nuw i64 %1756, 1, !dbg !427
  %1765 = and i64 %1764, 4294967295, !dbg !427
  %1766 = select i1 %1763, i64 %1750, i64 %1765, !dbg !427
  %1767 = select i1 %1763, i64 %1760, i64 %1751, !dbg !427
  %1768 = select i1 %1763, i64 %1752, i64 %1760, !dbg !427
  call void @llvm.dbg.value(metadata i32 17, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1768, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1767, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1766, metadata !399, metadata !DIExpression()), !dbg !407
  %1769 = icmp ult i64 %1766, %1767, !dbg !412
  br i1 %1769, label %1770, label %1808, !dbg !414

1770:                                             ; preds = %1759
  %1771 = add i64 %1767, %1766, !dbg !428
  %1772 = lshr i64 %1771, 1, !dbg !415
  %1773 = trunc i64 %1772 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1773, metadata !404, metadata !DIExpression()), !dbg !417
  %1774 = icmp ugt i32 %1773, 249999
  br i1 %1774, label %1808, label %1775, !dbg !418

1775:                                             ; preds = %1770
  %1776 = and i64 %1772, 4294967295, !dbg !420
  %1777 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1776, i32 0, !dbg !422
  %1778 = load i64, i64* %1777, align 8, !dbg !422, !tbaa !423
  %1779 = icmp ugt i64 %1778, %1494, !dbg !426
  %1780 = add nuw i64 %1772, 1, !dbg !427
  %1781 = and i64 %1780, 4294967295, !dbg !427
  %1782 = select i1 %1779, i64 %1766, i64 %1781, !dbg !427
  %1783 = select i1 %1779, i64 %1776, i64 %1767, !dbg !427
  %1784 = select i1 %1779, i64 %1768, i64 %1776, !dbg !427
  call void @llvm.dbg.value(metadata i32 18, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1784, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1783, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1782, metadata !399, metadata !DIExpression()), !dbg !407
  %1785 = icmp ult i64 %1782, %1783, !dbg !412
  br i1 %1785, label %1786, label %1808, !dbg !414

1786:                                             ; preds = %1775
  %1787 = add i64 %1783, %1782, !dbg !428
  %1788 = lshr i64 %1787, 1, !dbg !415
  %1789 = trunc i64 %1788 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1789, metadata !404, metadata !DIExpression()), !dbg !417
  %1790 = icmp ugt i32 %1789, 249999
  br i1 %1790, label %1808, label %1791, !dbg !418

1791:                                             ; preds = %1786
  %1792 = and i64 %1788, 4294967295, !dbg !420
  %1793 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1493, i64 0, i32 4, i64 %1792, i32 0, !dbg !422
  %1794 = load i64, i64* %1793, align 8, !dbg !422, !tbaa !423
  %1795 = icmp ugt i64 %1794, %1494, !dbg !426
  %1796 = add nuw i64 %1788, 1, !dbg !427
  %1797 = and i64 %1796, 4294967295, !dbg !427
  %1798 = select i1 %1795, i64 %1782, i64 %1797, !dbg !427
  %1799 = select i1 %1795, i64 %1792, i64 %1783, !dbg !427
  %1800 = select i1 %1795, i64 %1784, i64 %1792, !dbg !427
  call void @llvm.dbg.value(metadata i32 19, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1800, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1799, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1798, metadata !399, metadata !DIExpression()), !dbg !407
  %1801 = icmp ult i64 %1798, %1799, !dbg !412
  br i1 %1801, label %1802, label %1808, !dbg !414

1802:                                             ; preds = %1791
  %1803 = add i64 %1799, %1798, !dbg !428
  %1804 = lshr i64 %1803, 1, !dbg !415
  %1805 = trunc i64 %1804 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1805, metadata !404, metadata !DIExpression()), !dbg !417
  %1806 = icmp ugt i32 %1805, 249999
  br i1 %1806, label %1808, label %1807, !dbg !418

1807:                                             ; preds = %1802
  call void @llvm.dbg.value(metadata i64 undef, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !399, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i32 20, metadata !402, metadata !DIExpression()), !dbg !411
  br label %1808

1808:                                             ; preds = %1807, %1802, %1791, %1786, %1775, %1770, %1759, %1754, %1743, %1738, %1727, %1722, %1711, %1706, %1695, %1690, %1679, %1674, %1663, %1658, %1647, %1642, %1631, %1626, %1615, %1610, %1599, %1594, %1583, %1578, %1567, %1562, %1551, %1546, %1535, %1530, %1519, %1514, %1503, %1499, %1491
  %1809 = phi i64 [ 16431834, %1491 ], [ 3735928559, %1499 ], [ %1512, %1503 ], [ 3735928559, %1514 ], [ %1528, %1519 ], [ 3735928559, %1530 ], [ %1544, %1535 ], [ 3735928559, %1546 ], [ %1560, %1551 ], [ 3735928559, %1562 ], [ %1576, %1567 ], [ 3735928559, %1578 ], [ %1592, %1583 ], [ 3735928559, %1594 ], [ %1608, %1599 ], [ 3735928559, %1610 ], [ %1624, %1615 ], [ 3735928559, %1626 ], [ %1640, %1631 ], [ 3735928559, %1642 ], [ %1656, %1647 ], [ 3735928559, %1658 ], [ %1672, %1663 ], [ 3735928559, %1674 ], [ %1688, %1679 ], [ 3735928559, %1690 ], [ %1704, %1695 ], [ 3735928559, %1706 ], [ %1720, %1711 ], [ 3735928559, %1722 ], [ %1736, %1727 ], [ 3735928559, %1738 ], [ %1752, %1743 ], [ 3735928559, %1754 ], [ %1768, %1759 ], [ 3735928559, %1770 ], [ %1784, %1775 ], [ 3735928559, %1786 ], [ %1800, %1791 ], [ 3735928559, %1802 ], [ 12246957, %1807 ]
  call void @llvm.dbg.value(metadata i64 %1809, metadata !302, metadata !DIExpression()), !dbg !384
  %1810 = icmp eq i64 %1809, 16431834, !dbg !429
  %1811 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %1810)
  %1812 = freeze i1 %1811, !dbg !431
  br i1 %1812, label %2850, label %1813, !dbg !431

1813:                                             ; preds = %1808
  switch i64 %1809, label %1814 [
    i64 3735928559, label %2850
    i64 12246957, label %2850
  ], !dbg !431

1814:                                             ; preds = %1813
  %1815 = load i64, i64* %19, align 8, !dbg !432, !tbaa !433
  call void @llvm.dbg.value(metadata i64 %1815, metadata !303, metadata !DIExpression()), !dbg !384
  %1816 = icmp ult i64 %1815, 115
  br i1 %1816, label %1817, label %1819, !dbg !434

1817:                                             ; preds = %1814
  %1818 = getelementptr inbounds [115 x i64], [115 x i64]* %21, i64 0, i64 %1815, !dbg !436
  store i64 %1494, i64* %1818, align 8, !dbg !438, !tbaa !329
  br label %1819, !dbg !439

1819:                                             ; preds = %1817, %1814
  call void @llvm.dbg.value(metadata i64 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !384
  call void @llvm.dbg.value(metadata i16 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  %1820 = getelementptr inbounds i8, i8* %1492, i64 4000027, !dbg !440
  %1821 = load i8, i8* %1820, align 1, !dbg !440, !tbaa.struct !441
  call void @llvm.dbg.value(metadata i8 %1821, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 88, 8)), !dbg !384
  %1822 = getelementptr inbounds i8, i8* %1492, i64 4000028, !dbg !440
  %1823 = bitcast i8* %1822 to i16*, !dbg !440
  %1824 = load i16, i16* %1823, align 4, !dbg !440, !tbaa.struct !444
  call void @llvm.dbg.value(metadata i16 %1824, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !384
  %1825 = getelementptr inbounds i8, i8* %1492, i64 4000030, !dbg !440
  %1826 = bitcast i8* %1825 to i16*, !dbg !440
  %1827 = load i16, i16* %1826, align 2, !dbg !440, !tbaa.struct !445
  call void @llvm.dbg.value(metadata i16 %1827, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i64 undef, metadata !305, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 %1821, metadata !307, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %1824, metadata !308, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %1827, metadata !309, metadata !DIExpression()), !dbg !384
  %1828 = icmp eq i8 %1821, 2, !dbg !446
  %1829 = icmp eq i8 %1821, 3
  %1830 = call i1 @llvm.bpf.passthrough.i1.i1(i32 1, i1 %1828)
  %1831 = select i1 %1830, i1 true, i1 %1829, !dbg !448
  br i1 %1831, label %2850, label %1832, !dbg !448

1832:                                             ; preds = %1819
  %1833 = getelementptr inbounds i8, i8* %1492, i64 4000026, !dbg !440
  %1834 = load i8, i8* %1833, align 2, !dbg !440, !tbaa.struct !449
  call void @llvm.dbg.value(metadata i8 %1834, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  call void @llvm.dbg.value(metadata i8 %1834, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i64 0, metadata !310, metadata !DIExpression()), !dbg !384
  switch i8 %1834, label %2850 [
    i8 1, label %1850
    i8 2, label %1846
    i8 3, label %1835
  ], !dbg !450

1835:                                             ; preds = %1832
  switch i16 %1824, label %2850 [
    i16 2, label %1836
    i16 1, label %1837
  ], !dbg !462

1836:                                             ; preds = %1835
  call void @llvm.dbg.value(metadata i64 10, metadata !311, metadata !DIExpression()), !dbg !463
  br label %1837, !dbg !464

1837:                                             ; preds = %1836, %1835
  %1838 = phi i64 [ 11, %1835 ], [ 10, %1836 ]
  call void @llvm.dbg.value(metadata i64 0, metadata !311, metadata !DIExpression()), !dbg !463
  %1839 = load i64, i64* %23, align 8, !dbg !468, !tbaa !458
  %1840 = add i64 %1839, 8, !dbg !469
  %1841 = load i64, i64* %14, align 8, !dbg !470, !tbaa !339
  %1842 = and i64 %1841, 15, !dbg !471
  %1843 = icmp ult i64 %1842, %1838, !dbg !472
  %1844 = select i1 %1843, i64 0, i64 8, !dbg !473
  %1845 = add i64 %1840, %1844, !dbg !474
  call void @llvm.dbg.value(metadata i64 %1845, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1854

1846:                                             ; preds = %1832
  %1847 = load i64, i64* %23, align 8, !dbg !456, !tbaa !458
  %1848 = sext i16 %1824 to i64, !dbg !459
  %1849 = add i64 %1847, %1848, !dbg !460
  call void @llvm.dbg.value(metadata i64 %1849, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1854, !dbg !461

1850:                                             ; preds = %1832
  %1851 = load i64, i64* %25, align 8, !dbg !451, !tbaa !389
  %1852 = sext i16 %1824 to i64, !dbg !453
  %1853 = add i64 %1851, %1852, !dbg !454
  call void @llvm.dbg.value(metadata i64 %1853, metadata !310, metadata !DIExpression()), !dbg !384
  br label %1854, !dbg !455

1854:                                             ; preds = %1850, %1846, %1837
  %1855 = phi i64 [ %1853, %1850 ], [ %1849, %1846 ], [ %1845, %1837 ], !dbg !384
  call void @llvm.dbg.value(metadata i64 %1855, metadata !310, metadata !DIExpression()), !dbg !384
  %1856 = icmp eq i64 %1855, 0, !dbg !475
  br i1 %1856, label %2850, label %1857, !dbg !477

1857:                                             ; preds = %1854
  %1858 = add i64 %1855, -8, !dbg !478
  call void @llvm.dbg.value(metadata i64 %1858, metadata !316, metadata !DIExpression()), !dbg !384
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %26) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 0, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %6, align 8, !dbg !480, !tbaa !329
  %1859 = inttoptr i64 %1858 to i8*, !dbg !481
  call void @llvm.dbg.value(metadata i64* %6, metadata !317, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %1860 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %26, i32 noundef 8, i8* noundef %1859) #6, !dbg !482
  call void @llvm.dbg.value(metadata i64 %1860, metadata !318, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !384
  %1861 = load i64, i64* %6, align 8, !dbg !483, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %1861, metadata !317, metadata !DIExpression()), !dbg !384
  %1862 = icmp eq i64 %1861, 0, !dbg !485
  br i1 %1862, label %475, label %1863, !dbg !486

1863:                                             ; preds = %1857
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #6, !dbg !488
  call void @llvm.dbg.value(metadata i64 0, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %7, align 8, !dbg !489, !tbaa !329
  %1864 = icmp eq i8 %1821, 0, !dbg !490
  br i1 %1864, label %1874, label %1865, !dbg !491

1865:                                             ; preds = %1863
  %1866 = sext i16 %1827 to i64, !dbg !496
  %1867 = add i64 %1855, %1866, !dbg !497
  call void @llvm.dbg.value(metadata i64 %1867, metadata !320, metadata !DIExpression()), !dbg !498
  %1868 = inttoptr i64 %1867 to i8*, !dbg !499
  call void @llvm.dbg.value(metadata i64* %7, metadata !319, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %1869 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %27, i32 noundef 8, i8* noundef %1868) #6, !dbg !500
  %1870 = trunc i64 %1869 to i32, !dbg !500
  call void @llvm.dbg.value(metadata i32 %1870, metadata !323, metadata !DIExpression()), !dbg !498
  %1871 = icmp eq i32 %1870, 0, !dbg !501
  br i1 %1871, label %1872, label %489

1872:                                             ; preds = %1865
  %1873 = load i64, i64* %6, align 8, !dbg !503, !tbaa !329
  br label %1876

1874:                                             ; preds = %1863
  %1875 = load i64, i64* %25, align 8, !dbg !492, !tbaa !389
  call void @llvm.dbg.value(metadata i64 %1875, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %1875, i64* %7, align 8, !dbg !494, !tbaa !329
  br label %1876, !dbg !495

1876:                                             ; preds = %1872, %1874
  %1877 = phi i64 [ %1873, %1872 ], [ %1861, %1874 ], !dbg !503
  call void @llvm.dbg.value(metadata i64 %1877, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 %1877, i64* %14, align 8, !dbg !504, !tbaa !339
  store i64 %1855, i64* %23, align 8, !dbg !505, !tbaa !458
  %1878 = load i64, i64* %7, align 8, !dbg !506, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %1878, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %1878, i64* %25, align 8, !dbg !507, !tbaa !389
  %1879 = load i64, i64* %19, align 8, !dbg !508, !tbaa !433
  %1880 = add i64 %1879, 1, !dbg !508
  store i64 %1880, i64* %19, align 8, !dbg !508, !tbaa !433
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 4, metadata !297, metadata !DIExpression()), !dbg !337
  call void @llvm.dbg.value(metadata i32 4, metadata !297, metadata !DIExpression()), !dbg !337
  %1881 = load i64, i64* %14, align 8, !dbg !338, !tbaa !339
  call void @llvm.dbg.value(metadata i32 %9, metadata !343, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.dbg.value(metadata i64 %1881, metadata !350, metadata !DIExpression()) #6, !dbg !357
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15) #6, !dbg !359
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %4, metadata !351, metadata !DIExpression()) #6, !dbg !360
  store i32 %9, i32* %16, align 4, !dbg !361, !tbaa !362
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 0, i32* %17, align 4, !dbg !365, !tbaa !366
  %1882 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1882, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1883 = icmp eq i8* %1882, null, !dbg !369
  br i1 %1883, label %1893, label %1884, !dbg !371

1884:                                             ; preds = %1876
  %1885 = bitcast i8* %1882 to i64*, !dbg !372
  %1886 = load i64, i64* %1885, align 8, !dbg !372, !tbaa !375
  %1887 = icmp ugt i64 %1886, %1881, !dbg !377
  br i1 %1887, label %1893, label %1888, !dbg !378

1888:                                             ; preds = %1884
  %1889 = getelementptr inbounds i8, i8* %1882, i64 8, !dbg !379
  %1890 = bitcast i8* %1889 to i64*, !dbg !379
  %1891 = load i64, i64* %1890, align 8, !dbg !379, !tbaa !380
  %1892 = icmp ult i64 %1891, %1881, !dbg !381
  br i1 %1892, label %1893, label %1953, !dbg !382

1893:                                             ; preds = %1888, %1884, %1876
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 1, i32* %17, align 4, !dbg !365, !tbaa !366
  %1894 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1894, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1895 = icmp eq i8* %1894, null, !dbg !369
  br i1 %1895, label %1905, label %1896, !dbg !371

1896:                                             ; preds = %1893
  %1897 = bitcast i8* %1894 to i64*, !dbg !372
  %1898 = load i64, i64* %1897, align 8, !dbg !372, !tbaa !375
  %1899 = icmp ugt i64 %1898, %1881, !dbg !377
  br i1 %1899, label %1905, label %1900, !dbg !378

1900:                                             ; preds = %1896
  %1901 = getelementptr inbounds i8, i8* %1894, i64 8, !dbg !379
  %1902 = bitcast i8* %1901 to i64*, !dbg !379
  %1903 = load i64, i64* %1902, align 8, !dbg !379, !tbaa !380
  %1904 = icmp ult i64 %1903, %1881, !dbg !381
  br i1 %1904, label %1905, label %1953, !dbg !382

1905:                                             ; preds = %1900, %1896, %1893
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 2, i32* %17, align 4, !dbg !365, !tbaa !366
  %1906 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1906, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1907 = icmp eq i8* %1906, null, !dbg !369
  br i1 %1907, label %1917, label %1908, !dbg !371

1908:                                             ; preds = %1905
  %1909 = bitcast i8* %1906 to i64*, !dbg !372
  %1910 = load i64, i64* %1909, align 8, !dbg !372, !tbaa !375
  %1911 = icmp ugt i64 %1910, %1881, !dbg !377
  br i1 %1911, label %1917, label %1912, !dbg !378

1912:                                             ; preds = %1908
  %1913 = getelementptr inbounds i8, i8* %1906, i64 8, !dbg !379
  %1914 = bitcast i8* %1913 to i64*, !dbg !379
  %1915 = load i64, i64* %1914, align 8, !dbg !379, !tbaa !380
  %1916 = icmp ult i64 %1915, %1881, !dbg !381
  br i1 %1916, label %1917, label %1953, !dbg !382

1917:                                             ; preds = %1912, %1908, %1905
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 3, i32* %17, align 4, !dbg !365, !tbaa !366
  %1918 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1918, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1919 = icmp eq i8* %1918, null, !dbg !369
  br i1 %1919, label %1929, label %1920, !dbg !371

1920:                                             ; preds = %1917
  %1921 = bitcast i8* %1918 to i64*, !dbg !372
  %1922 = load i64, i64* %1921, align 8, !dbg !372, !tbaa !375
  %1923 = icmp ugt i64 %1922, %1881, !dbg !377
  br i1 %1923, label %1929, label %1924, !dbg !378

1924:                                             ; preds = %1920
  %1925 = getelementptr inbounds i8, i8* %1918, i64 8, !dbg !379
  %1926 = bitcast i8* %1925 to i64*, !dbg !379
  %1927 = load i64, i64* %1926, align 8, !dbg !379, !tbaa !380
  %1928 = icmp ult i64 %1927, %1881, !dbg !381
  br i1 %1928, label %1929, label %1953, !dbg !382

1929:                                             ; preds = %1924, %1920, %1917
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 4, i32* %17, align 4, !dbg !365, !tbaa !366
  %1930 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1930, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1931 = icmp eq i8* %1930, null, !dbg !369
  br i1 %1931, label %1941, label %1932, !dbg !371

1932:                                             ; preds = %1929
  %1933 = bitcast i8* %1930 to i64*, !dbg !372
  %1934 = load i64, i64* %1933, align 8, !dbg !372, !tbaa !375
  %1935 = icmp ugt i64 %1934, %1881, !dbg !377
  br i1 %1935, label %1941, label %1936, !dbg !378

1936:                                             ; preds = %1932
  %1937 = getelementptr inbounds i8, i8* %1930, i64 8, !dbg !379
  %1938 = bitcast i8* %1937 to i64*, !dbg !379
  %1939 = load i64, i64* %1938, align 8, !dbg !379, !tbaa !380
  %1940 = icmp ult i64 %1939, %1881, !dbg !381
  br i1 %1940, label %1941, label %1953, !dbg !382

1941:                                             ; preds = %1936, %1932, %1929
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !364
  store i32 5, i32* %17, align 4, !dbg !365, !tbaa !366
  %1942 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %15) #6, !dbg !367
  call void @llvm.dbg.value(metadata i8* %1942, metadata !354, metadata !DIExpression()) #6, !dbg !368
  %1943 = icmp eq i8* %1942, null, !dbg !369
  br i1 %1943, label %100, label %1944, !dbg !371

1944:                                             ; preds = %1941
  %1945 = bitcast i8* %1942 to i64*, !dbg !372
  %1946 = load i64, i64* %1945, align 8, !dbg !372, !tbaa !375
  %1947 = icmp ugt i64 %1946, %1881, !dbg !377
  br i1 %1947, label %100, label %1948, !dbg !378

1948:                                             ; preds = %1944
  %1949 = getelementptr inbounds i8, i8* %1942, i64 8, !dbg !379
  %1950 = bitcast i8* %1949 to i64*, !dbg !379
  %1951 = load i64, i64* %1950, align 8, !dbg !379, !tbaa !380
  %1952 = icmp ult i64 %1951, %1881, !dbg !381
  br i1 %1952, label %100, label %1953, !dbg !382

1953:                                             ; preds = %1948, %1936, %1924, %1912, %1900, %1888
  %1954 = phi i8* [ %1882, %1888 ], [ %1894, %1900 ], [ %1906, %1912 ], [ %1918, %1924 ], [ %1930, %1936 ], [ %1942, %1948 ], !dbg !367
  %1955 = bitcast i8* %1954 to %struct.stack_unwind_table_t*, !dbg !367
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15) #6, !dbg !383
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1955, metadata !299, metadata !DIExpression()), !dbg !384
  %1956 = load i64, i64* %14, align 8, !dbg !392, !tbaa !339
  call void @llvm.dbg.value(metadata %struct.stack_unwind_table_t* %1955, metadata !393, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1956, metadata !398, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 0, metadata !399, metadata !DIExpression()), !dbg !407
  %1957 = getelementptr inbounds i8, i8* %1954, i64 16, !dbg !409
  %1958 = bitcast i8* %1957 to i64*, !dbg !409
  %1959 = load i64, i64* %1958, align 8, !dbg !409, !tbaa !410
  call void @llvm.dbg.value(metadata i32 0, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 16431834, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1959, metadata !400, metadata !DIExpression()), !dbg !407
  %1960 = icmp eq i64 %1959, 0, !dbg !412
  br i1 %1960, label %2270, label %1961, !dbg !414

1961:                                             ; preds = %1953
  %1962 = lshr i64 %1959, 1, !dbg !415
  %1963 = trunc i64 %1962 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1963, metadata !404, metadata !DIExpression()), !dbg !417
  %1964 = icmp ugt i32 %1963, 249999
  br i1 %1964, label %2270, label %1965, !dbg !418

1965:                                             ; preds = %1961
  %1966 = and i64 %1962, 4294967295, !dbg !420
  %1967 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %1966, i32 0, !dbg !422
  %1968 = load i64, i64* %1967, align 8, !dbg !422, !tbaa !423
  %1969 = icmp ugt i64 %1968, %1956, !dbg !426
  %1970 = add nuw i64 %1962, 1, !dbg !427
  %1971 = and i64 %1970, 4294967295, !dbg !427
  %1972 = select i1 %1969, i64 0, i64 %1971, !dbg !427
  %1973 = select i1 %1969, i64 %1966, i64 %1959, !dbg !427
  %1974 = select i1 %1969, i64 16431834, i64 %1966, !dbg !427
  call void @llvm.dbg.value(metadata i32 1, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1974, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1973, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1972, metadata !399, metadata !DIExpression()), !dbg !407
  %1975 = icmp ult i64 %1972, %1973, !dbg !412
  br i1 %1975, label %1976, label %2270, !dbg !414

1976:                                             ; preds = %1965
  %1977 = add i64 %1973, %1972, !dbg !428
  %1978 = lshr i64 %1977, 1, !dbg !415
  %1979 = trunc i64 %1978 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1979, metadata !404, metadata !DIExpression()), !dbg !417
  %1980 = icmp ugt i32 %1979, 249999
  br i1 %1980, label %2270, label %1981, !dbg !418

1981:                                             ; preds = %1976
  %1982 = and i64 %1978, 4294967295, !dbg !420
  %1983 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %1982, i32 0, !dbg !422
  %1984 = load i64, i64* %1983, align 8, !dbg !422, !tbaa !423
  %1985 = icmp ugt i64 %1984, %1956, !dbg !426
  %1986 = add nuw i64 %1978, 1, !dbg !427
  %1987 = and i64 %1986, 4294967295, !dbg !427
  %1988 = select i1 %1985, i64 %1972, i64 %1987, !dbg !427
  %1989 = select i1 %1985, i64 %1982, i64 %1973, !dbg !427
  %1990 = select i1 %1985, i64 %1974, i64 %1982, !dbg !427
  call void @llvm.dbg.value(metadata i32 2, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %1990, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1989, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %1988, metadata !399, metadata !DIExpression()), !dbg !407
  %1991 = icmp ult i64 %1988, %1989, !dbg !412
  br i1 %1991, label %1992, label %2270, !dbg !414

1992:                                             ; preds = %1981
  %1993 = add i64 %1989, %1988, !dbg !428
  %1994 = lshr i64 %1993, 1, !dbg !415
  %1995 = trunc i64 %1994 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %1995, metadata !404, metadata !DIExpression()), !dbg !417
  %1996 = icmp ugt i32 %1995, 249999
  br i1 %1996, label %2270, label %1997, !dbg !418

1997:                                             ; preds = %1992
  %1998 = and i64 %1994, 4294967295, !dbg !420
  %1999 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %1998, i32 0, !dbg !422
  %2000 = load i64, i64* %1999, align 8, !dbg !422, !tbaa !423
  %2001 = icmp ugt i64 %2000, %1956, !dbg !426
  %2002 = add nuw i64 %1994, 1, !dbg !427
  %2003 = and i64 %2002, 4294967295, !dbg !427
  %2004 = select i1 %2001, i64 %1988, i64 %2003, !dbg !427
  %2005 = select i1 %2001, i64 %1998, i64 %1989, !dbg !427
  %2006 = select i1 %2001, i64 %1990, i64 %1998, !dbg !427
  call void @llvm.dbg.value(metadata i32 3, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2006, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2005, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2004, metadata !399, metadata !DIExpression()), !dbg !407
  %2007 = icmp ult i64 %2004, %2005, !dbg !412
  br i1 %2007, label %2008, label %2270, !dbg !414

2008:                                             ; preds = %1997
  %2009 = add i64 %2005, %2004, !dbg !428
  %2010 = lshr i64 %2009, 1, !dbg !415
  %2011 = trunc i64 %2010 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2011, metadata !404, metadata !DIExpression()), !dbg !417
  %2012 = icmp ugt i32 %2011, 249999
  br i1 %2012, label %2270, label %2013, !dbg !418

2013:                                             ; preds = %2008
  %2014 = and i64 %2010, 4294967295, !dbg !420
  %2015 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2014, i32 0, !dbg !422
  %2016 = load i64, i64* %2015, align 8, !dbg !422, !tbaa !423
  %2017 = icmp ugt i64 %2016, %1956, !dbg !426
  %2018 = add nuw i64 %2010, 1, !dbg !427
  %2019 = and i64 %2018, 4294967295, !dbg !427
  %2020 = select i1 %2017, i64 %2004, i64 %2019, !dbg !427
  %2021 = select i1 %2017, i64 %2014, i64 %2005, !dbg !427
  %2022 = select i1 %2017, i64 %2006, i64 %2014, !dbg !427
  call void @llvm.dbg.value(metadata i32 4, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2022, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2021, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2020, metadata !399, metadata !DIExpression()), !dbg !407
  %2023 = icmp ult i64 %2020, %2021, !dbg !412
  br i1 %2023, label %2024, label %2270, !dbg !414

2024:                                             ; preds = %2013
  %2025 = add i64 %2021, %2020, !dbg !428
  %2026 = lshr i64 %2025, 1, !dbg !415
  %2027 = trunc i64 %2026 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2027, metadata !404, metadata !DIExpression()), !dbg !417
  %2028 = icmp ugt i32 %2027, 249999
  br i1 %2028, label %2270, label %2029, !dbg !418

2029:                                             ; preds = %2024
  %2030 = and i64 %2026, 4294967295, !dbg !420
  %2031 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2030, i32 0, !dbg !422
  %2032 = load i64, i64* %2031, align 8, !dbg !422, !tbaa !423
  %2033 = icmp ugt i64 %2032, %1956, !dbg !426
  %2034 = add nuw i64 %2026, 1, !dbg !427
  %2035 = and i64 %2034, 4294967295, !dbg !427
  %2036 = select i1 %2033, i64 %2020, i64 %2035, !dbg !427
  %2037 = select i1 %2033, i64 %2030, i64 %2021, !dbg !427
  %2038 = select i1 %2033, i64 %2022, i64 %2030, !dbg !427
  call void @llvm.dbg.value(metadata i32 5, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2038, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2037, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2036, metadata !399, metadata !DIExpression()), !dbg !407
  %2039 = icmp ult i64 %2036, %2037, !dbg !412
  br i1 %2039, label %2040, label %2270, !dbg !414

2040:                                             ; preds = %2029
  %2041 = add i64 %2037, %2036, !dbg !428
  %2042 = lshr i64 %2041, 1, !dbg !415
  %2043 = trunc i64 %2042 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2043, metadata !404, metadata !DIExpression()), !dbg !417
  %2044 = icmp ugt i32 %2043, 249999
  br i1 %2044, label %2270, label %2045, !dbg !418

2045:                                             ; preds = %2040
  %2046 = and i64 %2042, 4294967295, !dbg !420
  %2047 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2046, i32 0, !dbg !422
  %2048 = load i64, i64* %2047, align 8, !dbg !422, !tbaa !423
  %2049 = icmp ugt i64 %2048, %1956, !dbg !426
  %2050 = add nuw i64 %2042, 1, !dbg !427
  %2051 = and i64 %2050, 4294967295, !dbg !427
  %2052 = select i1 %2049, i64 %2036, i64 %2051, !dbg !427
  %2053 = select i1 %2049, i64 %2046, i64 %2037, !dbg !427
  %2054 = select i1 %2049, i64 %2038, i64 %2046, !dbg !427
  call void @llvm.dbg.value(metadata i32 6, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2054, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2053, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2052, metadata !399, metadata !DIExpression()), !dbg !407
  %2055 = icmp ult i64 %2052, %2053, !dbg !412
  br i1 %2055, label %2056, label %2270, !dbg !414

2056:                                             ; preds = %2045
  %2057 = add i64 %2053, %2052, !dbg !428
  %2058 = lshr i64 %2057, 1, !dbg !415
  %2059 = trunc i64 %2058 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2059, metadata !404, metadata !DIExpression()), !dbg !417
  %2060 = icmp ugt i32 %2059, 249999
  br i1 %2060, label %2270, label %2061, !dbg !418

2061:                                             ; preds = %2056
  %2062 = and i64 %2058, 4294967295, !dbg !420
  %2063 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2062, i32 0, !dbg !422
  %2064 = load i64, i64* %2063, align 8, !dbg !422, !tbaa !423
  %2065 = icmp ugt i64 %2064, %1956, !dbg !426
  %2066 = add nuw i64 %2058, 1, !dbg !427
  %2067 = and i64 %2066, 4294967295, !dbg !427
  %2068 = select i1 %2065, i64 %2052, i64 %2067, !dbg !427
  %2069 = select i1 %2065, i64 %2062, i64 %2053, !dbg !427
  %2070 = select i1 %2065, i64 %2054, i64 %2062, !dbg !427
  call void @llvm.dbg.value(metadata i32 7, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2070, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2069, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2068, metadata !399, metadata !DIExpression()), !dbg !407
  %2071 = icmp ult i64 %2068, %2069, !dbg !412
  br i1 %2071, label %2072, label %2270, !dbg !414

2072:                                             ; preds = %2061
  %2073 = add i64 %2069, %2068, !dbg !428
  %2074 = lshr i64 %2073, 1, !dbg !415
  %2075 = trunc i64 %2074 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2075, metadata !404, metadata !DIExpression()), !dbg !417
  %2076 = icmp ugt i32 %2075, 249999
  br i1 %2076, label %2270, label %2077, !dbg !418

2077:                                             ; preds = %2072
  %2078 = and i64 %2074, 4294967295, !dbg !420
  %2079 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2078, i32 0, !dbg !422
  %2080 = load i64, i64* %2079, align 8, !dbg !422, !tbaa !423
  %2081 = icmp ugt i64 %2080, %1956, !dbg !426
  %2082 = add nuw i64 %2074, 1, !dbg !427
  %2083 = and i64 %2082, 4294967295, !dbg !427
  %2084 = select i1 %2081, i64 %2068, i64 %2083, !dbg !427
  %2085 = select i1 %2081, i64 %2078, i64 %2069, !dbg !427
  %2086 = select i1 %2081, i64 %2070, i64 %2078, !dbg !427
  call void @llvm.dbg.value(metadata i32 8, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2086, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2085, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2084, metadata !399, metadata !DIExpression()), !dbg !407
  %2087 = icmp ult i64 %2084, %2085, !dbg !412
  br i1 %2087, label %2088, label %2270, !dbg !414

2088:                                             ; preds = %2077
  %2089 = add i64 %2085, %2084, !dbg !428
  %2090 = lshr i64 %2089, 1, !dbg !415
  %2091 = trunc i64 %2090 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2091, metadata !404, metadata !DIExpression()), !dbg !417
  %2092 = icmp ugt i32 %2091, 249999
  br i1 %2092, label %2270, label %2093, !dbg !418

2093:                                             ; preds = %2088
  %2094 = and i64 %2090, 4294967295, !dbg !420
  %2095 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2094, i32 0, !dbg !422
  %2096 = load i64, i64* %2095, align 8, !dbg !422, !tbaa !423
  %2097 = icmp ugt i64 %2096, %1956, !dbg !426
  %2098 = add nuw i64 %2090, 1, !dbg !427
  %2099 = and i64 %2098, 4294967295, !dbg !427
  %2100 = select i1 %2097, i64 %2084, i64 %2099, !dbg !427
  %2101 = select i1 %2097, i64 %2094, i64 %2085, !dbg !427
  %2102 = select i1 %2097, i64 %2086, i64 %2094, !dbg !427
  call void @llvm.dbg.value(metadata i32 9, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2102, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2101, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2100, metadata !399, metadata !DIExpression()), !dbg !407
  %2103 = icmp ult i64 %2100, %2101, !dbg !412
  br i1 %2103, label %2104, label %2270, !dbg !414

2104:                                             ; preds = %2093
  %2105 = add i64 %2101, %2100, !dbg !428
  %2106 = lshr i64 %2105, 1, !dbg !415
  %2107 = trunc i64 %2106 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2107, metadata !404, metadata !DIExpression()), !dbg !417
  %2108 = icmp ugt i32 %2107, 249999
  br i1 %2108, label %2270, label %2109, !dbg !418

2109:                                             ; preds = %2104
  %2110 = and i64 %2106, 4294967295, !dbg !420
  %2111 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2110, i32 0, !dbg !422
  %2112 = load i64, i64* %2111, align 8, !dbg !422, !tbaa !423
  %2113 = icmp ugt i64 %2112, %1956, !dbg !426
  %2114 = add nuw i64 %2106, 1, !dbg !427
  %2115 = and i64 %2114, 4294967295, !dbg !427
  %2116 = select i1 %2113, i64 %2100, i64 %2115, !dbg !427
  %2117 = select i1 %2113, i64 %2110, i64 %2101, !dbg !427
  %2118 = select i1 %2113, i64 %2102, i64 %2110, !dbg !427
  call void @llvm.dbg.value(metadata i32 10, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2118, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2117, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2116, metadata !399, metadata !DIExpression()), !dbg !407
  %2119 = icmp ult i64 %2116, %2117, !dbg !412
  br i1 %2119, label %2120, label %2270, !dbg !414

2120:                                             ; preds = %2109
  %2121 = add i64 %2117, %2116, !dbg !428
  %2122 = lshr i64 %2121, 1, !dbg !415
  %2123 = trunc i64 %2122 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2123, metadata !404, metadata !DIExpression()), !dbg !417
  %2124 = icmp ugt i32 %2123, 249999
  br i1 %2124, label %2270, label %2125, !dbg !418

2125:                                             ; preds = %2120
  %2126 = and i64 %2122, 4294967295, !dbg !420
  %2127 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2126, i32 0, !dbg !422
  %2128 = load i64, i64* %2127, align 8, !dbg !422, !tbaa !423
  %2129 = icmp ugt i64 %2128, %1956, !dbg !426
  %2130 = add nuw i64 %2122, 1, !dbg !427
  %2131 = and i64 %2130, 4294967295, !dbg !427
  %2132 = select i1 %2129, i64 %2116, i64 %2131, !dbg !427
  %2133 = select i1 %2129, i64 %2126, i64 %2117, !dbg !427
  %2134 = select i1 %2129, i64 %2118, i64 %2126, !dbg !427
  call void @llvm.dbg.value(metadata i32 11, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2134, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2133, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2132, metadata !399, metadata !DIExpression()), !dbg !407
  %2135 = icmp ult i64 %2132, %2133, !dbg !412
  br i1 %2135, label %2136, label %2270, !dbg !414

2136:                                             ; preds = %2125
  %2137 = add i64 %2133, %2132, !dbg !428
  %2138 = lshr i64 %2137, 1, !dbg !415
  %2139 = trunc i64 %2138 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2139, metadata !404, metadata !DIExpression()), !dbg !417
  %2140 = icmp ugt i32 %2139, 249999
  br i1 %2140, label %2270, label %2141, !dbg !418

2141:                                             ; preds = %2136
  %2142 = and i64 %2138, 4294967295, !dbg !420
  %2143 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2142, i32 0, !dbg !422
  %2144 = load i64, i64* %2143, align 8, !dbg !422, !tbaa !423
  %2145 = icmp ugt i64 %2144, %1956, !dbg !426
  %2146 = add nuw i64 %2138, 1, !dbg !427
  %2147 = and i64 %2146, 4294967295, !dbg !427
  %2148 = select i1 %2145, i64 %2132, i64 %2147, !dbg !427
  %2149 = select i1 %2145, i64 %2142, i64 %2133, !dbg !427
  %2150 = select i1 %2145, i64 %2134, i64 %2142, !dbg !427
  call void @llvm.dbg.value(metadata i32 12, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2150, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2149, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2148, metadata !399, metadata !DIExpression()), !dbg !407
  %2151 = icmp ult i64 %2148, %2149, !dbg !412
  br i1 %2151, label %2152, label %2270, !dbg !414

2152:                                             ; preds = %2141
  %2153 = add i64 %2149, %2148, !dbg !428
  %2154 = lshr i64 %2153, 1, !dbg !415
  %2155 = trunc i64 %2154 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2155, metadata !404, metadata !DIExpression()), !dbg !417
  %2156 = icmp ugt i32 %2155, 249999
  br i1 %2156, label %2270, label %2157, !dbg !418

2157:                                             ; preds = %2152
  %2158 = and i64 %2154, 4294967295, !dbg !420
  %2159 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2158, i32 0, !dbg !422
  %2160 = load i64, i64* %2159, align 8, !dbg !422, !tbaa !423
  %2161 = icmp ugt i64 %2160, %1956, !dbg !426
  %2162 = add nuw i64 %2154, 1, !dbg !427
  %2163 = and i64 %2162, 4294967295, !dbg !427
  %2164 = select i1 %2161, i64 %2148, i64 %2163, !dbg !427
  %2165 = select i1 %2161, i64 %2158, i64 %2149, !dbg !427
  %2166 = select i1 %2161, i64 %2150, i64 %2158, !dbg !427
  call void @llvm.dbg.value(metadata i32 13, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2166, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2165, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2164, metadata !399, metadata !DIExpression()), !dbg !407
  %2167 = icmp ult i64 %2164, %2165, !dbg !412
  br i1 %2167, label %2168, label %2270, !dbg !414

2168:                                             ; preds = %2157
  %2169 = add i64 %2165, %2164, !dbg !428
  %2170 = lshr i64 %2169, 1, !dbg !415
  %2171 = trunc i64 %2170 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2171, metadata !404, metadata !DIExpression()), !dbg !417
  %2172 = icmp ugt i32 %2171, 249999
  br i1 %2172, label %2270, label %2173, !dbg !418

2173:                                             ; preds = %2168
  %2174 = and i64 %2170, 4294967295, !dbg !420
  %2175 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2174, i32 0, !dbg !422
  %2176 = load i64, i64* %2175, align 8, !dbg !422, !tbaa !423
  %2177 = icmp ugt i64 %2176, %1956, !dbg !426
  %2178 = add nuw i64 %2170, 1, !dbg !427
  %2179 = and i64 %2178, 4294967295, !dbg !427
  %2180 = select i1 %2177, i64 %2164, i64 %2179, !dbg !427
  %2181 = select i1 %2177, i64 %2174, i64 %2165, !dbg !427
  %2182 = select i1 %2177, i64 %2166, i64 %2174, !dbg !427
  call void @llvm.dbg.value(metadata i32 14, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2182, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2181, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2180, metadata !399, metadata !DIExpression()), !dbg !407
  %2183 = icmp ult i64 %2180, %2181, !dbg !412
  br i1 %2183, label %2184, label %2270, !dbg !414

2184:                                             ; preds = %2173
  %2185 = add i64 %2181, %2180, !dbg !428
  %2186 = lshr i64 %2185, 1, !dbg !415
  %2187 = trunc i64 %2186 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2187, metadata !404, metadata !DIExpression()), !dbg !417
  %2188 = icmp ugt i32 %2187, 249999
  br i1 %2188, label %2270, label %2189, !dbg !418

2189:                                             ; preds = %2184
  %2190 = and i64 %2186, 4294967295, !dbg !420
  %2191 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2190, i32 0, !dbg !422
  %2192 = load i64, i64* %2191, align 8, !dbg !422, !tbaa !423
  %2193 = icmp ugt i64 %2192, %1956, !dbg !426
  %2194 = add nuw i64 %2186, 1, !dbg !427
  %2195 = and i64 %2194, 4294967295, !dbg !427
  %2196 = select i1 %2193, i64 %2180, i64 %2195, !dbg !427
  %2197 = select i1 %2193, i64 %2190, i64 %2181, !dbg !427
  %2198 = select i1 %2193, i64 %2182, i64 %2190, !dbg !427
  call void @llvm.dbg.value(metadata i32 15, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2198, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2197, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2196, metadata !399, metadata !DIExpression()), !dbg !407
  %2199 = icmp ult i64 %2196, %2197, !dbg !412
  br i1 %2199, label %2200, label %2270, !dbg !414

2200:                                             ; preds = %2189
  %2201 = add i64 %2197, %2196, !dbg !428
  %2202 = lshr i64 %2201, 1, !dbg !415
  %2203 = trunc i64 %2202 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2203, metadata !404, metadata !DIExpression()), !dbg !417
  %2204 = icmp ugt i32 %2203, 249999
  br i1 %2204, label %2270, label %2205, !dbg !418

2205:                                             ; preds = %2200
  %2206 = and i64 %2202, 4294967295, !dbg !420
  %2207 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2206, i32 0, !dbg !422
  %2208 = load i64, i64* %2207, align 8, !dbg !422, !tbaa !423
  %2209 = icmp ugt i64 %2208, %1956, !dbg !426
  %2210 = add nuw i64 %2202, 1, !dbg !427
  %2211 = and i64 %2210, 4294967295, !dbg !427
  %2212 = select i1 %2209, i64 %2196, i64 %2211, !dbg !427
  %2213 = select i1 %2209, i64 %2206, i64 %2197, !dbg !427
  %2214 = select i1 %2209, i64 %2198, i64 %2206, !dbg !427
  call void @llvm.dbg.value(metadata i32 16, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2214, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2213, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2212, metadata !399, metadata !DIExpression()), !dbg !407
  %2215 = icmp ult i64 %2212, %2213, !dbg !412
  br i1 %2215, label %2216, label %2270, !dbg !414

2216:                                             ; preds = %2205
  %2217 = add i64 %2213, %2212, !dbg !428
  %2218 = lshr i64 %2217, 1, !dbg !415
  %2219 = trunc i64 %2218 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2219, metadata !404, metadata !DIExpression()), !dbg !417
  %2220 = icmp ugt i32 %2219, 249999
  br i1 %2220, label %2270, label %2221, !dbg !418

2221:                                             ; preds = %2216
  %2222 = and i64 %2218, 4294967295, !dbg !420
  %2223 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2222, i32 0, !dbg !422
  %2224 = load i64, i64* %2223, align 8, !dbg !422, !tbaa !423
  %2225 = icmp ugt i64 %2224, %1956, !dbg !426
  %2226 = add nuw i64 %2218, 1, !dbg !427
  %2227 = and i64 %2226, 4294967295, !dbg !427
  %2228 = select i1 %2225, i64 %2212, i64 %2227, !dbg !427
  %2229 = select i1 %2225, i64 %2222, i64 %2213, !dbg !427
  %2230 = select i1 %2225, i64 %2214, i64 %2222, !dbg !427
  call void @llvm.dbg.value(metadata i32 17, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2230, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2229, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2228, metadata !399, metadata !DIExpression()), !dbg !407
  %2231 = icmp ult i64 %2228, %2229, !dbg !412
  br i1 %2231, label %2232, label %2270, !dbg !414

2232:                                             ; preds = %2221
  %2233 = add i64 %2229, %2228, !dbg !428
  %2234 = lshr i64 %2233, 1, !dbg !415
  %2235 = trunc i64 %2234 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2235, metadata !404, metadata !DIExpression()), !dbg !417
  %2236 = icmp ugt i32 %2235, 249999
  br i1 %2236, label %2270, label %2237, !dbg !418

2237:                                             ; preds = %2232
  %2238 = and i64 %2234, 4294967295, !dbg !420
  %2239 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2238, i32 0, !dbg !422
  %2240 = load i64, i64* %2239, align 8, !dbg !422, !tbaa !423
  %2241 = icmp ugt i64 %2240, %1956, !dbg !426
  %2242 = add nuw i64 %2234, 1, !dbg !427
  %2243 = and i64 %2242, 4294967295, !dbg !427
  %2244 = select i1 %2241, i64 %2228, i64 %2243, !dbg !427
  %2245 = select i1 %2241, i64 %2238, i64 %2229, !dbg !427
  %2246 = select i1 %2241, i64 %2230, i64 %2238, !dbg !427
  call void @llvm.dbg.value(metadata i32 18, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2246, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2245, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2244, metadata !399, metadata !DIExpression()), !dbg !407
  %2247 = icmp ult i64 %2244, %2245, !dbg !412
  br i1 %2247, label %2248, label %2270, !dbg !414

2248:                                             ; preds = %2237
  %2249 = add i64 %2245, %2244, !dbg !428
  %2250 = lshr i64 %2249, 1, !dbg !415
  %2251 = trunc i64 %2250 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2251, metadata !404, metadata !DIExpression()), !dbg !417
  %2252 = icmp ugt i32 %2251, 249999
  br i1 %2252, label %2270, label %2253, !dbg !418

2253:                                             ; preds = %2248
  %2254 = and i64 %2250, 4294967295, !dbg !420
  %2255 = getelementptr inbounds %struct.stack_unwind_table_t, %struct.stack_unwind_table_t* %1955, i64 0, i32 4, i64 %2254, i32 0, !dbg !422
  %2256 = load i64, i64* %2255, align 8, !dbg !422, !tbaa !423
  %2257 = icmp ugt i64 %2256, %1956, !dbg !426
  %2258 = add nuw i64 %2250, 1, !dbg !427
  %2259 = and i64 %2258, 4294967295, !dbg !427
  %2260 = select i1 %2257, i64 %2244, i64 %2259, !dbg !427
  %2261 = select i1 %2257, i64 %2254, i64 %2245, !dbg !427
  %2262 = select i1 %2257, i64 %2246, i64 %2254, !dbg !427
  call void @llvm.dbg.value(metadata i32 19, metadata !402, metadata !DIExpression()), !dbg !411
  call void @llvm.dbg.value(metadata i64 %2262, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2261, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 %2260, metadata !399, metadata !DIExpression()), !dbg !407
  %2263 = icmp ult i64 %2260, %2261, !dbg !412
  br i1 %2263, label %2264, label %2270, !dbg !414

2264:                                             ; preds = %2253
  %2265 = add i64 %2261, %2260, !dbg !428
  %2266 = lshr i64 %2265, 1, !dbg !415
  %2267 = trunc i64 %2266 to i32, !dbg !416
  call void @llvm.dbg.value(metadata i32 %2267, metadata !404, metadata !DIExpression()), !dbg !417
  %2268 = icmp ugt i32 %2267, 249999
  br i1 %2268, label %2270, label %2269, !dbg !418

2269:                                             ; preds = %2264
  call void @llvm.dbg.value(metadata i64 undef, metadata !401, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !400, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i64 undef, metadata !399, metadata !DIExpression()), !dbg !407
  call void @llvm.dbg.value(metadata i32 20, metadata !402, metadata !DIExpression()), !dbg !411
  br label %2270

2270:                                             ; preds = %2269, %2264, %2253, %2248, %2237, %2232, %2221, %2216, %2205, %2200, %2189, %2184, %2173, %2168, %2157, %2152, %2141, %2136, %2125, %2120, %2109, %2104, %2093, %2088, %2077, %2072, %2061, %2056, %2045, %2040, %2029, %2024, %2013, %2008, %1997, %1992, %1981, %1976, %1965, %1961, %1953
  %2271 = phi i64 [ 16431834, %1953 ], [ 3735928559, %1961 ], [ %1974, %1965 ], [ 3735928559, %1976 ], [ %1990, %1981 ], [ 3735928559, %1992 ], [ %2006, %1997 ], [ 3735928559, %2008 ], [ %2022, %2013 ], [ 3735928559, %2024 ], [ %2038, %2029 ], [ 3735928559, %2040 ], [ %2054, %2045 ], [ 3735928559, %2056 ], [ %2070, %2061 ], [ 3735928559, %2072 ], [ %2086, %2077 ], [ 3735928559, %2088 ], [ %2102, %2093 ], [ 3735928559, %2104 ], [ %2118, %2109 ], [ 3735928559, %2120 ], [ %2134, %2125 ], [ 3735928559, %2136 ], [ %2150, %2141 ], [ 3735928559, %2152 ], [ %2166, %2157 ], [ 3735928559, %2168 ], [ %2182, %2173 ], [ 3735928559, %2184 ], [ %2198, %2189 ], [ 3735928559, %2200 ], [ %2214, %2205 ], [ 3735928559, %2216 ], [ %2230, %2221 ], [ 3735928559, %2232 ], [ %2246, %2237 ], [ 3735928559, %2248 ], [ %2262, %2253 ], [ 3735928559, %2264 ], [ 12246957, %2269 ]
  call void @llvm.dbg.value(metadata i64 %2271, metadata !302, metadata !DIExpression()), !dbg !384
  %2272 = icmp eq i64 %2271, 16431834, !dbg !429
  %2273 = call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %2272)
  %2274 = freeze i1 %2273, !dbg !431
  br i1 %2274, label %2850, label %2275, !dbg !431

2275:                                             ; preds = %2270
  switch i64 %2271, label %2276 [
    i64 3735928559, label %2850
    i64 12246957, label %2850
  ], !dbg !431

2276:                                             ; preds = %2275
  %2277 = load i64, i64* %19, align 8, !dbg !432, !tbaa !433
  call void @llvm.dbg.value(metadata i64 %2277, metadata !303, metadata !DIExpression()), !dbg !384
  %2278 = icmp ult i64 %2277, 115
  br i1 %2278, label %2279, label %2281, !dbg !434

2279:                                             ; preds = %2276
  %2280 = getelementptr inbounds [115 x i64], [115 x i64]* %21, i64 0, i64 %2277, !dbg !436
  store i64 %1956, i64* %2280, align 8, !dbg !438, !tbaa !329
  br label %2281, !dbg !439

2281:                                             ; preds = %2279, %2276
  call void @llvm.dbg.value(metadata i64 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !384
  call void @llvm.dbg.value(metadata i16 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  %2282 = getelementptr inbounds i8, i8* %1954, i64 4000027, !dbg !440
  %2283 = load i8, i8* %2282, align 1, !dbg !440, !tbaa.struct !441
  call void @llvm.dbg.value(metadata i8 %2283, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 88, 8)), !dbg !384
  %2284 = getelementptr inbounds i8, i8* %1954, i64 4000028, !dbg !440
  %2285 = bitcast i8* %2284 to i16*, !dbg !440
  %2286 = load i16, i16* %2285, align 4, !dbg !440, !tbaa.struct !444
  call void @llvm.dbg.value(metadata i16 %2286, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !384
  %2287 = getelementptr inbounds i8, i8* %1954, i64 4000030, !dbg !440
  %2288 = bitcast i8* %2287 to i16*, !dbg !440
  %2289 = load i16, i16* %2288, align 2, !dbg !440, !tbaa.struct !445
  call void @llvm.dbg.value(metadata i16 %2289, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 16)), !dbg !384
  call void @llvm.dbg.value(metadata i64 undef, metadata !305, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 undef, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i8 %2283, metadata !307, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %2286, metadata !308, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i16 %2289, metadata !309, metadata !DIExpression()), !dbg !384
  %2290 = icmp eq i8 %2283, 2, !dbg !446
  %2291 = icmp eq i8 %2283, 3
  %2292 = call i1 @llvm.bpf.passthrough.i1.i1(i32 1, i1 %2290)
  %2293 = select i1 %2292, i1 true, i1 %2291, !dbg !448
  br i1 %2293, label %2850, label %2294, !dbg !448

2294:                                             ; preds = %2281
  %2295 = getelementptr inbounds i8, i8* %1954, i64 4000026, !dbg !440
  %2296 = load i8, i8* %2295, align 2, !dbg !440, !tbaa.struct !449
  call void @llvm.dbg.value(metadata i8 %2296, metadata !304, metadata !DIExpression(DW_OP_LLVM_fragment, 80, 8)), !dbg !384
  call void @llvm.dbg.value(metadata i8 %2296, metadata !306, metadata !DIExpression()), !dbg !384
  call void @llvm.dbg.value(metadata i64 0, metadata !310, metadata !DIExpression()), !dbg !384
  switch i8 %2296, label %2850 [
    i8 1, label %2312
    i8 2, label %2308
    i8 3, label %2297
  ], !dbg !450

2297:                                             ; preds = %2294
  switch i16 %2286, label %2850 [
    i16 2, label %2298
    i16 1, label %2299
  ], !dbg !462

2298:                                             ; preds = %2297
  call void @llvm.dbg.value(metadata i64 10, metadata !311, metadata !DIExpression()), !dbg !463
  br label %2299, !dbg !464

2299:                                             ; preds = %2298, %2297
  %2300 = phi i64 [ 11, %2297 ], [ 10, %2298 ]
  call void @llvm.dbg.value(metadata i64 0, metadata !311, metadata !DIExpression()), !dbg !463
  %2301 = load i64, i64* %23, align 8, !dbg !468, !tbaa !458
  %2302 = add i64 %2301, 8, !dbg !469
  %2303 = load i64, i64* %14, align 8, !dbg !470, !tbaa !339
  %2304 = and i64 %2303, 15, !dbg !471
  %2305 = icmp ult i64 %2304, %2300, !dbg !472
  %2306 = select i1 %2305, i64 0, i64 8, !dbg !473
  %2307 = add i64 %2302, %2306, !dbg !474
  call void @llvm.dbg.value(metadata i64 %2307, metadata !310, metadata !DIExpression()), !dbg !384
  br label %2316

2308:                                             ; preds = %2294
  %2309 = load i64, i64* %23, align 8, !dbg !456, !tbaa !458
  %2310 = sext i16 %2286 to i64, !dbg !459
  %2311 = add i64 %2309, %2310, !dbg !460
  call void @llvm.dbg.value(metadata i64 %2311, metadata !310, metadata !DIExpression()), !dbg !384
  br label %2316, !dbg !461

2312:                                             ; preds = %2294
  %2313 = load i64, i64* %25, align 8, !dbg !451, !tbaa !389
  %2314 = sext i16 %2286 to i64, !dbg !453
  %2315 = add i64 %2313, %2314, !dbg !454
  call void @llvm.dbg.value(metadata i64 %2315, metadata !310, metadata !DIExpression()), !dbg !384
  br label %2316, !dbg !455

2316:                                             ; preds = %2312, %2308, %2299
  %2317 = phi i64 [ %2315, %2312 ], [ %2311, %2308 ], [ %2307, %2299 ], !dbg !384
  call void @llvm.dbg.value(metadata i64 %2317, metadata !310, metadata !DIExpression()), !dbg !384
  %2318 = icmp eq i64 %2317, 0, !dbg !475
  br i1 %2318, label %2850, label %2319, !dbg !477

2319:                                             ; preds = %2316
  %2320 = add i64 %2317, -8, !dbg !478
  call void @llvm.dbg.value(metadata i64 %2320, metadata !316, metadata !DIExpression()), !dbg !384
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %26) #6, !dbg !479
  call void @llvm.dbg.value(metadata i64 0, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %6, align 8, !dbg !480, !tbaa !329
  %2321 = inttoptr i64 %2320 to i8*, !dbg !481
  call void @llvm.dbg.value(metadata i64* %6, metadata !317, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %2322 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %26, i32 noundef 8, i8* noundef %2321) #6, !dbg !482
  call void @llvm.dbg.value(metadata i64 %2322, metadata !318, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !384
  %2323 = load i64, i64* %6, align 8, !dbg !483, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %2323, metadata !317, metadata !DIExpression()), !dbg !384
  %2324 = icmp eq i64 %2323, 0, !dbg !485
  br i1 %2324, label %475, label %2325, !dbg !486

2325:                                             ; preds = %2319
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %27) #6, !dbg !488
  call void @llvm.dbg.value(metadata i64 0, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 0, i64* %7, align 8, !dbg !489, !tbaa !329
  %2326 = icmp eq i8 %2283, 0, !dbg !490
  br i1 %2326, label %2336, label %2327, !dbg !491

2327:                                             ; preds = %2325
  %2328 = sext i16 %2289 to i64, !dbg !496
  %2329 = add i64 %2317, %2328, !dbg !497
  call void @llvm.dbg.value(metadata i64 %2329, metadata !320, metadata !DIExpression()), !dbg !498
  %2330 = inttoptr i64 %2329 to i8*, !dbg !499
  call void @llvm.dbg.value(metadata i64* %7, metadata !319, metadata !DIExpression(DW_OP_deref)), !dbg !384
  %2331 = call i64 inttoptr (i64 112 to i64 (i8*, i32, i8*)*)(i8* noundef nonnull %27, i32 noundef 8, i8* noundef %2330) #6, !dbg !500
  %2332 = trunc i64 %2331 to i32, !dbg !500
  call void @llvm.dbg.value(metadata i32 %2332, metadata !323, metadata !DIExpression()), !dbg !498
  %2333 = icmp eq i32 %2332, 0, !dbg !501
  br i1 %2333, label %2334, label %489

2334:                                             ; preds = %2327
  %2335 = load i64, i64* %6, align 8, !dbg !503, !tbaa !329
  br label %2338

2336:                                             ; preds = %2325
  %2337 = load i64, i64* %25, align 8, !dbg !492, !tbaa !389
  call void @llvm.dbg.value(metadata i64 %2337, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %2337, i64* %7, align 8, !dbg !494, !tbaa !329
  br label %2338, !dbg !495

2338:                                             ; preds = %2334, %2336
  %2339 = phi i64 [ %2335, %2334 ], [ %2323, %2336 ], !dbg !503
  call void @llvm.dbg.value(metadata i64 %2339, metadata !317, metadata !DIExpression()), !dbg !384
  store i64 %2339, i64* %14, align 8, !dbg !504, !tbaa !339
  store i64 %2317, i64* %23, align 8, !dbg !505, !tbaa !458
  %2340 = load i64, i64* %7, align 8, !dbg !506, !tbaa !329
  call void @llvm.dbg.value(metadata i64 %2340, metadata !319, metadata !DIExpression()), !dbg !384
  store i64 %2340, i64* %25, align 8, !dbg !507, !tbaa !389
  %2341 = load i64, i64* %19, align 8, !dbg !508, !tbaa !433
  %2342 = add i64 %2341, 1, !dbg !508
  store i64 %2342, i64* %19, align 8, !dbg !508, !tbaa !433
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %27) #6, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %26) #6, !dbg !487
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  call void @llvm.dbg.value(metadata i32 5, metadata !297, metadata !DIExpression()), !dbg !337
  call void @llvm.dbg.value(metadata i8 poison, metadata !292, metadata !DIExpression()), !dbg !324
  %2343 = icmp ult i64 %2342, 115, !dbg !509
  br i1 %2343, label %2841, label %2850, !dbg !511

2344:                                             ; preds = %100
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !512, metadata !DIExpression()) #6, !dbg !532
  call void @llvm.dbg.value(metadata i64 %8, metadata !517, metadata !DIExpression()) #6, !dbg !532
  call void @llvm.dbg.value(metadata i32 1, metadata !518, metadata !DIExpression()) #6, !dbg !532
  call void @llvm.dbg.value(metadata i8* %11, metadata !519, metadata !DIExpression()) #6, !dbg !532
  %2345 = bitcast i64* %2 to i8*, !dbg !535
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2345) #6, !dbg !535
  call void @llvm.dbg.value(metadata i64 0, metadata !520, metadata !DIExpression()) #6, !dbg !532
  store i64 0, i64* %2, align 8, !dbg !536, !tbaa !329
  %2346 = bitcast %struct.stack_count_key* %3 to i8*, !dbg !537
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %2346) #6, !dbg !537
  call void @llvm.dbg.declare(metadata %struct.stack_count_key* %3, metadata !521, metadata !DIExpression()) #6, !dbg !538
  %2347 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %3, i64 0, i32 2, !dbg !538
  %2348 = getelementptr inbounds i32, i32* %2347, i64 1, !dbg !538
  store i32 0, i32* %2348, align 4, !dbg !538
  %2349 = lshr i64 %8, 32, !dbg !539
  %2350 = trunc i64 %2349 to i32, !dbg !540
  call void @llvm.dbg.value(metadata i32 %2350, metadata !522, metadata !DIExpression()) #6, !dbg !532
  call void @llvm.dbg.value(metadata i32 %9, metadata !523, metadata !DIExpression()) #6, !dbg !532
  %2351 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %3, i64 0, i32 0, !dbg !541
  store i32 %2350, i32* %2351, align 4, !dbg !542, !tbaa !543
  %2352 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %3, i64 0, i32 1, !dbg !545
  store i32 %9, i32* %2352, align 4, !dbg !546, !tbaa !547
  %2353 = bitcast %struct.bpf_perf_event_data* %0 to i8*, !dbg !548
  %2354 = call i64 inttoptr (i64 27 to i64 (i8*, i8*, i64)*)(i8* noundef %2353, i8* noundef bitcast (%struct.anon.3* @stack_traces to i8*), i64 noundef 0) #6, !dbg !549
  %2355 = trunc i64 %2354 to i32, !dbg !549
  call void @llvm.dbg.value(metadata i32 %2355, metadata !524, metadata !DIExpression()) #6, !dbg !532
  %2356 = icmp sgt i32 %2355, -1, !dbg !550
  br i1 %2356, label %2357, label %2359, !dbg !552

2357:                                             ; preds = %2344
  %2358 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %3, i64 0, i32 3, !dbg !553
  store i32 %2355, i32* %2358, align 4, !dbg !555, !tbaa !556
  br label %2359, !dbg !557

2359:                                             ; preds = %2357, %2344
  %2360 = load i64, i64* %19, align 8, !dbg !558, !tbaa !433
  %2361 = trunc i64 %2360 to i32, !dbg !559
  call void @llvm.dbg.value(metadata i8* %20, metadata !560, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 %2361, metadata !565, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 1540483477, metadata !566, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 24, metadata !568, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 %2361, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2362 = bitcast i8* %20 to i32*, !dbg !579
  call void @llvm.dbg.value(metadata i32* %2362, metadata !571, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 0, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2363 = load i32, i32* %2362, align 4, !tbaa !581
  %2364 = mul i32 %2363, 1540483477
  %2365 = lshr i32 %2364, 24
  %2366 = xor i32 %2365, %2364
  %2367 = mul i32 %2366, 1540483477
  call void @llvm.dbg.value(metadata i32 %2367, metadata !574, metadata !DIExpression()) #6, !dbg !582
  %2368 = mul i32 %2361, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2368, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2369 = xor i32 %2367, %2368, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2369, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 1, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2370 = mul i32 %2369, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2370, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2371 = xor i32 %2370, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2371, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 2, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2372 = mul i32 %2371, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2372, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2373 = xor i32 %2372, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2373, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 3, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2374 = mul i32 %2373, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2374, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2375 = xor i32 %2374, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2375, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 4, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2376 = mul i32 %2375, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2376, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2377 = xor i32 %2376, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2377, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 5, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2378 = mul i32 %2377, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2378, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2379 = xor i32 %2378, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2379, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 6, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2380 = mul i32 %2379, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2380, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2381 = xor i32 %2380, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2381, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 7, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2382 = mul i32 %2381, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2382, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2383 = xor i32 %2382, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2383, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 8, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2384 = mul i32 %2383, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2384, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2385 = xor i32 %2384, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2385, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 9, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2386 = mul i32 %2385, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2386, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2387 = xor i32 %2386, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2387, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 10, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2388 = mul i32 %2387, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2388, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2389 = xor i32 %2388, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2389, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 11, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2390 = mul i32 %2389, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2390, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2391 = xor i32 %2390, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2391, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 12, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2392 = mul i32 %2391, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2392, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2393 = xor i32 %2392, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2393, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 13, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2394 = mul i32 %2393, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2394, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2395 = xor i32 %2394, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2395, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 14, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2396 = mul i32 %2395, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2396, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2397 = xor i32 %2396, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2397, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 15, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2398 = mul i32 %2397, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2398, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2399 = xor i32 %2398, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2399, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 16, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2400 = mul i32 %2399, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2400, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2401 = xor i32 %2400, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2401, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 17, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2402 = mul i32 %2401, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2402, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2403 = xor i32 %2402, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2403, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 18, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2404 = mul i32 %2403, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2404, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2405 = xor i32 %2404, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2405, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 19, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2406 = mul i32 %2405, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2406, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2407 = xor i32 %2406, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2407, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 20, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2408 = mul i32 %2407, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2408, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2409 = xor i32 %2408, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2409, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 21, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2410 = mul i32 %2409, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2410, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2411 = xor i32 %2410, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2411, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 22, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2412 = mul i32 %2411, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2412, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2413 = xor i32 %2412, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2413, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 23, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2414 = mul i32 %2413, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2414, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2415 = xor i32 %2414, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2415, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 24, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2416 = mul i32 %2415, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2416, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2417 = xor i32 %2416, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2417, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 25, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2418 = mul i32 %2417, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2418, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2419 = xor i32 %2418, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2419, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 26, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2420 = mul i32 %2419, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2420, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2421 = xor i32 %2420, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2421, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 27, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2422 = mul i32 %2421, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2422, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2423 = xor i32 %2422, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2423, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 28, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2424 = mul i32 %2423, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2424, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2425 = xor i32 %2424, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2425, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 29, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2426 = mul i32 %2425, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2426, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2427 = xor i32 %2426, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2427, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 30, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2428 = mul i32 %2427, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2428, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2429 = xor i32 %2428, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2429, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 31, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2430 = mul i32 %2429, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2430, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2431 = xor i32 %2430, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2431, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 32, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2432 = mul i32 %2431, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2432, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2433 = xor i32 %2432, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2433, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 33, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2434 = mul i32 %2433, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2434, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2435 = xor i32 %2434, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2435, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 34, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2436 = mul i32 %2435, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2436, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2437 = xor i32 %2436, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2437, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 35, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2438 = mul i32 %2437, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2438, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2439 = xor i32 %2438, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2439, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 36, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2440 = mul i32 %2439, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2440, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2441 = xor i32 %2440, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2441, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 37, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2442 = mul i32 %2441, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2442, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2443 = xor i32 %2442, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2443, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 38, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2444 = mul i32 %2443, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2444, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2445 = xor i32 %2444, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2445, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 39, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2446 = mul i32 %2445, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2446, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2447 = xor i32 %2446, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2447, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 40, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2448 = mul i32 %2447, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2448, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2449 = xor i32 %2448, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2449, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 41, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2450 = mul i32 %2449, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2450, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2451 = xor i32 %2450, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2451, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 42, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2452 = mul i32 %2451, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2452, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2453 = xor i32 %2452, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2453, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 43, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2454 = mul i32 %2453, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2454, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2455 = xor i32 %2454, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2455, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 44, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2456 = mul i32 %2455, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2456, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2457 = xor i32 %2456, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2457, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 45, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2458 = mul i32 %2457, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2458, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2459 = xor i32 %2458, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2459, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 46, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2460 = mul i32 %2459, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2460, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2461 = xor i32 %2460, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2461, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 47, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2462 = mul i32 %2461, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2462, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2463 = xor i32 %2462, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2463, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 48, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2464 = mul i32 %2463, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2464, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2465 = xor i32 %2464, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2465, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 49, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2466 = mul i32 %2465, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2466, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2467 = xor i32 %2466, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2467, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 50, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2468 = mul i32 %2467, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2468, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2469 = xor i32 %2468, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2469, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 51, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2470 = mul i32 %2469, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2470, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2471 = xor i32 %2470, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2471, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 52, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2472 = mul i32 %2471, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2472, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2473 = xor i32 %2472, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2473, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 53, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2474 = mul i32 %2473, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2474, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2475 = xor i32 %2474, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2475, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 54, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2476 = mul i32 %2475, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2476, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2477 = xor i32 %2476, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2477, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 55, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2478 = mul i32 %2477, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2478, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2479 = xor i32 %2478, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2479, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 56, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2480 = mul i32 %2479, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2480, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2481 = xor i32 %2480, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2481, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 57, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2482 = mul i32 %2481, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2482, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2483 = xor i32 %2482, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2483, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 58, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2484 = mul i32 %2483, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2484, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2485 = xor i32 %2484, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2485, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 59, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2486 = mul i32 %2485, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2486, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2487 = xor i32 %2486, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2487, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 60, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2488 = mul i32 %2487, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2488, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2489 = xor i32 %2488, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2489, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 61, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2490 = mul i32 %2489, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2490, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2491 = xor i32 %2490, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2491, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 62, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2492 = mul i32 %2491, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2492, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2493 = xor i32 %2492, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2493, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 63, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2494 = mul i32 %2493, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2494, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2495 = xor i32 %2494, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2495, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 64, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2496 = mul i32 %2495, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2496, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2497 = xor i32 %2496, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2497, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 65, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2498 = mul i32 %2497, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2498, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2499 = xor i32 %2498, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2499, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 66, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2500 = mul i32 %2499, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2500, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2501 = xor i32 %2500, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2501, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 67, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2502 = mul i32 %2501, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2502, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2503 = xor i32 %2502, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2503, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 68, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2504 = mul i32 %2503, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2504, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2505 = xor i32 %2504, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2505, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 69, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2506 = mul i32 %2505, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2506, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2507 = xor i32 %2506, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2507, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 70, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2508 = mul i32 %2507, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2508, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2509 = xor i32 %2508, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2509, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 71, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2510 = mul i32 %2509, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2510, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2511 = xor i32 %2510, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2511, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 72, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2512 = mul i32 %2511, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2512, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2513 = xor i32 %2512, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2513, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 73, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2514 = mul i32 %2513, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2514, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2515 = xor i32 %2514, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2515, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 74, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2516 = mul i32 %2515, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2516, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2517 = xor i32 %2516, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2517, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 75, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2518 = mul i32 %2517, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2518, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2519 = xor i32 %2518, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2519, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 76, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2520 = mul i32 %2519, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2520, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2521 = xor i32 %2520, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2521, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 77, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2522 = mul i32 %2521, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2522, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2523 = xor i32 %2522, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2523, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 78, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2524 = mul i32 %2523, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2524, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2525 = xor i32 %2524, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2525, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 79, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2526 = mul i32 %2525, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2526, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2527 = xor i32 %2526, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2527, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 80, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2528 = mul i32 %2527, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2528, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2529 = xor i32 %2528, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2529, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 81, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2530 = mul i32 %2529, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2530, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2531 = xor i32 %2530, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2531, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 82, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2532 = mul i32 %2531, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2532, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2533 = xor i32 %2532, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2533, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 83, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2534 = mul i32 %2533, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2534, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2535 = xor i32 %2534, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2535, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 84, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2536 = mul i32 %2535, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2536, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2537 = xor i32 %2536, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2537, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 85, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2538 = mul i32 %2537, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2538, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2539 = xor i32 %2538, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2539, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 86, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2540 = mul i32 %2539, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2540, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2541 = xor i32 %2540, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2541, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 87, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2542 = mul i32 %2541, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2542, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2543 = xor i32 %2542, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2543, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 88, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2544 = mul i32 %2543, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2544, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2545 = xor i32 %2544, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2545, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 89, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2546 = mul i32 %2545, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2546, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2547 = xor i32 %2546, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2547, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 90, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2548 = mul i32 %2547, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2548, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2549 = xor i32 %2548, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2549, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 91, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2550 = mul i32 %2549, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2550, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2551 = xor i32 %2550, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2551, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 92, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2552 = mul i32 %2551, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2552, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2553 = xor i32 %2552, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2553, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 93, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2554 = mul i32 %2553, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2554, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2555 = xor i32 %2554, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2555, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 94, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2556 = mul i32 %2555, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2556, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2557 = xor i32 %2556, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2557, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 95, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2558 = mul i32 %2557, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2558, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2559 = xor i32 %2558, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2559, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 96, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2560 = mul i32 %2559, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2560, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2561 = xor i32 %2560, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2561, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 97, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2562 = mul i32 %2561, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2562, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2563 = xor i32 %2562, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2563, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 98, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2564 = mul i32 %2563, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2564, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2565 = xor i32 %2564, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2565, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 99, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2566 = mul i32 %2565, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2566, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2567 = xor i32 %2566, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2567, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 100, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2568 = mul i32 %2567, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2568, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2569 = xor i32 %2568, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2569, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 101, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2570 = mul i32 %2569, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2570, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2571 = xor i32 %2570, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2571, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 102, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2572 = mul i32 %2571, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2572, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2573 = xor i32 %2572, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2573, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 103, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2574 = mul i32 %2573, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2574, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2575 = xor i32 %2574, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2575, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 104, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2576 = mul i32 %2575, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2576, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2577 = xor i32 %2576, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2577, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 105, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2578 = mul i32 %2577, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2578, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2579 = xor i32 %2578, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2579, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 106, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2580 = mul i32 %2579, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2580, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2581 = xor i32 %2580, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2581, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 107, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2582 = mul i32 %2581, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2582, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2583 = xor i32 %2582, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2583, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 108, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2584 = mul i32 %2583, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2584, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2585 = xor i32 %2584, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2585, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 109, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2586 = mul i32 %2585, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2586, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2587 = xor i32 %2586, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2587, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 110, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2588 = mul i32 %2587, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2588, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2589 = xor i32 %2588, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2589, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 111, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2590 = mul i32 %2589, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2590, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2591 = xor i32 %2590, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2591, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 112, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2592 = mul i32 %2591, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2592, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2593 = xor i32 %2592, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2593, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 113, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2594 = mul i32 %2593, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2594, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2595 = xor i32 %2594, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2595, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 114, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2596 = mul i32 %2595, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2596, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2597 = xor i32 %2596, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2597, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 115, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2598 = mul i32 %2597, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2598, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2599 = xor i32 %2598, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2599, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 116, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2600 = mul i32 %2599, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2600, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2601 = xor i32 %2600, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2601, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 117, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2602 = mul i32 %2601, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2602, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2603 = xor i32 %2602, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2603, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 118, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2604 = mul i32 %2603, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2604, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2605 = xor i32 %2604, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2605, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 119, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2606 = mul i32 %2605, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2606, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2607 = xor i32 %2606, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2607, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 120, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2608 = mul i32 %2607, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2608, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2609 = xor i32 %2608, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2609, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 121, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2610 = mul i32 %2609, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2610, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2611 = xor i32 %2610, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2611, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 122, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2612 = mul i32 %2611, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2612, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2613 = xor i32 %2612, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2613, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 123, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2614 = mul i32 %2613, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2614, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2615 = xor i32 %2614, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2615, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 124, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2616 = mul i32 %2615, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2616, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2617 = xor i32 %2616, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2617, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 125, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2618 = mul i32 %2617, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2618, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2619 = xor i32 %2618, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2619, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 126, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2620 = mul i32 %2619, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2620, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2621 = xor i32 %2620, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2621, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 127, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2622 = mul i32 %2621, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2622, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2623 = xor i32 %2622, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2623, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 128, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2624 = mul i32 %2623, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2624, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2625 = xor i32 %2624, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2625, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 129, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2626 = mul i32 %2625, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2626, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2627 = xor i32 %2626, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2627, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 130, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2628 = mul i32 %2627, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2628, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2629 = xor i32 %2628, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2629, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 131, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2630 = mul i32 %2629, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2630, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2631 = xor i32 %2630, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2631, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 132, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2632 = mul i32 %2631, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2632, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2633 = xor i32 %2632, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2633, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 133, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2634 = mul i32 %2633, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2634, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2635 = xor i32 %2634, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2635, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 134, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2636 = mul i32 %2635, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2636, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2637 = xor i32 %2636, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2637, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 135, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2638 = mul i32 %2637, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2638, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2639 = xor i32 %2638, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2639, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 136, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2640 = mul i32 %2639, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2640, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2641 = xor i32 %2640, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2641, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 137, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2642 = mul i32 %2641, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2642, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2643 = xor i32 %2642, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2643, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 138, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2644 = mul i32 %2643, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2644, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2645 = xor i32 %2644, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2645, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 139, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2646 = mul i32 %2645, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2646, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2647 = xor i32 %2646, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2647, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 140, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2648 = mul i32 %2647, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2648, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2649 = xor i32 %2648, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2649, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 141, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2650 = mul i32 %2649, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2650, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2651 = xor i32 %2650, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2651, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 142, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2652 = mul i32 %2651, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2652, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2653 = xor i32 %2652, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2653, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 143, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2654 = mul i32 %2653, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2654, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2655 = xor i32 %2654, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2655, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 144, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2656 = mul i32 %2655, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2656, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2657 = xor i32 %2656, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2657, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 145, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2658 = mul i32 %2657, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2658, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2659 = xor i32 %2658, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2659, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 146, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2660 = mul i32 %2659, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2660, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2661 = xor i32 %2660, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2661, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 147, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2662 = mul i32 %2661, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2662, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2663 = xor i32 %2662, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2663, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 148, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2664 = mul i32 %2663, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2664, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2665 = xor i32 %2664, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2665, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 149, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2666 = mul i32 %2665, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2666, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2667 = xor i32 %2666, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2667, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 150, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2668 = mul i32 %2667, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2668, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2669 = xor i32 %2668, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2669, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 151, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2670 = mul i32 %2669, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2670, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2671 = xor i32 %2670, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2671, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 152, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2672 = mul i32 %2671, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2672, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2673 = xor i32 %2672, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2673, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 153, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2674 = mul i32 %2673, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2674, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2675 = xor i32 %2674, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2675, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 154, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2676 = mul i32 %2675, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2676, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2677 = xor i32 %2676, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2677, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 155, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2678 = mul i32 %2677, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2678, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2679 = xor i32 %2678, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2679, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 156, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2680 = mul i32 %2679, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2680, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2681 = xor i32 %2680, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2681, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 157, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2682 = mul i32 %2681, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2682, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2683 = xor i32 %2682, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2683, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 158, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2684 = mul i32 %2683, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2684, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2685 = xor i32 %2684, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2685, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 159, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2686 = mul i32 %2685, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2686, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2687 = xor i32 %2686, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2687, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 160, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2688 = mul i32 %2687, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2688, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2689 = xor i32 %2688, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2689, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 161, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2690 = mul i32 %2689, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2690, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2691 = xor i32 %2690, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2691, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 162, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2692 = mul i32 %2691, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2692, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2693 = xor i32 %2692, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2693, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 163, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2694 = mul i32 %2693, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2694, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2695 = xor i32 %2694, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2695, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 164, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2696 = mul i32 %2695, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2696, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2697 = xor i32 %2696, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2697, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 165, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2698 = mul i32 %2697, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2698, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2699 = xor i32 %2698, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2699, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 166, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2700 = mul i32 %2699, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2700, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2701 = xor i32 %2700, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2701, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 167, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2702 = mul i32 %2701, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2702, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2703 = xor i32 %2702, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2703, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 168, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2704 = mul i32 %2703, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2704, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2705 = xor i32 %2704, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2705, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 169, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2706 = mul i32 %2705, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2706, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2707 = xor i32 %2706, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2707, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 170, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2708 = mul i32 %2707, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2708, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2709 = xor i32 %2708, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2709, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 171, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2710 = mul i32 %2709, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2710, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2711 = xor i32 %2710, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2711, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 172, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2712 = mul i32 %2711, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2712, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2713 = xor i32 %2712, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2713, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 173, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2714 = mul i32 %2713, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2714, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2715 = xor i32 %2714, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2715, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 174, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2716 = mul i32 %2715, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2716, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2717 = xor i32 %2716, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2717, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 175, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2718 = mul i32 %2717, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2718, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2719 = xor i32 %2718, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2719, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 176, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2720 = mul i32 %2719, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2720, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2721 = xor i32 %2720, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2721, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 177, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2722 = mul i32 %2721, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2722, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2723 = xor i32 %2722, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2723, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 178, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2724 = mul i32 %2723, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2724, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2725 = xor i32 %2724, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2725, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 179, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2726 = mul i32 %2725, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2726, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2727 = xor i32 %2726, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2727, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 180, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2728 = mul i32 %2727, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2728, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2729 = xor i32 %2728, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2729, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 181, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2730 = mul i32 %2729, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2730, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2731 = xor i32 %2730, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2731, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 182, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2732 = mul i32 %2731, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2732, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2733 = xor i32 %2732, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2733, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 183, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2734 = mul i32 %2733, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2734, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2735 = xor i32 %2734, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2735, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 184, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2736 = mul i32 %2735, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2736, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2737 = xor i32 %2736, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2737, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 185, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2738 = mul i32 %2737, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2738, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2739 = xor i32 %2738, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2739, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 186, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2740 = mul i32 %2739, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2740, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2741 = xor i32 %2740, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2741, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 187, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2742 = mul i32 %2741, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2742, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2743 = xor i32 %2742, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2743, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 188, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2744 = mul i32 %2743, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2744, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2745 = xor i32 %2744, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2745, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 189, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2746 = mul i32 %2745, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2746, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2747 = xor i32 %2746, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2747, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 190, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2748 = mul i32 %2747, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2748, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2749 = xor i32 %2748, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2749, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 191, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2750 = mul i32 %2749, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2750, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2751 = xor i32 %2750, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2751, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 192, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2752 = mul i32 %2751, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2752, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2753 = xor i32 %2752, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2753, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 193, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2754 = mul i32 %2753, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2754, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2755 = xor i32 %2754, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2755, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 194, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2756 = mul i32 %2755, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2756, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2757 = xor i32 %2756, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2757, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 195, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2758 = mul i32 %2757, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2758, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2759 = xor i32 %2758, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2759, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 196, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2760 = mul i32 %2759, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2760, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2761 = xor i32 %2760, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2761, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 197, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2762 = mul i32 %2761, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2762, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2763 = xor i32 %2762, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2763, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 198, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2764 = mul i32 %2763, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2764, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2765 = xor i32 %2764, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2765, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 199, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2766 = mul i32 %2765, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2766, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2767 = xor i32 %2766, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2767, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 200, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2768 = mul i32 %2767, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2768, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2769 = xor i32 %2768, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2769, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 201, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2770 = mul i32 %2769, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2770, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2771 = xor i32 %2770, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2771, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 202, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2772 = mul i32 %2771, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2772, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2773 = xor i32 %2772, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2773, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 203, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2774 = mul i32 %2773, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2774, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2775 = xor i32 %2774, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2775, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 204, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2776 = mul i32 %2775, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2776, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2777 = xor i32 %2776, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2777, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 205, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2778 = mul i32 %2777, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2778, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2779 = xor i32 %2778, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2779, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 206, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2780 = mul i32 %2779, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2780, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2781 = xor i32 %2780, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2781, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 207, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2782 = mul i32 %2781, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2782, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2783 = xor i32 %2782, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2783, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 208, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2784 = mul i32 %2783, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2784, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2785 = xor i32 %2784, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2785, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 209, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2786 = mul i32 %2785, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2786, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2787 = xor i32 %2786, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2787, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 210, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2788 = mul i32 %2787, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2788, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2789 = xor i32 %2788, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2789, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 211, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2790 = mul i32 %2789, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2790, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2791 = xor i32 %2790, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2791, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 212, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2792 = mul i32 %2791, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2792, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2793 = xor i32 %2792, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2793, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 213, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2794 = mul i32 %2793, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2794, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2795 = xor i32 %2794, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2795, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 214, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2796 = mul i32 %2795, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2796, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2797 = xor i32 %2796, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2797, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 215, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2798 = mul i32 %2797, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2798, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2799 = xor i32 %2798, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2799, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 216, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2800 = mul i32 %2799, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2800, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2801 = xor i32 %2800, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2801, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 217, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2802 = mul i32 %2801, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2802, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2803 = xor i32 %2802, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2803, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 218, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2804 = mul i32 %2803, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2804, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2805 = xor i32 %2804, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2805, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 219, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2806 = mul i32 %2805, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2806, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2807 = xor i32 %2806, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2807, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 220, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2808 = mul i32 %2807, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2808, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2809 = xor i32 %2808, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2809, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 221, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2810 = mul i32 %2809, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2810, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2811 = xor i32 %2810, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2811, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 222, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2812 = mul i32 %2811, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2812, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2813 = xor i32 %2812, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2813, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 223, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2814 = mul i32 %2813, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2814, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2815 = xor i32 %2814, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2815, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 224, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2816 = mul i32 %2815, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2816, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2817 = xor i32 %2816, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2817, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 225, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2818 = mul i32 %2817, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2818, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2819 = xor i32 %2818, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2819, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 226, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2820 = mul i32 %2819, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2820, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2821 = xor i32 %2820, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2821, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 227, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2822 = mul i32 %2821, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2822, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2823 = xor i32 %2822, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2823, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 228, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2824 = mul i32 %2823, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2824, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2825 = xor i32 %2824, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2825, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 229, metadata !572, metadata !DIExpression()) #6, !dbg !580
  %2826 = mul i32 %2825, 1540483477, !dbg !583
  call void @llvm.dbg.value(metadata i32 %2826, metadata !570, metadata !DIExpression()) #6, !dbg !577
  %2827 = xor i32 %2826, %2367, !dbg !584
  call void @llvm.dbg.value(metadata i32 %2827, metadata !570, metadata !DIExpression()) #6, !dbg !577
  call void @llvm.dbg.value(metadata i32 230, metadata !572, metadata !DIExpression()) #6, !dbg !580
  call void @llvm.dbg.value(metadata i32 %2827, metadata !525, metadata !DIExpression()) #6, !dbg !585
  %2828 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %3, i64 0, i32 4, !dbg !586
  store i32 %2827, i32* %2828, align 4, !dbg !587, !tbaa !588
  store i32 0, i32* %2347, align 4, !dbg !589, !tbaa !581
  call void @llvm.dbg.value(metadata i64* %2, metadata !520, metadata !DIExpression(DW_OP_deref)) #6, !dbg !532
  call void @llvm.dbg.value(metadata i8* bitcast (%struct.anon.2* @stack_counts to i8*), metadata !590, metadata !DIExpression()) #6, !dbg !599
  call void @llvm.dbg.value(metadata i8* %2346, metadata !595, metadata !DIExpression()) #6, !dbg !599
  call void @llvm.dbg.value(metadata i8* %2345, metadata !596, metadata !DIExpression()) #6, !dbg !599
  %2829 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %2346) #6, !dbg !601
  call void @llvm.dbg.value(metadata i8* %2829, metadata !597, metadata !DIExpression()) #6, !dbg !599
  %2830 = icmp eq i8* %2829, null, !dbg !602
  br i1 %2830, label %2831, label %2836, !dbg !604

2831:                                             ; preds = %2359
  %2832 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %2346, i8* noundef nonnull %2345, i64 noundef 1) #6, !dbg !605
  call void @llvm.dbg.value(metadata i64 %2832, metadata !598, metadata !DIExpression()) #6, !dbg !599
  switch i64 %2832, label %2840 [
    i64 -17, label %2833
    i64 0, label %2833
  ], !dbg !606

2833:                                             ; preds = %2831, %2831
  %2834 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %2346) #6, !dbg !608
  call void @llvm.dbg.value(metadata i8* %2834, metadata !531, metadata !DIExpression()) #6, !dbg !532
  %2835 = icmp eq i8* %2834, null, !dbg !609
  br i1 %2835, label %2840, label %2836, !dbg !611

2836:                                             ; preds = %2833, %2359
  %2837 = phi i8* [ %2834, %2833 ], [ %2829, %2359 ]
  %2838 = bitcast i8* %2837 to i64*, !dbg !612
  call void @llvm.dbg.value(metadata i64* %2838, metadata !531, metadata !DIExpression()) #6, !dbg !532
  %2839 = atomicrmw add i64* %2838, i64 1 seq_cst, align 8, !dbg !613
  br label %2840, !dbg !615

2840:                                             ; preds = %2831, %2833, %2836
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %2346) #6, !dbg !616
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2345) #6, !dbg !616
  br label %2850, !dbg !617

2841:                                             ; preds = %2338
  %2842 = getelementptr inbounds i8, i8* %11, i64 24, !dbg !618
  %2843 = bitcast i8* %2842 to i32*, !dbg !618
  %2844 = load i32, i32* %2843, align 8, !dbg !618, !tbaa !619
  %2845 = icmp ult i32 %2844, 30, !dbg !620
  br i1 %2845, label %2846, label %2850, !dbg !621

2846:                                             ; preds = %2841
  %2847 = add nuw nsw i32 %2844, 1, !dbg !622
  store i32 %2847, i32* %2843, align 8, !dbg !622, !tbaa !619
  %2848 = bitcast %struct.bpf_perf_event_data* %0 to i8*, !dbg !624
  %2849 = call i64 inttoptr (i64 12 to i64 (i8*, i8*, i32)*)(i8* noundef %2848, i8* noundef bitcast (%struct.anon.0* @programs to i8*), i32 noundef 0) #6, !dbg !625
  br label %2850, !dbg !626

2850:                                             ; preds = %455, %425, %425, %420, %431, %444, %466, %884, %889, %889, %895, %908, %911, %930, %1346, %1351, %1351, %1357, %1370, %1373, %1392, %1808, %1813, %1813, %1819, %1832, %1835, %1854, %2270, %2275, %2275, %2281, %2294, %2297, %2316, %475, %489, %2846, %2841, %2338, %2840, %100, %1
  %2851 = phi i32 [ 1, %1 ], [ 0, %100 ], [ 0, %2840 ], [ 0, %2338 ], [ 0, %2841 ], [ 0, %2846 ], [ 1, %489 ], [ 1, %475 ], [ 1, %2316 ], [ 1, %2297 ], [ 1, %2294 ], [ 1, %2281 ], [ 1, %2275 ], [ 1, %2275 ], [ 1, %2270 ], [ 1, %1854 ], [ 1, %1835 ], [ 1, %1832 ], [ 1, %1819 ], [ 1, %1813 ], [ 1, %1813 ], [ 1, %1808 ], [ 1, %1392 ], [ 1, %1373 ], [ 1, %1370 ], [ 1, %1357 ], [ 1, %1351 ], [ 1, %1351 ], [ 1, %1346 ], [ 1, %930 ], [ 1, %911 ], [ 1, %908 ], [ 1, %895 ], [ 1, %889 ], [ 1, %889 ], [ 1, %884 ], [ 1, %466 ], [ 1, %444 ], [ 1, %431 ], [ 1, %420 ], [ 1, %425 ], [ 1, %425 ], [ 1, %455 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %10) #6, !dbg !627
  ret i32 %2851, !dbg !627
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind
define dso_local i32 @profile_cpu(%struct.bpf_perf_event_data* noundef %0) #0 section "perf_event" !dbg !628 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.unwind_tables_key, align 4
  %4 = alloca i64, align 8
  %5 = alloca %struct.stack_count_key, align 4
  %6 = alloca %struct.unwind_tables_key, align 4
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !630, metadata !DIExpression()), !dbg !639
  %7 = tail call i64 inttoptr (i64 14 to i64 ()*)() #6, !dbg !640
  call void @llvm.dbg.value(metadata i64 %7, metadata !631, metadata !DIExpression()), !dbg !639
  %8 = trunc i64 %7 to i32, !dbg !641
  call void @llvm.dbg.value(metadata i32 %8, metadata !632, metadata !DIExpression()), !dbg !639
  call void @llvm.dbg.value(metadata i64 %7, metadata !633, metadata !DIExpression(DW_OP_constu, 32, DW_OP_shr, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !639
  %9 = icmp eq i32 %8, 0, !dbg !642
  br i1 %9, label %157, label %10, !dbg !644

10:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i32 %8, metadata !645, metadata !DIExpression()) #6, !dbg !652
  %11 = bitcast %struct.unwind_tables_key* %6 to i8*, !dbg !654
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %11) #6, !dbg !654
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %6, metadata !650, metadata !DIExpression()) #6, !dbg !655
  %12 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %6, i64 0, i32 0, !dbg !656
  store i32 %8, i32* %12, align 4, !dbg !656, !tbaa !362
  %13 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %6, i64 0, i32 1, !dbg !656
  store i32 0, i32* %13, align 4, !dbg !656, !tbaa !366
  %14 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %11) #6, !dbg !657
  call void @llvm.dbg.value(metadata i8* %14, metadata !651, metadata !DIExpression()) #6, !dbg !652
  %15 = icmp eq i8* %14, null, !dbg !658
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %11) #6, !dbg !660
  call void @llvm.dbg.value(metadata i1 %15, metadata !634, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !639
  br i1 %15, label %16, label %50, !dbg !661

16:                                               ; preds = %10
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !512, metadata !DIExpression()) #6, !dbg !662
  call void @llvm.dbg.value(metadata i64 %7, metadata !517, metadata !DIExpression()) #6, !dbg !662
  call void @llvm.dbg.value(metadata i32 0, metadata !518, metadata !DIExpression()) #6, !dbg !662
  call void @llvm.dbg.value(metadata %struct.unwind_state* null, metadata !519, metadata !DIExpression()) #6, !dbg !662
  %17 = bitcast i64* %4 to i8*, !dbg !665
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %17) #6, !dbg !665
  call void @llvm.dbg.value(metadata i64 0, metadata !520, metadata !DIExpression()) #6, !dbg !662
  store i64 0, i64* %4, align 8, !dbg !666, !tbaa !329
  %18 = bitcast %struct.stack_count_key* %5 to i8*, !dbg !667
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %18) #6, !dbg !667
  call void @llvm.dbg.declare(metadata %struct.stack_count_key* %5, metadata !521, metadata !DIExpression()) #6, !dbg !668
  %19 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %5, i64 0, i32 2, !dbg !668
  %20 = bitcast i32* %19 to i8*, !dbg !668
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(20) %20, i8 0, i64 12, i1 false) #6, !dbg !668
  %21 = lshr i64 %7, 32, !dbg !669
  %22 = trunc i64 %21 to i32, !dbg !670
  call void @llvm.dbg.value(metadata i32 %22, metadata !522, metadata !DIExpression()) #6, !dbg !662
  call void @llvm.dbg.value(metadata i32 %8, metadata !523, metadata !DIExpression()) #6, !dbg !662
  %23 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %5, i64 0, i32 0, !dbg !671
  store i32 %22, i32* %23, align 4, !dbg !672, !tbaa !543
  %24 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %5, i64 0, i32 1, !dbg !673
  store i32 %8, i32* %24, align 4, !dbg !674, !tbaa !547
  %25 = bitcast %struct.bpf_perf_event_data* %0 to i8*, !dbg !675
  %26 = call i64 inttoptr (i64 27 to i64 (i8*, i8*, i64)*)(i8* noundef %25, i8* noundef bitcast (%struct.anon.3* @stack_traces to i8*), i64 noundef 0) #6, !dbg !676
  %27 = trunc i64 %26 to i32, !dbg !676
  call void @llvm.dbg.value(metadata i32 %27, metadata !524, metadata !DIExpression()) #6, !dbg !662
  %28 = icmp sgt i32 %27, -1, !dbg !677
  br i1 %28, label %29, label %31, !dbg !678

29:                                               ; preds = %16
  %30 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %5, i64 0, i32 3, !dbg !679
  store i32 %27, i32* %30, align 4, !dbg !680, !tbaa !556
  br label %31, !dbg !681

31:                                               ; preds = %29, %16
  %32 = call i64 inttoptr (i64 27 to i64 (i8*, i8*, i64)*)(i8* noundef %25, i8* noundef bitcast (%struct.anon.3* @stack_traces to i8*), i64 noundef 256) #6, !dbg !682
  %33 = trunc i64 %32 to i32, !dbg !682
  call void @llvm.dbg.value(metadata i32 %33, metadata !528, metadata !DIExpression()) #6, !dbg !683
  %34 = icmp sgt i32 %33, -1, !dbg !684
  br i1 %34, label %35, label %37, !dbg !686

35:                                               ; preds = %31
  store i32 %33, i32* %19, align 4, !dbg !687, !tbaa !689
  %36 = getelementptr inbounds %struct.stack_count_key, %struct.stack_count_key* %5, i64 0, i32 4, !dbg !690
  store i32 0, i32* %36, align 4, !dbg !691, !tbaa !581
  br label %37, !dbg !692

37:                                               ; preds = %35, %31
  call void @llvm.dbg.value(metadata i64* %4, metadata !520, metadata !DIExpression(DW_OP_deref)) #6, !dbg !662
  call void @llvm.dbg.value(metadata i8* bitcast (%struct.anon.2* @stack_counts to i8*), metadata !590, metadata !DIExpression()) #6, !dbg !694
  call void @llvm.dbg.value(metadata i8* %18, metadata !595, metadata !DIExpression()) #6, !dbg !694
  call void @llvm.dbg.value(metadata i8* %17, metadata !596, metadata !DIExpression()) #6, !dbg !694
  %38 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %18) #6, !dbg !692
  call void @llvm.dbg.value(metadata i8* %38, metadata !597, metadata !DIExpression()) #6, !dbg !694
  %39 = icmp eq i8* %38, null, !dbg !695
  br i1 %39, label %40, label %45, !dbg !696

40:                                               ; preds = %37
  %41 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %18, i8* noundef nonnull %17, i64 noundef 1) #6, !dbg !697
  call void @llvm.dbg.value(metadata i64 %41, metadata !598, metadata !DIExpression()) #6, !dbg !694
  switch i64 %41, label %49 [
    i64 -17, label %42
    i64 0, label %42
  ], !dbg !698

42:                                               ; preds = %40, %40
  %43 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.2* @stack_counts to i8*), i8* noundef nonnull %18) #6, !dbg !699
  call void @llvm.dbg.value(metadata i8* %43, metadata !531, metadata !DIExpression()) #6, !dbg !662
  %44 = icmp eq i8* %43, null, !dbg !700
  br i1 %44, label %49, label %45, !dbg !701

45:                                               ; preds = %42, %37
  %46 = phi i8* [ %43, %42 ], [ %38, %37 ]
  %47 = bitcast i8* %46 to i64*, !dbg !702
  call void @llvm.dbg.value(metadata i64* %47, metadata !531, metadata !DIExpression()) #6, !dbg !662
  %48 = atomicrmw add i64* %47, i64 1 seq_cst, align 8, !dbg !703
  br label %49, !dbg !704

49:                                               ; preds = %40, %42, %45
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %18) #6, !dbg !705
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %17) #6, !dbg !705
  br label %157, !dbg !706

50:                                               ; preds = %10
  %51 = getelementptr inbounds %struct.bpf_perf_event_data, %struct.bpf_perf_event_data* %0, i64 0, i32 0, i32 16, !dbg !707
  %52 = load i64, i64* %51, align 8, !dbg !707, !tbaa !708
  call void @llvm.dbg.value(metadata i32 %8, metadata !343, metadata !DIExpression()) #6, !dbg !712
  call void @llvm.dbg.value(metadata i64 %52, metadata !350, metadata !DIExpression()) #6, !dbg !712
  %53 = bitcast %struct.unwind_tables_key* %3 to i8*, !dbg !714
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %53) #6, !dbg !714
  call void @llvm.dbg.declare(metadata %struct.unwind_tables_key* %3, metadata !351, metadata !DIExpression()) #6, !dbg !715
  %54 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %3, i64 0, i32 0, !dbg !716
  store i32 %8, i32* %54, align 4, !dbg !716, !tbaa !362
  %55 = getelementptr inbounds %struct.unwind_tables_key, %struct.unwind_tables_key* %3, i64 0, i32 1, !dbg !716
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 0, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 0, i32* %55, align 4, !dbg !718, !tbaa !366
  %56 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %56, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %57 = icmp eq i8* %56, null, !dbg !721
  br i1 %57, label %67, label %58, !dbg !722

58:                                               ; preds = %50
  %59 = bitcast i8* %56 to i64*, !dbg !723
  %60 = load i64, i64* %59, align 8, !dbg !723, !tbaa !375
  %61 = icmp ugt i64 %60, %52, !dbg !724
  br i1 %61, label %67, label %62, !dbg !725

62:                                               ; preds = %58
  %63 = getelementptr inbounds i8, i8* %56, i64 8, !dbg !726
  %64 = bitcast i8* %63 to i64*, !dbg !726
  %65 = load i64, i64* %64, align 8, !dbg !726, !tbaa !380
  %66 = icmp ult i64 %65, %52, !dbg !727
  br i1 %66, label %67, label %128, !dbg !728

67:                                               ; preds = %62, %58, %50
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 1, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 1, i32* %55, align 4, !dbg !718, !tbaa !366
  %68 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %68, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %69 = icmp eq i8* %68, null, !dbg !721
  br i1 %69, label %79, label %70, !dbg !722

70:                                               ; preds = %67
  %71 = bitcast i8* %68 to i64*, !dbg !723
  %72 = load i64, i64* %71, align 8, !dbg !723, !tbaa !375
  %73 = icmp ugt i64 %72, %52, !dbg !724
  br i1 %73, label %79, label %74, !dbg !725

74:                                               ; preds = %70
  %75 = getelementptr inbounds i8, i8* %68, i64 8, !dbg !726
  %76 = bitcast i8* %75 to i64*, !dbg !726
  %77 = load i64, i64* %76, align 8, !dbg !726, !tbaa !380
  %78 = icmp ult i64 %77, %52, !dbg !727
  br i1 %78, label %79, label %128, !dbg !728

79:                                               ; preds = %74, %70, %67
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 2, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 2, i32* %55, align 4, !dbg !718, !tbaa !366
  %80 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %80, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %81 = icmp eq i8* %80, null, !dbg !721
  br i1 %81, label %91, label %82, !dbg !722

82:                                               ; preds = %79
  %83 = bitcast i8* %80 to i64*, !dbg !723
  %84 = load i64, i64* %83, align 8, !dbg !723, !tbaa !375
  %85 = icmp ugt i64 %84, %52, !dbg !724
  br i1 %85, label %91, label %86, !dbg !725

86:                                               ; preds = %82
  %87 = getelementptr inbounds i8, i8* %80, i64 8, !dbg !726
  %88 = bitcast i8* %87 to i64*, !dbg !726
  %89 = load i64, i64* %88, align 8, !dbg !726, !tbaa !380
  %90 = icmp ult i64 %89, %52, !dbg !727
  br i1 %90, label %91, label %128, !dbg !728

91:                                               ; preds = %86, %82, %79
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 3, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 3, i32* %55, align 4, !dbg !718, !tbaa !366
  %92 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %92, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %93 = icmp eq i8* %92, null, !dbg !721
  br i1 %93, label %103, label %94, !dbg !722

94:                                               ; preds = %91
  %95 = bitcast i8* %92 to i64*, !dbg !723
  %96 = load i64, i64* %95, align 8, !dbg !723, !tbaa !375
  %97 = icmp ugt i64 %96, %52, !dbg !724
  br i1 %97, label %103, label %98, !dbg !725

98:                                               ; preds = %94
  %99 = getelementptr inbounds i8, i8* %92, i64 8, !dbg !726
  %100 = bitcast i8* %99 to i64*, !dbg !726
  %101 = load i64, i64* %100, align 8, !dbg !726, !tbaa !380
  %102 = icmp ult i64 %101, %52, !dbg !727
  br i1 %102, label %103, label %128, !dbg !728

103:                                              ; preds = %98, %94, %91
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 4, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 4, i32* %55, align 4, !dbg !718, !tbaa !366
  %104 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %104, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %105 = icmp eq i8* %104, null, !dbg !721
  br i1 %105, label %115, label %106, !dbg !722

106:                                              ; preds = %103
  %107 = bitcast i8* %104 to i64*, !dbg !723
  %108 = load i64, i64* %107, align 8, !dbg !723, !tbaa !375
  %109 = icmp ugt i64 %108, %52, !dbg !724
  br i1 %109, label %115, label %110, !dbg !725

110:                                              ; preds = %106
  %111 = getelementptr inbounds i8, i8* %104, i64 8, !dbg !726
  %112 = bitcast i8* %111 to i64*, !dbg !726
  %113 = load i64, i64* %112, align 8, !dbg !726, !tbaa !380
  %114 = icmp ult i64 %113, %52, !dbg !727
  br i1 %114, label %115, label %128, !dbg !728

115:                                              ; preds = %110, %106, %103
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !717
  call void @llvm.dbg.value(metadata i32 5, metadata !352, metadata !DIExpression()) #6, !dbg !717
  store i32 5, i32* %55, align 4, !dbg !718, !tbaa !366
  %116 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @unwind_tables to i8*), i8* noundef nonnull %53) #6, !dbg !719
  call void @llvm.dbg.value(metadata i8* %116, metadata !354, metadata !DIExpression()) #6, !dbg !720
  %117 = icmp eq i8* %116, null, !dbg !721
  br i1 %117, label %127, label %118, !dbg !722

118:                                              ; preds = %115
  %119 = bitcast i8* %116 to i64*, !dbg !723
  %120 = load i64, i64* %119, align 8, !dbg !723, !tbaa !375
  %121 = icmp ugt i64 %120, %52, !dbg !724
  br i1 %121, label %127, label %122, !dbg !725

122:                                              ; preds = %118
  %123 = getelementptr inbounds i8, i8* %116, i64 8, !dbg !726
  %124 = bitcast i8* %123 to i64*, !dbg !726
  %125 = load i64, i64* %124, align 8, !dbg !726, !tbaa !380
  %126 = icmp ult i64 %125, %52, !dbg !727
  br i1 %126, label %127, label %128, !dbg !728

127:                                              ; preds = %122, %118, %115
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %53) #6, !dbg !729
  call void @llvm.dbg.value(metadata i8* %129, metadata !635, metadata !DIExpression()), !dbg !730
  br label %157, !dbg !731

128:                                              ; preds = %62, %74, %86, %98, %110, %122
  %129 = phi i8* [ %56, %62 ], [ %68, %74 ], [ %80, %86 ], [ %92, %98 ], [ %104, %110 ], [ %116, %122 ], !dbg !719
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %53) #6, !dbg !729
  call void @llvm.dbg.value(metadata i8* %129, metadata !635, metadata !DIExpression()), !dbg !730
  call void @llvm.dbg.value(metadata i8* %129, metadata !635, metadata !DIExpression()), !dbg !730
  %130 = getelementptr inbounds i8, i8* %129, i64 16, !dbg !732
  %131 = bitcast i8* %130 to i64*, !dbg !732
  %132 = load i64, i64* %131, align 8, !dbg !732, !tbaa !410
  call void @llvm.dbg.value(metadata i64 %132, metadata !638, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !730
  %133 = add i64 %132, -250001
  %134 = icmp ult i64 %133, -250000
  br i1 %134, label %157, label %135, !dbg !733

135:                                              ; preds = %128
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !735, metadata !DIExpression()) #6, !dbg !738
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !740, metadata !DIExpression()) #6, !dbg !748
  %136 = bitcast i32* %2 to i8*, !dbg !750
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %136) #6, !dbg !750
  call void @llvm.dbg.value(metadata i32 0, metadata !746, metadata !DIExpression()) #6, !dbg !748
  store i32 0, i32* %2, align 4, !dbg !751, !tbaa !581
  call void @llvm.dbg.value(metadata i32* %2, metadata !746, metadata !DIExpression(DW_OP_deref)) #6, !dbg !748
  %137 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @heap to i8*), i8* noundef nonnull %136) #6, !dbg !752
  call void @llvm.dbg.value(metadata i8* %137, metadata !747, metadata !DIExpression()) #6, !dbg !748
  %138 = icmp eq i8* %137, null, !dbg !753
  br i1 %138, label %154, label %139, !dbg !755

139:                                              ; preds = %135
  call void @llvm.dbg.value(metadata %struct.bpf_perf_event_data* %0, metadata !740, metadata !DIExpression()) #6, !dbg !748
  call void @llvm.dbg.value(metadata i8* %137, metadata !747, metadata !DIExpression()) #6, !dbg !748
  %140 = getelementptr inbounds i8, i8* %137, i64 32, !dbg !756
  %141 = bitcast i8* %140 to i64*, !dbg !757
  store i64 0, i64* %141, align 8, !dbg !758, !tbaa !433
  %142 = load i64, i64* %51, align 8, !dbg !759, !tbaa !760
  %143 = bitcast i8* %137 to i64*, !dbg !761
  store i64 %142, i64* %143, align 8, !dbg !762, !tbaa !339
  %144 = getelementptr inbounds %struct.bpf_perf_event_data, %struct.bpf_perf_event_data* %0, i64 0, i32 0, i32 19, !dbg !763
  %145 = load i64, i64* %144, align 8, !dbg !763, !tbaa !764
  %146 = getelementptr inbounds i8, i8* %137, i64 8, !dbg !765
  %147 = bitcast i8* %146 to i64*, !dbg !765
  store i64 %145, i64* %147, align 8, !dbg !766, !tbaa !458
  %148 = getelementptr inbounds %struct.bpf_perf_event_data, %struct.bpf_perf_event_data* %0, i64 0, i32 0, i32 4, !dbg !767
  %149 = load i64, i64* %148, align 8, !dbg !767, !tbaa !768
  %150 = getelementptr inbounds i8, i8* %137, i64 16, !dbg !769
  %151 = bitcast i8* %150 to i64*, !dbg !769
  store i64 %149, i64* %151, align 8, !dbg !770, !tbaa !389
  %152 = getelementptr inbounds i8, i8* %137, i64 24, !dbg !771
  %153 = bitcast i8* %152 to i32*, !dbg !771
  store i32 0, i32* %153, align 8, !dbg !772, !tbaa !619
  br label %154, !dbg !773

154:                                              ; preds = %135, %139
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %136) #6, !dbg !773
  %155 = bitcast %struct.bpf_perf_event_data* %0 to i8*, !dbg !774
  %156 = call i64 inttoptr (i64 12 to i64 (i8*, i8*, i32)*)(i8* noundef %155, i8* noundef bitcast (%struct.anon.0* @programs to i8*), i32 noundef 0) #6, !dbg !775
  br label %157, !dbg !776

157:                                              ; preds = %127, %128, %154, %49, %1
  ret i32 0, !dbg !777
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nounwind readnone
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #5

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-jump-tables"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn writeonly }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nounwind readnone }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!249, !250, !251, !252}
!llvm.ident = !{!253}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "heap", scope: !2, file: !3, line: 182, type: !234, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 14.0.5 (Fedora 14.0.5-2.fc36)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !28, globals: !33, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "cpu/cpu.bpf.c", directory: "/home/javierhonduco/code/parca-agent/bpf")
!4 = !{!5, !11, !15, !22}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 32, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "cpu/../common.h", directory: "/home/javierhonduco/code/parca-agent/bpf")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10}
!9 = !DIEnumerator(name: "false", value: 0)
!10 = !DIEnumerator(name: "true", value: 1)
!11 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "stack_walking_method", file: !3, line: 61, baseType: !7, size: 32, elements: !12)
!12 = !{!13, !14}
!13 = !DIEnumerator(name: "STACK_WALKING_METHOD_FP", value: 0)
!14 = !DIEnumerator(name: "STACK_WALKING_METHOD_DWARF", value: 1)
!15 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 84, baseType: !7, size: 32, elements: !16)
!16 = !{!17, !18, !19, !20, !21}
!17 = !DIEnumerator(name: "BPF_F_SKIP_FIELD_MASK", value: 255)
!18 = !DIEnumerator(name: "BPF_F_USER_STACK", value: 256)
!19 = !DIEnumerator(name: "BPF_F_FAST_STACK_CMP", value: 512)
!20 = !DIEnumerator(name: "BPF_F_REUSE_STACKID", value: 1024)
!21 = !DIEnumerator(name: "BPF_F_USER_BUILD_ID", value: 2048)
!22 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 43, baseType: !7, size: 32, elements: !23)
!23 = !{!24, !25, !26, !27}
!24 = !DIEnumerator(name: "BPF_ANY", value: 0)
!25 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!26 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!27 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!28 = !{!29, !30, !31}
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!30 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !3, line: 302, baseType: !7)
!33 = !{!34, !36, !42, !63, !88, !112, !127, !0, !172, !188, !200, !206, !213, !219, !224, !229}
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "VERSION", scope: !2, file: !3, line: 631, type: !7, isLocal: false, isDefinition: true)
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(name: "LICENSE", scope: !2, file: !3, line: 632, type: !38, isLocal: false, isDefinition: true)
!38 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 32, elements: !40)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !{!41}
!41 = !DISubrange(count: 4)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "debug_pids", scope: !2, file: !3, line: 170, type: !44, isLocal: false, isDefinition: true)
!44 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 170, size: 256, elements: !45)
!45 = !{!46, !51, !56, !58}
!46 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !44, file: !3, line: 170, baseType: !47, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 32, elements: !49)
!49 = !{!50}
!50 = !DISubrange(count: 1)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !44, file: !3, line: 170, baseType: !52, size: 64, offset: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 1024, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 32)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !44, file: !3, line: 170, baseType: !57, size: 64, offset: 128)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !44, file: !3, line: 170, baseType: !59, size: 64, offset: 192)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "u8", file: !6, line: 19, baseType: !61)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !6, line: 8, baseType: !62)
!62 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(name: "stack_counts", scope: !2, file: !3, line: 171, type: !65, isLocal: false, isDefinition: true)
!65 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 171, size: 256, elements: !66)
!66 = !{!67, !68, !73, !83}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !65, file: !3, line: 171, baseType: !47, size: 64)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !65, file: !3, line: 171, baseType: !69, size: 64, offset: 64)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 327680, elements: !71)
!71 = !{!72}
!72 = !DISubrange(count: 10240)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !65, file: !3, line: 171, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "stack_count_key_t", file: !3, line: 100, baseType: !76)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stack_count_key", file: !3, line: 94, size: 160, elements: !77)
!77 = !{!78, !79, !80, !81, !82}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "pid", scope: !76, file: !3, line: 95, baseType: !30, size: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "tgid", scope: !76, file: !3, line: 96, baseType: !30, size: 32, offset: 32)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "user_stack_id", scope: !76, file: !3, line: 97, baseType: !30, size: 32, offset: 64)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "kernel_stack_id", scope: !76, file: !3, line: 98, baseType: !30, size: 32, offset: 96)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "user_stack_id_dwarf", scope: !76, file: !3, line: 99, baseType: !30, size: 32, offset: 128)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !65, file: !3, line: 171, baseType: !84, size: 64, offset: 192)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "u64", file: !6, line: 17, baseType: !86)
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !6, line: 16, baseType: !87)
!87 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!88 = !DIGlobalVariableExpression(var: !89, expr: !DIExpression())
!89 = distinct !DIGlobalVariable(name: "stack_traces", scope: !2, file: !3, line: 172, type: !90, isLocal: false, isDefinition: true)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 172, size: 256, elements: !91)
!91 = !{!92, !97, !102, !106}
!92 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !90, file: !3, line: 172, baseType: !93, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 224, elements: !95)
!95 = !{!96}
!96 = !DISubrange(count: 7)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !90, file: !3, line: 172, baseType: !98, size: 64, offset: 64)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 32768, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 1024)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !90, file: !3, line: 172, baseType: !103, size: 64, offset: 128)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_typedef, name: "u32", file: !6, line: 22, baseType: !105)
!105 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !6, line: 11, baseType: !7)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !90, file: !3, line: 172, baseType: !107, size: 64, offset: 192)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "stack_trace_type", file: !3, line: 79, baseType: !109)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !86, size: 7360, elements: !110)
!110 = !{!111}
!111 = !DISubrange(count: 115)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "dwarf_stack_traces", scope: !2, file: !3, line: 173, type: !114, isLocal: false, isDefinition: true)
!114 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 173, size: 256, elements: !115)
!115 = !{!116, !117, !118, !119}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !114, file: !3, line: 173, baseType: !47, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !114, file: !3, line: 173, baseType: !98, size: 64, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !114, file: !3, line: 173, baseType: !57, size: 64, offset: 128)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !114, file: !3, line: 173, baseType: !120, size: 64, offset: 192)
!120 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "stack_trace_t", file: !3, line: 92, baseType: !122)
!122 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stack_trace_t", file: !3, line: 89, size: 7424, elements: !123)
!123 = !{!124, !125}
!124 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !122, file: !3, line: 90, baseType: !85, size: 64)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "addresses", scope: !122, file: !3, line: 91, baseType: !126, size: 7360, offset: 64)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !85, size: 7360, elements: !110)
!127 = !DIGlobalVariableExpression(var: !128, expr: !DIExpression())
!128 = distinct !DIGlobalVariable(name: "unwind_tables", scope: !2, file: !3, line: 174, type: !129, isLocal: false, isDefinition: true)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 174, size: 256, elements: !130)
!130 = !{!131, !132, !137, !144}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !129, file: !3, line: 174, baseType: !47, size: 64)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !129, file: !3, line: 174, baseType: !133, size: 64, offset: 64)
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 64, elements: !135)
!135 = !{!136}
!136 = !DISubrange(count: 2)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !129, file: !3, line: 174, baseType: !138, size: 64, offset: 128)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !139, size: 64)
!139 = !DIDerivedType(tag: DW_TAG_typedef, name: "unwind_tables_key_t", file: !3, line: 105, baseType: !140)
!140 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unwind_tables_key", file: !3, line: 102, size: 64, elements: !141)
!141 = !{!142, !143}
!142 = !DIDerivedType(tag: DW_TAG_member, name: "pid", scope: !140, file: !3, line: 103, baseType: !30, size: 32)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "shard", scope: !140, file: !3, line: 104, baseType: !30, size: 32, offset: 32)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !129, file: !3, line: 174, baseType: !145, size: 64, offset: 192)
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !146, size: 64)
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "stack_unwind_table_t", file: !3, line: 163, baseType: !147)
!147 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stack_unwind_table_t", file: !3, line: 157, size: 32000256, elements: !148)
!148 = !{!149, !150, !151, !152, !153}
!149 = !DIDerivedType(tag: DW_TAG_member, name: "low_pc", scope: !147, file: !3, line: 158, baseType: !85, size: 64)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "high_pc", scope: !147, file: !3, line: 159, baseType: !85, size: 64, offset: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "table_len", scope: !147, file: !3, line: 160, baseType: !85, size: 64, offset: 128)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "__explicit_padding", scope: !147, file: !3, line: 161, baseType: !85, size: 64, offset: 192)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "rows", scope: !147, file: !3, line: 162, baseType: !154, size: 32000000, offset: 256)
!154 = !DICompositeType(tag: DW_TAG_array_type, baseType: !155, size: 32000000, elements: !170)
!155 = !DIDerivedType(tag: DW_TAG_typedef, name: "stack_unwind_row_t", file: !3, line: 134, baseType: !156)
!156 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stack_unwind_row", file: !3, line: 127, size: 128, elements: !157)
!157 = !{!158, !159, !163, !164, !165, !169}
!158 = !DIDerivedType(tag: DW_TAG_member, name: "pc", scope: !156, file: !3, line: 128, baseType: !85, size: 64)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "__reserved_do_not_use", scope: !156, file: !3, line: 129, baseType: !160, size: 16, offset: 64)
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "u16", file: !6, line: 20, baseType: !161)
!161 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !6, line: 9, baseType: !162)
!162 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "cfa_type", scope: !156, file: !3, line: 130, baseType: !60, size: 8, offset: 80)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "rbp_type", scope: !156, file: !3, line: 131, baseType: !60, size: 8, offset: 88)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "cfa_offset", scope: !156, file: !3, line: 132, baseType: !166, size: 16, offset: 96)
!166 = !DIDerivedType(tag: DW_TAG_typedef, name: "s16", file: !6, line: 21, baseType: !167)
!167 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s16", file: !6, line: 10, baseType: !168)
!168 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "rbp_offset", scope: !156, file: !3, line: 133, baseType: !166, size: 16, offset: 112)
!170 = !{!171}
!171 = !DISubrange(count: 250000)
!172 = !DIGlobalVariableExpression(var: !173, expr: !DIExpression())
!173 = distinct !DIGlobalVariable(name: "percpu_stats", scope: !2, file: !3, line: 189, type: !174, isLocal: false, isDefinition: true)
!174 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 184, size: 256, elements: !175)
!175 = !{!176, !181, !186, !187}
!176 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !174, file: !3, line: 185, baseType: !177, size: 64)
!177 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !178, size: 64)
!178 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 192, elements: !179)
!179 = !{!180}
!180 = !DISubrange(count: 6)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !174, file: !3, line: 186, baseType: !182, size: 64, offset: 64)
!182 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !183, size: 64)
!183 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 320, elements: !184)
!184 = !{!185}
!185 = !DISubrange(count: 10)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !174, file: !3, line: 187, baseType: !103, size: 64, offset: 128)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !174, file: !3, line: 188, baseType: !103, size: 64, offset: 192)
!188 = !DIGlobalVariableExpression(var: !189, expr: !DIExpression())
!189 = distinct !DIGlobalVariable(name: "programs", scope: !2, file: !3, line: 196, type: !190, isLocal: false, isDefinition: true)
!190 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 191, size: 256, elements: !191)
!191 = !{!192, !197, !198, !199}
!192 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !190, file: !3, line: 192, baseType: !193, size: 64)
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !194, size: 64)
!194 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 96, elements: !195)
!195 = !{!196}
!196 = !DISubrange(count: 3)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !190, file: !3, line: 193, baseType: !47, size: 64, offset: 64)
!198 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !190, file: !3, line: 194, baseType: !103, size: 64, offset: 128)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !190, file: !3, line: 195, baseType: !103, size: 64, offset: 192)
!200 = !DIGlobalVariableExpression(var: !201, expr: !DIExpression())
!201 = distinct !DIGlobalVariable(name: "bpf_get_current_pid_tgid", scope: !2, file: !202, line: 367, type: !203, isLocal: true, isDefinition: true)
!202 = !DIFile(filename: "../dist/libbpf/amd64/usr/include/bpf/bpf_helper_defs.h", directory: "/home/javierhonduco/code/parca-agent/bpf")
!203 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !204, size: 64)
!204 = !DISubroutineType(types: !205)
!205 = !{!86}
!206 = !DIGlobalVariableExpression(var: !207, expr: !DIExpression())
!207 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !202, line: 55, type: !208, isLocal: true, isDefinition: true)
!208 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !209, size: 64)
!209 = !DISubroutineType(types: !210)
!210 = !{!29, !29, !211}
!211 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !212, size: 64)
!212 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!213 = !DIGlobalVariableExpression(var: !214, expr: !DIExpression())
!214 = distinct !DIGlobalVariable(name: "bpf_probe_read_user", scope: !2, file: !202, line: 2768, type: !215, isLocal: true, isDefinition: true)
!215 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !216, size: 64)
!216 = !DISubroutineType(types: !217)
!217 = !{!218, !29, !105, !211}
!218 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(name: "bpf_get_stackid", scope: !2, file: !202, line: 759, type: !221, isLocal: true, isDefinition: true)
!221 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !222, size: 64)
!222 = !DISubroutineType(types: !223)
!223 = !{!218, !29, !29, !86}
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !202, line: 77, type: !226, isLocal: true, isDefinition: true)
!226 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !227, size: 64)
!227 = !DISubroutineType(types: !228)
!228 = !{!218, !29, !211, !211, !86}
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(name: "bpf_tail_call", scope: !2, file: !202, line: 326, type: !231, isLocal: true, isDefinition: true)
!231 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !232, size: 64)
!232 = !DISubroutineType(types: !233)
!233 = !{!218, !29, !29, !105}
!234 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 177, size: 256, elements: !235)
!235 = !{!236, !237, !238, !239}
!236 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !234, file: !3, line: 178, baseType: !177, size: 64)
!237 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !234, file: !3, line: 179, baseType: !47, size: 64, offset: 64)
!238 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !234, file: !3, line: 180, baseType: !103, size: 64, offset: 128)
!239 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !234, file: !3, line: 181, baseType: !240, size: 64, offset: 192)
!240 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !241, size: 64)
!241 = !DIDerivedType(tag: DW_TAG_typedef, name: "unwind_state_t", file: !3, line: 113, baseType: !242)
!242 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "unwind_state", file: !3, line: 107, size: 7680, elements: !243)
!243 = !{!244, !245, !246, !247, !248}
!244 = !DIDerivedType(tag: DW_TAG_member, name: "ip", scope: !242, file: !3, line: 108, baseType: !85, size: 64)
!245 = !DIDerivedType(tag: DW_TAG_member, name: "sp", scope: !242, file: !3, line: 109, baseType: !85, size: 64, offset: 64)
!246 = !DIDerivedType(tag: DW_TAG_member, name: "bp", scope: !242, file: !3, line: 110, baseType: !85, size: 64, offset: 128)
!247 = !DIDerivedType(tag: DW_TAG_member, name: "tail_calls", scope: !242, file: !3, line: 111, baseType: !104, size: 32, offset: 192)
!248 = !DIDerivedType(tag: DW_TAG_member, name: "stack", scope: !242, file: !3, line: 112, baseType: !121, size: 7424, offset: 256)
!249 = !{i32 7, !"Dwarf Version", i32 4}
!250 = !{i32 2, !"Debug Info Version", i32 3}
!251 = !{i32 1, !"wchar_size", i32 4}
!252 = !{i32 7, !"frame-pointer", i32 2}
!253 = !{!"clang version 14.0.5 (Fedora 14.0.5-2.fc36)"}
!254 = distinct !DISubprogram(name: "walk_user_stacktrace_impl", scope: !3, file: !3, line: 385, type: !255, scopeLine: 385, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !288)
!255 = !DISubroutineType(types: !256)
!256 = !{!30, !257}
!257 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!258 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_perf_event_data", file: !6, line: 124, size: 1472, elements: !259)
!259 = !{!260, !286, !287}
!260 = !DIDerivedType(tag: DW_TAG_member, name: "regs", scope: !258, file: !6, line: 125, baseType: !261, size: 1344)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "bpf_user_pt_regs_t", file: !6, line: 122, baseType: !262)
!262 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "pt_regs", file: !6, line: 98, size: 1344, elements: !263)
!263 = !{!264, !266, !267, !268, !269, !270, !271, !272, !273, !274, !275, !276, !277, !278, !279, !280, !281, !282, !283, !284, !285}
!264 = !DIDerivedType(tag: DW_TAG_member, name: "r15", scope: !262, file: !6, line: 99, baseType: !265, size: 64)
!265 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!266 = !DIDerivedType(tag: DW_TAG_member, name: "r14", scope: !262, file: !6, line: 100, baseType: !265, size: 64, offset: 64)
!267 = !DIDerivedType(tag: DW_TAG_member, name: "r13", scope: !262, file: !6, line: 101, baseType: !265, size: 64, offset: 128)
!268 = !DIDerivedType(tag: DW_TAG_member, name: "r12", scope: !262, file: !6, line: 102, baseType: !265, size: 64, offset: 192)
!269 = !DIDerivedType(tag: DW_TAG_member, name: "bp", scope: !262, file: !6, line: 103, baseType: !265, size: 64, offset: 256)
!270 = !DIDerivedType(tag: DW_TAG_member, name: "bx", scope: !262, file: !6, line: 104, baseType: !265, size: 64, offset: 320)
!271 = !DIDerivedType(tag: DW_TAG_member, name: "r11", scope: !262, file: !6, line: 105, baseType: !265, size: 64, offset: 384)
!272 = !DIDerivedType(tag: DW_TAG_member, name: "r10", scope: !262, file: !6, line: 106, baseType: !265, size: 64, offset: 448)
!273 = !DIDerivedType(tag: DW_TAG_member, name: "r9", scope: !262, file: !6, line: 107, baseType: !265, size: 64, offset: 512)
!274 = !DIDerivedType(tag: DW_TAG_member, name: "r8", scope: !262, file: !6, line: 108, baseType: !265, size: 64, offset: 576)
!275 = !DIDerivedType(tag: DW_TAG_member, name: "ax", scope: !262, file: !6, line: 109, baseType: !265, size: 64, offset: 640)
!276 = !DIDerivedType(tag: DW_TAG_member, name: "cx", scope: !262, file: !6, line: 110, baseType: !265, size: 64, offset: 704)
!277 = !DIDerivedType(tag: DW_TAG_member, name: "dx", scope: !262, file: !6, line: 111, baseType: !265, size: 64, offset: 768)
!278 = !DIDerivedType(tag: DW_TAG_member, name: "si", scope: !262, file: !6, line: 112, baseType: !265, size: 64, offset: 832)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "di", scope: !262, file: !6, line: 113, baseType: !265, size: 64, offset: 896)
!280 = !DIDerivedType(tag: DW_TAG_member, name: "orig_ax", scope: !262, file: !6, line: 114, baseType: !265, size: 64, offset: 960)
!281 = !DIDerivedType(tag: DW_TAG_member, name: "ip", scope: !262, file: !6, line: 115, baseType: !265, size: 64, offset: 1024)
!282 = !DIDerivedType(tag: DW_TAG_member, name: "cs", scope: !262, file: !6, line: 116, baseType: !265, size: 64, offset: 1088)
!283 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !262, file: !6, line: 117, baseType: !265, size: 64, offset: 1152)
!284 = !DIDerivedType(tag: DW_TAG_member, name: "sp", scope: !262, file: !6, line: 118, baseType: !265, size: 64, offset: 1216)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "ss", scope: !262, file: !6, line: 119, baseType: !265, size: 64, offset: 1280)
!286 = !DIDerivedType(tag: DW_TAG_member, name: "sample_period", scope: !258, file: !6, line: 126, baseType: !86, size: 64, offset: 1344)
!287 = !DIDerivedType(tag: DW_TAG_member, name: "addr", scope: !258, file: !6, line: 127, baseType: !86, size: 64, offset: 1408)
!288 = !{!289, !290, !291, !292, !295, !296, !297, !299, !302, !303, !304, !305, !306, !307, !308, !309, !310, !311, !316, !317, !318, !319, !320, !323}
!289 = !DILocalVariable(name: "ctx", arg: 1, scope: !254, file: !3, line: 385, type: !257)
!290 = !DILocalVariable(name: "pid_tgid", scope: !254, file: !3, line: 386, type: !85)
!291 = !DILocalVariable(name: "user_pid", scope: !254, file: !3, line: 387, type: !30)
!292 = !DILocalVariable(name: "reached_bottom_of_stack", scope: !254, file: !3, line: 389, type: !293)
!293 = !DIDerivedType(tag: DW_TAG_typedef, name: "bool", file: !6, line: 37, baseType: !294)
!294 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!295 = !DILocalVariable(name: "zero", scope: !254, file: !3, line: 390, type: !85)
!296 = !DILocalVariable(name: "unwind_state", scope: !254, file: !3, line: 392, type: !240)
!297 = !DILocalVariable(name: "i", scope: !298, file: !3, line: 399, type: !30)
!298 = distinct !DILexicalBlock(scope: !254, file: !3, line: 399, column: 3)
!299 = !DILocalVariable(name: "unwind_table", scope: !300, file: !3, line: 401, type: !145)
!300 = distinct !DILexicalBlock(scope: !301, file: !3, line: 399, column: 57)
!301 = distinct !DILexicalBlock(scope: !298, file: !3, line: 399, column: 3)
!302 = !DILocalVariable(name: "table_idx", scope: !300, file: !3, line: 409, type: !85)
!303 = !DILocalVariable(name: "len", scope: !300, file: !3, line: 421, type: !85)
!304 = !DILocalVariable(name: "aa", scope: !300, file: !3, line: 430, type: !155)
!305 = !DILocalVariable(name: "found_pc", scope: !300, file: !3, line: 432, type: !85)
!306 = !DILocalVariable(name: "found_cfa_type", scope: !300, file: !3, line: 433, type: !60)
!307 = !DILocalVariable(name: "found_rbp_type", scope: !300, file: !3, line: 434, type: !60)
!308 = !DILocalVariable(name: "found_cfa_offset", scope: !300, file: !3, line: 435, type: !166)
!309 = !DILocalVariable(name: "found_rbp_offset", scope: !300, file: !3, line: 436, type: !166)
!310 = !DILocalVariable(name: "previous_rsp", scope: !300, file: !3, line: 444, type: !85)
!311 = !DILocalVariable(name: "threshold", scope: !312, file: !3, line: 455, type: !85)
!312 = distinct !DILexicalBlock(scope: !313, file: !3, line: 449, column: 55)
!313 = distinct !DILexicalBlock(scope: !314, file: !3, line: 449, column: 16)
!314 = distinct !DILexicalBlock(scope: !315, file: !3, line: 447, column: 16)
!315 = distinct !DILexicalBlock(scope: !300, file: !3, line: 445, column: 9)
!316 = !DILocalVariable(name: "previous_rip_addr", scope: !300, file: !3, line: 484, type: !85)
!317 = !DILocalVariable(name: "previous_rip", scope: !300, file: !3, line: 487, type: !85)
!318 = !DILocalVariable(name: "err", scope: !300, file: !3, line: 488, type: !30)
!319 = !DILocalVariable(name: "previous_rbp", scope: !300, file: !3, line: 499, type: !85)
!320 = !DILocalVariable(name: "previous_rbp_addr", scope: !321, file: !3, line: 503, type: !85)
!321 = distinct !DILexicalBlock(scope: !322, file: !3, line: 502, column: 12)
!322 = distinct !DILexicalBlock(scope: !300, file: !3, line: 500, column: 9)
!323 = !DILocalVariable(name: "ret", scope: !321, file: !3, line: 505, type: !30)
!324 = !DILocation(line: 0, scope: !254)
!325 = !DILocation(line: 386, column: 18, scope: !254)
!326 = !DILocation(line: 387, column: 18, scope: !254)
!327 = !DILocation(line: 390, column: 3, scope: !254)
!328 = !DILocation(line: 390, column: 7, scope: !254)
!329 = !{!330, !330, i64 0}
!330 = !{!"long long", !331, i64 0}
!331 = !{!"omnipotent char", !332, i64 0}
!332 = !{!"Simple C/C++ TBAA"}
!333 = !DILocation(line: 392, column: 34, scope: !254)
!334 = !DILocation(line: 393, column: 20, scope: !335)
!335 = distinct !DILexicalBlock(scope: !254, file: !3, line: 393, column: 7)
!336 = !DILocation(line: 393, column: 7, scope: !254)
!337 = !DILocation(line: 0, scope: !298)
!338 = !DILocation(line: 402, column: 51, scope: !300)
!339 = !{!340, !330, i64 0}
!340 = !{!"unwind_state", !330, i64 0, !330, i64 8, !330, i64 16, !341, i64 24, !342, i64 32}
!341 = !{!"int", !331, i64 0}
!342 = !{!"stack_trace_t", !330, i64 0, !331, i64 8}
!343 = !DILocalVariable(name: "pid", arg: 1, scope: !344, file: !3, line: 282, type: !347)
!344 = distinct !DISubprogram(name: "find_unwind_table", scope: !3, file: !3, line: 282, type: !345, scopeLine: 283, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !349)
!345 = !DISubroutineType(types: !346)
!346 = !{!145, !347, !85}
!347 = !DIDerivedType(tag: DW_TAG_typedef, name: "pid_t", file: !6, line: 41, baseType: !348)
!348 = !DIDerivedType(tag: DW_TAG_typedef, name: "__kernel_pid_t", file: !6, line: 40, baseType: !30)
!349 = !{!343, !350, !351, !352, !354}
!350 = !DILocalVariable(name: "pc", arg: 2, scope: !344, file: !3, line: 283, type: !85)
!351 = !DILocalVariable(name: "key", scope: !344, file: !3, line: 284, type: !139)
!352 = !DILocalVariable(name: "i", scope: !353, file: !3, line: 287, type: !30)
!353 = distinct !DILexicalBlock(scope: !344, file: !3, line: 287, column: 3)
!354 = !DILocalVariable(name: "shard", scope: !355, file: !3, line: 289, type: !145)
!355 = distinct !DILexicalBlock(scope: !356, file: !3, line: 287, column: 40)
!356 = distinct !DILexicalBlock(scope: !353, file: !3, line: 287, column: 3)
!357 = !DILocation(line: 0, scope: !344, inlinedAt: !358)
!358 = distinct !DILocation(line: 402, column: 9, scope: !300)
!359 = !DILocation(line: 284, column: 3, scope: !344, inlinedAt: !358)
!360 = !DILocation(line: 284, column: 23, scope: !344, inlinedAt: !358)
!361 = !DILocation(line: 284, column: 29, scope: !344, inlinedAt: !358)
!362 = !{!363, !341, i64 0}
!363 = !{!"unwind_tables_key", !341, i64 0, !341, i64 4}
!364 = !DILocation(line: 0, scope: !353, inlinedAt: !358)
!365 = !DILocation(line: 288, column: 15, scope: !355, inlinedAt: !358)
!366 = !{!363, !341, i64 4}
!367 = !DILocation(line: 289, column: 35, scope: !355, inlinedAt: !358)
!368 = !DILocation(line: 0, scope: !355, inlinedAt: !358)
!369 = !DILocation(line: 290, column: 9, scope: !370, inlinedAt: !358)
!370 = distinct !DILexicalBlock(scope: !355, file: !3, line: 290, column: 9)
!371 = !DILocation(line: 290, column: 9, scope: !355, inlinedAt: !358)
!372 = !DILocation(line: 291, column: 18, scope: !373, inlinedAt: !358)
!373 = distinct !DILexicalBlock(scope: !374, file: !3, line: 291, column: 11)
!374 = distinct !DILexicalBlock(scope: !370, file: !3, line: 290, column: 16)
!375 = !{!376, !330, i64 0}
!376 = !{!"stack_unwind_table_t", !330, i64 0, !330, i64 8, !330, i64 16, !330, i64 24, !331, i64 32}
!377 = !DILocation(line: 291, column: 25, scope: !373, inlinedAt: !358)
!378 = !DILocation(line: 291, column: 31, scope: !373, inlinedAt: !358)
!379 = !DILocation(line: 291, column: 47, scope: !373, inlinedAt: !358)
!380 = !{!376, !330, i64 8}
!381 = !DILocation(line: 291, column: 37, scope: !373, inlinedAt: !358)
!382 = !DILocation(line: 291, column: 11, scope: !374, inlinedAt: !358)
!383 = !DILocation(line: 299, column: 1, scope: !344, inlinedAt: !358)
!384 = !DILocation(line: 0, scope: !300)
!385 = !DILocation(line: 538, column: 23, scope: !386)
!386 = distinct !DILexicalBlock(scope: !387, file: !3, line: 538, column: 9)
!387 = distinct !DILexicalBlock(scope: !388, file: !3, line: 527, column: 32)
!388 = distinct !DILexicalBlock(scope: !254, file: !3, line: 527, column: 7)
!389 = !{!340, !330, i64 16}
!390 = !DILocation(line: 538, column: 26, scope: !386)
!391 = !DILocation(line: 538, column: 9, scope: !387)
!392 = !DILocation(line: 409, column: 68, scope: !300)
!393 = !DILocalVariable(name: "table", arg: 1, scope: !394, file: !3, line: 204, type: !145)
!394 = distinct !DISubprogram(name: "find_offset_for_pc", scope: !3, file: !3, line: 204, type: !395, scopeLine: 204, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !397)
!395 = !DISubroutineType(types: !396)
!396 = !{!85, !145, !85}
!397 = !{!393, !398, !399, !400, !401, !402, !404}
!398 = !DILocalVariable(name: "pc", arg: 2, scope: !394, file: !3, line: 204, type: !85)
!399 = !DILocalVariable(name: "left", scope: !394, file: !3, line: 205, type: !85)
!400 = !DILocalVariable(name: "right", scope: !394, file: !3, line: 206, type: !85)
!401 = !DILocalVariable(name: "found", scope: !394, file: !3, line: 207, type: !85)
!402 = !DILocalVariable(name: "i", scope: !403, file: !3, line: 210, type: !30)
!403 = distinct !DILexicalBlock(scope: !394, file: !3, line: 210, column: 3)
!404 = !DILocalVariable(name: "mid", scope: !405, file: !3, line: 218, type: !104)
!405 = distinct !DILexicalBlock(scope: !406, file: !3, line: 210, column: 53)
!406 = distinct !DILexicalBlock(scope: !403, file: !3, line: 210, column: 3)
!407 = !DILocation(line: 0, scope: !394, inlinedAt: !408)
!408 = distinct !DILocation(line: 409, column: 21, scope: !300)
!409 = !DILocation(line: 206, column: 22, scope: !394, inlinedAt: !408)
!410 = !{!376, !330, i64 16}
!411 = !DILocation(line: 0, scope: !403, inlinedAt: !408)
!412 = !DILocation(line: 213, column: 14, scope: !413, inlinedAt: !408)
!413 = distinct !DILexicalBlock(scope: !405, file: !3, line: 213, column: 9)
!414 = !DILocation(line: 213, column: 9, scope: !405, inlinedAt: !408)
!415 = !DILocation(line: 218, column: 30, scope: !405, inlinedAt: !408)
!416 = !DILocation(line: 218, column: 15, scope: !405, inlinedAt: !408)
!417 = !DILocation(line: 0, scope: !405, inlinedAt: !408)
!418 = !DILocation(line: 221, column: 17, scope: !419, inlinedAt: !408)
!419 = distinct !DILexicalBlock(scope: !405, file: !3, line: 221, column: 9)
!420 = !DILocation(line: 230, column: 9, scope: !421, inlinedAt: !408)
!421 = distinct !DILexicalBlock(scope: !405, file: !3, line: 230, column: 9)
!422 = !DILocation(line: 230, column: 26, scope: !421, inlinedAt: !408)
!423 = !{!424, !330, i64 0}
!424 = !{!"stack_unwind_row", !330, i64 0, !425, i64 8, !331, i64 10, !331, i64 11, !425, i64 12, !425, i64 14}
!425 = !{!"short", !331, i64 0}
!426 = !DILocation(line: 230, column: 29, scope: !421, inlinedAt: !408)
!427 = !DILocation(line: 230, column: 9, scope: !405, inlinedAt: !408)
!428 = !DILocation(line: 218, column: 21, scope: !405, inlinedAt: !408)
!429 = !DILocation(line: 411, column: 19, scope: !430)
!430 = distinct !DILexicalBlock(scope: !300, file: !3, line: 411, column: 9)
!431 = !DILocation(line: 411, column: 46, scope: !430)
!432 = !DILocation(line: 421, column: 35, scope: !300)
!433 = !{!340, !330, i64 32}
!434 = !DILocation(line: 425, column: 18, scope: !435)
!435 = distinct !DILexicalBlock(scope: !300, file: !3, line: 425, column: 9)
!436 = !DILocation(line: 426, column: 7, scope: !437)
!437 = distinct !DILexicalBlock(scope: !435, file: !3, line: 425, column: 44)
!438 = !DILocation(line: 426, column: 42, scope: !437)
!439 = !DILocation(line: 427, column: 5, scope: !437)
!440 = !DILocation(line: 430, column: 29, scope: !300)
!441 = !{i64 0, i64 1, !442, i64 1, i64 2, !443, i64 3, i64 2, !443}
!442 = !{!331, !331, i64 0}
!443 = !{!425, !425, i64 0}
!444 = !{i64 0, i64 2, !443, i64 2, i64 2, !443}
!445 = !{i64 0, i64 2, !443}
!446 = !DILocation(line: 438, column: 24, scope: !447)
!447 = distinct !DILexicalBlock(scope: !300, file: !3, line: 438, column: 9)
!448 = !DILocation(line: 438, column: 45, scope: !447)
!449 = !{i64 0, i64 1, !442, i64 1, i64 1, !442, i64 2, i64 2, !443, i64 4, i64 2, !443}
!450 = !DILocation(line: 445, column: 9, scope: !300)
!451 = !DILocation(line: 446, column: 36, scope: !452)
!452 = distinct !DILexicalBlock(scope: !315, file: !3, line: 445, column: 41)
!453 = !DILocation(line: 446, column: 41, scope: !452)
!454 = !DILocation(line: 446, column: 39, scope: !452)
!455 = !DILocation(line: 447, column: 5, scope: !452)
!456 = !DILocation(line: 448, column: 36, scope: !457)
!457 = distinct !DILexicalBlock(scope: !314, file: !3, line: 447, column: 48)
!458 = !{!340, !330, i64 8}
!459 = !DILocation(line: 448, column: 41, scope: !457)
!460 = !DILocation(line: 448, column: 39, scope: !457)
!461 = !DILocation(line: 449, column: 5, scope: !457)
!462 = !DILocation(line: 450, column: 11, scope: !312)
!463 = !DILocation(line: 0, scope: !312)
!464 = !DILocation(line: 460, column: 7, scope: !465)
!465 = distinct !DILexicalBlock(scope: !466, file: !3, line: 458, column: 61)
!466 = distinct !DILexicalBlock(scope: !467, file: !3, line: 458, column: 18)
!467 = distinct !DILexicalBlock(scope: !312, file: !3, line: 456, column: 11)
!468 = !DILocation(line: 467, column: 36, scope: !312)
!469 = !DILocation(line: 467, column: 39, scope: !312)
!470 = !DILocation(line: 468, column: 40, scope: !312)
!471 = !DILocation(line: 468, column: 43, scope: !312)
!472 = !DILocation(line: 468, column: 49, scope: !312)
!473 = !DILocation(line: 468, column: 64, scope: !312)
!474 = !DILocation(line: 467, column: 43, scope: !312)
!475 = !DILocation(line: 476, column: 22, scope: !476)
!476 = distinct !DILexicalBlock(scope: !300, file: !3, line: 476, column: 9)
!477 = !DILocation(line: 476, column: 9, scope: !300)
!478 = !DILocation(line: 485, column: 22, scope: !300)
!479 = !DILocation(line: 487, column: 5, scope: !300)
!480 = !DILocation(line: 487, column: 9, scope: !300)
!481 = !DILocation(line: 490, column: 9, scope: !300)
!482 = !DILocation(line: 488, column: 15, scope: !300)
!483 = !DILocation(line: 493, column: 9, scope: !484)
!484 = distinct !DILexicalBlock(scope: !300, file: !3, line: 493, column: 9)
!485 = !DILocation(line: 493, column: 22, scope: !484)
!486 = !DILocation(line: 493, column: 9, scope: !300)
!487 = !DILocation(line: 525, column: 3, scope: !301)
!488 = !DILocation(line: 499, column: 5, scope: !300)
!489 = !DILocation(line: 499, column: 9, scope: !300)
!490 = !DILocation(line: 500, column: 24, scope: !322)
!491 = !DILocation(line: 500, column: 9, scope: !300)
!492 = !DILocation(line: 501, column: 36, scope: !493)
!493 = distinct !DILexicalBlock(scope: !322, file: !3, line: 500, column: 47)
!494 = !DILocation(line: 501, column: 20, scope: !493)
!495 = !DILocation(line: 502, column: 5, scope: !493)
!496 = !DILocation(line: 503, column: 46, scope: !321)
!497 = !DILocation(line: 503, column: 44, scope: !321)
!498 = !DILocation(line: 0, scope: !321)
!499 = !DILocation(line: 507, column: 11, scope: !321)
!500 = !DILocation(line: 505, column: 17, scope: !321)
!501 = !DILocation(line: 510, column: 15, scope: !502)
!502 = distinct !DILexicalBlock(scope: !321, file: !3, line: 510, column: 11)
!503 = !DILocation(line: 517, column: 24, scope: !300)
!504 = !DILocation(line: 517, column: 22, scope: !300)
!505 = !DILocation(line: 518, column: 22, scope: !300)
!506 = !DILocation(line: 521, column: 24, scope: !300)
!507 = !DILocation(line: 521, column: 22, scope: !300)
!508 = !DILocation(line: 524, column: 28, scope: !300)
!509 = !DILocation(line: 548, column: 38, scope: !510)
!510 = distinct !DILexicalBlock(scope: !388, file: !3, line: 548, column: 14)
!511 = !DILocation(line: 548, column: 56, scope: !510)
!512 = !DILocalVariable(name: "ctx", arg: 1, scope: !513, file: !3, line: 334, type: !257)
!513 = distinct !DISubprogram(name: "add_stacks", scope: !3, file: !3, line: 334, type: !514, scopeLine: 337, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !516)
!514 = !DISubroutineType(types: !515)
!515 = !{null, !257, !85, !11, !240}
!516 = !{!512, !517, !518, !519, !520, !521, !522, !523, !524, !525, !528, !531}
!517 = !DILocalVariable(name: "pid_tgid", arg: 2, scope: !513, file: !3, line: 335, type: !85)
!518 = !DILocalVariable(name: "method", arg: 3, scope: !513, file: !3, line: 336, type: !11)
!519 = !DILocalVariable(name: "unwind_state", arg: 4, scope: !513, file: !3, line: 337, type: !240)
!520 = !DILocalVariable(name: "zero", scope: !513, file: !3, line: 338, type: !85)
!521 = !DILocalVariable(name: "stack_key", scope: !513, file: !3, line: 339, type: !75)
!522 = !DILocalVariable(name: "user_pid", scope: !513, file: !3, line: 348, type: !30)
!523 = !DILocalVariable(name: "user_tgid", scope: !513, file: !3, line: 349, type: !30)
!524 = !DILocalVariable(name: "kernel_stack_id", scope: !513, file: !3, line: 354, type: !30)
!525 = !DILocalVariable(name: "stack_hash", scope: !526, file: !3, line: 360, type: !30)
!526 = distinct !DILexicalBlock(scope: !527, file: !3, line: 359, column: 45)
!527 = distinct !DILexicalBlock(scope: !513, file: !3, line: 359, column: 7)
!528 = !DILocalVariable(name: "stack_id", scope: !529, file: !3, line: 370, type: !30)
!529 = distinct !DILexicalBlock(scope: !530, file: !3, line: 369, column: 49)
!530 = distinct !DILexicalBlock(scope: !527, file: !3, line: 369, column: 14)
!531 = !DILocalVariable(name: "scount", scope: !513, file: !3, line: 378, type: !84)
!532 = !DILocation(line: 0, scope: !513, inlinedAt: !533)
!533 = distinct !DILocation(line: 540, column: 7, scope: !534)
!534 = distinct !DILexicalBlock(scope: !386, file: !3, line: 538, column: 32)
!535 = !DILocation(line: 338, column: 3, scope: !513, inlinedAt: !533)
!536 = !DILocation(line: 338, column: 7, scope: !513, inlinedAt: !533)
!537 = !DILocation(line: 339, column: 3, scope: !513, inlinedAt: !533)
!538 = !DILocation(line: 339, column: 21, scope: !513, inlinedAt: !533)
!539 = !DILocation(line: 348, column: 27, scope: !513, inlinedAt: !533)
!540 = !DILocation(line: 348, column: 18, scope: !513, inlinedAt: !533)
!541 = !DILocation(line: 350, column: 13, scope: !513, inlinedAt: !533)
!542 = !DILocation(line: 350, column: 17, scope: !513, inlinedAt: !533)
!543 = !{!544, !341, i64 0}
!544 = !{!"stack_count_key", !341, i64 0, !341, i64 4, !341, i64 8, !341, i64 12, !341, i64 16}
!545 = !DILocation(line: 351, column: 13, scope: !513, inlinedAt: !533)
!546 = !DILocation(line: 351, column: 18, scope: !513, inlinedAt: !533)
!547 = !{!544, !341, i64 4}
!548 = !DILocation(line: 354, column: 41, scope: !513, inlinedAt: !533)
!549 = !DILocation(line: 354, column: 25, scope: !513, inlinedAt: !533)
!550 = !DILocation(line: 355, column: 23, scope: !551, inlinedAt: !533)
!551 = distinct !DILexicalBlock(scope: !513, file: !3, line: 355, column: 7)
!552 = !DILocation(line: 355, column: 7, scope: !513, inlinedAt: !533)
!553 = !DILocation(line: 356, column: 15, scope: !554, inlinedAt: !533)
!554 = distinct !DILexicalBlock(scope: !551, file: !3, line: 355, column: 29)
!555 = !DILocation(line: 356, column: 31, scope: !554, inlinedAt: !533)
!556 = !{!544, !341, i64 12}
!557 = !DILocation(line: 357, column: 3, scope: !554, inlinedAt: !533)
!558 = !DILocation(line: 360, column: 91, scope: !526, inlinedAt: !533)
!559 = !DILocation(line: 360, column: 71, scope: !526, inlinedAt: !533)
!560 = !DILocalVariable(name: "key", arg: 1, scope: !561, file: !3, line: 304, type: !211)
!561 = distinct !DISubprogram(name: "MurmurHash2", scope: !3, file: !3, line: 304, type: !562, scopeLine: 304, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !564)
!562 = !DISubroutineType(types: !563)
!563 = !{!32, !211, !30}
!564 = !{!560, !565, !566, !568, !570, !571, !572, !574}
!565 = !DILocalVariable(name: "len", arg: 2, scope: !561, file: !3, line: 304, type: !30)
!566 = !DILocalVariable(name: "m", scope: !561, file: !3, line: 308, type: !567)
!567 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !32)
!568 = !DILocalVariable(name: "r", scope: !561, file: !3, line: 309, type: !569)
!569 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !30)
!570 = !DILocalVariable(name: "h", scope: !561, file: !3, line: 313, type: !32)
!571 = !DILocalVariable(name: "data", scope: !561, file: !3, line: 319, type: !31)
!572 = !DILocalVariable(name: "i", scope: !573, file: !3, line: 321, type: !30)
!573 = distinct !DILexicalBlock(scope: !561, file: !3, line: 321, column: 3)
!574 = !DILocalVariable(name: "k", scope: !575, file: !3, line: 322, type: !32)
!575 = distinct !DILexicalBlock(scope: !576, file: !3, line: 321, column: 47)
!576 = distinct !DILexicalBlock(scope: !573, file: !3, line: 321, column: 3)
!577 = !DILocation(line: 0, scope: !561, inlinedAt: !578)
!578 = distinct !DILocation(line: 360, column: 27, scope: !526, inlinedAt: !533)
!579 = !DILocation(line: 319, column: 23, scope: !561, inlinedAt: !578)
!580 = !DILocation(line: 0, scope: !573, inlinedAt: !578)
!581 = !{!341, !341, i64 0}
!582 = !DILocation(line: 0, scope: !575, inlinedAt: !578)
!583 = !DILocation(line: 327, column: 7, scope: !575, inlinedAt: !578)
!584 = !DILocation(line: 328, column: 7, scope: !575, inlinedAt: !578)
!585 = !DILocation(line: 0, scope: !526, inlinedAt: !533)
!586 = !DILocation(line: 362, column: 15, scope: !526, inlinedAt: !533)
!587 = !DILocation(line: 362, column: 35, scope: !526, inlinedAt: !533)
!588 = !{!544, !341, i64 16}
!589 = !DILocation(line: 0, scope: !527, inlinedAt: !533)
!590 = !DILocalVariable(name: "map", arg: 1, scope: !591, file: !3, line: 137, type: !29)
!591 = distinct !DISubprogram(name: "bpf_map_lookup_or_try_init", scope: !3, file: !3, line: 137, type: !592, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !594)
!592 = !DISubroutineType(types: !593)
!593 = !{!29, !29, !211, !211}
!594 = !{!590, !595, !596, !597, !598}
!595 = !DILocalVariable(name: "key", arg: 2, scope: !591, file: !3, line: 137, type: !211)
!596 = !DILocalVariable(name: "init", arg: 3, scope: !591, file: !3, line: 137, type: !211)
!597 = !DILocalVariable(name: "val", scope: !591, file: !3, line: 138, type: !29)
!598 = !DILocalVariable(name: "err", scope: !591, file: !3, line: 139, type: !218)
!599 = !DILocation(line: 0, scope: !591, inlinedAt: !600)
!600 = distinct !DILocation(line: 378, column: 17, scope: !513, inlinedAt: !533)
!601 = !DILocation(line: 141, column: 9, scope: !591, inlinedAt: !600)
!602 = !DILocation(line: 142, column: 7, scope: !603, inlinedAt: !600)
!603 = distinct !DILexicalBlock(scope: !591, file: !3, line: 142, column: 7)
!604 = !DILocation(line: 142, column: 7, scope: !591, inlinedAt: !600)
!605 = !DILocation(line: 146, column: 9, scope: !591, inlinedAt: !600)
!606 = !DILocation(line: 148, column: 11, scope: !607, inlinedAt: !600)
!607 = distinct !DILexicalBlock(scope: !591, file: !3, line: 148, column: 7)
!608 = !DILocation(line: 153, column: 10, scope: !591, inlinedAt: !600)
!609 = !DILocation(line: 379, column: 7, scope: !610, inlinedAt: !533)
!610 = distinct !DILexicalBlock(scope: !513, file: !3, line: 379, column: 7)
!611 = !DILocation(line: 379, column: 7, scope: !513, inlinedAt: !533)
!612 = !DILocation(line: 378, column: 17, scope: !513, inlinedAt: !533)
!613 = !DILocation(line: 380, column: 5, scope: !614, inlinedAt: !533)
!614 = distinct !DILexicalBlock(scope: !610, file: !3, line: 379, column: 15)
!615 = !DILocation(line: 381, column: 3, scope: !614, inlinedAt: !533)
!616 = !DILocation(line: 382, column: 1, scope: !513, inlinedAt: !533)
!617 = !DILocation(line: 542, column: 5, scope: !534)
!618 = !DILocation(line: 549, column: 28, scope: !510)
!619 = !{!340, !341, i64 24}
!620 = !DILocation(line: 549, column: 39, scope: !510)
!621 = !DILocation(line: 548, column: 14, scope: !388)
!622 = !DILocation(line: 551, column: 29, scope: !623)
!623 = distinct !DILexicalBlock(scope: !510, file: !3, line: 549, column: 57)
!624 = !DILocation(line: 552, column: 19, scope: !623)
!625 = !DILocation(line: 552, column: 5, scope: !623)
!626 = !DILocation(line: 553, column: 3, scope: !623)
!627 = !DILocation(line: 558, column: 1, scope: !254)
!628 = distinct !DISubprogram(name: "profile_cpu", scope: !3, file: !3, line: 588, type: !255, scopeLine: 588, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !629)
!629 = !{!630, !631, !632, !633, !634, !635, !638}
!630 = !DILocalVariable(name: "ctx", arg: 1, scope: !628, file: !3, line: 588, type: !257)
!631 = !DILocalVariable(name: "pid_tgid", scope: !628, file: !3, line: 589, type: !85)
!632 = !DILocalVariable(name: "user_pid", scope: !628, file: !3, line: 590, type: !30)
!633 = !DILocalVariable(name: "user_tgid", scope: !628, file: !3, line: 591, type: !30)
!634 = !DILocalVariable(name: "has_unwind_info", scope: !628, file: !3, line: 596, type: !293)
!635 = !DILocalVariable(name: "unwind_table", scope: !636, file: !3, line: 602, type: !145)
!636 = distinct !DILexicalBlock(scope: !637, file: !3, line: 601, column: 10)
!637 = distinct !DILexicalBlock(scope: !628, file: !3, line: 599, column: 7)
!638 = !DILocalVariable(name: "last_idx", scope: !636, file: !3, line: 609, type: !85)
!639 = !DILocation(line: 0, scope: !628)
!640 = !DILocation(line: 589, column: 18, scope: !628)
!641 = !DILocation(line: 590, column: 18, scope: !628)
!642 = !DILocation(line: 593, column: 16, scope: !643)
!643 = distinct !DILexicalBlock(scope: !628, file: !3, line: 593, column: 7)
!644 = !DILocation(line: 593, column: 7, scope: !628)
!645 = !DILocalVariable(name: "pid", arg: 1, scope: !646, file: !3, line: 260, type: !347)
!646 = distinct !DISubprogram(name: "has_unwind_information", scope: !3, file: !3, line: 260, type: !647, scopeLine: 260, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !649)
!647 = !DISubroutineType(types: !648)
!648 = !{!293, !347}
!649 = !{!645, !650, !651}
!650 = !DILocalVariable(name: "key", scope: !646, file: !3, line: 261, type: !139)
!651 = !DILocalVariable(name: "shard1", scope: !646, file: !3, line: 263, type: !145)
!652 = !DILocation(line: 0, scope: !646, inlinedAt: !653)
!653 = distinct !DILocation(line: 596, column: 26, scope: !628)
!654 = !DILocation(line: 261, column: 3, scope: !646, inlinedAt: !653)
!655 = !DILocation(line: 261, column: 23, scope: !646, inlinedAt: !653)
!656 = !DILocation(line: 261, column: 29, scope: !646, inlinedAt: !653)
!657 = !DILocation(line: 263, column: 34, scope: !646, inlinedAt: !653)
!658 = !DILocation(line: 264, column: 7, scope: !659, inlinedAt: !653)
!659 = distinct !DILexicalBlock(scope: !646, file: !3, line: 264, column: 7)
!660 = !DILocation(line: 268, column: 1, scope: !646, inlinedAt: !653)
!661 = !DILocation(line: 599, column: 7, scope: !628)
!662 = !DILocation(line: 0, scope: !513, inlinedAt: !663)
!663 = distinct !DILocation(line: 600, column: 5, scope: !664)
!664 = distinct !DILexicalBlock(scope: !637, file: !3, line: 599, column: 25)
!665 = !DILocation(line: 338, column: 3, scope: !513, inlinedAt: !663)
!666 = !DILocation(line: 338, column: 7, scope: !513, inlinedAt: !663)
!667 = !DILocation(line: 339, column: 3, scope: !513, inlinedAt: !663)
!668 = !DILocation(line: 339, column: 21, scope: !513, inlinedAt: !663)
!669 = !DILocation(line: 348, column: 27, scope: !513, inlinedAt: !663)
!670 = !DILocation(line: 348, column: 18, scope: !513, inlinedAt: !663)
!671 = !DILocation(line: 350, column: 13, scope: !513, inlinedAt: !663)
!672 = !DILocation(line: 350, column: 17, scope: !513, inlinedAt: !663)
!673 = !DILocation(line: 351, column: 13, scope: !513, inlinedAt: !663)
!674 = !DILocation(line: 351, column: 18, scope: !513, inlinedAt: !663)
!675 = !DILocation(line: 354, column: 41, scope: !513, inlinedAt: !663)
!676 = !DILocation(line: 354, column: 25, scope: !513, inlinedAt: !663)
!677 = !DILocation(line: 355, column: 23, scope: !551, inlinedAt: !663)
!678 = !DILocation(line: 355, column: 7, scope: !513, inlinedAt: !663)
!679 = !DILocation(line: 356, column: 15, scope: !554, inlinedAt: !663)
!680 = !DILocation(line: 356, column: 31, scope: !554, inlinedAt: !663)
!681 = !DILocation(line: 357, column: 3, scope: !554, inlinedAt: !663)
!682 = !DILocation(line: 370, column: 20, scope: !529, inlinedAt: !663)
!683 = !DILocation(line: 0, scope: !529, inlinedAt: !663)
!684 = !DILocation(line: 371, column: 18, scope: !685, inlinedAt: !663)
!685 = distinct !DILexicalBlock(scope: !529, file: !3, line: 371, column: 9)
!686 = !DILocation(line: 371, column: 9, scope: !529, inlinedAt: !663)
!687 = !DILocation(line: 372, column: 31, scope: !688, inlinedAt: !663)
!688 = distinct !DILexicalBlock(scope: !685, file: !3, line: 371, column: 24)
!689 = !{!544, !341, i64 8}
!690 = !DILocation(line: 373, column: 17, scope: !688, inlinedAt: !663)
!691 = !DILocation(line: 0, scope: !527, inlinedAt: !663)
!692 = !DILocation(line: 141, column: 9, scope: !591, inlinedAt: !693)
!693 = distinct !DILocation(line: 378, column: 17, scope: !513, inlinedAt: !663)
!694 = !DILocation(line: 0, scope: !591, inlinedAt: !693)
!695 = !DILocation(line: 142, column: 7, scope: !603, inlinedAt: !693)
!696 = !DILocation(line: 142, column: 7, scope: !591, inlinedAt: !693)
!697 = !DILocation(line: 146, column: 9, scope: !591, inlinedAt: !693)
!698 = !DILocation(line: 148, column: 11, scope: !607, inlinedAt: !693)
!699 = !DILocation(line: 153, column: 10, scope: !591, inlinedAt: !693)
!700 = !DILocation(line: 379, column: 7, scope: !610, inlinedAt: !663)
!701 = !DILocation(line: 379, column: 7, scope: !513, inlinedAt: !663)
!702 = !DILocation(line: 378, column: 17, scope: !513, inlinedAt: !663)
!703 = !DILocation(line: 380, column: 5, scope: !614, inlinedAt: !663)
!704 = !DILocation(line: 381, column: 3, scope: !614, inlinedAt: !663)
!705 = !DILocation(line: 382, column: 1, scope: !513, inlinedAt: !663)
!706 = !DILocation(line: 601, column: 3, scope: !664)
!707 = !DILocation(line: 603, column: 47, scope: !636)
!708 = !{!709, !711, i64 128}
!709 = !{!"bpf_perf_event_data", !710, i64 0, !330, i64 168, !330, i64 176}
!710 = !{!"pt_regs", !711, i64 0, !711, i64 8, !711, i64 16, !711, i64 24, !711, i64 32, !711, i64 40, !711, i64 48, !711, i64 56, !711, i64 64, !711, i64 72, !711, i64 80, !711, i64 88, !711, i64 96, !711, i64 104, !711, i64 112, !711, i64 120, !711, i64 128, !711, i64 136, !711, i64 144, !711, i64 152, !711, i64 160}
!711 = !{!"long", !331, i64 0}
!712 = !DILocation(line: 0, scope: !344, inlinedAt: !713)
!713 = distinct !DILocation(line: 603, column: 9, scope: !636)
!714 = !DILocation(line: 284, column: 3, scope: !344, inlinedAt: !713)
!715 = !DILocation(line: 284, column: 23, scope: !344, inlinedAt: !713)
!716 = !DILocation(line: 284, column: 29, scope: !344, inlinedAt: !713)
!717 = !DILocation(line: 0, scope: !353, inlinedAt: !713)
!718 = !DILocation(line: 288, column: 15, scope: !355, inlinedAt: !713)
!719 = !DILocation(line: 289, column: 35, scope: !355, inlinedAt: !713)
!720 = !DILocation(line: 0, scope: !355, inlinedAt: !713)
!721 = !DILocation(line: 290, column: 9, scope: !370, inlinedAt: !713)
!722 = !DILocation(line: 290, column: 9, scope: !355, inlinedAt: !713)
!723 = !DILocation(line: 291, column: 18, scope: !373, inlinedAt: !713)
!724 = !DILocation(line: 291, column: 25, scope: !373, inlinedAt: !713)
!725 = !DILocation(line: 291, column: 31, scope: !373, inlinedAt: !713)
!726 = !DILocation(line: 291, column: 47, scope: !373, inlinedAt: !713)
!727 = !DILocation(line: 291, column: 37, scope: !373, inlinedAt: !713)
!728 = !DILocation(line: 291, column: 11, scope: !374, inlinedAt: !713)
!729 = !DILocation(line: 299, column: 1, scope: !344, inlinedAt: !713)
!730 = !DILocation(line: 0, scope: !636)
!731 = !DILocation(line: 604, column: 9, scope: !636)
!732 = !DILocation(line: 609, column: 34, scope: !636)
!733 = !DILocation(line: 611, column: 22, scope: !734)
!734 = distinct !DILexicalBlock(scope: !636, file: !3, line: 611, column: 9)
!735 = !DILocalVariable(name: "ctx", arg: 1, scope: !736, file: !3, line: 580, type: !257)
!736 = distinct !DISubprogram(name: "walk_user_stacktrace", scope: !3, file: !3, line: 580, type: !255, scopeLine: 580, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !737)
!737 = !{!735}
!738 = !DILocation(line: 0, scope: !736, inlinedAt: !739)
!739 = distinct !DILocation(line: 624, column: 5, scope: !636)
!740 = !DILocalVariable(name: "regs", arg: 1, scope: !741, file: !3, line: 560, type: !744)
!741 = distinct !DISubprogram(name: "set_initial_state", scope: !3, file: !3, line: 560, type: !742, scopeLine: 560, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !745)
!742 = !DISubroutineType(types: !743)
!743 = !{null, !744}
!744 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!745 = !{!740, !746, !747}
!746 = !DILocalVariable(name: "zero", scope: !741, file: !3, line: 561, type: !104)
!747 = !DILocalVariable(name: "unwind_state", scope: !741, file: !3, line: 563, type: !240)
!748 = !DILocation(line: 0, scope: !741, inlinedAt: !749)
!749 = distinct !DILocation(line: 582, column: 3, scope: !736, inlinedAt: !739)
!750 = !DILocation(line: 561, column: 3, scope: !741, inlinedAt: !749)
!751 = !DILocation(line: 561, column: 7, scope: !741, inlinedAt: !749)
!752 = !DILocation(line: 563, column: 34, scope: !741, inlinedAt: !749)
!753 = !DILocation(line: 564, column: 20, scope: !754, inlinedAt: !749)
!754 = distinct !DILexicalBlock(scope: !741, file: !3, line: 564, column: 7)
!755 = !DILocation(line: 564, column: 7, scope: !741, inlinedAt: !749)
!756 = !DILocation(line: 571, column: 17, scope: !741, inlinedAt: !749)
!757 = !DILocation(line: 571, column: 23, scope: !741, inlinedAt: !749)
!758 = !DILocation(line: 571, column: 27, scope: !741, inlinedAt: !749)
!759 = !DILocation(line: 573, column: 28, scope: !741, inlinedAt: !749)
!760 = !{!710, !711, i64 128}
!761 = !DILocation(line: 573, column: 17, scope: !741, inlinedAt: !749)
!762 = !DILocation(line: 573, column: 20, scope: !741, inlinedAt: !749)
!763 = !DILocation(line: 574, column: 28, scope: !741, inlinedAt: !749)
!764 = !{!710, !711, i64 152}
!765 = !DILocation(line: 574, column: 17, scope: !741, inlinedAt: !749)
!766 = !DILocation(line: 574, column: 20, scope: !741, inlinedAt: !749)
!767 = !DILocation(line: 575, column: 28, scope: !741, inlinedAt: !749)
!768 = !{!710, !711, i64 32}
!769 = !DILocation(line: 575, column: 17, scope: !741, inlinedAt: !749)
!770 = !DILocation(line: 575, column: 20, scope: !741, inlinedAt: !749)
!771 = !DILocation(line: 576, column: 17, scope: !741, inlinedAt: !749)
!772 = !DILocation(line: 576, column: 28, scope: !741, inlinedAt: !749)
!773 = !DILocation(line: 577, column: 1, scope: !741, inlinedAt: !749)
!774 = !DILocation(line: 583, column: 17, scope: !736, inlinedAt: !739)
!775 = !DILocation(line: 583, column: 3, scope: !736, inlinedAt: !739)
!776 = !DILocation(line: 625, column: 3, scope: !637)
!777 = !DILocation(line: 628, column: 1, scope: !628)

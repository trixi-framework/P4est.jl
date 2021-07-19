module LibP4est

using P4est_jll
export P4est_jll

@enum sc_tag_t::UInt32 begin
    SC_TAG_FIRST = 214
    # SC_TAG_AG_ALLTOALL = 214
    SC_TAG_AG_RECURSIVE_A = 215
    SC_TAG_AG_RECURSIVE_B = 216
    SC_TAG_AG_RECURSIVE_C = 217
    SC_TAG_NOTIFY_CENSUS = 218
    SC_TAG_NOTIFY_CENSUSV = 219
    SC_TAG_NOTIFY_NBX = 220
    SC_TAG_NOTIFY_NBXV = 221
    SC_TAG_NOTIFY_WRAPPER = 222
    SC_TAG_NOTIFY_WRAPPERV = 223
    SC_TAG_NOTIFY_RANGES = 224
    SC_TAG_NOTIFY_PAYLOAD = 225
    SC_TAG_NOTIFY_SUPER_TRUE = 226
    SC_TAG_NOTIFY_SUPER_EXTRA = 227
    SC_TAG_NOTIFY_RECURSIVE = 228
    SC_TAG_NOTIFY_NARY = 260
    SC_TAG_REDUCE = 292
    SC_TAG_PSORT_LO = 293
    SC_TAG_PSORT_HI = 294
    SC_TAG_LAST = 295
end

const sc_MPI_Comm = Cint

const sc_MPI_Group = Cint

const sc_MPI_Datatype = Cint

const sc_MPI_Op = Cint

const sc_MPI_Request = Cint

struct sc_MPI_Status
    count::Cint
    cancelled::Cint
    MPI_SOURCE::Cint
    MPI_TAG::Cint
    MPI_ERROR::Cint
end

function sc_MPI_Init(arg1, arg2)
    @ccall libp4est.sc_MPI_Init(arg1::Ptr{Cint}, arg2::Ptr{Ptr{Cstring}})::Cint
end

function sc_MPI_Finalize()
    @ccall libp4est.sc_MPI_Finalize()::Cint
end

function sc_MPI_Abort(arg1, arg2)
    @ccall libp4est.sc_MPI_Abort(arg1::sc_MPI_Comm, arg2::Cint)::Cint
end

function sc_MPI_Comm_dup(arg1, arg2)
    @ccall libp4est.sc_MPI_Comm_dup(arg1::sc_MPI_Comm, arg2::Ptr{sc_MPI_Comm})::Cint
end

function sc_MPI_Comm_create(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Comm_create(arg1::sc_MPI_Comm, arg2::sc_MPI_Group, arg3::Ptr{sc_MPI_Comm})::Cint
end

function sc_MPI_Comm_split(arg1, arg2, arg3, arg4)
    @ccall libp4est.sc_MPI_Comm_split(arg1::sc_MPI_Comm, arg2::Cint, arg3::Cint, arg4::Ptr{sc_MPI_Comm})::Cint
end

function sc_MPI_Comm_free(arg1)
    @ccall libp4est.sc_MPI_Comm_free(arg1::Ptr{sc_MPI_Comm})::Cint
end

function sc_MPI_Comm_size(arg1, arg2)
    @ccall libp4est.sc_MPI_Comm_size(arg1::sc_MPI_Comm, arg2::Ptr{Cint})::Cint
end

function sc_MPI_Comm_rank(arg1, arg2)
    @ccall libp4est.sc_MPI_Comm_rank(arg1::sc_MPI_Comm, arg2::Ptr{Cint})::Cint
end

function sc_MPI_Comm_compare(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Comm_compare(arg1::sc_MPI_Comm, arg2::sc_MPI_Comm, arg3::Ptr{Cint})::Cint
end

function sc_MPI_Comm_group(arg1, arg2)
    @ccall libp4est.sc_MPI_Comm_group(arg1::sc_MPI_Comm, arg2::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_free(arg1)
    @ccall libp4est.sc_MPI_Group_free(arg1::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_size(arg1, arg2)
    @ccall libp4est.sc_MPI_Group_size(arg1::sc_MPI_Group, arg2::Ptr{Cint})::Cint
end

function sc_MPI_Group_rank(arg1, arg2)
    @ccall libp4est.sc_MPI_Group_rank(arg1::sc_MPI_Group, arg2::Ptr{Cint})::Cint
end

function sc_MPI_Group_translate_ranks(arg1, arg2, arg3, arg4, arg5)
    @ccall libp4est.sc_MPI_Group_translate_ranks(arg1::sc_MPI_Group, arg2::Cint, arg3::Ptr{Cint}, arg4::sc_MPI_Group, arg5::Ptr{Cint})::Cint
end

function sc_MPI_Group_compare(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Group_compare(arg1::sc_MPI_Group, arg2::sc_MPI_Group, arg3::Ptr{Cint})::Cint
end

function sc_MPI_Group_union(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Group_union(arg1::sc_MPI_Group, arg2::sc_MPI_Group, arg3::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_intersection(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Group_intersection(arg1::sc_MPI_Group, arg2::sc_MPI_Group, arg3::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_difference(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Group_difference(arg1::sc_MPI_Group, arg2::sc_MPI_Group, arg3::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_incl(arg1, arg2, arg3, arg4)
    @ccall libp4est.sc_MPI_Group_incl(arg1::sc_MPI_Group, arg2::Cint, arg3::Ptr{Cint}, arg4::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_excl(arg1, arg2, arg3, arg4)
    @ccall libp4est.sc_MPI_Group_excl(arg1::sc_MPI_Group, arg2::Cint, arg3::Ptr{Cint}, arg4::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_range_incl(arg1, arg2, ranges, arg4)
    @ccall libp4est.sc_MPI_Group_range_incl(arg1::sc_MPI_Group, arg2::Cint, ranges::Ptr{NTuple{3, Cint}}, arg4::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Group_range_excl(arg1, arg2, ranges, arg4)
    @ccall libp4est.sc_MPI_Group_range_excl(arg1::sc_MPI_Group, arg2::Cint, ranges::Ptr{NTuple{3, Cint}}, arg4::Ptr{sc_MPI_Group})::Cint
end

function sc_MPI_Barrier(arg1)
    @ccall libp4est.sc_MPI_Barrier(arg1::sc_MPI_Comm)::Cint
end

function sc_MPI_Bcast(arg1, arg2, arg3, arg4, arg5)
    @ccall libp4est.sc_MPI_Bcast(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Cint, arg5::sc_MPI_Comm)::Cint
end

function sc_MPI_Gather(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libp4est.sc_MPI_Gather(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Ptr{Cvoid}, arg5::Cint, arg6::sc_MPI_Datatype, arg7::Cint, arg8::sc_MPI_Comm)::Cint
end

function sc_MPI_Gatherv(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    @ccall libp4est.sc_MPI_Gatherv(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Ptr{Cvoid}, arg5::Ptr{Cint}, arg6::Ptr{Cint}, arg7::sc_MPI_Datatype, arg8::Cint, arg9::sc_MPI_Comm)::Cint
end

function sc_MPI_Allgather(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Allgather(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Ptr{Cvoid}, arg5::Cint, arg6::sc_MPI_Datatype, arg7::sc_MPI_Comm)::Cint
end

function sc_MPI_Allgatherv(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    @ccall libp4est.sc_MPI_Allgatherv(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Ptr{Cvoid}, arg5::Ptr{Cint}, arg6::Ptr{Cint}, arg7::sc_MPI_Datatype, arg8::sc_MPI_Comm)::Cint
end

function sc_MPI_Alltoall(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Alltoall(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Ptr{Cvoid}, arg5::Cint, arg6::sc_MPI_Datatype, arg7::sc_MPI_Comm)::Cint
end

function sc_MPI_Reduce(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Reduce(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid}, arg3::Cint, arg4::sc_MPI_Datatype, arg5::sc_MPI_Op, arg6::Cint, arg7::sc_MPI_Comm)::Cint
end

function sc_MPI_Reduce_scatter_block(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libp4est.sc_MPI_Reduce_scatter_block(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid}, arg3::Cint, arg4::sc_MPI_Datatype, arg5::sc_MPI_Op, arg6::sc_MPI_Comm)::Cint
end

function sc_MPI_Allreduce(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libp4est.sc_MPI_Allreduce(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid}, arg3::Cint, arg4::sc_MPI_Datatype, arg5::sc_MPI_Op, arg6::sc_MPI_Comm)::Cint
end

function sc_MPI_Scan(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libp4est.sc_MPI_Scan(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid}, arg3::Cint, arg4::sc_MPI_Datatype, arg5::sc_MPI_Op, arg6::sc_MPI_Comm)::Cint
end

function sc_MPI_Exscan(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libp4est.sc_MPI_Exscan(arg1::Ptr{Cvoid}, arg2::Ptr{Cvoid}, arg3::Cint, arg4::sc_MPI_Datatype, arg5::sc_MPI_Op, arg6::sc_MPI_Comm)::Cint
end

function sc_MPI_Wtime()
    @ccall libp4est.sc_MPI_Wtime()::Cdouble
end

function sc_MPI_Recv(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Recv(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Cint, arg5::Cint, arg6::sc_MPI_Comm, arg7::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Irecv(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Irecv(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Cint, arg5::Cint, arg6::sc_MPI_Comm, arg7::Ptr{sc_MPI_Request})::Cint
end

function sc_MPI_Send(arg1, arg2, arg3, arg4, arg5, arg6)
    @ccall libp4est.sc_MPI_Send(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Cint, arg5::Cint, arg6::sc_MPI_Comm)::Cint
end

function sc_MPI_Isend(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    @ccall libp4est.sc_MPI_Isend(arg1::Ptr{Cvoid}, arg2::Cint, arg3::sc_MPI_Datatype, arg4::Cint, arg5::Cint, arg6::sc_MPI_Comm, arg7::Ptr{sc_MPI_Request})::Cint
end

function sc_MPI_Probe(arg1, arg2, arg3, arg4)
    @ccall libp4est.sc_MPI_Probe(arg1::Cint, arg2::Cint, arg3::sc_MPI_Comm, arg4::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Iprobe(arg1, arg2, arg3, arg4, arg5)
    @ccall libp4est.sc_MPI_Iprobe(arg1::Cint, arg2::Cint, arg3::sc_MPI_Comm, arg4::Ptr{Cint}, arg5::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Get_count(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Get_count(arg1::Ptr{sc_MPI_Status}, arg2::sc_MPI_Datatype, arg3::Ptr{Cint})::Cint
end

function sc_MPI_Wait(arg1, arg2)
    @ccall libp4est.sc_MPI_Wait(arg1::Ptr{sc_MPI_Request}, arg2::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Waitsome(arg1, arg2, arg3, arg4, arg5)
    @ccall libp4est.sc_MPI_Waitsome(arg1::Cint, arg2::Ptr{sc_MPI_Request}, arg3::Ptr{Cint}, arg4::Ptr{Cint}, arg5::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Waitall(arg1, arg2, arg3)
    @ccall libp4est.sc_MPI_Waitall(arg1::Cint, arg2::Ptr{sc_MPI_Request}, arg3::Ptr{sc_MPI_Status})::Cint
end

function sc_MPI_Init_thread(argc, argv, required, provided)
    @ccall libp4est.sc_MPI_Init_thread(argc::Ptr{Cint}, argv::Ptr{Ptr{Cstring}}, required::Cint, provided::Ptr{Cint})::Cint
end

function sc_mpi_sizeof(t)
    @ccall libp4est.sc_mpi_sizeof(t::sc_MPI_Datatype)::Csize_t
end

function sc_mpi_comm_attach_node_comms(comm, processes_per_node)
    @ccall libp4est.sc_mpi_comm_attach_node_comms(comm::sc_MPI_Comm, processes_per_node::Cint)::Cvoid
end

function sc_mpi_comm_detach_node_comms(comm)
    @ccall libp4est.sc_mpi_comm_detach_node_comms(comm::sc_MPI_Comm)::Cvoid
end

function sc_mpi_comm_get_node_comms(comm, intranode, internode)
    @ccall libp4est.sc_mpi_comm_get_node_comms(comm::sc_MPI_Comm, intranode::Ptr{sc_MPI_Comm}, internode::Ptr{sc_MPI_Comm})::Cvoid
end

# typedef void ( * sc_handler_t ) ( void * data )
const sc_handler_t = Ptr{Cvoid}

# typedef void ( * sc_log_handler_t ) ( FILE * log_stream , const char * filename , int lineno , int package , int category , int priority , const char * msg )
const sc_log_handler_t = Ptr{Cvoid}

# typedef void ( * sc_abort_handler_t ) ( void )
const sc_abort_handler_t = Ptr{Cvoid}

function sc_malloc(package, size)
    @ccall libp4est.sc_malloc(package::Cint, size::Csize_t)::Ptr{Cvoid}
end

function sc_calloc(package, nmemb, size)
    @ccall libp4est.sc_calloc(package::Cint, nmemb::Csize_t, size::Csize_t)::Ptr{Cvoid}
end

function sc_realloc(package, ptr, size)
    @ccall libp4est.sc_realloc(package::Cint, ptr::Ptr{Cvoid}, size::Csize_t)::Ptr{Cvoid}
end

function sc_strdup(package, s)
    @ccall libp4est.sc_strdup(package::Cint, s::Cstring)::Cstring
end

function sc_free(package, ptr)
    @ccall libp4est.sc_free(package::Cint, ptr::Ptr{Cvoid})::Cvoid
end

function sc_memory_status(package)
    @ccall libp4est.sc_memory_status(package::Cint)::Cint
end

function sc_memory_check(package)
    @ccall libp4est.sc_memory_check(package::Cint)::Cvoid
end

function sc_int_compare(v1, v2)
    @ccall libp4est.sc_int_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_int8_compare(v1, v2)
    @ccall libp4est.sc_int8_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_int16_compare(v1, v2)
    @ccall libp4est.sc_int16_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_int32_compare(v1, v2)
    @ccall libp4est.sc_int32_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_int64_compare(v1, v2)
    @ccall libp4est.sc_int64_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_double_compare(v1, v2)
    @ccall libp4est.sc_double_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

function sc_atoi(nptr)
    @ccall libp4est.sc_atoi(nptr::Cstring)::Cint
end

function sc_atol(nptr)
    @ccall libp4est.sc_atol(nptr::Cstring)::Clong
end

function sc_set_log_defaults(log_stream, log_handler, log_thresold)
    @ccall libp4est.sc_set_log_defaults(log_stream::Ptr{Libc.FILE}, log_handler::sc_log_handler_t, log_thresold::Cint)::Cvoid
end

function sc_set_abort_handler(abort_handler)
    @ccall libp4est.sc_set_abort_handler(abort_handler::sc_abort_handler_t)::Cvoid
end

function sc_log(filename, lineno, package, category, priority, msg)
    @ccall libp4est.sc_log(filename::Cstring, lineno::Cint, package::Cint, category::Cint, priority::Cint, msg::Cstring)::Cvoid
end

function sc_log_indent_push_count(package, count)
    @ccall libp4est.sc_log_indent_push_count(package::Cint, count::Cint)::Cvoid
end

function sc_log_indent_pop_count(package, count)
    @ccall libp4est.sc_log_indent_pop_count(package::Cint, count::Cint)::Cvoid
end

function sc_log_indent_push()
    @ccall libp4est.sc_log_indent_push()::Cvoid
end

function sc_log_indent_pop()
    @ccall libp4est.sc_log_indent_pop()::Cvoid
end

function sc_abort()
    @ccall libp4est.sc_abort()::Cvoid
end

function sc_abort_verbose(filename, lineno, msg)
    @ccall libp4est.sc_abort_verbose(filename::Cstring, lineno::Cint, msg::Cstring)::Cvoid
end

function sc_abort_collective(msg)
    @ccall libp4est.sc_abort_collective(msg::Cstring)::Cvoid
end

function sc_package_register(log_handler, log_threshold, name, full)
    @ccall libp4est.sc_package_register(log_handler::sc_log_handler_t, log_threshold::Cint, name::Cstring, full::Cstring)::Cint
end

function sc_package_is_registered(package_id)
    @ccall libp4est.sc_package_is_registered(package_id::Cint)::Cint
end

function sc_package_lock(package_id)
    @ccall libp4est.sc_package_lock(package_id::Cint)::Cvoid
end

function sc_package_unlock(package_id)
    @ccall libp4est.sc_package_unlock(package_id::Cint)::Cvoid
end

function sc_package_set_verbosity(package_id, log_priority)
    @ccall libp4est.sc_package_set_verbosity(package_id::Cint, log_priority::Cint)::Cvoid
end

function sc_package_set_abort_alloc_mismatch(package_id, set_abort)
    @ccall libp4est.sc_package_set_abort_alloc_mismatch(package_id::Cint, set_abort::Cint)::Cvoid
end

function sc_package_unregister(package_id)
    @ccall libp4est.sc_package_unregister(package_id::Cint)::Cvoid
end

function sc_package_print_summary(log_priority)
    @ccall libp4est.sc_package_print_summary(log_priority::Cint)::Cvoid
end

function sc_init(mpicomm, catch_signals, print_backtrace, log_handler, log_threshold)
    @ccall libp4est.sc_init(mpicomm::sc_MPI_Comm, catch_signals::Cint, print_backtrace::Cint, log_handler::sc_log_handler_t, log_threshold::Cint)::Cvoid
end

function sc_finalize()
    @ccall libp4est.sc_finalize()::Cvoid
end

function sc_is_root()
    @ccall libp4est.sc_is_root()::Cint
end

function sc_strcopy(dest, size, src)
    @ccall libp4est.sc_strcopy(dest::Cstring, size::Csize_t, src::Cstring)::Cvoid
end

function sc_version()
    @ccall libp4est.sc_version()::Cstring
end

function sc_version_major()
    @ccall libp4est.sc_version_major()::Cint
end

function sc_version_minor()
    @ccall libp4est.sc_version_minor()::Cint
end

# typedef unsigned int ( * sc_hash_function_t ) ( const void * v , const void * u )
const sc_hash_function_t = Ptr{Cvoid}

# typedef int ( * sc_equal_function_t ) ( const void * v1 , const void * v2 , const void * u )
const sc_equal_function_t = Ptr{Cvoid}

# typedef int ( * sc_hash_foreach_t ) ( void * * v , const void * u )
const sc_hash_foreach_t = Ptr{Cvoid}

struct sc_array
    elem_size::Csize_t
    elem_count::Csize_t
    byte_alloc::Cssize_t
    array::Cstring
end

const sc_array_t = sc_array

function sc_array_memory_used(array, is_dynamic)
    @ccall libp4est.sc_array_memory_used(array::Ptr{sc_array_t}, is_dynamic::Cint)::Csize_t
end

function sc_array_new(elem_size)
    @ccall libp4est.sc_array_new(elem_size::Csize_t)::Ptr{sc_array_t}
end

function sc_array_new_count(elem_size, elem_count)
    @ccall libp4est.sc_array_new_count(elem_size::Csize_t, elem_count::Csize_t)::Ptr{sc_array_t}
end

function sc_array_new_view(array, offset, length)
    @ccall libp4est.sc_array_new_view(array::Ptr{sc_array_t}, offset::Csize_t, length::Csize_t)::Ptr{sc_array_t}
end

function sc_array_new_data(base, elem_size, elem_count)
    @ccall libp4est.sc_array_new_data(base::Ptr{Cvoid}, elem_size::Csize_t, elem_count::Csize_t)::Ptr{sc_array_t}
end

function sc_array_destroy(array)
    @ccall libp4est.sc_array_destroy(array::Ptr{sc_array_t})::Cvoid
end

function sc_array_destroy_null(parray)
    @ccall libp4est.sc_array_destroy_null(parray::Ptr{Ptr{sc_array_t}})::Cvoid
end

function sc_array_init(array, elem_size)
    @ccall libp4est.sc_array_init(array::Ptr{sc_array_t}, elem_size::Csize_t)::Cvoid
end

function sc_array_init_size(array, elem_size, elem_count)
    @ccall libp4est.sc_array_init_size(array::Ptr{sc_array_t}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

function sc_array_init_count(array, elem_size, elem_count)
    @ccall libp4est.sc_array_init_count(array::Ptr{sc_array_t}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

function sc_array_init_view(view, array, offset, length)
    @ccall libp4est.sc_array_init_view(view::Ptr{sc_array_t}, array::Ptr{sc_array_t}, offset::Csize_t, length::Csize_t)::Cvoid
end

function sc_array_init_data(view, base, elem_size, elem_count)
    @ccall libp4est.sc_array_init_data(view::Ptr{sc_array_t}, base::Ptr{Cvoid}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

function sc_array_memset(array, c)
    @ccall libp4est.sc_array_memset(array::Ptr{sc_array_t}, c::Cint)::Cvoid
end

function sc_array_reset(array)
    @ccall libp4est.sc_array_reset(array::Ptr{sc_array_t})::Cvoid
end

function sc_array_truncate(array)
    @ccall libp4est.sc_array_truncate(array::Ptr{sc_array_t})::Cvoid
end

function sc_array_rewind(array, new_count)
    @ccall libp4est.sc_array_rewind(array::Ptr{sc_array_t}, new_count::Csize_t)::Cvoid
end

function sc_array_resize(array, new_count)
    @ccall libp4est.sc_array_resize(array::Ptr{sc_array_t}, new_count::Csize_t)::Cvoid
end

function sc_array_copy(dest, src)
    @ccall libp4est.sc_array_copy(dest::Ptr{sc_array_t}, src::Ptr{sc_array_t})::Cvoid
end

function sc_array_copy_into(dest, dest_offset, src)
    @ccall libp4est.sc_array_copy_into(dest::Ptr{sc_array_t}, dest_offset::Csize_t, src::Ptr{sc_array_t})::Cvoid
end

function sc_array_move_part(dest, dest_offset, src, src_offset, count)
    @ccall libp4est.sc_array_move_part(dest::Ptr{sc_array_t}, dest_offset::Csize_t, src::Ptr{sc_array_t}, src_offset::Csize_t, count::Csize_t)::Cvoid
end

function sc_array_sort(array, compar)
    @ccall libp4est.sc_array_sort(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cvoid
end

function sc_array_is_sorted(array, compar)
    @ccall libp4est.sc_array_is_sorted(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cint
end

function sc_array_is_equal(array, other)
    @ccall libp4est.sc_array_is_equal(array::Ptr{sc_array_t}, other::Ptr{sc_array_t})::Cint
end

function sc_array_uniq(array, compar)
    @ccall libp4est.sc_array_uniq(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cvoid
end

function sc_array_bsearch(array, key, compar)
    @ccall libp4est.sc_array_bsearch(array::Ptr{sc_array_t}, key::Ptr{Cvoid}, compar::Ptr{Cvoid})::Cssize_t
end

# typedef size_t ( * sc_array_type_t ) ( sc_array_t * array , size_t index , void * data )
const sc_array_type_t = Ptr{Cvoid}

function sc_array_split(array, offsets, num_types, type_fn, data)
    @ccall libp4est.sc_array_split(array::Ptr{sc_array_t}, offsets::Ptr{sc_array_t}, num_types::Csize_t, type_fn::sc_array_type_t, data::Ptr{Cvoid})::Cvoid
end

function sc_array_is_permutation(array)
    @ccall libp4est.sc_array_is_permutation(array::Ptr{sc_array_t})::Cint
end

function sc_array_permute(array, newindices, keepperm)
    @ccall libp4est.sc_array_permute(array::Ptr{sc_array_t}, newindices::Ptr{sc_array_t}, keepperm::Cint)::Cvoid
end

function sc_array_checksum(array)
    @ccall libp4est.sc_array_checksum(array::Ptr{sc_array_t})::Cuint
end

function sc_array_pqueue_add(array, temp, compar)
    @ccall libp4est.sc_array_pqueue_add(array::Ptr{sc_array_t}, temp::Ptr{Cvoid}, compar::Ptr{Cvoid})::Csize_t
end

function sc_array_pqueue_pop(array, result, compar)
    @ccall libp4est.sc_array_pqueue_pop(array::Ptr{sc_array_t}, result::Ptr{Cvoid}, compar::Ptr{Cvoid})::Csize_t
end

function sc_array_index(array, iz)
    @ccall libp4est.sc_array_index(array::Ptr{sc_array_t}, iz::Csize_t)::Ptr{Cvoid}
end

function sc_array_index_null(array, iz)
    @ccall libp4est.sc_array_index_null(array::Ptr{sc_array_t}, iz::Csize_t)::Ptr{Cvoid}
end

function sc_array_index_int(array, i)
    @ccall libp4est.sc_array_index_int(array::Ptr{sc_array_t}, i::Cint)::Ptr{Cvoid}
end

function sc_array_index_long(array, l)
    @ccall libp4est.sc_array_index_long(array::Ptr{sc_array_t}, l::Clong)::Ptr{Cvoid}
end

function sc_array_index_ssize_t(array, is)
    @ccall libp4est.sc_array_index_ssize_t(array::Ptr{sc_array_t}, is::Cssize_t)::Ptr{Cvoid}
end

function sc_array_index_int16(array, i16)
    @ccall libp4est.sc_array_index_int16(array::Ptr{sc_array_t}, i16::Int16)::Ptr{Cvoid}
end

function sc_array_position(array, element)
    @ccall libp4est.sc_array_position(array::Ptr{sc_array_t}, element::Ptr{Cvoid})::Csize_t
end

function sc_array_pop(array)
    @ccall libp4est.sc_array_pop(array::Ptr{sc_array_t})::Ptr{Cvoid}
end

function sc_array_push_count(array, add_count)
    @ccall libp4est.sc_array_push_count(array::Ptr{sc_array_t}, add_count::Csize_t)::Ptr{Cvoid}
end

function sc_array_push(array)
    @ccall libp4est.sc_array_push(array::Ptr{sc_array_t})::Ptr{Cvoid}
end

struct sc_mstamp
    elem_size::Csize_t
    per_stamp::Csize_t
    stamp_size::Csize_t
    cur_snext::Csize_t
    current::Cstring
    remember::sc_array_t
end

const sc_mstamp_t = sc_mstamp

function sc_mstamp_init(mst, stamp_unit, elem_size)
    @ccall libp4est.sc_mstamp_init(mst::Ptr{sc_mstamp_t}, stamp_unit::Csize_t, elem_size::Csize_t)::Cvoid
end

function sc_mstamp_reset(mst)
    @ccall libp4est.sc_mstamp_reset(mst::Ptr{sc_mstamp_t})::Cvoid
end

function sc_mstamp_truncate(mst)
    @ccall libp4est.sc_mstamp_truncate(mst::Ptr{sc_mstamp_t})::Cvoid
end

function sc_mstamp_alloc(mst)
    @ccall libp4est.sc_mstamp_alloc(mst::Ptr{sc_mstamp_t})::Ptr{Cvoid}
end

function sc_mstamp_memory_used(mst)
    @ccall libp4est.sc_mstamp_memory_used(mst::Ptr{sc_mstamp_t})::Csize_t
end

struct sc_mempool
    elem_size::Csize_t
    elem_count::Csize_t
    zero_and_persist::Cint
    mstamp::sc_mstamp_t
    freed::sc_array_t
end

const sc_mempool_t = sc_mempool

function sc_mempool_memory_used(mempool)
    @ccall libp4est.sc_mempool_memory_used(mempool::Ptr{sc_mempool_t})::Csize_t
end

function sc_mempool_new(elem_size)
    @ccall libp4est.sc_mempool_new(elem_size::Csize_t)::Ptr{sc_mempool_t}
end

function sc_mempool_new_zero_and_persist(elem_size)
    @ccall libp4est.sc_mempool_new_zero_and_persist(elem_size::Csize_t)::Ptr{sc_mempool_t}
end

function sc_mempool_init(mempool, elem_size)
    @ccall libp4est.sc_mempool_init(mempool::Ptr{sc_mempool_t}, elem_size::Csize_t)::Cvoid
end

function sc_mempool_destroy(mempool)
    @ccall libp4est.sc_mempool_destroy(mempool::Ptr{sc_mempool_t})::Cvoid
end

function sc_mempool_destroy_null(pmempool)
    @ccall libp4est.sc_mempool_destroy_null(pmempool::Ptr{Ptr{sc_mempool_t}})::Cvoid
end

function sc_mempool_reset(mempool)
    @ccall libp4est.sc_mempool_reset(mempool::Ptr{sc_mempool_t})::Cvoid
end

function sc_mempool_truncate(mempool)
    @ccall libp4est.sc_mempool_truncate(mempool::Ptr{sc_mempool_t})::Cvoid
end

function sc_mempool_alloc(mempool)
    @ccall libp4est.sc_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{Cvoid}
end

function sc_mempool_free(mempool, elem)
    @ccall libp4est.sc_mempool_free(mempool::Ptr{sc_mempool_t}, elem::Ptr{Cvoid})::Cvoid
end

struct sc_link
    data::Ptr{Cvoid}
    next::Ptr{sc_link}
end

const sc_link_t = sc_link

mutable struct sc_list
    elem_count::Csize_t
    first::Ptr{sc_link_t}
    last::Ptr{sc_link_t}
    allocator_owned::Cint
    allocator::Ptr{sc_mempool_t}
    sc_list() = new()
end

const sc_list_t = sc_list

function sc_list_memory_used(list, is_dynamic)
    @ccall libp4est.sc_list_memory_used(list::Ptr{sc_list_t}, is_dynamic::Cint)::Csize_t
end

function sc_list_new(allocator)
    @ccall libp4est.sc_list_new(allocator::Ptr{sc_mempool_t})::Ptr{sc_list_t}
end

function sc_list_destroy(list)
    @ccall libp4est.sc_list_destroy(list::Ptr{sc_list_t})::Cvoid
end

function sc_list_init(list, allocator)
    @ccall libp4est.sc_list_init(list::Ptr{sc_list_t}, allocator::Ptr{sc_mempool_t})::Cvoid
end

function sc_list_reset(list)
    @ccall libp4est.sc_list_reset(list::Ptr{sc_list_t})::Cvoid
end

function sc_list_unlink(list)
    @ccall libp4est.sc_list_unlink(list::Ptr{sc_list_t})::Cvoid
end

function sc_list_prepend(list, data)
    @ccall libp4est.sc_list_prepend(list::Ptr{sc_list_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

function sc_list_append(list, data)
    @ccall libp4est.sc_list_append(list::Ptr{sc_list_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

function sc_list_insert(list, pred, data)
    @ccall libp4est.sc_list_insert(list::Ptr{sc_list_t}, pred::Ptr{sc_link_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

function sc_list_remove(list, pred)
    @ccall libp4est.sc_list_remove(list::Ptr{sc_list_t}, pred::Ptr{sc_link_t})::Ptr{Cvoid}
end

function sc_list_pop(list)
    @ccall libp4est.sc_list_pop(list::Ptr{sc_list_t})::Ptr{Cvoid}
end

struct sc_hash
    elem_count::Csize_t
    slots::Ptr{sc_array_t}
    user_data::Ptr{Cvoid}
    hash_fn::sc_hash_function_t
    equal_fn::sc_equal_function_t
    resize_checks::Csize_t
    resize_actions::Csize_t
    allocator_owned::Cint
    allocator::Ptr{sc_mempool_t}
end

const sc_hash_t = sc_hash

function sc_hash_function_string(s, u)
    @ccall libp4est.sc_hash_function_string(s::Ptr{Cvoid}, u::Ptr{Cvoid})::Cuint
end

function sc_hash_memory_used(hash)
    @ccall libp4est.sc_hash_memory_used(hash::Ptr{sc_hash_t})::Csize_t
end

function sc_hash_new(hash_fn, equal_fn, user_data, allocator)
    @ccall libp4est.sc_hash_new(hash_fn::sc_hash_function_t, equal_fn::sc_equal_function_t, user_data::Ptr{Cvoid}, allocator::Ptr{sc_mempool_t})::Ptr{sc_hash_t}
end

function sc_hash_destroy(hash)
    @ccall libp4est.sc_hash_destroy(hash::Ptr{sc_hash_t})::Cvoid
end

function sc_hash_destroy_null(phash)
    @ccall libp4est.sc_hash_destroy_null(phash::Ptr{Ptr{sc_hash_t}})::Cvoid
end

function sc_hash_truncate(hash)
    @ccall libp4est.sc_hash_truncate(hash::Ptr{sc_hash_t})::Cvoid
end

function sc_hash_unlink(hash)
    @ccall libp4est.sc_hash_unlink(hash::Ptr{sc_hash_t})::Cvoid
end

function sc_hash_unlink_destroy(hash)
    @ccall libp4est.sc_hash_unlink_destroy(hash::Ptr{sc_hash_t})::Cvoid
end

function sc_hash_lookup(hash, v, found)
    @ccall libp4est.sc_hash_lookup(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Ptr{Cvoid}}})::Cint
end

function sc_hash_insert_unique(hash, v, found)
    @ccall libp4est.sc_hash_insert_unique(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Ptr{Cvoid}}})::Cint
end

function sc_hash_remove(hash, v, found)
    @ccall libp4est.sc_hash_remove(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Cvoid}})::Cint
end

function sc_hash_foreach(hash, fn)
    @ccall libp4est.sc_hash_foreach(hash::Ptr{sc_hash_t}, fn::sc_hash_foreach_t)::Cvoid
end

function sc_hash_print_statistics(package_id, log_priority, hash)
    @ccall libp4est.sc_hash_print_statistics(package_id::Cint, log_priority::Cint, hash::Ptr{sc_hash_t})::Cvoid
end

struct sc_hash_array_data
    pa::Ptr{sc_array_t}
    hash_fn::sc_hash_function_t
    equal_fn::sc_equal_function_t
    user_data::Ptr{Cvoid}
    current_item::Ptr{Cvoid}
end

const sc_hash_array_data_t = sc_hash_array_data

mutable struct sc_hash_array
    a::sc_array_t
    internal_data::sc_hash_array_data_t
    h::Ptr{sc_hash_t}
    sc_hash_array() = new()
end

const sc_hash_array_t = sc_hash_array

function sc_hash_array_memory_used(ha)
    @ccall libp4est.sc_hash_array_memory_used(ha::Ptr{sc_hash_array_t})::Csize_t
end

function sc_hash_array_new(elem_size, hash_fn, equal_fn, user_data)
    @ccall libp4est.sc_hash_array_new(elem_size::Csize_t, hash_fn::sc_hash_function_t, equal_fn::sc_equal_function_t, user_data::Ptr{Cvoid})::Ptr{sc_hash_array_t}
end

function sc_hash_array_destroy(hash_array)
    @ccall libp4est.sc_hash_array_destroy(hash_array::Ptr{sc_hash_array_t})::Cvoid
end

function sc_hash_array_is_valid(hash_array)
    @ccall libp4est.sc_hash_array_is_valid(hash_array::Ptr{sc_hash_array_t})::Cint
end

function sc_hash_array_truncate(hash_array)
    @ccall libp4est.sc_hash_array_truncate(hash_array::Ptr{sc_hash_array_t})::Cvoid
end

function sc_hash_array_lookup(hash_array, v, position)
    @ccall libp4est.sc_hash_array_lookup(hash_array::Ptr{sc_hash_array_t}, v::Ptr{Cvoid}, position::Ptr{Csize_t})::Cint
end

function sc_hash_array_insert_unique(hash_array, v, position)
    @ccall libp4est.sc_hash_array_insert_unique(hash_array::Ptr{sc_hash_array_t}, v::Ptr{Cvoid}, position::Ptr{Csize_t})::Ptr{Cvoid}
end

function sc_hash_array_rip(hash_array, rip)
    @ccall libp4est.sc_hash_array_rip(hash_array::Ptr{sc_hash_array_t}, rip::Ptr{sc_array_t})::Cvoid
end

mutable struct sc_recycle_array
    elem_count::Csize_t
    a::sc_array_t
    f::sc_array_t
    sc_recycle_array() = new()
end

const sc_recycle_array_t = sc_recycle_array

function sc_recycle_array_init(rec_array, elem_size)
    @ccall libp4est.sc_recycle_array_init(rec_array::Ptr{sc_recycle_array_t}, elem_size::Csize_t)::Cvoid
end

function sc_recycle_array_reset(rec_array)
    @ccall libp4est.sc_recycle_array_reset(rec_array::Ptr{sc_recycle_array_t})::Cvoid
end

function sc_recycle_array_insert(rec_array, position)
    @ccall libp4est.sc_recycle_array_insert(rec_array::Ptr{sc_recycle_array_t}, position::Ptr{Csize_t})::Ptr{Cvoid}
end

function sc_recycle_array_remove(rec_array, position)
    @ccall libp4est.sc_recycle_array_remove(rec_array::Ptr{sc_recycle_array_t}, position::Csize_t)::Ptr{Cvoid}
end

@enum sc_io_error_t::Int32 begin
    SC_IO_ERROR_NONE = 0
    SC_IO_ERROR_FATAL = -1
    SC_IO_ERROR_AGAIN = -2
end

@enum sc_io_mode_t::UInt32 begin
    SC_IO_MODE_WRITE = 0
    SC_IO_MODE_APPEND = 1
    SC_IO_MODE_LAST = 2
end

@enum sc_io_encode_t::UInt32 begin
    SC_IO_ENCODE_NONE = 0
    SC_IO_ENCODE_LAST = 1
end

@enum sc_io_type_t::UInt32 begin
    SC_IO_TYPE_BUFFER = 0
    SC_IO_TYPE_FILENAME = 1
    SC_IO_TYPE_FILEFILE = 2
    SC_IO_TYPE_LAST = 3
end

struct sc_io_sink
    iotype::sc_io_type_t
    mode::sc_io_mode_t
    encode::sc_io_encode_t
    buffer::Ptr{sc_array_t}
    buffer_bytes::Csize_t
    file::Ptr{Libc.FILE}
    bytes_in::Csize_t
    bytes_out::Csize_t
end

const sc_io_sink_t = sc_io_sink

mutable struct sc_io_source
    iotype::sc_io_type_t
    encode::sc_io_encode_t
    buffer::Ptr{sc_array_t}
    buffer_bytes::Csize_t
    file::Ptr{Libc.FILE}
    bytes_in::Csize_t
    bytes_out::Csize_t
    mirror::Ptr{sc_io_sink_t}
    mirror_buffer::Ptr{sc_array_t}
    sc_io_source() = new()
end

const sc_io_source_t = sc_io_source

function sc_io_sink_destroy(sink)
    @ccall libp4est.sc_io_sink_destroy(sink::Ptr{sc_io_sink_t})::Cint
end

function sc_io_sink_write(sink, data, bytes_avail)
    @ccall libp4est.sc_io_sink_write(sink::Ptr{sc_io_sink_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t)::Cint
end

function sc_io_sink_complete(sink, bytes_in, bytes_out)
    @ccall libp4est.sc_io_sink_complete(sink::Ptr{sc_io_sink_t}, bytes_in::Ptr{Csize_t}, bytes_out::Ptr{Csize_t})::Cint
end

function sc_io_sink_align(sink, bytes_align)
    @ccall libp4est.sc_io_sink_align(sink::Ptr{sc_io_sink_t}, bytes_align::Csize_t)::Cint
end

function sc_io_source_destroy(source)
    @ccall libp4est.sc_io_source_destroy(source::Ptr{sc_io_source_t})::Cint
end

function sc_io_source_read(source, data, bytes_avail, bytes_out)
    @ccall libp4est.sc_io_source_read(source::Ptr{sc_io_source_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t, bytes_out::Ptr{Csize_t})::Cint
end

function sc_io_source_complete(source, bytes_in, bytes_out)
    @ccall libp4est.sc_io_source_complete(source::Ptr{sc_io_source_t}, bytes_in::Ptr{Csize_t}, bytes_out::Ptr{Csize_t})::Cint
end

function sc_io_source_align(source, bytes_align)
    @ccall libp4est.sc_io_source_align(source::Ptr{sc_io_source_t}, bytes_align::Csize_t)::Cint
end

function sc_io_source_activate_mirror(source)
    @ccall libp4est.sc_io_source_activate_mirror(source::Ptr{sc_io_source_t})::Cint
end

function sc_io_source_read_mirror(source, data, bytes_avail, bytes_out)
    @ccall libp4est.sc_io_source_read_mirror(source::Ptr{sc_io_source_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t, bytes_out::Ptr{Csize_t})::Cint
end

function sc_vtk_write_binary(vtkfile, numeric_data, byte_length)
    @ccall libp4est.sc_vtk_write_binary(vtkfile::Ptr{Libc.FILE}, numeric_data::Cstring, byte_length::Csize_t)::Cint
end

function sc_vtk_write_compressed(vtkfile, numeric_data, byte_length)
    @ccall libp4est.sc_vtk_write_compressed(vtkfile::Ptr{Libc.FILE}, numeric_data::Cstring, byte_length::Csize_t)::Cint
end

function sc_fwrite(ptr, size, nmemb, file, errmsg)
    @ccall libp4est.sc_fwrite(ptr::Ptr{Cvoid}, size::Csize_t, nmemb::Csize_t, file::Ptr{Libc.FILE}, errmsg::Cstring)::Cvoid
end

function sc_fread(ptr, size, nmemb, file, errmsg)
    @ccall libp4est.sc_fread(ptr::Ptr{Cvoid}, size::Csize_t, nmemb::Csize_t, file::Ptr{Libc.FILE}, errmsg::Cstring)::Cvoid
end

function sc_fflush_fsync_fclose(file)
    @ccall libp4est.sc_fflush_fsync_fclose(file::Ptr{Libc.FILE})::Cvoid
end

const p4est_qcoord_t = Int32

const p4est_topidx_t = Int32

const p4est_locidx_t = Int32

const p4est_gloidx_t = Int64

@enum p4est_comm_tag::UInt32 begin
    P4EST_COMM_TAG_FIRST = 214
    P4EST_COMM_COUNT_PERTREE = 295
    P4EST_COMM_BALANCE_FIRST_COUNT = 296
    P4EST_COMM_BALANCE_FIRST_LOAD = 297
    P4EST_COMM_BALANCE_SECOND_COUNT = 298
    P4EST_COMM_BALANCE_SECOND_LOAD = 299
    P4EST_COMM_PARTITION_GIVEN = 300
    P4EST_COMM_PARTITION_WEIGHTED_LOW = 301
    P4EST_COMM_PARTITION_WEIGHTED_HIGH = 302
    P4EST_COMM_PARTITION_CORRECTION = 303
    P4EST_COMM_GHOST_COUNT = 304
    P4EST_COMM_GHOST_LOAD = 305
    P4EST_COMM_GHOST_EXCHANGE = 306
    P4EST_COMM_GHOST_EXPAND_COUNT = 307
    P4EST_COMM_GHOST_EXPAND_LOAD = 308
    P4EST_COMM_GHOST_SUPPORT_COUNT = 309
    P4EST_COMM_GHOST_SUPPORT_LOAD = 310
    P4EST_COMM_GHOST_CHECKSUM = 311
    P4EST_COMM_NODES_QUERY = 312
    P4EST_COMM_NODES_REPLY = 313
    P4EST_COMM_SAVE = 314
    P4EST_COMM_LNODES_TEST = 315
    P4EST_COMM_LNODES_PASS = 316
    P4EST_COMM_LNODES_OWNED = 317
    P4EST_COMM_LNODES_ALL = 318
    P4EST_COMM_TAG_LAST = 319
end

const p4est_comm_tag_t = p4est_comm_tag

# no prototype is found for this function at p4est_base.h:325:1, please use with caution
function p4est_log_indent_push()
    ccall((:p4est_log_indent_push, libp4est), Cvoid, ())
end

# no prototype is found for this function at p4est_base.h:331:1, please use with caution
function p4est_log_indent_pop()
    ccall((:p4est_log_indent_pop, libp4est), Cvoid, ())
end

function p4est_init(log_handler, log_threshold)
    @ccall libp4est.p4est_init(log_handler::sc_log_handler_t, log_threshold::Cint)::Cvoid
end

function p4est_topidx_hash2(tt)
    @ccall libp4est.p4est_topidx_hash2(tt::Ptr{p4est_topidx_t})::Cuint
end

function p4est_topidx_hash3(tt)
    @ccall libp4est.p4est_topidx_hash3(tt::Ptr{p4est_topidx_t})::Cuint
end

function p4est_topidx_hash4(tt)
    @ccall libp4est.p4est_topidx_hash4(tt::Ptr{p4est_topidx_t})::Cuint
end

function p4est_topidx_is_sorted(t, length)
    @ccall libp4est.p4est_topidx_is_sorted(t::Ptr{p4est_topidx_t}, length::Cint)::Cint
end

function p4est_topidx_bsort(t, length)
    @ccall libp4est.p4est_topidx_bsort(t::Ptr{p4est_topidx_t}, length::Cint)::Cvoid
end

function p4est_partition_cut_uint64(global_num, p, num_procs)
    @ccall libp4est.p4est_partition_cut_uint64(global_num::UInt64, p::Cint, num_procs::Cint)::UInt64
end

function p4est_partition_cut_gloidx(global_num, p, num_procs)
    @ccall libp4est.p4est_partition_cut_gloidx(global_num::p4est_gloidx_t, p::Cint, num_procs::Cint)::p4est_gloidx_t
end

function p4est_version()
    @ccall libp4est.p4est_version()::Cstring
end

function p4est_version_major()
    @ccall libp4est.p4est_version_major()::Cint
end

function p4est_version_minor()
    @ccall libp4est.p4est_version_minor()::Cint
end

@enum p4est_connect_type_t::UInt32 begin
    P4EST_CONNECT_FACE = 21
    P4EST_CONNECT_CORNER = 22
    # P4EST_CONNECT_FULL = 22
end

@enum p4est_connectivity_encode_t::UInt32 begin
    P4EST_CONN_ENCODE_NONE = 0
    P4EST_CONN_ENCODE_LAST = 1
end

function p4est_connect_type_int(btype)
    @ccall libp4est.p4est_connect_type_int(btype::p4est_connect_type_t)::Cint
end

function p4est_connect_type_string(btype)
    @ccall libp4est.p4est_connect_type_string(btype::p4est_connect_type_t)::Cstring
end

struct p4est_connectivity
    num_vertices::p4est_topidx_t
    num_trees::p4est_topidx_t
    num_corners::p4est_topidx_t
    vertices::Ptr{Cdouble}
    tree_to_vertex::Ptr{p4est_topidx_t}
    tree_attr_bytes::Csize_t
    tree_to_attr::Cstring
    tree_to_tree::Ptr{p4est_topidx_t}
    tree_to_face::Ptr{Int8}
    tree_to_corner::Ptr{p4est_topidx_t}
    ctt_offset::Ptr{p4est_topidx_t}
    corner_to_tree::Ptr{p4est_topidx_t}
    corner_to_corner::Ptr{Int8}
end

const p4est_connectivity_t = p4est_connectivity

function p4est_connectivity_memory_used(conn)
    @ccall libp4est.p4est_connectivity_memory_used(conn::Ptr{p4est_connectivity_t})::Csize_t
end

mutable struct p4est_corner_transform_t
    ntree::p4est_topidx_t
    ncorner::Int8
    p4est_corner_transform_t() = new()
end

mutable struct p4est_corner_info_t
    icorner::p4est_topidx_t
    corner_transforms::sc_array_t
    p4est_corner_info_t() = new()
end

function p4est_connectivity_face_neighbor_face_corner(fc, f, nf, o)
    @ccall libp4est.p4est_connectivity_face_neighbor_face_corner(fc::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p4est_connectivity_face_neighbor_corner(c, f, nf, o)
    @ccall libp4est.p4est_connectivity_face_neighbor_corner(c::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p4est_connectivity_new(num_vertices, num_trees, num_corners, num_ctt)
    @ccall libp4est.p4est_connectivity_new(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_corners::p4est_topidx_t, num_ctt::p4est_topidx_t)::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_copy(num_vertices, num_trees, num_corners, vertices, ttv, ttt, ttf, ttc, coff, ctt, ctc)
    @ccall libp4est.p4est_connectivity_new_copy(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_corners::p4est_topidx_t, vertices::Ptr{Cdouble}, ttv::Ptr{p4est_topidx_t}, ttt::Ptr{p4est_topidx_t}, ttf::Ptr{Int8}, ttc::Ptr{p4est_topidx_t}, coff::Ptr{p4est_topidx_t}, ctt::Ptr{p4est_topidx_t}, ctc::Ptr{Int8})::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_bcast(conn_in, root, comm)
    @ccall libp4est.p4est_connectivity_bcast(conn_in::Ptr{p4est_connectivity_t}, root::Cint, comm::sc_MPI_Comm)::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_destroy(connectivity)
    @ccall libp4est.p4est_connectivity_destroy(connectivity::Ptr{p4est_connectivity_t})::Cvoid
end

function p4est_connectivity_set_attr(conn, bytes_per_tree)
    @ccall libp4est.p4est_connectivity_set_attr(conn::Ptr{p4est_connectivity_t}, bytes_per_tree::Csize_t)::Cvoid
end

function p4est_connectivity_is_valid(connectivity)
    @ccall libp4est.p4est_connectivity_is_valid(connectivity::Ptr{p4est_connectivity_t})::Cint
end

function p4est_connectivity_is_equal(conn1, conn2)
    @ccall libp4est.p4est_connectivity_is_equal(conn1::Ptr{p4est_connectivity_t}, conn2::Ptr{p4est_connectivity_t})::Cint
end

function p4est_connectivity_sink(conn, sink)
    @ccall libp4est.p4est_connectivity_sink(conn::Ptr{p4est_connectivity_t}, sink::Ptr{sc_io_sink_t})::Cint
end

function p4est_connectivity_deflate(conn, code)
    @ccall libp4est.p4est_connectivity_deflate(conn::Ptr{p4est_connectivity_t}, code::p4est_connectivity_encode_t)::Ptr{sc_array_t}
end

function p4est_connectivity_save(filename, connectivity)
    @ccall libp4est.p4est_connectivity_save(filename::Cstring, connectivity::Ptr{p4est_connectivity_t})::Cint
end

function p4est_connectivity_source(source)
    @ccall libp4est.p4est_connectivity_source(source::Ptr{sc_io_source_t})::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_inflate(buffer)
    @ccall libp4est.p4est_connectivity_inflate(buffer::Ptr{sc_array_t})::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_load(filename, bytes)
    @ccall libp4est.p4est_connectivity_load(filename::Cstring, bytes::Ptr{Csize_t})::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_unitsquare()
    @ccall libp4est.p4est_connectivity_new_unitsquare()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_periodic()
    @ccall libp4est.p4est_connectivity_new_periodic()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_rotwrap()
    @ccall libp4est.p4est_connectivity_new_rotwrap()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_twotrees(l_face, r_face, orientation)
    @ccall libp4est.p4est_connectivity_new_twotrees(l_face::Cint, r_face::Cint, orientation::Cint)::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_corner()
    @ccall libp4est.p4est_connectivity_new_corner()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_pillow()
    @ccall libp4est.p4est_connectivity_new_pillow()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_moebius()
    @ccall libp4est.p4est_connectivity_new_moebius()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_star()
    @ccall libp4est.p4est_connectivity_new_star()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_cubed()
    @ccall libp4est.p4est_connectivity_new_cubed()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_disk_nonperiodic()
    @ccall libp4est.p4est_connectivity_new_disk_nonperiodic()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_disk(periodic_a, periodic_b)
    @ccall libp4est.p4est_connectivity_new_disk(periodic_a::Cint, periodic_b::Cint)::Ptr{p4est_connectivity_t}
end

# no prototype is found for this function at p4est_connectivity.h:475:23, please use with caution
function p4est_connectivity_new_icosahedron()
    ccall((:p4est_connectivity_new_icosahedron, libp4est), Ptr{p4est_connectivity_t}, ())
end

function p4est_connectivity_new_shell2d()
    @ccall libp4est.p4est_connectivity_new_shell2d()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_disk2d()
    @ccall libp4est.p4est_connectivity_new_disk2d()::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_brick(mi, ni, periodic_a, periodic_b)
    @ccall libp4est.p4est_connectivity_new_brick(mi::Cint, ni::Cint, periodic_a::Cint, periodic_b::Cint)::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_new_byname(name)
    @ccall libp4est.p4est_connectivity_new_byname(name::Cstring)::Ptr{p4est_connectivity_t}
end

function p4est_connectivity_refine(conn, num_per_edge)
    @ccall libp4est.p4est_connectivity_refine(conn::Ptr{p4est_connectivity_t}, num_per_edge::Cint)::Ptr{p4est_connectivity_t}
end

function p4est_expand_face_transform(iface, nface, ftransform)
    @ccall libp4est.p4est_expand_face_transform(iface::Cint, nface::Cint, ftransform::Ptr{Cint})::Cvoid
end

function p4est_find_face_transform(connectivity, itree, iface, ftransform)
    @ccall libp4est.p4est_find_face_transform(connectivity::Ptr{p4est_connectivity_t}, itree::p4est_topidx_t, iface::Cint, ftransform::Ptr{Cint})::p4est_topidx_t
end

function p4est_find_corner_transform(connectivity, itree, icorner, ci)
    @ccall libp4est.p4est_find_corner_transform(connectivity::Ptr{p4est_connectivity_t}, itree::p4est_topidx_t, icorner::Cint, ci::Ptr{p4est_corner_info_t})::Cvoid
end

function p4est_connectivity_complete(conn)
    @ccall libp4est.p4est_connectivity_complete(conn::Ptr{p4est_connectivity_t})::Cvoid
end

function p4est_connectivity_reduce(conn)
    @ccall libp4est.p4est_connectivity_reduce(conn::Ptr{p4est_connectivity_t})::Cvoid
end

function p4est_connectivity_permute(conn, perm, is_current_to_new)
    @ccall libp4est.p4est_connectivity_permute(conn::Ptr{p4est_connectivity_t}, perm::Ptr{sc_array_t}, is_current_to_new::Cint)::Cvoid
end

function p4est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)
    @ccall libp4est.p4est_connectivity_join_faces(conn::Ptr{p4est_connectivity_t}, tree_left::p4est_topidx_t, tree_right::p4est_topidx_t, face_left::Cint, face_right::Cint, orientation::Cint)::Cvoid
end

function p4est_connectivity_is_equivalent(conn1, conn2)
    @ccall libp4est.p4est_connectivity_is_equivalent(conn1::Ptr{p4est_connectivity_t}, conn2::Ptr{p4est_connectivity_t})::Cint
end

function p4est_corner_array_index(array, it)
    @ccall libp4est.p4est_corner_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_corner_transform_t}
end

function p4est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)
    @ccall libp4est.p4est_connectivity_read_inp_stream(stream::Ptr{Libc.FILE}, num_vertices::Ptr{p4est_topidx_t}, num_trees::Ptr{p4est_topidx_t}, vertices::Ptr{Cdouble}, tree_to_vertex::Ptr{p4est_topidx_t})::Cint
end

function p4est_connectivity_read_inp(filename)
    @ccall libp4est.p4est_connectivity_read_inp(filename::Cstring)::Ptr{p4est_connectivity_t}
end

struct p4est_quadrant_data
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{p4est_quadrant_data}, f::Symbol)
    f === :user_data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :user_long && return Ptr{Clong}(x + 0)
    f === :user_int && return Ptr{Cint}(x + 0)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :piggy1 && return Ptr{__JL_Ctag_234}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_235}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_236}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p4est_quadrant_data, f::Symbol)
    r = Ref{p4est_quadrant_data}(x)
    ptr = Base.unsafe_convert(Ptr{p4est_quadrant_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p4est_quadrant_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct p4est_quadrant
    x::p4est_qcoord_t
    y::p4est_qcoord_t
    level::Int8
    pad8::Int8
    pad16::Int16
    p::p4est_quadrant_data
end

const p4est_quadrant_t = p4est_quadrant

mutable struct p4est_tree
    quadrants::sc_array_t
    first_desc::p4est_quadrant_t
    last_desc::p4est_quadrant_t
    quadrants_offset::p4est_locidx_t
    quadrants_per_level::NTuple{31, p4est_locidx_t}
    maxlevel::Int8
    p4est_tree() = new()
end

const p4est_tree_t = p4est_tree

struct p4est_inspect
    use_balance_ranges::Cint
    use_balance_ranges_notify::Cint
    use_balance_verify::Cint
    balance_max_ranges::Cint
    balance_A_count_in::Csize_t
    balance_A_count_out::Csize_t
    balance_comm_sent::Csize_t
    balance_comm_nzpeers::Csize_t
    balance_B_count_in::Csize_t
    balance_B_count_out::Csize_t
    balance_zero_sends::NTuple{2, Csize_t}
    balance_zero_receives::NTuple{2, Csize_t}
    balance_A::Cdouble
    balance_comm::Cdouble
    balance_B::Cdouble
    balance_ranges::Cdouble
    balance_notify::Cdouble
    balance_notify_allgather::Cdouble
    use_B::Cint
end

const p4est_inspect_t = p4est_inspect

struct p4est
    mpicomm::sc_MPI_Comm
    mpisize::Cint
    mpirank::Cint
    mpicomm_owned::Cint
    data_size::Csize_t
    user_pointer::Ptr{Cvoid}
    revision::Clong
    first_local_tree::p4est_topidx_t
    last_local_tree::p4est_topidx_t
    local_num_quadrants::p4est_locidx_t
    global_num_quadrants::p4est_gloidx_t
    global_first_quadrant::Ptr{p4est_gloidx_t}
    global_first_position::Ptr{p4est_quadrant_t}
    connectivity::Ptr{p4est_connectivity_t}
    trees::Ptr{sc_array_t}
    user_data_pool::Ptr{sc_mempool_t}
    quadrant_pool::Ptr{sc_mempool_t}
    inspect::Ptr{p4est_inspect_t}
end

const p4est_t = p4est

function p4est_memory_used(p4est_)
    @ccall libp4est.p4est_memory_used(p4est_::Ptr{p4est_t})::Csize_t
end

function p4est_revision(p4est_)
    @ccall libp4est.p4est_revision(p4est_::Ptr{p4est_t})::Clong
end

# typedef void ( * p4est_init_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
const p4est_init_t = Ptr{Cvoid}

# typedef int ( * p4est_refine_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
const p4est_refine_t = Ptr{Cvoid}

# typedef int ( * p4est_coarsen_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrants [ ] )
const p4est_coarsen_t = Ptr{Cvoid}

# typedef int ( * p4est_weight_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
const p4est_weight_t = Ptr{Cvoid}

function p4est_qcoord_to_vertex(connectivity, treeid, x, y, vxyz)
    @ccall libp4est.p4est_qcoord_to_vertex(connectivity::Ptr{p4est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

function p4est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_new(mpicomm::sc_MPI_Comm, connectivity::Ptr{p4est_connectivity_t}, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p4est_t}
end

function p4est_destroy(p4est_)
    @ccall libp4est.p4est_destroy(p4est_::Ptr{p4est_t})::Cvoid
end

function p4est_copy(input, copy_data)
    @ccall libp4est.p4est_copy(input::Ptr{p4est_t}, copy_data::Cint)::Ptr{p4est_t}
end

function p4est_reset_data(p4est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_reset_data(p4est_::Ptr{p4est_t}, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

function p4est_refine(p4est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p4est_refine(p4est_::Ptr{p4est_t}, refine_recursive::Cint, refine_fn::p4est_refine_t, init_fn::p4est_init_t)::Cvoid
end

function p4est_coarsen(p4est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p4est_coarsen(p4est_::Ptr{p4est_t}, coarsen_recursive::Cint, coarsen_fn::p4est_coarsen_t, init_fn::p4est_init_t)::Cvoid
end

function p4est_balance(p4est_, btype, init_fn)
    @ccall libp4est.p4est_balance(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, init_fn::p4est_init_t)::Cvoid
end

function p4est_partition(p4est_, allow_for_coarsening, weight_fn)
    @ccall libp4est.p4est_partition(p4est_::Ptr{p4est_t}, allow_for_coarsening::Cint, weight_fn::p4est_weight_t)::Cvoid
end

function p4est_checksum(p4est_)
    @ccall libp4est.p4est_checksum(p4est_::Ptr{p4est_t})::Cuint
end

function p4est_checksum_partition(p4est_)
    @ccall libp4est.p4est_checksum_partition(p4est_::Ptr{p4est_t})::Cuint
end

function p4est_save(filename, p4est_, save_data)
    @ccall libp4est.p4est_save(filename::Cstring, p4est_::Ptr{p4est_t}, save_data::Cint)::Cvoid
end

function p4est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p4est_load(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

function p4est_tree_array_index(array, it)
    @ccall libp4est.p4est_tree_array_index(array::Ptr{sc_array_t}, it::p4est_topidx_t)::Ptr{p4est_tree_t}
end

function p4est_quadrant_array_index(array, it)
    @ccall libp4est.p4est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_quadrant_t}
end

function p4est_quadrant_array_push(array)
    @ccall libp4est.p4est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p4est_quadrant_t}
end

function p4est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p4est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p4est_quadrant_t}
end

function p4est_quadrant_list_pop(list)
    @ccall libp4est.p4est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p4est_quadrant_t}
end

mutable struct p4est_ghost_t
    mpisize::Cint
    num_trees::p4est_topidx_t
    btype::p4est_connect_type_t
    ghosts::sc_array_t
    tree_offsets::Ptr{p4est_locidx_t}
    proc_offsets::Ptr{p4est_locidx_t}
    mirrors::sc_array_t
    mirror_tree_offsets::Ptr{p4est_locidx_t}
    mirror_proc_mirrors::Ptr{p4est_locidx_t}
    mirror_proc_offsets::Ptr{p4est_locidx_t}
    mirror_proc_fronts::Ptr{p4est_locidx_t}
    mirror_proc_front_offsets::Ptr{p4est_locidx_t}
    p4est_ghost_t() = new()
end

function p4est_ghost_is_valid(p4est_, ghost)
    @ccall libp4est.p4est_ghost_is_valid(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cint
end

function p4est_ghost_memory_used(ghost)
    @ccall libp4est.p4est_ghost_memory_used(ghost::Ptr{p4est_ghost_t})::Csize_t
end

function p4est_quadrant_find_owner(p4est_, treeid, face, q)
    @ccall libp4est.p4est_quadrant_find_owner(p4est_::Ptr{p4est_t}, treeid::p4est_topidx_t, face::Cint, q::Ptr{p4est_quadrant_t})::Cint
end

function p4est_ghost_new(p4est_, btype)
    @ccall libp4est.p4est_ghost_new(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t)::Ptr{p4est_ghost_t}
end

function p4est_ghost_destroy(ghost)
    @ccall libp4est.p4est_ghost_destroy(ghost::Ptr{p4est_ghost_t})::Cvoid
end

function p4est_ghost_bsearch(ghost, which_proc, which_tree, q)
    @ccall libp4est.p4est_ghost_bsearch(ghost::Ptr{p4est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p4est_quadrant_t})::Cssize_t
end

function p4est_ghost_contains(ghost, which_proc, which_tree, q)
    @ccall libp4est.p4est_ghost_contains(ghost::Ptr{p4est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p4est_quadrant_t})::Cssize_t
end

function p4est_face_quadrant_exists(p4est_, ghost, treeid, q, face, hang, owner_rank)
    @ccall libp4est.p4est_face_quadrant_exists(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p4est_quadrant_t}, face::Ptr{Cint}, hang::Ptr{Cint}, owner_rank::Ptr{Cint})::p4est_locidx_t
end

function p4est_quadrant_exists(p4est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)
    @ccall libp4est.p4est_quadrant_exists(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p4est_quadrant_t}, exists_arr::Ptr{sc_array_t}, rproc_arr::Ptr{sc_array_t}, rquad_arr::Ptr{sc_array_t})::Cint
end

function p4est_is_balanced(p4est_, btype)
    @ccall libp4est.p4est_is_balanced(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t)::Cint
end

function p4est_ghost_checksum(p4est_, ghost)
    @ccall libp4est.p4est_ghost_checksum(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cuint
end

function p4est_ghost_exchange_data(p4est_, ghost, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_data(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, ghost_data::Ptr{Cvoid})::Cvoid
end

mutable struct p4est_ghost_exchange
    is_custom::Cint
    is_levels::Cint
    p4est::Ptr{p4est_t}
    ghost::Ptr{p4est_ghost_t}
    minlevel::Cint
    maxlevel::Cint
    data_size::Csize_t
    ghost_data::Ptr{Cvoid}
    qactive::Ptr{Cint}
    qbuffer::Ptr{Cint}
    requests::sc_array_t
    sbuffers::sc_array_t
    rrequests::sc_array_t
    rbuffers::sc_array_t
    p4est_ghost_exchange() = new()
end

const p4est_ghost_exchange_t = p4est_ghost_exchange

function p4est_ghost_exchange_data_begin(p4est_, ghost, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_data_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

function p4est_ghost_exchange_data_end(exc)
    @ccall libp4est.p4est_ghost_exchange_data_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

function p4est_ghost_exchange_custom(p4est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

function p4est_ghost_exchange_custom_begin(p4est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

function p4est_ghost_exchange_custom_end(exc)
    @ccall libp4est.p4est_ghost_exchange_custom_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

function p4est_ghost_exchange_custom_levels(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_levels(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

function p4est_ghost_exchange_custom_levels_begin(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_levels_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

function p4est_ghost_exchange_custom_levels_end(exc)
    @ccall libp4est.p4est_ghost_exchange_custom_levels_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

function p4est_ghost_expand(p4est_, ghost)
    @ccall libp4est.p4est_ghost_expand(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

mutable struct p4est_mesh_t
    local_num_quadrants::p4est_locidx_t
    ghost_num_quadrants::p4est_locidx_t
    quad_to_tree::Ptr{p4est_topidx_t}
    ghost_to_proc::Ptr{Cint}
    quad_to_quad::Ptr{p4est_locidx_t}
    quad_to_face::Ptr{Int8}
    quad_to_half::Ptr{sc_array_t}
    quad_level::Ptr{sc_array_t}
    local_num_corners::p4est_locidx_t
    quad_to_corner::Ptr{p4est_locidx_t}
    corner_offset::Ptr{sc_array_t}
    corner_quad::Ptr{sc_array_t}
    corner_corner::Ptr{sc_array_t}
    p4est_mesh_t() = new()
end

mutable struct p4est_mesh_face_neighbor_t
    p4est::Ptr{p4est_t}
    ghost::Ptr{p4est_ghost_t}
    mesh::Ptr{p4est_mesh_t}
    which_tree::p4est_topidx_t
    quadrant_id::p4est_locidx_t
    quadrant_code::p4est_locidx_t
    face::Cint
    subface::Cint
    current_qtq::p4est_locidx_t
    p4est_mesh_face_neighbor_t() = new()
end

function p4est_mesh_memory_used(mesh)
    @ccall libp4est.p4est_mesh_memory_used(mesh::Ptr{p4est_mesh_t})::Csize_t
end

function p4est_mesh_new(p4est_, ghost, btype)
    @ccall libp4est.p4est_mesh_new(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, btype::p4est_connect_type_t)::Ptr{p4est_mesh_t}
end

function p4est_mesh_destroy(mesh)
    @ccall libp4est.p4est_mesh_destroy(mesh::Ptr{p4est_mesh_t})::Cvoid
end

function p4est_mesh_get_quadrant(p4est_, mesh, qid)
    @ccall libp4est.p4est_mesh_get_quadrant(p4est_::Ptr{p4est_t}, mesh::Ptr{p4est_mesh_t}, qid::p4est_locidx_t)::Ptr{p4est_quadrant_t}
end

function p4est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)
    @ccall libp4est.p4est_mesh_get_neighbors(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, curr_quad_id::p4est_locidx_t, direction::p4est_locidx_t, neighboring_quads::Ptr{sc_array_t}, neighboring_encs::Ptr{sc_array_t}, neighboring_qids::Ptr{sc_array_t})::p4est_locidx_t
end

function p4est_mesh_quadrant_cumulative(p4est_, mesh, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p4est_mesh_quadrant_cumulative(p4est_::Ptr{p4est_t}, mesh::Ptr{p4est_mesh_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p4est_quadrant_t}
end

function p4est_mesh_face_neighbor_init2(mfn, p4est_, ghost, mesh, which_tree, quadrant_id)
    @ccall libp4est.p4est_mesh_face_neighbor_init2(mfn::Ptr{p4est_mesh_face_neighbor_t}, p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, which_tree::p4est_topidx_t, quadrant_id::p4est_locidx_t)::Cvoid
end

function p4est_mesh_face_neighbor_init(mfn, p4est_, ghost, mesh, which_tree, quadrant)
    @ccall libp4est.p4est_mesh_face_neighbor_init(mfn::Ptr{p4est_mesh_face_neighbor_t}, p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, which_tree::p4est_topidx_t, quadrant::Ptr{p4est_quadrant_t})::Cvoid
end

function p4est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)
    @ccall libp4est.p4est_mesh_face_neighbor_next(mfn::Ptr{p4est_mesh_face_neighbor_t}, ntree::Ptr{p4est_topidx_t}, nquad::Ptr{p4est_locidx_t}, nface::Ptr{Cint}, nrank::Ptr{Cint})::Ptr{p4est_quadrant_t}
end

function p4est_mesh_face_neighbor_data(mfn, ghost_data)
    @ccall libp4est.p4est_mesh_face_neighbor_data(mfn::Ptr{p4est_mesh_face_neighbor_t}, ghost_data::Ptr{Cvoid})::Ptr{Cvoid}
end

mutable struct p4est_iter_volume_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
    treeid::p4est_topidx_t
    p4est_iter_volume_info() = new()
end

const p4est_iter_volume_info_t = p4est_iter_volume_info

# typedef void ( * p4est_iter_volume_t ) ( p4est_iter_volume_info_t * info , void * user_data )
const p4est_iter_volume_t = Ptr{Cvoid}

struct p4est_iter_face_side_data
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{p4est_iter_face_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_247}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_248}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p4est_iter_face_side_data, f::Symbol)
    r = Ref{p4est_iter_face_side_data}(x)
    ptr = Base.unsafe_convert(Ptr{p4est_iter_face_side_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p4est_iter_face_side_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct p4est_iter_face_side
    treeid::p4est_topidx_t
    face::Int8
    is_hanging::Int8
    is::p4est_iter_face_side_data
    p4est_iter_face_side() = new()
end

const p4est_iter_face_side_t = p4est_iter_face_side

mutable struct p4est_iter_face_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    orientation::Int8
    tree_boundary::Int8
    sides::sc_array_t
    p4est_iter_face_info() = new()
end

const p4est_iter_face_info_t = p4est_iter_face_info

# typedef void ( * p4est_iter_face_t ) ( p4est_iter_face_info_t * info , void * user_data )
const p4est_iter_face_t = Ptr{Cvoid}

mutable struct p4est_iter_corner_side
    treeid::p4est_topidx_t
    corner::Int8
    is_ghost::Int8
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
    faces::NTuple{2, Int8}
    p4est_iter_corner_side() = new()
end

const p4est_iter_corner_side_t = p4est_iter_corner_side

mutable struct p4est_iter_corner_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
    p4est_iter_corner_info() = new()
end

const p4est_iter_corner_info_t = p4est_iter_corner_info

# typedef void ( * p4est_iter_corner_t ) ( p4est_iter_corner_info_t * info , void * user_data )
const p4est_iter_corner_t = Ptr{Cvoid}

function p4est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner)
    @ccall libp4est.p4est_iterate(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p4est_iter_volume_t, iter_face::p4est_iter_face_t, iter_corner::p4est_iter_corner_t)::Cvoid
end

function p4est_iter_cside_array_index_int(array, it)
    @ccall libp4est.p4est_iter_cside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_iter_corner_side_t}
end

function p4est_iter_cside_array_index(array, it)
    @ccall libp4est.p4est_iter_cside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_iter_corner_side_t}
end

function p4est_iter_fside_array_index_int(array, it)
    @ccall libp4est.p4est_iter_fside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_iter_face_side_t}
end

function p4est_iter_fside_array_index(array, it)
    @ccall libp4est.p4est_iter_fside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_iter_face_side_t}
end

const p4est_lnodes_code_t = Int8

mutable struct p4est_lnodes
    mpicomm::sc_MPI_Comm
    num_local_nodes::p4est_locidx_t
    owned_count::p4est_locidx_t
    global_offset::p4est_gloidx_t
    nonlocal_nodes::Ptr{p4est_gloidx_t}
    sharers::Ptr{sc_array_t}
    global_owned_count::Ptr{p4est_locidx_t}
    degree::Cint
    vnodes::Cint
    num_local_elements::p4est_locidx_t
    face_code::Ptr{p4est_lnodes_code_t}
    element_nodes::Ptr{p4est_locidx_t}
    p4est_lnodes() = new()
end

const p4est_lnodes_t = p4est_lnodes

mutable struct p4est_lnodes_rank
    rank::Cint
    shared_nodes::sc_array_t
    shared_mine_offset::p4est_locidx_t
    shared_mine_count::p4est_locidx_t
    owned_offset::p4est_locidx_t
    owned_count::p4est_locidx_t
    p4est_lnodes_rank() = new()
end

const p4est_lnodes_rank_t = p4est_lnodes_rank

function p4est_lnodes_decode(face_code, hanging_face)
    @ccall libp4est.p4est_lnodes_decode(face_code::p4est_lnodes_code_t, hanging_face::Ptr{Cint})::Cint
end

function p4est_lnodes_new(p4est_, ghost_layer, degree)
    @ccall libp4est.p4est_lnodes_new(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, degree::Cint)::Ptr{p4est_lnodes_t}
end

function p4est_lnodes_destroy(lnodes)
    @ccall libp4est.p4est_lnodes_destroy(lnodes::Ptr{p4est_lnodes_t})::Cvoid
end

function p4est_ghost_support_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p4est_ghost_support_lnodes(p4est_::Ptr{p4est_t}, lnodes::Ptr{p4est_lnodes_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

function p4est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p4est_ghost_expand_by_lnodes(p4est_::Ptr{p4est_t}, lnodes::Ptr{p4est_lnodes_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

function p4est_partition_lnodes(p4est_, ghost, degree, partition_for_coarsening)
    @ccall libp4est.p4est_partition_lnodes(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, degree::Cint, partition_for_coarsening::Cint)::Cvoid
end

function p4est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_corner, partition_for_coarsening)
    @ccall libp4est.p4est_partition_lnodes_detailed(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, nodes_per_volume::Cint, nodes_per_face::Cint, nodes_per_corner::Cint, partition_for_coarsening::Cint)::Cvoid
end

mutable struct p4est_lnodes_buffer
    requests::Ptr{sc_array_t}
    send_buffers::Ptr{sc_array_t}
    recv_buffers::Ptr{sc_array_t}
    p4est_lnodes_buffer() = new()
end

const p4est_lnodes_buffer_t = p4est_lnodes_buffer

function p4est_lnodes_share_owned_begin(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_owned_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

function p4est_lnodes_share_owned_end(buffer)
    @ccall libp4est.p4est_lnodes_share_owned_end(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

function p4est_lnodes_share_owned(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_owned(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Cvoid
end

function p4est_lnodes_share_all_begin(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_all_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

function p4est_lnodes_share_all_end(buffer)
    @ccall libp4est.p4est_lnodes_share_all_end(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

function p4est_lnodes_share_all(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_all(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

function p4est_lnodes_buffer_destroy(buffer)
    @ccall libp4est.p4est_lnodes_buffer_destroy(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

function p4est_lnodes_rank_array_index_int(array, it)
    @ccall libp4est.p4est_lnodes_rank_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_lnodes_rank_t}
end

function p4est_lnodes_rank_array_index(array, it)
    @ccall libp4est.p4est_lnodes_rank_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_lnodes_rank_t}
end

function p4est_lnodes_global_index(lnodes, lidx)
    @ccall libp4est.p4est_lnodes_global_index(lnodes::Ptr{p4est_lnodes_t}, lidx::p4est_locidx_t)::p4est_gloidx_t
end

const p4est_lid_t = UInt64

# typedef void ( * p4est_replace_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , int num_outgoing , p4est_quadrant_t * outgoing [ ] , int num_incoming , p4est_quadrant_t * incoming [ ] )
const p4est_replace_t = Ptr{Cvoid}

function p4est_lid_compare(a, b)
    @ccall libp4est.p4est_lid_compare(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cint
end

function p4est_lid_is_equal(a, b)
    @ccall libp4est.p4est_lid_is_equal(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cint
end

function p4est_lid_init(input, high, low)
    @ccall libp4est.p4est_lid_init(input::Ptr{p4est_lid_t}, high::UInt64, low::UInt64)::Cvoid
end

function p4est_lid_set_zero(input)
    @ccall libp4est.p4est_lid_set_zero(input::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_set_one(input)
    @ccall libp4est.p4est_lid_set_one(input::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_set_uint64(input, u)
    @ccall libp4est.p4est_lid_set_uint64(input::Ptr{p4est_lid_t}, u::UInt64)::Cvoid
end

function p4est_lid_chk_bit(input, bit_number)
    @ccall libp4est.p4est_lid_chk_bit(input::Ptr{p4est_lid_t}, bit_number::Cint)::Cint
end

function p4est_lid_set_bit(input, bit_number)
    @ccall libp4est.p4est_lid_set_bit(input::Ptr{p4est_lid_t}, bit_number::Cint)::Cvoid
end

function p4est_lid_copy(input, output)
    @ccall libp4est.p4est_lid_copy(input::Ptr{p4est_lid_t}, output::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_add(a, b, result)
    @ccall libp4est.p4est_lid_add(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_sub(a, b, result)
    @ccall libp4est.p4est_lid_sub(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_bitwise_neg(a, result)
    @ccall libp4est.p4est_lid_bitwise_neg(a::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_bitwise_or(a, b, result)
    @ccall libp4est.p4est_lid_bitwise_or(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_bitwise_and(a, b, result)
    @ccall libp4est.p4est_lid_bitwise_and(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_shift_right(input, shift_count, result)
    @ccall libp4est.p4est_lid_shift_right(input::Ptr{p4est_lid_t}, shift_count::Cuint, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_shift_left(input, shift_count, result)
    @ccall libp4est.p4est_lid_shift_left(input::Ptr{p4est_lid_t}, shift_count::Cuint, result::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_add_inplace(a, b)
    @ccall libp4est.p4est_lid_add_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_sub_inplace(a, b)
    @ccall libp4est.p4est_lid_sub_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_bitwise_or_inplace(a, b)
    @ccall libp4est.p4est_lid_bitwise_or_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

function p4est_lid_bitwise_and_inplace(a, b)
    @ccall libp4est.p4est_lid_bitwise_and_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

function p4est_quadrant_linear_id_ext128(quadrant, level, id)
    @ccall libp4est.p4est_quadrant_linear_id_ext128(quadrant::Ptr{p4est_quadrant_t}, level::Cint, id::Ptr{p4est_lid_t})::Cvoid
end

function p4est_quadrant_set_morton_ext128(quadrant, level, id)
    @ccall libp4est.p4est_quadrant_set_morton_ext128(quadrant::Ptr{p4est_quadrant_t}, level::Cint, id::Ptr{p4est_lid_t})::Cvoid
end

function p4est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_new_ext(mpicomm::sc_MPI_Comm, connectivity::Ptr{p4est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p4est_t}
end

function p4est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)
    @ccall libp4est.p4est_mesh_new_ext(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, compute_tree_index::Cint, compute_level_lists::Cint, btype::p4est_connect_type_t)::Ptr{p4est_mesh_t}
end

function p4est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p4est_copy_ext(input::Ptr{p4est_t}, copy_data::Cint, duplicate_mpicomm::Cint)::Ptr{p4est_t}
end

function p4est_refine_ext(p4est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p4est_refine_ext(p4est_::Ptr{p4est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p4est_refine_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

function p4est_coarsen_ext(p4est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p4est_coarsen_ext(p4est_::Ptr{p4est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p4est_coarsen_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

function p4est_balance_ext(p4est_, btype, init_fn, replace_fn)
    @ccall libp4est.p4est_balance_ext(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

function p4est_balance_subtree_ext(p4est_, btype, which_tree, init_fn, replace_fn)
    @ccall libp4est.p4est_balance_subtree_ext(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, which_tree::p4est_topidx_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

function p4est_partition_ext(p4est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p4est_partition_ext(p4est_::Ptr{p4est_t}, partition_for_coarsening::Cint, weight_fn::p4est_weight_t)::p4est_gloidx_t
end

function p4est_partition_for_coarsening(p4est_, num_quadrants_in_proc)
    @ccall libp4est.p4est_partition_for_coarsening(p4est_::Ptr{p4est_t}, num_quadrants_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

function p4est_iterate_ext(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner, remote)
    @ccall libp4est.p4est_iterate_ext(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p4est_iter_volume_t, iter_face::p4est_iter_face_t, iter_corner::p4est_iter_corner_t, remote::Cint)::Cvoid
end

function p4est_save_ext(filename, p4est_, save_data, save_partition)
    @ccall libp4est.p4est_save_ext(filename::Cstring, p4est_::Ptr{p4est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

function p4est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p4est_load_ext(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

function p4est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p4est_source_ext(src::Ptr{sc_io_source_t}, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

function p4est_get_plex_data_ext(p4est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)
    @ccall libp4est.p4est_get_plex_data_ext(p4est_::Ptr{p4est_t}, ghost::Ptr{Ptr{p4est_ghost_t}}, lnodes::Ptr{Ptr{p4est_lnodes_t}}, ctype::p4est_connect_type_t, overlap::Cint, first_local_quad::Ptr{p4est_locidx_t}, out_points_per_dim::Ptr{sc_array_t}, out_cone_sizes::Ptr{sc_array_t}, out_cones::Ptr{sc_array_t}, out_cone_orientations::Ptr{sc_array_t}, out_vertex_coords::Ptr{sc_array_t}, out_children::Ptr{sc_array_t}, out_parents::Ptr{sc_array_t}, out_childids::Ptr{sc_array_t}, out_leaves::Ptr{sc_array_t}, out_remotes::Ptr{sc_array_t}, custom_numbering::Cint)::Cvoid
end

@enum p8est_connect_type_t::UInt32 begin
    P8EST_CONNECT_FACE = 31
    P8EST_CONNECT_EDGE = 32
    P8EST_CONNECT_CORNER = 33
    # P8EST_CONNECT_FULL = 33
end

@enum p8est_connectivity_encode_t::UInt32 begin
    P8EST_CONN_ENCODE_NONE = 0
    P8EST_CONN_ENCODE_LAST = 1
end

function p8est_connect_type_int(btype)
    @ccall libp4est.p8est_connect_type_int(btype::p8est_connect_type_t)::Cint
end

function p8est_connect_type_string(btype)
    @ccall libp4est.p8est_connect_type_string(btype::p8est_connect_type_t)::Cstring
end

struct p8est_connectivity
    num_vertices::p4est_topidx_t
    num_trees::p4est_topidx_t
    num_edges::p4est_topidx_t
    num_corners::p4est_topidx_t
    vertices::Ptr{Cdouble}
    tree_to_vertex::Ptr{p4est_topidx_t}
    tree_attr_bytes::Csize_t
    tree_to_attr::Cstring
    tree_to_tree::Ptr{p4est_topidx_t}
    tree_to_face::Ptr{Int8}
    tree_to_edge::Ptr{p4est_topidx_t}
    ett_offset::Ptr{p4est_topidx_t}
    edge_to_tree::Ptr{p4est_topidx_t}
    edge_to_edge::Ptr{Int8}
    tree_to_corner::Ptr{p4est_topidx_t}
    ctt_offset::Ptr{p4est_topidx_t}
    corner_to_tree::Ptr{p4est_topidx_t}
    corner_to_corner::Ptr{Int8}
end

const p8est_connectivity_t = p8est_connectivity

function p8est_connectivity_memory_used(conn)
    @ccall libp4est.p8est_connectivity_memory_used(conn::Ptr{p8est_connectivity_t})::Csize_t
end

mutable struct p8est_edge_transform_t
    ntree::p4est_topidx_t
    nedge::Int8
    naxis::NTuple{3, Int8}
    nflip::Int8
    corners::Int8
    p8est_edge_transform_t() = new()
end

mutable struct p8est_edge_info_t
    iedge::Int8
    edge_transforms::sc_array_t
    p8est_edge_info_t() = new()
end

mutable struct p8est_corner_transform_t
    ntree::p4est_topidx_t
    ncorner::Int8
    p8est_corner_transform_t() = new()
end

mutable struct p8est_corner_info_t
    icorner::p4est_topidx_t
    corner_transforms::sc_array_t
    p8est_corner_info_t() = new()
end

function p8est_connectivity_face_neighbor_corner_set(c, f, nf, set)
    @ccall libp4est.p8est_connectivity_face_neighbor_corner_set(c::Cint, f::Cint, nf::Cint, set::Cint)::Cint
end

function p8est_connectivity_face_neighbor_face_corner(fc, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_face_corner(fc::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p8est_connectivity_face_neighbor_corner(c, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_corner(c::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p8est_connectivity_face_neighbor_face_edge(fe, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_face_edge(fe::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p8est_connectivity_face_neighbor_edge(e, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_edge(e::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

function p8est_connectivity_edge_neighbor_edge_corner(ec, o)
    @ccall libp4est.p8est_connectivity_edge_neighbor_edge_corner(ec::Cint, o::Cint)::Cint
end

function p8est_connectivity_edge_neighbor_corner(c, e, ne, o)
    @ccall libp4est.p8est_connectivity_edge_neighbor_corner(c::Cint, e::Cint, ne::Cint, o::Cint)::Cint
end

function p8est_connectivity_new(num_vertices, num_trees, num_edges, num_ett, num_corners, num_ctt)
    @ccall libp4est.p8est_connectivity_new(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_edges::p4est_topidx_t, num_ett::p4est_topidx_t, num_corners::p4est_topidx_t, num_ctt::p4est_topidx_t)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_copy(num_vertices, num_trees, num_edges, num_corners, vertices, ttv, ttt, ttf, tte, eoff, ett, ete, ttc, coff, ctt, ctc)
    @ccall libp4est.p8est_connectivity_new_copy(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_edges::p4est_topidx_t, num_corners::p4est_topidx_t, vertices::Ptr{Cdouble}, ttv::Ptr{p4est_topidx_t}, ttt::Ptr{p4est_topidx_t}, ttf::Ptr{Int8}, tte::Ptr{p4est_topidx_t}, eoff::Ptr{p4est_topidx_t}, ett::Ptr{p4est_topidx_t}, ete::Ptr{Int8}, ttc::Ptr{p4est_topidx_t}, coff::Ptr{p4est_topidx_t}, ctt::Ptr{p4est_topidx_t}, ctc::Ptr{Int8})::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_bcast(conn_in, root, comm)
    @ccall libp4est.p8est_connectivity_bcast(conn_in::Ptr{p8est_connectivity_t}, root::Cint, comm::sc_MPI_Comm)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_destroy(connectivity)
    @ccall libp4est.p8est_connectivity_destroy(connectivity::Ptr{p8est_connectivity_t})::Cvoid
end

function p8est_connectivity_set_attr(conn, bytes_per_tree)
    @ccall libp4est.p8est_connectivity_set_attr(conn::Ptr{p8est_connectivity_t}, bytes_per_tree::Csize_t)::Cvoid
end

function p8est_connectivity_is_valid(connectivity)
    @ccall libp4est.p8est_connectivity_is_valid(connectivity::Ptr{p8est_connectivity_t})::Cint
end

function p8est_connectivity_is_equal(conn1, conn2)
    @ccall libp4est.p8est_connectivity_is_equal(conn1::Ptr{p8est_connectivity_t}, conn2::Ptr{p8est_connectivity_t})::Cint
end

function p8est_connectivity_sink(conn, sink)
    @ccall libp4est.p8est_connectivity_sink(conn::Ptr{p8est_connectivity_t}, sink::Ptr{sc_io_sink_t})::Cint
end

function p8est_connectivity_deflate(conn, code)
    @ccall libp4est.p8est_connectivity_deflate(conn::Ptr{p8est_connectivity_t}, code::p8est_connectivity_encode_t)::Ptr{sc_array_t}
end

function p8est_connectivity_save(filename, connectivity)
    @ccall libp4est.p8est_connectivity_save(filename::Cstring, connectivity::Ptr{p8est_connectivity_t})::Cint
end

function p8est_connectivity_source(source)
    @ccall libp4est.p8est_connectivity_source(source::Ptr{sc_io_source_t})::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_inflate(buffer)
    @ccall libp4est.p8est_connectivity_inflate(buffer::Ptr{sc_array_t})::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_load(filename, bytes)
    @ccall libp4est.p8est_connectivity_load(filename::Cstring, bytes::Ptr{Csize_t})::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_unitcube()
    @ccall libp4est.p8est_connectivity_new_unitcube()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_periodic()
    @ccall libp4est.p8est_connectivity_new_periodic()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_rotwrap()
    @ccall libp4est.p8est_connectivity_new_rotwrap()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_twocubes()
    @ccall libp4est.p8est_connectivity_new_twocubes()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_twotrees(l_face, r_face, orientation)
    @ccall libp4est.p8est_connectivity_new_twotrees(l_face::Cint, r_face::Cint, orientation::Cint)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_twowrap()
    @ccall libp4est.p8est_connectivity_new_twowrap()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_rotcubes()
    @ccall libp4est.p8est_connectivity_new_rotcubes()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_brick(m, n, p, periodic_a, periodic_b, periodic_c)
    @ccall libp4est.p8est_connectivity_new_brick(m::Cint, n::Cint, p::Cint, periodic_a::Cint, periodic_b::Cint, periodic_c::Cint)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_shell()
    @ccall libp4est.p8est_connectivity_new_shell()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_sphere()
    @ccall libp4est.p8est_connectivity_new_sphere()::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_torus(nSegments)
    @ccall libp4est.p8est_connectivity_new_torus(nSegments::Cint)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_new_byname(name)
    @ccall libp4est.p8est_connectivity_new_byname(name::Cstring)::Ptr{p8est_connectivity_t}
end

function p8est_connectivity_refine(conn, num_per_edge)
    @ccall libp4est.p8est_connectivity_refine(conn::Ptr{p8est_connectivity_t}, num_per_edge::Cint)::Ptr{p8est_connectivity_t}
end

function p8est_expand_face_transform(iface, nface, ftransform)
    @ccall libp4est.p8est_expand_face_transform(iface::Cint, nface::Cint, ftransform::Ptr{Cint})::Cvoid
end

function p8est_find_face_transform(connectivity, itree, iface, ftransform)
    @ccall libp4est.p8est_find_face_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, iface::Cint, ftransform::Ptr{Cint})::p4est_topidx_t
end

function p8est_find_edge_transform(connectivity, itree, iedge, ei)
    @ccall libp4est.p8est_find_edge_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, iedge::Cint, ei::Ptr{p8est_edge_info_t})::Cvoid
end

function p8est_find_corner_transform(connectivity, itree, icorner, ci)
    @ccall libp4est.p8est_find_corner_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, icorner::Cint, ci::Ptr{p8est_corner_info_t})::Cvoid
end

function p8est_connectivity_complete(conn)
    @ccall libp4est.p8est_connectivity_complete(conn::Ptr{p8est_connectivity_t})::Cvoid
end

function p8est_connectivity_reduce(conn)
    @ccall libp4est.p8est_connectivity_reduce(conn::Ptr{p8est_connectivity_t})::Cvoid
end

function p8est_connectivity_permute(conn, perm, is_current_to_new)
    @ccall libp4est.p8est_connectivity_permute(conn::Ptr{p8est_connectivity_t}, perm::Ptr{sc_array_t}, is_current_to_new::Cint)::Cvoid
end

function p8est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)
    @ccall libp4est.p8est_connectivity_join_faces(conn::Ptr{p8est_connectivity_t}, tree_left::p4est_topidx_t, tree_right::p4est_topidx_t, face_left::Cint, face_right::Cint, orientation::Cint)::Cvoid
end

function p8est_connectivity_is_equivalent(conn1, conn2)
    @ccall libp4est.p8est_connectivity_is_equivalent(conn1::Ptr{p8est_connectivity_t}, conn2::Ptr{p8est_connectivity_t})::Cint
end

function p8est_edge_array_index(array, it)
    @ccall libp4est.p8est_edge_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_edge_transform_t}
end

function p8est_corner_array_index(array, it)
    @ccall libp4est.p8est_corner_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_corner_transform_t}
end

function p8est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)
    @ccall libp4est.p8est_connectivity_read_inp_stream(stream::Ptr{Libc.FILE}, num_vertices::Ptr{p4est_topidx_t}, num_trees::Ptr{p4est_topidx_t}, vertices::Ptr{Cdouble}, tree_to_vertex::Ptr{p4est_topidx_t})::Cint
end

function p8est_connectivity_read_inp(filename)
    @ccall libp4est.p8est_connectivity_read_inp(filename::Cstring)::Ptr{p8est_connectivity_t}
end

struct p6est_connectivity
    conn4::Ptr{p4est_connectivity_t}
    top_vertices::Ptr{Cdouble}
    height::NTuple{3, Cdouble}
end

const p6est_connectivity_t = p6est_connectivity

function p6est_connectivity_new(conn4, top_vertices, height)
    @ccall libp4est.p6est_connectivity_new(conn4::Ptr{p4est_connectivity_t}, top_vertices::Ptr{Cdouble}, height::Ptr{Cdouble})::Ptr{p6est_connectivity_t}
end

function p6est_connectivity_destroy(conn)
    @ccall libp4est.p6est_connectivity_destroy(conn::Ptr{p6est_connectivity_t})::Cvoid
end

function p6est_tree_get_vertices(conn, which_tree, vertices)
    @ccall libp4est.p6est_tree_get_vertices(conn::Ptr{p6est_connectivity_t}, which_tree::p4est_topidx_t, vertices::Ptr{Cdouble})::Cvoid
end

function p6est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)
    @ccall libp4est.p6est_qcoord_to_vertex(connectivity::Ptr{p6est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, z::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

struct p6est_quadrant_data
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{p6est_quadrant_data}, f::Symbol)
    f === :user_data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :user_long && return Ptr{Clong}(x + 0)
    f === :user_int && return Ptr{Cint}(x + 0)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :piggy1 && return Ptr{__JL_Ctag_237}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_238}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_239}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p6est_quadrant_data, f::Symbol)
    r = Ref{p6est_quadrant_data}(x)
    ptr = Base.unsafe_convert(Ptr{p6est_quadrant_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p6est_quadrant_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct p2est_quadrant
    z::p4est_qcoord_t
    level::Int8
    pad8::Int8
    pad16::Int16
    p::p6est_quadrant_data
    p2est_quadrant() = new()
end

const p2est_quadrant_t = p2est_quadrant

mutable struct p6est
    mpicomm::sc_MPI_Comm
    mpisize::Cint
    mpirank::Cint
    mpicomm_owned::Cint
    data_size::Csize_t
    user_pointer::Ptr{Cvoid}
    connectivity::Ptr{p6est_connectivity_t}
    columns::Ptr{p4est_t}
    layers::Ptr{sc_array_t}
    user_data_pool::Ptr{sc_mempool_t}
    layer_pool::Ptr{sc_mempool_t}
    global_first_layer::Ptr{p4est_gloidx_t}
    root_len::p4est_qcoord_t
    p6est() = new()
end

const p6est_t = p6est

# typedef void ( * p6est_init_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
const p6est_init_t = Ptr{Cvoid}

# typedef void ( * p6est_replace_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , int num_outcolumns , int num_outlayers , p4est_quadrant_t * outcolumns [ ] , p2est_quadrant_t * outlayers [ ] , int num_incolumns , int num_inlayers , p4est_quadrant_t * incolumns [ ] , p2est_quadrant_t * inlayers [ ] )
const p6est_replace_t = Ptr{Cvoid}

# typedef int ( * p6est_refine_column_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column )
const p6est_refine_column_t = Ptr{Cvoid}

# typedef int ( * p6est_refine_layer_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
const p6est_refine_layer_t = Ptr{Cvoid}

# typedef int ( * p6est_coarsen_column_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * columns [ ] )
const p6est_coarsen_column_t = Ptr{Cvoid}

# typedef int ( * p6est_coarsen_layer_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layers [ ] )
const p6est_coarsen_layer_t = Ptr{Cvoid}

# typedef int ( * p6est_weight_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
const p6est_weight_t = Ptr{Cvoid}

function p6est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new(mpicomm::sc_MPI_Comm, connectivity::Ptr{p6est_connectivity_t}, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

function p6est_new_from_p4est(p4est_, top_vertices, height, min_zlevel, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new_from_p4est(p4est_::Ptr{p4est_t}, top_vertices::Ptr{Cdouble}, height::Ptr{Cdouble}, min_zlevel::Cint, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

function p6est_destroy(p6est_)
    @ccall libp4est.p6est_destroy(p6est_::Ptr{p6est_t})::Cvoid
end

function p6est_copy(input, copy_data)
    @ccall libp4est.p6est_copy(input::Ptr{p6est_t}, copy_data::Cint)::Ptr{p6est_t}
end

function p6est_reset_data(p6est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_reset_data(p6est_::Ptr{p6est_t}, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

function p6est_refine_columns(p6est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p6est_refine_columns(p6est_::Ptr{p6est_t}, refine_recursive::Cint, refine_fn::p6est_refine_column_t, init_fn::p6est_init_t)::Cvoid
end

function p6est_refine_layers(p6est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p6est_refine_layers(p6est_::Ptr{p6est_t}, refine_recursive::Cint, refine_fn::p6est_refine_layer_t, init_fn::p6est_init_t)::Cvoid
end

function p6est_coarsen_columns(p6est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p6est_coarsen_columns(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, coarsen_fn::p6est_coarsen_column_t, init_fn::p6est_init_t)::Cvoid
end

function p6est_coarsen_layers(p6est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p6est_coarsen_layers(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, coarsen_fn::p6est_coarsen_layer_t, init_fn::p6est_init_t)::Cvoid
end

function p6est_balance(p6est_, btype, init_fn)
    @ccall libp4est.p6est_balance(p6est_::Ptr{p6est_t}, btype::p8est_connect_type_t, init_fn::p6est_init_t)::Cvoid
end

@enum p6est_comm_tag_t::UInt32 begin
    P6EST_COMM_PARTITION = 1
    P6EST_COMM_GHOST = 2
    P6EST_COMM_BALANCE = 3
end

function p6est_partition(p6est_, weight_fn)
    @ccall libp4est.p6est_partition(p6est_::Ptr{p6est_t}, weight_fn::p6est_weight_t)::p4est_gloidx_t
end

function p6est_partition_correct(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_correct(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

function p6est_partition_to_p4est_partition(p6est_, num_layers_in_proc, num_columns_in_proc)
    @ccall libp4est.p6est_partition_to_p4est_partition(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t}, num_columns_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

function p4est_partition_to_p6est_partition(p6est_, num_columns_in_proc, num_layers_in_proc)
    @ccall libp4est.p4est_partition_to_p6est_partition(p6est_::Ptr{p6est_t}, num_columns_in_proc::Ptr{p4est_locidx_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

function p6est_partition_for_coarsening(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_for_coarsening(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

function p6est_partition_given(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_given(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

function p6est_checksum(p6est_)
    @ccall libp4est.p6est_checksum(p6est_::Ptr{p6est_t})::Cuint
end

function p6est_save(filename, p6est_, save_data)
    @ccall libp4est.p6est_save(filename::Cstring, p6est_::Ptr{p6est_t}, save_data::Cint)::Cvoid
end

function p6est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p6est_load(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p6est_connectivity_t}})::Ptr{p6est_t}
end

function p2est_quadrant_array_index(array, it)
    @ccall libp4est.p2est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p2est_quadrant_t}
end

function p2est_quadrant_array_push(array)
    @ccall libp4est.p2est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p2est_quadrant_t}
end

function p2est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p2est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p2est_quadrant_t}
end

function p2est_quadrant_list_pop(list)
    @ccall libp4est.p2est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p2est_quadrant_t}
end

function p6est_layer_init_data(p6est_, which_tree, column, layer, init_fn)
    @ccall libp4est.p6est_layer_init_data(p6est_::Ptr{p6est_t}, which_tree::p4est_topidx_t, column::Ptr{p4est_quadrant_t}, layer::Ptr{p2est_quadrant_t}, init_fn::p6est_init_t)::Cvoid
end

function p6est_layer_free_data(p6est_, layer)
    @ccall libp4est.p6est_layer_free_data(p6est_::Ptr{p6est_t}, layer::Ptr{p2est_quadrant_t})::Cvoid
end

function p6est_compress_columns(p6est_)
    @ccall libp4est.p6est_compress_columns(p6est_::Ptr{p6est_t})::Cvoid
end

function p6est_update_offsets(p6est_)
    @ccall libp4est.p6est_update_offsets(p6est_::Ptr{p6est_t})::Cvoid
end

function p6est_new_ext(mpicomm, connectivity, min_quadrants, min_level, min_zlevel, num_zroot, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new_ext(mpicomm::sc_MPI_Comm, connectivity::Ptr{p6est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, min_zlevel::Cint, num_zroot::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

function p6est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p6est_copy_ext(input::Ptr{p6est_t}, copy_data::Cint, duplicate_mpicomm::Cint)::Ptr{p6est_t}
end

function p6est_save_ext(filename, p6est_, save_data, save_partition)
    @ccall libp4est.p6est_save_ext(filename::Cstring, p6est_::Ptr{p6est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

function p6est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p6est_load_ext(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p6est_connectivity_t}})::Ptr{p6est_t}
end

function p6est_refine_columns_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_refine_columns_ext(p6est_::Ptr{p6est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p6est_refine_column_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

function p6est_refine_layers_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_refine_layers_ext(p6est_::Ptr{p6est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p6est_refine_layer_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

function p6est_coarsen_columns_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_coarsen_columns_ext(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p6est_coarsen_column_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

function p6est_coarsen_layers_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_coarsen_layers_ext(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p6est_coarsen_layer_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

function p6est_partition_ext(p6est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p6est_partition_ext(p6est_::Ptr{p6est_t}, partition_for_coarsening::Cint, weight_fn::p6est_weight_t)::p4est_gloidx_t
end

function p6est_balance_ext(p6est_, btype, max_diff, min_diff, init_fn, replace_fn)
    @ccall libp4est.p6est_balance_ext(p6est_::Ptr{p6est_t}, btype::p8est_connect_type_t, max_diff::Cint, min_diff::Cint, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

struct p8est_quadrant_data
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{p8est_quadrant_data}, f::Symbol)
    f === :user_data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :user_long && return Ptr{Clong}(x + 0)
    f === :user_int && return Ptr{Cint}(x + 0)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :piggy1 && return Ptr{__JL_Ctag_240}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_241}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_242}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_quadrant_data, f::Symbol)
    r = Ref{p8est_quadrant_data}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_quadrant_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_quadrant_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct p8est_quadrant
    x::p4est_qcoord_t
    y::p4est_qcoord_t
    z::p4est_qcoord_t
    level::Int8
    pad8::Int8
    pad16::Int16
    p::p8est_quadrant_data
end

const p8est_quadrant_t = p8est_quadrant

mutable struct p8est_tree
    quadrants::sc_array_t
    first_desc::p8est_quadrant_t
    last_desc::p8est_quadrant_t
    quadrants_offset::p4est_locidx_t
    quadrants_per_level::NTuple{31, p4est_locidx_t}
    maxlevel::Int8
    p8est_tree() = new()
end

const p8est_tree_t = p8est_tree

struct p8est_inspect
    use_balance_ranges::Cint
    use_balance_ranges_notify::Cint
    use_balance_verify::Cint
    balance_max_ranges::Cint
    balance_A_count_in::Csize_t
    balance_A_count_out::Csize_t
    balance_comm_sent::Csize_t
    balance_comm_nzpeers::Csize_t
    balance_B_count_in::Csize_t
    balance_B_count_out::Csize_t
    balance_zero_sends::NTuple{2, Csize_t}
    balance_zero_receives::NTuple{2, Csize_t}
    balance_A::Cdouble
    balance_comm::Cdouble
    balance_B::Cdouble
    balance_ranges::Cdouble
    balance_notify::Cdouble
    balance_notify_allgather::Cdouble
    use_B::Cint
end

const p8est_inspect_t = p8est_inspect

struct p8est
    mpicomm::sc_MPI_Comm
    mpisize::Cint
    mpirank::Cint
    mpicomm_owned::Cint
    data_size::Csize_t
    user_pointer::Ptr{Cvoid}
    revision::Clong
    first_local_tree::p4est_topidx_t
    last_local_tree::p4est_topidx_t
    local_num_quadrants::p4est_locidx_t
    global_num_quadrants::p4est_gloidx_t
    global_first_quadrant::Ptr{p4est_gloidx_t}
    global_first_position::Ptr{p8est_quadrant_t}
    connectivity::Ptr{p8est_connectivity_t}
    trees::Ptr{sc_array_t}
    user_data_pool::Ptr{sc_mempool_t}
    quadrant_pool::Ptr{sc_mempool_t}
    inspect::Ptr{p8est_inspect_t}
end

const p8est_t = p8est

function p8est_memory_used(p8est_)
    @ccall libp4est.p8est_memory_used(p8est_::Ptr{p8est_t})::Csize_t
end

function p8est_revision(p8est_)
    @ccall libp4est.p8est_revision(p8est_::Ptr{p8est_t})::Clong
end

# typedef void ( * p8est_init_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
const p8est_init_t = Ptr{Cvoid}

# typedef int ( * p8est_refine_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
const p8est_refine_t = Ptr{Cvoid}

# typedef int ( * p8est_coarsen_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrants [ ] )
const p8est_coarsen_t = Ptr{Cvoid}

# typedef int ( * p8est_weight_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
const p8est_weight_t = Ptr{Cvoid}

function p8est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)
    @ccall libp4est.p8est_qcoord_to_vertex(connectivity::Ptr{p8est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, z::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

function p8est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_new(mpicomm::sc_MPI_Comm, connectivity::Ptr{p8est_connectivity_t}, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p8est_t}
end

function p8est_destroy(p8est_)
    @ccall libp4est.p8est_destroy(p8est_::Ptr{p8est_t})::Cvoid
end

function p8est_copy(input, copy_data)
    @ccall libp4est.p8est_copy(input::Ptr{p8est_t}, copy_data::Cint)::Ptr{p8est_t}
end

function p8est_reset_data(p8est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_reset_data(p8est_::Ptr{p8est_t}, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

function p8est_refine(p8est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p8est_refine(p8est_::Ptr{p8est_t}, refine_recursive::Cint, refine_fn::p8est_refine_t, init_fn::p8est_init_t)::Cvoid
end

function p8est_coarsen(p8est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p8est_coarsen(p8est_::Ptr{p8est_t}, coarsen_recursive::Cint, coarsen_fn::p8est_coarsen_t, init_fn::p8est_init_t)::Cvoid
end

function p8est_balance(p8est_, btype, init_fn)
    @ccall libp4est.p8est_balance(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, init_fn::p8est_init_t)::Cvoid
end

function p8est_partition(p8est_, allow_for_coarsening, weight_fn)
    @ccall libp4est.p8est_partition(p8est_::Ptr{p8est_t}, allow_for_coarsening::Cint, weight_fn::p8est_weight_t)::Cvoid
end

function p8est_checksum(p8est_)
    @ccall libp4est.p8est_checksum(p8est_::Ptr{p8est_t})::Cuint
end

function p8est_checksum_partition(p8est_)
    @ccall libp4est.p8est_checksum_partition(p8est_::Ptr{p8est_t})::Cuint
end

function p8est_save(filename, p8est_, save_data)
    @ccall libp4est.p8est_save(filename::Cstring, p8est_::Ptr{p8est_t}, save_data::Cint)::Cvoid
end

function p8est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p8est_load(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

function p8est_tree_array_index(array, it)
    @ccall libp4est.p8est_tree_array_index(array::Ptr{sc_array_t}, it::p4est_topidx_t)::Ptr{p8est_tree_t}
end

function p8est_quadrant_array_index(array, it)
    @ccall libp4est.p8est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_quadrant_t}
end

function p8est_quadrant_array_push(array)
    @ccall libp4est.p8est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p8est_quadrant_t}
end

function p8est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p8est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p8est_quadrant_t}
end

function p8est_quadrant_list_pop(list)
    @ccall libp4est.p8est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p8est_quadrant_t}
end

mutable struct p8est_ghost_t
    mpisize::Cint
    num_trees::p4est_topidx_t
    btype::p8est_connect_type_t
    ghosts::sc_array_t
    tree_offsets::Ptr{p4est_locidx_t}
    proc_offsets::Ptr{p4est_locidx_t}
    mirrors::sc_array_t
    mirror_tree_offsets::Ptr{p4est_locidx_t}
    mirror_proc_mirrors::Ptr{p4est_locidx_t}
    mirror_proc_offsets::Ptr{p4est_locidx_t}
    mirror_proc_fronts::Ptr{p4est_locidx_t}
    mirror_proc_front_offsets::Ptr{p4est_locidx_t}
    p8est_ghost_t() = new()
end

function p8est_ghost_is_valid(p8est_, ghost)
    @ccall libp4est.p8est_ghost_is_valid(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cint
end

function p8est_ghost_memory_used(ghost)
    @ccall libp4est.p8est_ghost_memory_used(ghost::Ptr{p8est_ghost_t})::Csize_t
end

function p8est_quadrant_find_owner(p8est_, treeid, face, q)
    @ccall libp4est.p8est_quadrant_find_owner(p8est_::Ptr{p8est_t}, treeid::p4est_topidx_t, face::Cint, q::Ptr{p8est_quadrant_t})::Cint
end

function p8est_ghost_new(p8est_, btype)
    @ccall libp4est.p8est_ghost_new(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t)::Ptr{p8est_ghost_t}
end

function p8est_ghost_destroy(ghost)
    @ccall libp4est.p8est_ghost_destroy(ghost::Ptr{p8est_ghost_t})::Cvoid
end

function p8est_ghost_bsearch(ghost, which_proc, which_tree, q)
    @ccall libp4est.p8est_ghost_bsearch(ghost::Ptr{p8est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p8est_quadrant_t})::Cssize_t
end

function p8est_ghost_tree_contains(ghost, which_proc, which_tree, q)
    @ccall libp4est.p8est_ghost_tree_contains(ghost::Ptr{p8est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p8est_quadrant_t})::Cssize_t
end

function p8est_face_quadrant_exists(p8est_, ghost, treeid, q, face, hang, owner_rank)
    @ccall libp4est.p8est_face_quadrant_exists(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p8est_quadrant_t}, face::Ptr{Cint}, hang::Ptr{Cint}, owner_rank::Ptr{Cint})::p4est_locidx_t
end

function p8est_quadrant_exists(p8est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)
    @ccall libp4est.p8est_quadrant_exists(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p8est_quadrant_t}, exists_arr::Ptr{sc_array_t}, rproc_arr::Ptr{sc_array_t}, rquad_arr::Ptr{sc_array_t})::Cint
end

function p8est_is_balanced(p8est_, btype)
    @ccall libp4est.p8est_is_balanced(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t)::Cint
end

function p8est_ghost_checksum(p8est_, ghost)
    @ccall libp4est.p8est_ghost_checksum(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cuint
end

function p8est_ghost_exchange_data(p8est_, ghost, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_data(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, ghost_data::Ptr{Cvoid})::Cvoid
end

mutable struct p8est_ghost_exchange
    is_custom::Cint
    is_levels::Cint
    p4est::Ptr{p8est_t}
    ghost::Ptr{p8est_ghost_t}
    minlevel::Cint
    maxlevel::Cint
    data_size::Csize_t
    ghost_data::Ptr{Cvoid}
    qactive::Ptr{Cint}
    qbuffer::Ptr{Cint}
    requests::sc_array_t
    sbuffers::sc_array_t
    rrequests::sc_array_t
    rbuffers::sc_array_t
    p8est_ghost_exchange() = new()
end

const p8est_ghost_exchange_t = p8est_ghost_exchange

function p8est_ghost_exchange_data_begin(p8est_, ghost, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_data_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

function p8est_ghost_exchange_data_end(exc)
    @ccall libp4est.p8est_ghost_exchange_data_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

function p8est_ghost_exchange_custom(p8est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

function p8est_ghost_exchange_custom_begin(p8est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

function p8est_ghost_exchange_custom_end(exc)
    @ccall libp4est.p8est_ghost_exchange_custom_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

function p8est_ghost_exchange_custom_levels(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_levels(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

function p8est_ghost_exchange_custom_levels_begin(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_levels_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

function p8est_ghost_exchange_custom_levels_end(exc)
    @ccall libp4est.p8est_ghost_exchange_custom_levels_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

function p8est_ghost_expand(p8est_, ghost)
    @ccall libp4est.p8est_ghost_expand(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

mutable struct p8est_mesh_t
    local_num_quadrants::p4est_locidx_t
    ghost_num_quadrants::p4est_locidx_t
    quad_to_tree::Ptr{p4est_topidx_t}
    ghost_to_proc::Ptr{Cint}
    quad_to_quad::Ptr{p4est_locidx_t}
    quad_to_face::Ptr{Int8}
    quad_to_half::Ptr{sc_array_t}
    quad_level::Ptr{sc_array_t}
    local_num_edges::p4est_locidx_t
    quad_to_edge::Ptr{p4est_locidx_t}
    edge_offset::Ptr{sc_array_t}
    edge_quad::Ptr{sc_array_t}
    edge_edge::Ptr{sc_array_t}
    local_num_corners::p4est_locidx_t
    quad_to_corner::Ptr{p4est_locidx_t}
    corner_offset::Ptr{sc_array_t}
    corner_quad::Ptr{sc_array_t}
    corner_corner::Ptr{sc_array_t}
    p8est_mesh_t() = new()
end

mutable struct p8est_mesh_face_neighbor_t
    p4est::Ptr{p8est_t}
    ghost::Ptr{p8est_ghost_t}
    mesh::Ptr{p8est_mesh_t}
    which_tree::p4est_topidx_t
    quadrant_id::p4est_locidx_t
    quadrant_code::p4est_locidx_t
    face::Cint
    subface::Cint
    current_qtq::p4est_locidx_t
    p8est_mesh_face_neighbor_t() = new()
end

function p8est_mesh_memory_used(mesh)
    @ccall libp4est.p8est_mesh_memory_used(mesh::Ptr{p8est_mesh_t})::Csize_t
end

function p8est_mesh_new(p8est_, ghost, btype)
    @ccall libp4est.p8est_mesh_new(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, btype::p8est_connect_type_t)::Ptr{p8est_mesh_t}
end

function p8est_mesh_destroy(mesh)
    @ccall libp4est.p8est_mesh_destroy(mesh::Ptr{p8est_mesh_t})::Cvoid
end

function p8est_mesh_get_quadrant(p4est_, mesh, qid)
    @ccall libp4est.p8est_mesh_get_quadrant(p4est_::Ptr{p8est_t}, mesh::Ptr{p8est_mesh_t}, qid::p4est_locidx_t)::Ptr{p8est_quadrant_t}
end

function p8est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)
    @ccall libp4est.p8est_mesh_get_neighbors(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, curr_quad_id::p4est_locidx_t, direction::p4est_locidx_t, neighboring_quads::Ptr{sc_array_t}, neighboring_encs::Ptr{sc_array_t}, neighboring_qids::Ptr{sc_array_t})::p4est_locidx_t
end

function p8est_mesh_quadrant_cumulative(p8est_, mesh, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p8est_mesh_quadrant_cumulative(p8est_::Ptr{p8est_t}, mesh::Ptr{p8est_mesh_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p8est_quadrant_t}
end

function p8est_mesh_face_neighbor_init2(mfn, p8est_, ghost, mesh, which_tree, quadrant_id)
    @ccall libp4est.p8est_mesh_face_neighbor_init2(mfn::Ptr{p8est_mesh_face_neighbor_t}, p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, which_tree::p4est_topidx_t, quadrant_id::p4est_locidx_t)::Cvoid
end

function p8est_mesh_face_neighbor_init(mfn, p8est_, ghost, mesh, which_tree, quadrant)
    @ccall libp4est.p8est_mesh_face_neighbor_init(mfn::Ptr{p8est_mesh_face_neighbor_t}, p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, which_tree::p4est_topidx_t, quadrant::Ptr{p8est_quadrant_t})::Cvoid
end

function p8est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)
    @ccall libp4est.p8est_mesh_face_neighbor_next(mfn::Ptr{p8est_mesh_face_neighbor_t}, ntree::Ptr{p4est_topidx_t}, nquad::Ptr{p4est_locidx_t}, nface::Ptr{Cint}, nrank::Ptr{Cint})::Ptr{p8est_quadrant_t}
end

function p8est_mesh_face_neighbor_data(mfn, ghost_data)
    @ccall libp4est.p8est_mesh_face_neighbor_data(mfn::Ptr{p8est_mesh_face_neighbor_t}, ghost_data::Ptr{Cvoid})::Ptr{Cvoid}
end

mutable struct p8est_iter_volume_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    treeid::p4est_topidx_t
    p8est_iter_volume_info() = new()
end

const p8est_iter_volume_info_t = p8est_iter_volume_info

# typedef void ( * p8est_iter_volume_t ) ( p8est_iter_volume_info_t * info , void * user_data )
const p8est_iter_volume_t = Ptr{Cvoid}

struct p8est_iter_face_side_data
    data::NTuple{56, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_face_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_245}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_246}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_iter_face_side_data, f::Symbol)
    r = Ref{p8est_iter_face_side_data}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_iter_face_side_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_iter_face_side_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct p8est_iter_face_side
    treeid::p4est_topidx_t
    face::Int8
    is_hanging::Int8
    is::p8est_iter_face_side_data
    p8est_iter_face_side() = new()
end

const p8est_iter_face_side_t = p8est_iter_face_side

mutable struct p8est_iter_face_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    orientation::Int8
    tree_boundary::Int8
    sides::sc_array_t
    p8est_iter_face_info() = new()
end

const p8est_iter_face_info_t = p8est_iter_face_info

# typedef void ( * p8est_iter_face_t ) ( p8est_iter_face_info_t * info , void * user_data )
const p8est_iter_face_t = Ptr{Cvoid}

struct p8est_iter_edge_side_data
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_edge_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_243}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_244}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_iter_edge_side_data, f::Symbol)
    r = Ref{p8est_iter_edge_side_data}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_iter_edge_side_data}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_iter_edge_side_data}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct p8est_iter_edge_side
    treeid::p4est_topidx_t
    edge::Int8
    orientation::Int8
    is_hanging::Int8
    is::p8est_iter_edge_side_data
    faces::NTuple{2, Int8}
    p8est_iter_edge_side() = new()
end

const p8est_iter_edge_side_t = p8est_iter_edge_side

mutable struct p8est_iter_edge_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
    p8est_iter_edge_info() = new()
end

const p8est_iter_edge_info_t = p8est_iter_edge_info

# typedef void ( * p8est_iter_edge_t ) ( p8est_iter_edge_info_t * info , void * user_data )
const p8est_iter_edge_t = Ptr{Cvoid}

mutable struct p8est_iter_corner_side
    treeid::p4est_topidx_t
    corner::Int8
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    faces::NTuple{3, Int8}
    edges::NTuple{3, Int8}
    p8est_iter_corner_side() = new()
end

const p8est_iter_corner_side_t = p8est_iter_corner_side

mutable struct p8est_iter_corner_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
    p8est_iter_corner_info() = new()
end

const p8est_iter_corner_info_t = p8est_iter_corner_info

# typedef void ( * p8est_iter_corner_t ) ( p8est_iter_corner_info_t * info , void * user_data )
const p8est_iter_corner_t = Ptr{Cvoid}

function p8est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner)
    @ccall libp4est.p8est_iterate(p4est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p8est_iter_volume_t, iter_face::p8est_iter_face_t, iter_edge::p8est_iter_edge_t, iter_corner::p8est_iter_corner_t)::Cvoid
end

function p8est_iter_cside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_cside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_corner_side_t}
end

function p8est_iter_cside_array_index(array, it)
    @ccall libp4est.p8est_iter_cside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_corner_side_t}
end

function p8est_iter_eside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_eside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_edge_side_t}
end

function p8est_iter_eside_array_index(array, it)
    @ccall libp4est.p8est_iter_eside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_edge_side_t}
end

function p8est_iter_fside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_fside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_face_side_t}
end

function p8est_iter_fside_array_index(array, it)
    @ccall libp4est.p8est_iter_fside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_face_side_t}
end

const p8est_lnodes_code_t = Int16

mutable struct p8est_lnodes
    mpicomm::sc_MPI_Comm
    num_local_nodes::p4est_locidx_t
    owned_count::p4est_locidx_t
    global_offset::p4est_gloidx_t
    nonlocal_nodes::Ptr{p4est_gloidx_t}
    sharers::Ptr{sc_array_t}
    global_owned_count::Ptr{p4est_locidx_t}
    degree::Cint
    vnodes::Cint
    num_local_elements::p4est_locidx_t
    face_code::Ptr{p8est_lnodes_code_t}
    element_nodes::Ptr{p4est_locidx_t}
    p8est_lnodes() = new()
end

const p8est_lnodes_t = p8est_lnodes

mutable struct p8est_lnodes_rank
    rank::Cint
    shared_nodes::sc_array_t
    shared_mine_offset::p4est_locidx_t
    shared_mine_count::p4est_locidx_t
    owned_offset::p4est_locidx_t
    owned_count::p4est_locidx_t
    p8est_lnodes_rank() = new()
end

const p8est_lnodes_rank_t = p8est_lnodes_rank

function p8est_lnodes_decode(face_code, hanging_face, hanging_edge)
    @ccall libp4est.p8est_lnodes_decode(face_code::p8est_lnodes_code_t, hanging_face::Ptr{Cint}, hanging_edge::Ptr{Cint})::Cint
end

function p8est_lnodes_new(p8est_, ghost_layer, degree)
    @ccall libp4est.p8est_lnodes_new(p8est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, degree::Cint)::Ptr{p8est_lnodes_t}
end

function p8est_lnodes_destroy(lnodes)
    @ccall libp4est.p8est_lnodes_destroy(lnodes::Ptr{p8est_lnodes_t})::Cvoid
end

function p8est_partition_lnodes(p8est_, ghost, degree, partition_for_coarsening)
    @ccall libp4est.p8est_partition_lnodes(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, degree::Cint, partition_for_coarsening::Cint)::Cvoid
end

function p8est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_edge, nodes_per_corner, partition_for_coarsening)
    @ccall libp4est.p8est_partition_lnodes_detailed(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, nodes_per_volume::Cint, nodes_per_face::Cint, nodes_per_edge::Cint, nodes_per_corner::Cint, partition_for_coarsening::Cint)::Cvoid
end

function p8est_ghost_support_lnodes(p8est_, lnodes, ghost)
    @ccall libp4est.p8est_ghost_support_lnodes(p8est_::Ptr{p8est_t}, lnodes::Ptr{p8est_lnodes_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

function p8est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p8est_ghost_expand_by_lnodes(p4est_::Ptr{p8est_t}, lnodes::Ptr{p8est_lnodes_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

mutable struct p8est_lnodes_buffer
    requests::Ptr{sc_array_t}
    send_buffers::Ptr{sc_array_t}
    recv_buffers::Ptr{sc_array_t}
    p8est_lnodes_buffer() = new()
end

const p8est_lnodes_buffer_t = p8est_lnodes_buffer

function p8est_lnodes_share_owned_begin(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_owned_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

function p8est_lnodes_share_owned_end(buffer)
    @ccall libp4est.p8est_lnodes_share_owned_end(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

function p8est_lnodes_share_owned(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_owned(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Cvoid
end

function p8est_lnodes_share_all_begin(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_all_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

function p8est_lnodes_share_all_end(buffer)
    @ccall libp4est.p8est_lnodes_share_all_end(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

function p8est_lnodes_share_all(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_all(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

function p8est_lnodes_buffer_destroy(buffer)
    @ccall libp4est.p8est_lnodes_buffer_destroy(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

function p8est_lnodes_rank_array_index_int(array, it)
    @ccall libp4est.p8est_lnodes_rank_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_lnodes_rank_t}
end

function p8est_lnodes_rank_array_index(array, it)
    @ccall libp4est.p8est_lnodes_rank_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_lnodes_rank_t}
end

function p8est_lnodes_global_index(lnodes, lidx)
    @ccall libp4est.p8est_lnodes_global_index(lnodes::Ptr{p8est_lnodes_t}, lidx::p4est_locidx_t)::p4est_gloidx_t
end

mutable struct sc_uint128
    high_bits::UInt64
    low_bits::UInt64
    sc_uint128() = new()
end

const sc_uint128_t = sc_uint128

function sc_uint128_compare(a, b)
    @ccall libp4est.sc_uint128_compare(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

function sc_uint128_is_equal(a, b)
    @ccall libp4est.sc_uint128_is_equal(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cint
end

function sc_uint128_init(a, high, low)
    @ccall libp4est.sc_uint128_init(a::Ptr{sc_uint128_t}, high::UInt64, low::UInt64)::Cvoid
end

function sc_uint128_chk_bit(input, exponent)
    @ccall libp4est.sc_uint128_chk_bit(input::Ptr{sc_uint128_t}, exponent::Cint)::Cint
end

function sc_uint128_set_bit(a, exponent)
    @ccall libp4est.sc_uint128_set_bit(a::Ptr{sc_uint128_t}, exponent::Cint)::Cvoid
end

function sc_uint128_copy(input, output)
    @ccall libp4est.sc_uint128_copy(input::Ptr{sc_uint128_t}, output::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_add(a, b, result)
    @ccall libp4est.sc_uint128_add(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_sub(a, b, result)
    @ccall libp4est.sc_uint128_sub(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_bitwise_neg(a, result)
    @ccall libp4est.sc_uint128_bitwise_neg(a::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_bitwise_or(a, b, result)
    @ccall libp4est.sc_uint128_bitwise_or(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_bitwise_and(a, b, result)
    @ccall libp4est.sc_uint128_bitwise_and(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_shift_right(input, shift_count, result)
    @ccall libp4est.sc_uint128_shift_right(input::Ptr{sc_uint128_t}, shift_count::Cint, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_shift_left(input, shift_count, result)
    @ccall libp4est.sc_uint128_shift_left(input::Ptr{sc_uint128_t}, shift_count::Cint, result::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_add_inplace(a, b)
    @ccall libp4est.sc_uint128_add_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_sub_inplace(a, b)
    @ccall libp4est.sc_uint128_sub_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_bitwise_or_inplace(a, b)
    @ccall libp4est.sc_uint128_bitwise_or_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

function sc_uint128_bitwise_and_inplace(a, b)
    @ccall libp4est.sc_uint128_bitwise_and_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

const p8est_lid_t = sc_uint128_t

# typedef void ( * p8est_replace_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , int num_outgoing , p8est_quadrant_t * outgoing [ ] , int num_incoming , p8est_quadrant_t * incoming [ ] )
const p8est_replace_t = Ptr{Cvoid}

function p8est_lid_compare(a, b)
    @ccall libp4est.p8est_lid_compare(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cint
end

function p8est_lid_is_equal(a, b)
    @ccall libp4est.p8est_lid_is_equal(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cint
end

function p8est_lid_init(input, high, low)
    @ccall libp4est.p8est_lid_init(input::Ptr{p8est_lid_t}, high::UInt64, low::UInt64)::Cvoid
end

function p8est_lid_set_zero(input)
    @ccall libp4est.p8est_lid_set_zero(input::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_set_one(input)
    @ccall libp4est.p8est_lid_set_one(input::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_set_uint64(input, u)
    @ccall libp4est.p8est_lid_set_uint64(input::Ptr{p8est_lid_t}, u::UInt64)::Cvoid
end

function p8est_lid_chk_bit(input, bit_number)
    @ccall libp4est.p8est_lid_chk_bit(input::Ptr{p8est_lid_t}, bit_number::Cint)::Cint
end

function p8est_lid_set_bit(input, bit_number)
    @ccall libp4est.p8est_lid_set_bit(input::Ptr{p8est_lid_t}, bit_number::Cint)::Cvoid
end

function p8est_lid_copy(input, output)
    @ccall libp4est.p8est_lid_copy(input::Ptr{p8est_lid_t}, output::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_add(a, b, result)
    @ccall libp4est.p8est_lid_add(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_sub(a, b, result)
    @ccall libp4est.p8est_lid_sub(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_bitwise_neg(a, result)
    @ccall libp4est.p8est_lid_bitwise_neg(a::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_bitwise_or(a, b, result)
    @ccall libp4est.p8est_lid_bitwise_or(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_bitwise_and(a, b, result)
    @ccall libp4est.p8est_lid_bitwise_and(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_shift_right(input, shift_count, result)
    @ccall libp4est.p8est_lid_shift_right(input::Ptr{p8est_lid_t}, shift_count::Cuint, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_shift_left(input, shift_count, result)
    @ccall libp4est.p8est_lid_shift_left(input::Ptr{p8est_lid_t}, shift_count::Cuint, result::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_add_inplace(a, b)
    @ccall libp4est.p8est_lid_add_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_sub_inplace(a, b)
    @ccall libp4est.p8est_lid_sub_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_bitwise_or_inplace(a, b)
    @ccall libp4est.p8est_lid_bitwise_or_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

function p8est_lid_bitwise_and_inplace(a, b)
    @ccall libp4est.p8est_lid_bitwise_and_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

function p8est_quadrant_linear_id_ext128(quadrant, level, id)
    @ccall libp4est.p8est_quadrant_linear_id_ext128(quadrant::Ptr{p8est_quadrant_t}, level::Cint, id::Ptr{p8est_lid_t})::Cvoid
end

function p8est_quadrant_set_morton_ext128(quadrant, level, id)
    @ccall libp4est.p8est_quadrant_set_morton_ext128(quadrant::Ptr{p8est_quadrant_t}, level::Cint, id::Ptr{p8est_lid_t})::Cvoid
end

function p8est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_new_ext(mpicomm::sc_MPI_Comm, connectivity::Ptr{p8est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p8est_t}
end

function p8est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)
    @ccall libp4est.p8est_mesh_new_ext(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, compute_tree_index::Cint, compute_level_lists::Cint, btype::p8est_connect_type_t)::Ptr{p8est_mesh_t}
end

function p8est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p8est_copy_ext(input::Ptr{p8est_t}, copy_data::Cint, duplicate_mpicomm::Cint)::Ptr{p8est_t}
end

function p8est_refine_ext(p8est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p8est_refine_ext(p8est_::Ptr{p8est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p8est_refine_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

function p8est_coarsen_ext(p8est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p8est_coarsen_ext(p8est_::Ptr{p8est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p8est_coarsen_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

function p8est_balance_ext(p8est_, btype, init_fn, replace_fn)
    @ccall libp4est.p8est_balance_ext(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

function p8est_balance_subtree_ext(p8est_, btype, which_tree, init_fn, replace_fn)
    @ccall libp4est.p8est_balance_subtree_ext(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, which_tree::p4est_topidx_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

function p8est_partition_ext(p8est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p8est_partition_ext(p8est_::Ptr{p8est_t}, partition_for_coarsening::Cint, weight_fn::p8est_weight_t)::p4est_gloidx_t
end

function p8est_partition_for_coarsening(p8est_, num_quadrants_in_proc)
    @ccall libp4est.p8est_partition_for_coarsening(p8est_::Ptr{p8est_t}, num_quadrants_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

function p8est_iterate_ext(p8est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner, remote)
    @ccall libp4est.p8est_iterate_ext(p8est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p8est_iter_volume_t, iter_face::p8est_iter_face_t, iter_edge::p8est_iter_edge_t, iter_corner::p8est_iter_corner_t, remote::Cint)::Cvoid
end

function p8est_save_ext(filename, p8est_, save_data, save_partition)
    @ccall libp4est.p8est_save_ext(filename::Cstring, p8est_::Ptr{p8est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

function p8est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p8est_load_ext(filename::Cstring, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

function p8est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p8est_source_ext(src::Ptr{sc_io_source_t}, mpicomm::sc_MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

function p8est_get_plex_data_ext(p8est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)
    @ccall libp4est.p8est_get_plex_data_ext(p8est_::Ptr{p8est_t}, ghost::Ptr{Ptr{p8est_ghost_t}}, lnodes::Ptr{Ptr{p8est_lnodes_t}}, ctype::p8est_connect_type_t, overlap::Cint, first_local_quad::Ptr{p4est_locidx_t}, out_points_per_dim::Ptr{sc_array_t}, out_cone_sizes::Ptr{sc_array_t}, out_cones::Ptr{sc_array_t}, out_cone_orientations::Ptr{sc_array_t}, out_vertex_coords::Ptr{sc_array_t}, out_children::Ptr{sc_array_t}, out_parents::Ptr{sc_array_t}, out_childids::Ptr{sc_array_t}, out_leaves::Ptr{sc_array_t}, out_remotes::Ptr{sc_array_t}, custom_numbering::Cint)::Cvoid
end

mutable struct __JL_Ctag_234
    which_tree::p4est_topidx_t
    owner_rank::Cint
    __JL_Ctag_234() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_234}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_234, f::Symbol)
    r = Ref{__JL_Ctag_234}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_234}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_234}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_235
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
    __JL_Ctag_235() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_235}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_235, f::Symbol)
    r = Ref{__JL_Ctag_235}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_235}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_235}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_236
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
    __JL_Ctag_236() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_236}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_236, f::Symbol)
    r = Ref{__JL_Ctag_236}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_236}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_236}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_237
    which_tree::p4est_topidx_t
    owner_rank::Cint
    __JL_Ctag_237() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_237}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_237, f::Symbol)
    r = Ref{__JL_Ctag_237}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_237}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_237}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_238
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
    __JL_Ctag_238() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_238}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_238, f::Symbol)
    r = Ref{__JL_Ctag_238}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_238}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_238}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_239
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
    __JL_Ctag_239() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_239}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_239, f::Symbol)
    r = Ref{__JL_Ctag_239}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_239}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_239}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_240
    which_tree::p4est_topidx_t
    owner_rank::Cint
    __JL_Ctag_240() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_240}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_240, f::Symbol)
    r = Ref{__JL_Ctag_240}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_240}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_240}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_241
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
    __JL_Ctag_241() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_241}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_241, f::Symbol)
    r = Ref{__JL_Ctag_241}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_241}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_241}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_242
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
    __JL_Ctag_242() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_242}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_242, f::Symbol)
    r = Ref{__JL_Ctag_242}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_242}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_242}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_243
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    __JL_Ctag_243() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_243}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p8est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_243, f::Symbol)
    r = Ref{__JL_Ctag_243}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_243}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_243}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_244
    is_ghost::NTuple{2, Int8}
    quad::NTuple{2, Ptr{p8est_quadrant_t}}
    quadid::NTuple{2, p4est_locidx_t}
    __JL_Ctag_244() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_244}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{2, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{2, Ptr{p8est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{2, p4est_locidx_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_244, f::Symbol)
    r = Ref{__JL_Ctag_244}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_244}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_244}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_245
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    __JL_Ctag_245() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_245}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p8est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_245, f::Symbol)
    r = Ref{__JL_Ctag_245}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_245}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_245}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_246
    is_ghost::NTuple{4, Int8}
    quad::NTuple{4, Ptr{p8est_quadrant_t}}
    quadid::NTuple{4, p4est_locidx_t}
    __JL_Ctag_246() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_246}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{4, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{4, Ptr{p8est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{4, p4est_locidx_t}}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_246, f::Symbol)
    r = Ref{__JL_Ctag_246}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_246}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_246}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_247
    is_ghost::Int8
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
    __JL_Ctag_247() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_247}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p4est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_247, f::Symbol)
    r = Ref{__JL_Ctag_247}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_247}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_247}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct __JL_Ctag_248
    is_ghost::NTuple{2, Int8}
    quad::NTuple{2, Ptr{p4est_quadrant_t}}
    quadid::NTuple{2, p4est_locidx_t}
    __JL_Ctag_248() = new()
end

function Base.getproperty(x::Ptr{__JL_Ctag_248}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{2, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{2, Ptr{p4est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{2, p4est_locidx_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_248, f::Symbol)
    r = Ref{__JL_Ctag_248}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_248}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_248}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const SC_CC = "cc"

const SC_CFLAGS = "-g -O2"

const SC_CPP = "cc -E"

const SC_CPPFLAGS = "-I/workspace/destdir/include"

const SC_CXX = "c++"

const SC_CXXFLAGS = "-g -O2"

const SC_ENABLE_MEMALIGN = 1

const SC_ENABLE_USE_REALLOC = 1

const SC_ENABLE_V4L2 = 1

const SC_F77 = "gfortran"

const SC_FC = "gfortran"

const SC_FCFLAGS = "-g -O2"

const SC_FFLAGS = "-g -O2"

const SC_HAVE_BACKTRACE = 1

const SC_HAVE_BACKTRACE_SYMBOLS = 1

const SC_HAVE_FSYNC = 1

const SC_HAVE_POSIX_MEMALIGN = 1

const SC_HAVE_QSORT_R = 1

const SC_HAVE_STRTOL = 1

const SC_HAVE_STRTOLL = 1

const SC_HAVE_ZLIB = 1

const SC_LDFLAGS = "-L/workspace/destdir/lib"

const SC_LIBS = "  -lz -lm   "

const SC_LT_OBJDIR = ".libs/"

const SC_MEMALIGN = 1

const SC_SIZEOF_VOID_P = 8

const SC_MEMALIGN_BYTES = SC_SIZEOF_VOID_P

const SC_PACKAGE = "libsc"

const SC_PACKAGE_BUGREPORT = "p4est@ins.uni-bonn.de"

const SC_PACKAGE_NAME = "libsc"

const SC_PACKAGE_STRING = "libsc 2.3.2"

const SC_PACKAGE_TARNAME = "libsc"

const SC_PACKAGE_URL = ""

const SC_PACKAGE_VERSION = "2.3.2"

const SC_SIZEOF_INT = 4

const SC_SIZEOF_LONG = 8

const SC_SIZEOF_LONG_LONG = 8

const SC_SIZEOF_UNSIGNED_LONG = 8

const SC_SIZEOF_UNSIGNED_LONG_LONG = 8

const SC_STDC_HEADERS = 1

const SC_USE_REALLOC = 1

const SC_VERSION = "2.3.2"

const SC_VERSION_MAJOR = 2

const SC_VERSION_MINOR = 3

const SC_VERSION_POINT = 2

const sc_MPI_SUCCESS = 0

const sc_MPI_COMM_NULL = sc_MPI_Comm(0x04000000)

const sc_MPI_COMM_WORLD = sc_MPI_Comm(0x44000000)

const sc_MPI_COMM_SELF = sc_MPI_Comm(0x44000001)

const sc_MPI_GROUP_NULL = sc_MPI_Group(0x54000000)

const sc_MPI_GROUP_EMPTY = sc_MPI_Group(0x54000001)

const sc_MPI_IDENT = 1

const sc_MPI_CONGRUENT = 2

const sc_MPI_SIMILAR = 3

const sc_MPI_UNEQUAL = -1

const sc_MPI_ANY_SOURCE = -2

const sc_MPI_ANY_TAG = -1

# Skipping MacroDefinition: sc_MPI_STATUS_IGNORE ( sc_MPI_Status * ) 1

# Skipping MacroDefinition: sc_MPI_STATUSES_IGNORE ( sc_MPI_Status * ) 1

const sc_MPI_REQUEST_NULL = sc_MPI_Request(0x2c000000)

const sc_MPI_DATATYPE_NULL = sc_MPI_Datatype(0x4c000000)

const sc_MPI_CHAR = sc_MPI_Datatype(0x4c000101)

const sc_MPI_SIGNED_CHAR = sc_MPI_Datatype(0x4c000118)

const sc_MPI_UNSIGNED_CHAR = sc_MPI_Datatype(0x4c000102)

const sc_MPI_BYTE = sc_MPI_Datatype(0x4c00010d)

const sc_MPI_SHORT = sc_MPI_Datatype(0x4c000203)

const sc_MPI_UNSIGNED_SHORT = sc_MPI_Datatype(0x4c000204)

const sc_MPI_INT = sc_MPI_Datatype(0x4c000405)

const sc_MPI_UNSIGNED = sc_MPI_Datatype(0x4c000406)

const sc_MPI_LONG = sc_MPI_Datatype(0x4c000407)

const sc_MPI_UNSIGNED_LONG = sc_MPI_Datatype(0x4c000408)

const sc_MPI_LONG_LONG_INT = sc_MPI_Datatype(0x4c000809)

const sc_MPI_UNSIGNED_LONG_LONG = sc_MPI_Datatype(0x4c000409)

const sc_MPI_FLOAT = sc_MPI_Datatype(0x4c00040a)

const sc_MPI_DOUBLE = sc_MPI_Datatype(0x4c00080b)

const sc_MPI_LONG_DOUBLE = sc_MPI_Datatype(0x4c000c0c)

const sc_MPI_2INT = sc_MPI_Datatype(0x4c000816)

const sc_MPI_MAX = sc_MPI_Op(0x58000001)

const sc_MPI_MIN = sc_MPI_Op(0x58000002)

const sc_MPI_SUM = sc_MPI_Op(0x58000003)

const sc_MPI_PROD = sc_MPI_Op(0x58000004)

const sc_MPI_LAND = sc_MPI_Op(0x58000005)

const sc_MPI_BAND = sc_MPI_Op(0x58000006)

const sc_MPI_LOR = sc_MPI_Op(0x58000007)

const sc_MPI_BOR = sc_MPI_Op(0x58000008)

const sc_MPI_LXOR = sc_MPI_Op(0x58000009)

const sc_MPI_BXOR = sc_MPI_Op(0x5800000a)

const sc_MPI_MINLOC = sc_MPI_Op(0x5800000b)

const sc_MPI_MAXLOC = sc_MPI_Op(0x5800000c)

const sc_MPI_REPLACE = sc_MPI_Op(0x5800000d)

const sc_MPI_UNDEFINED = -32766

const sc_MPI_ERR_GROUP = -123456

const sc_MPI_THREAD_SINGLE = 0

const sc_MPI_THREAD_FUNNELED = 1

const sc_MPI_THREAD_SERIALIZED = 2

const sc_MPI_THREAD_MULTIPLE = 3

const SC_EPS = 2.220446049250313e-16

const SC_1000_EPS = 1000.0 * 2.220446049250313e-16

const SC_LC_GLOBAL = 1

const SC_LC_NORMAL = 2

const SC_LP_DEFAULT = -1

const SC_LP_ALWAYS = 0

const SC_LP_TRACE = 1

const SC_LP_DEBUG = 2

const SC_LP_VERBOSE = 3

const SC_LP_INFO = 4

const SC_LP_STATISTICS = 5

const SC_LP_PRODUCTION = 6

const SC_LP_ESSENTIAL = 7

const SC_LP_ERROR = 8

const SC_LP_SILENT = 9

const SC_LP_THRESHOLD = SC_LP_INFO

const P4EST_BUILD_2D = 1

const P4EST_BUILD_3D = 1

const P4EST_BUILD_P6EST = 1

const P4EST_CC = "cc"

const P4EST_CFLAGS = "-g -O2"

const P4EST_CPP = "cc -E"

const P4EST_CPPFLAGS = "-I/workspace/destdir/include"

const P4EST_ENABLE_BUILD_2D = 1

const P4EST_ENABLE_BUILD_3D = 1

const P4EST_ENABLE_BUILD_P6EST = 1

const P4EST_ENABLE_MEMALIGN = 1

const P4EST_ENABLE_VTK_BINARY = 1

const P4EST_ENABLE_VTK_COMPRESSION = 1

const P4EST_HAVE_POSIX_MEMALIGN = 1

const P4EST_HAVE_ZLIB = 1

const P4EST_LDFLAGS = "-L/workspace/destdir/lib"

const P4EST_LIBS = "  -lz -lm   "

const P4EST_LT_OBJDIR = ".libs/"

const P4EST_MEMALIGN = 1

const P4EST_SIZEOF_VOID_P = 8

const P4EST_MEMALIGN_BYTES = P4EST_SIZEOF_VOID_P

const P4EST_PACKAGE = "p4est"

const P4EST_PACKAGE_BUGREPORT = "p4est@ins.uni-bonn.de"

const P4EST_PACKAGE_NAME = "p4est"

const P4EST_PACKAGE_STRING = "p4est 2.3.2"

const P4EST_PACKAGE_TARNAME = "p4est"

const P4EST_PACKAGE_URL = ""

const P4EST_PACKAGE_VERSION = "2.3.2"

const P4EST_STDC_HEADERS = 1

const P4EST_VERSION = "2.3.2"

const P4EST_VERSION_MAJOR = 2

const P4EST_VERSION_MINOR = 3

const P4EST_VERSION_POINT = 2

const P4EST_VTK_BINARY = 1

const P4EST_VTK_COMPRESSION = 1

const p4est_qcoord_compare = sc_int32_compare

const P4EST_QCOORD_BITS = 32

const P4EST_MPI_QCOORD = sc_MPI_INT

const P4EST_VTK_QCOORD = "Int32"

# const P4EST_QCOORD_MIN = INT32_MIN
const P4EST_QCOORD_MIN = typemin(Int32)

const P4EST_QCOORD_MAX = typemax(Int32)

const P4EST_QCOORD_1 = p4est_qcoord_t(1)

const p4est_topidx_compare = sc_int32_compare

const P4EST_TOPIDX_BITS = 32

const P4EST_MPI_TOPIDX = sc_MPI_INT

const P4EST_VTK_TOPIDX = "Int32"

# const P4EST_TOPIDX_MIN = INT32_MIN
const P4EST_TOPIDX_MIN = typemin(Int32)

# const P4EST_TOPIDX_MAX = INT32_MAX
const P4EST_TOPIDX_MAX = typemax(Int32)

const P4EST_TOPIDX_FITS_32 = 1

const P4EST_TOPIDX_1 = p4est_topidx_t(1)

const p4est_locidx_compare = sc_int32_compare

const P4EST_LOCIDX_BITS = 32

const P4EST_MPI_LOCIDX = sc_MPI_INT

const P4EST_VTK_LOCIDX = "Int32"

# const P4EST_LOCIDX_MIN = INT32_MIN
const P4EST_LOCIDX_MIN = typemin(Int32)

# const P4EST_LOCIDX_MAX = INT32_MAX
const P4EST_LOCIDX_MAX = typemax(Int32)

const P4EST_LOCIDX_1 = p4est_locidx_t(1)

const p4est_gloidx_compare = sc_int64_compare

const P4EST_GLOIDX_BITS = 64

const P4EST_MPI_GLOIDX = sc_MPI_LONG_LONG_INT

const P4EST_VTK_GLOIDX = "Int64"

const P4EST_GLOIDX_MIN = typemin(Int64)

const P4EST_GLOIDX_MAX = typemax(Int64)

const P4EST_GLOIDX_1 = p4est_gloidx_t(1)

const P4EST_DIM = 2

const P4EST_FACES = 2P4EST_DIM

const P4EST_CHILDREN = 4

const P4EST_HALF = P4EST_CHILDREN ÷ 2

const P4EST_INSUL = 9

const P4EST_FTRANSFORM = 9

const P4EST_STRING = "p4est"

const P4EST_ONDISK_FORMAT = 0x02000009

const P4EST_OLD_MAXLEVEL = 30

const P4EST_MAXLEVEL = 30

const P4EST_OLD_QMAXLEVEL = 29

const P4EST_QMAXLEVEL = 29

const P4EST_ROOT_LEN = p4est_qcoord_t(1) << P4EST_MAXLEVEL

const P8EST_DIM = 3

const P8EST_FACES = 2P8EST_DIM

const P8EST_CHILDREN = 8

const P8EST_HALF = P8EST_CHILDREN ÷ 2

const P8EST_EDGES = 12

const P8EST_INSUL = 27

const P8EST_FTRANSFORM = 9

const P8EST_STRING = "p8est"

const P8EST_ONDISK_FORMAT = 0x03000009

const P8EST_OLD_MAXLEVEL = 19

const P8EST_MAXLEVEL = 30

const P8EST_OLD_QMAXLEVEL = 18

const P8EST_QMAXLEVEL = 29

const P8EST_ROOT_LEN = p4est_qcoord_t(1) << P8EST_MAXLEVEL

# exports
const PREFIXES = ["p4est_", "p6est_", "p8est_", "sc_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module

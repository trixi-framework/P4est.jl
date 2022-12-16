module LibP4est

using P4est_jll
export P4est_jll

using ..P4est: _PREFERENCE_LIBP4EST

@static if _PREFERENCE_LIBP4EST == "P4est_jll"
    const libp4est = P4est_jll.libp4est
else
    const libp4est = _PREFERENCE_LIBP4EST
end


using CEnum

to_c_type(t::Type) = t
to_c_type_pairs(va_list) = map(enumerate(to_c_type.(va_list))) do (ind, type)
    :(va_list[$ind]::$type)
end

using MPI: MPI_Datatype, MPI_Comm, MPI_File

# Define missing types
const ptrdiff_t = Cptrdiff_t

# Dummy definitions to avoid `UndefVarError`s
const MPI_SUCCESS = C_NULL
const MPI_ERR_OTHER = C_NULL
const MPI_COMM_NULL = C_NULL
const MPI_COMM_WORLD = C_NULL
const MPI_COMM_SELF = C_NULL
const MPI_COMM_TYPE_SHARED = C_NULL
const MPI_GROUP_NULL = C_NULL
const MPI_GROUP_EMPTY = C_NULL
const MPI_IDENT = C_NULL
const MPI_CONGRUENT = C_NULL
const MPI_SIMILAR = C_NULL
const MPI_UNEQUAL = C_NULL
const MPI_ANY_SOURCE = C_NULL
const MPI_ANY_TAG = C_NULL
const MPI_STATUS_IGNORE = C_NULL
const MPI_STATUSES_IGNORE = C_NULL
const MPI_REQUEST_NULL = C_NULL
const MPI_INFO_NULL = C_NULL
const MPI_DATATYPE_NULL = C_NULL
const MPI_CHAR = C_NULL
const MPI_SIGNED_CHAR = C_NULL
const MPI_UNSIGNED_CHAR = C_NULL
const MPI_BYTE = C_NULL
const MPI_SHORT = C_NULL
const MPI_UNSIGNED_SHORT = C_NULL
const MPI_INT = C_NULL
const MPI_2INT = C_NULL
const MPI_UNSIGNED = C_NULL
const MPI_LONG = C_NULL
const MPI_UNSIGNED_LONG = C_NULL
const MPI_LONG_LONG_INT = C_NULL
const MPI_UNSIGNED_LONG_LONG = C_NULL
const MPI_FLOAT = C_NULL
const MPI_DOUBLE = C_NULL
const MPI_LONG_DOUBLE = C_NULL
const MPI_OP_NULL = C_NULL
const MPI_MAX = C_NULL
const MPI_MIN = C_NULL
const MPI_LAND = C_NULL
const MPI_BAND = C_NULL
const MPI_LOR = C_NULL
const MPI_BOR = C_NULL
const MPI_LXOR = C_NULL
const MPI_BXOR = C_NULL
const MPI_MINLOC = C_NULL
const MPI_MAXLOC = C_NULL
const MPI_REPLACE = C_NULL
const MPI_SUM = C_NULL
const MPI_PROD = C_NULL
const MPI_UNDEFINED = C_NULL
const MPI_KEYVAL_INVALID = C_NULL
const MPI_Group = C_NULL
const MPI_Op = C_NULL
const MPI_Request = C_NULL
const MPI_Status = C_NULL
const MPI_Init = C_NULL
const MPI_Finalize = C_NULL
const MPI_Abort = C_NULL
const MPI_Alloc_mem = C_NULL
const MPI_Free_mem = C_NULL
const MPI_Comm_set_attr = C_NULL
const MPI_Comm_get_attr = C_NULL
const MPI_Comm_delete_attr = C_NULL
const MPI_Comm_create_keyval = C_NULL
const MPI_Comm_dup = C_NULL
const MPI_Comm_create = C_NULL
const MPI_Comm_split = C_NULL
const MPI_Comm_split_type = C_NULL
const MPI_Comm_free = C_NULL
const MPI_Comm_size = C_NULL
const MPI_Comm_rank = C_NULL
const MPI_Comm_compare = C_NULL
const MPI_Comm_group = C_NULL
const MPI_Group_free = C_NULL
const MPI_Group_size = C_NULL
const MPI_Group_rank = C_NULL
const MPI_Group_translate_ranks = C_NULL
const MPI_Group_compare = C_NULL
const MPI_Group_union = C_NULL
const MPI_Group_intersection = C_NULL
const MPI_Group_difference = C_NULL
const MPI_Group_incl = C_NULL
const MPI_Group_excl = C_NULL
const MPI_Group_range_incl = C_NULL
const MPI_Group_range_excl = C_NULL
const MPI_Barrier = C_NULL
const MPI_Bcast = C_NULL
const MPI_Gather = C_NULL
const MPI_Gatherv = C_NULL
const MPI_Allgather = C_NULL
const MPI_Allgatherv = C_NULL
const MPI_Alltoall = C_NULL
const MPI_Reduce = C_NULL
const MPI_Reduce_scatter_block = C_NULL
const MPI_Allreduce = C_NULL
const MPI_Scan = C_NULL
const MPI_Exscan = C_NULL
const MPI_Recv = C_NULL
const MPI_Irecv = C_NULL
const MPI_Send = C_NULL
const MPI_Isend = C_NULL
const MPI_Probe = C_NULL
const MPI_Iprobe = C_NULL
const MPI_Get_count = C_NULL
const MPI_Wtime = C_NULL
const MPI_Wait = C_NULL
const MPI_Waitsome = C_NULL
const MPI_Waitall = C_NULL
const MPI_THREAD_SINGLE = C_NULL
const MPI_THREAD_FUNNELED = C_NULL
const MPI_THREAD_SERIALIZED = C_NULL
const MPI_THREAD_MULTIPLE = C_NULL
const MPI_Init_thread = C_NULL

# Other definitions
const INT32_MIN = typemin(Cint)
const INT32_MAX = typemax(Cint)
const INT64_MIN = typemin(Clonglong)
const INT64_MAX = typemax(Clonglong)


"""
    sc_abort_verbose(filename, lineno, msg)

Print a message to stderr and then call [`sc_abort`](@ref) ().

### Prototype
```c
void sc_abort_verbose (const char *filename, int lineno, const char *msg) __attribute__ ((noreturn));
```
"""
function sc_abort_verbose(filename, lineno, msg)
    @ccall libp4est.sc_abort_verbose(filename::Cstring, lineno::Cint, msg::Cstring)::Cvoid
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function sc_abort_verbosef(filename, lineno, fmt, va_list...)
        :(@ccall(libp4est.sc_abort_verbosef(filename::Cstring, lineno::Cint, fmt::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

"""
    sc_malloc(package, size)

### Prototype
```c
void *sc_malloc (int package, size_t size);
```
"""
function sc_malloc(package, size)
    @ccall libp4est.sc_malloc(package::Cint, size::Csize_t)::Ptr{Cvoid}
end

"""
    sc_calloc(package, nmemb, size)

### Prototype
```c
void *sc_calloc (int package, size_t nmemb, size_t size);
```
"""
function sc_calloc(package, nmemb, size)
    @ccall libp4est.sc_calloc(package::Cint, nmemb::Csize_t, size::Csize_t)::Ptr{Cvoid}
end

"""
    sc_realloc(package, ptr, size)

### Prototype
```c
void *sc_realloc (int package, void *ptr, size_t size);
```
"""
function sc_realloc(package, ptr, size)
    @ccall libp4est.sc_realloc(package::Cint, ptr::Ptr{Cvoid}, size::Csize_t)::Ptr{Cvoid}
end

"""
    sc_strdup(package, s)

### Prototype
```c
char *sc_strdup (int package, const char *s);
```
"""
function sc_strdup(package, s)
    @ccall libp4est.sc_strdup(package::Cint, s::Cstring)::Cstring
end

"""
    sc_free(package, ptr)

### Prototype
```c
void sc_free (int package, void *ptr);
```
"""
function sc_free(package, ptr)
    @ccall libp4est.sc_free(package::Cint, ptr::Ptr{Cvoid})::Cvoid
end

"""
    sc_log(filename, lineno, package, category, priority, msg)

The central log function to be called by all packages. Dispatches the log calls by package and filters by category and priority.

### Parameters
* `package`:\\[in\\] Must be a registered package id or -1.
* `category`:\\[in\\] Must be [`SC_LC_NORMAL`](@ref) or [`SC_LC_GLOBAL`](@ref).
* `priority`:\\[in\\] Must be > [`SC_LP_ALWAYS`](@ref) and < [`SC_LP_SILENT`](@ref).
### Prototype
```c
void sc_log (const char *filename, int lineno, int package, int category, int priority, const char *msg);
```
"""
function sc_log(filename, lineno, package, category, priority, msg)
    @ccall libp4est.sc_log(filename::Cstring, lineno::Cint, package::Cint, category::Cint, priority::Cint, msg::Cstring)::Cvoid
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function sc_logf(filename, lineno, package, category, priority, fmt, va_list...)
        :(@ccall(libp4est.sc_logf(filename::Cstring, lineno::Cint, package::Cint, category::Cint, priority::Cint, fmt::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

"""
    sc_array

The [`sc_array`](@ref) object provides a dynamic array of equal-size elements. Elements are accessed by their 0-based index. Their address may change. The number of elements (== elem\\_count) of the array can be changed by  sc_array_resize and sc_array_rewind. Elements can be sorted with sc_array_sort. If the array is sorted, it can be searched with sc_array_bsearch. A priority queue is implemented with pqueue\\_add and pqueue\\_pop (untested).

| Field        | Note                                                                                                                                            |
| :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| elem\\_size  | size of a single element                                                                                                                        |
| elem\\_count | number of valid elements                                                                                                                        |
| byte\\_alloc | number of allocated bytes or -(number of viewed bytes + 1) if this is a view: the "+ 1" distinguishes an array of size 0 from a view of size 0  |
| array        | linear array to store elements                                                                                                                  |
"""
struct sc_array
    elem_size::Csize_t
    elem_count::Csize_t
    byte_alloc::Cssize_t
    array::Ptr{Int8}
end

"""The [`sc_array`](@ref) object provides a dynamic array of equal-size elements. Elements are accessed by their 0-based index. Their address may change. The number of elements (== elem\\_count) of the array can be changed by  sc_array_resize and sc_array_rewind. Elements can be sorted with sc_array_sort. If the array is sorted, it can be searched with sc_array_bsearch. A priority queue is implemented with pqueue\\_add and pqueue\\_pop (untested)."""
const sc_array_t = sc_array

"""
    sc_array_new_count(elem_size, elem_count)

Creates a new array structure with a given length (number of elements).

### Parameters
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `elem_count`:\\[in\\] Initial number of array elements.
### Returns
Return an allocated array with allocated but uninitialized elements.
### Prototype
```c
sc_array_t *sc_array_new_count (size_t elem_size, size_t elem_count);
```
"""
function sc_array_new_count(elem_size, elem_count)
    @ccall libp4est.sc_array_new_count(elem_size::Csize_t, elem_count::Csize_t)::Ptr{sc_array_t}
end

"""
    sc_int32_compare(v1, v2)

### Prototype
```c
int sc_int32_compare (const void *v1, const void *v2);
```
"""
function sc_int32_compare(v1, v2)
    @ccall libp4est.sc_int32_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""Typedef for quadrant coordinates."""
const p4est_qcoord_t = Int32

"""Typedef for counting topological entities (trees, tree vertices)."""
const p4est_topidx_t = Int32

"""Typedef for processor-local indexing of quadrants and nodes."""
const p4est_locidx_t = Int32

"""
    sc_int64_compare(v1, v2)

### Prototype
```c
int sc_int64_compare (const void *v1, const void *v2);
```
"""
function sc_int64_compare(v1, v2)
    @ccall libp4est.sc_int64_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""Typedef for globally unique indexing of quadrants."""
const p4est_gloidx_t = Int64

struct p4est_quadrant_data
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{p4est_quadrant_data}, f::Symbol)
    f === :user_data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :user_long && return Ptr{Clong}(x + 0)
    f === :user_int && return Ptr{Cint}(x + 0)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :piggy1 && return Ptr{__JL_Ctag_314}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_315}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_316}(x + 0)
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

"""
    p4est_quadrant

The 2D quadrant datatype

| Field | Note                                               |
| :---- | :------------------------------------------------- |
| x     | coordinates                                        |
| y     |                                                    |
| level | level of refinement                                |
| pad8  | padding                                            |
| pad16 |                                                    |
| p     | a union of additional data attached to a quadrant  |
"""
struct p4est_quadrant
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{p4est_quadrant}, f::Symbol)
    f === :x && return Ptr{p4est_qcoord_t}(x + 0)
    f === :y && return Ptr{p4est_qcoord_t}(x + 4)
    f === :level && return Ptr{Int8}(x + 8)
    f === :pad8 && return Ptr{Int8}(x + 9)
    f === :pad16 && return Ptr{Int16}(x + 10)
    f === :p && return Ptr{p4est_quadrant_data}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::p4est_quadrant, f::Symbol)
    r = Ref{p4est_quadrant}(x)
    ptr = Base.unsafe_convert(Ptr{p4est_quadrant}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p4est_quadrant}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""The 2D quadrant datatype"""
const p4est_quadrant_t = p4est_quadrant

@cenum sc_tag_t::UInt32 begin
    SC_TAG_FIRST = 214
    SC_TAG_AG_ALLTOALL = 214
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

"""
    sc_mpi_sizeof(t)

### Prototype
```c
size_t sc_mpi_sizeof (sc_MPI_Datatype t);
```
"""
function sc_mpi_sizeof(t)
    @ccall libp4est.sc_mpi_sizeof(t::MPI_Datatype)::Csize_t
end

"""
    sc_mpi_comm_attach_node_comms(comm, processes_per_node)

### Prototype
```c
void sc_mpi_comm_attach_node_comms (sc_MPI_Comm comm, int processes_per_node);
```
"""
function sc_mpi_comm_attach_node_comms(comm, processes_per_node)
    @ccall libp4est.sc_mpi_comm_attach_node_comms(comm::Cint, processes_per_node::Cint)::Cvoid
end

"""
    sc_mpi_comm_detach_node_comms(comm)

### Prototype
```c
void sc_mpi_comm_detach_node_comms (sc_MPI_Comm comm);
```
"""
function sc_mpi_comm_detach_node_comms(comm)
    @ccall libp4est.sc_mpi_comm_detach_node_comms(comm::Cint)::Cvoid
end

"""
    sc_mpi_comm_get_node_comms(comm, intranode, internode)

### Prototype
```c
void sc_mpi_comm_get_node_comms (sc_MPI_Comm comm, sc_MPI_Comm * intranode, sc_MPI_Comm * internode);
```
"""
function sc_mpi_comm_get_node_comms(comm, intranode, internode)
    @ccall libp4est.sc_mpi_comm_get_node_comms(comm::Cint, intranode::Ptr{Cint}, internode::Ptr{Cint})::Cvoid
end

"""
    sc_mpi_comm_get_and_attach(comm)

### Prototype
```c
int sc_mpi_comm_get_and_attach (sc_MPI_Comm comm);
```
"""
function sc_mpi_comm_get_and_attach(comm)
    @ccall libp4est.sc_mpi_comm_get_and_attach(comm::Cint)::Cint
end

# typedef void ( * sc_handler_t ) ( void * data )
const sc_handler_t = Ptr{Cvoid}

# typedef void ( * sc_log_handler_t ) ( FILE * log_stream , const char * filename , int lineno , int package , int category , int priority , const char * msg )
const sc_log_handler_t = Ptr{Cvoid}

# typedef void ( * sc_abort_handler_t ) ( void )
const sc_abort_handler_t = Ptr{Cvoid}

"""
    sc_memory_status(package)

### Prototype
```c
int sc_memory_status (int package);
```
"""
function sc_memory_status(package)
    @ccall libp4est.sc_memory_status(package::Cint)::Cint
end

"""
    sc_memory_check(package)

### Prototype
```c
void sc_memory_check (int package);
```
"""
function sc_memory_check(package)
    @ccall libp4est.sc_memory_check(package::Cint)::Cvoid
end

"""
    sc_memory_check_noerr(package)

Return error count or zero if all is ok.

### Prototype
```c
int sc_memory_check_noerr (int package);
```
"""
function sc_memory_check_noerr(package)
    @ccall libp4est.sc_memory_check_noerr(package::Cint)::Cint
end

"""
    sc_int_compare(v1, v2)

### Prototype
```c
int sc_int_compare (const void *v1, const void *v2);
```
"""
function sc_int_compare(v1, v2)
    @ccall libp4est.sc_int_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""
    sc_int8_compare(v1, v2)

### Prototype
```c
int sc_int8_compare (const void *v1, const void *v2);
```
"""
function sc_int8_compare(v1, v2)
    @ccall libp4est.sc_int8_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""
    sc_int16_compare(v1, v2)

### Prototype
```c
int sc_int16_compare (const void *v1, const void *v2);
```
"""
function sc_int16_compare(v1, v2)
    @ccall libp4est.sc_int16_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""
    sc_double_compare(v1, v2)

### Prototype
```c
int sc_double_compare (const void *v1, const void *v2);
```
"""
function sc_double_compare(v1, v2)
    @ccall libp4est.sc_double_compare(v1::Ptr{Cvoid}, v2::Ptr{Cvoid})::Cint
end

"""
    sc_atoi(nptr)

Safe version of the standard library atoi (3) function.

### Parameters
* `nptr`:\\[in\\] NUL-terminated string.
### Returns
Converted integer value. 0 if no valid number. INT\\_MAX on overflow, INT\\_MIN on underflow.
### Prototype
```c
int sc_atoi (const char *nptr);
```
"""
function sc_atoi(nptr)
    @ccall libp4est.sc_atoi(nptr::Cstring)::Cint
end

"""
    sc_atol(nptr)

Safe version of the standard library atol (3) function.

### Parameters
* `nptr`:\\[in\\] NUL-terminated string.
### Returns
Converted long value. 0 if no valid number. LONG\\_MAX on overflow, LONG\\_MIN on underflow.
### Prototype
```c
long sc_atol (const char *nptr);
```
"""
function sc_atol(nptr)
    @ccall libp4est.sc_atol(nptr::Cstring)::Clong
end

"""
    sc_set_log_defaults(log_stream, log_handler, log_thresold)

Controls the default SC log behavior.

### Parameters
* `log_stream`:\\[in\\] Set stream to use by [`sc_logf`](@ref) (or NULL for stdout).
* `log_handler`:\\[in\\] Set default SC log handler (NULL selects builtin).
* `log_threshold`:\\[in\\] Set default SC log threshold (or [`SC_LP_DEFAULT`](@ref)). May be [`SC_LP_ALWAYS`](@ref) or [`SC_LP_SILENT`](@ref).
### Prototype
```c
void sc_set_log_defaults (FILE * log_stream, sc_log_handler_t log_handler, int log_thresold);
```
"""
function sc_set_log_defaults(log_stream, log_handler, log_thresold)
    @ccall libp4est.sc_set_log_defaults(log_stream::Ptr{Libc.FILE}, log_handler::sc_log_handler_t, log_thresold::Cint)::Cvoid
end

"""
    sc_set_abort_handler(abort_handler)

Controls the default SC abort behavior.

### Parameters
* `abort_handler`:\\[in\\] Set default SC above handler (NULL selects builtin). ***This function should not return!***
### Prototype
```c
void sc_set_abort_handler (sc_abort_handler_t abort_handler);
```
"""
function sc_set_abort_handler(abort_handler)
    @ccall libp4est.sc_set_abort_handler(abort_handler::sc_abort_handler_t)::Cvoid
end

"""
    sc_log_indent_push_count(package, count)

Add spaces to the start of a package's default log format.

### Prototype
```c
void sc_log_indent_push_count (int package, int count);
```
"""
function sc_log_indent_push_count(package, count)
    @ccall libp4est.sc_log_indent_push_count(package::Cint, count::Cint)::Cvoid
end

"""
    sc_log_indent_pop_count(package, count)

Remove spaces from the start of a package's default log format.

### Prototype
```c
void sc_log_indent_pop_count (int package, int count);
```
"""
function sc_log_indent_pop_count(package, count)
    @ccall libp4est.sc_log_indent_pop_count(package::Cint, count::Cint)::Cvoid
end

"""
    sc_log_indent_push()

Add one space to the start of sc's default log format.

### Prototype
```c
void sc_log_indent_push (void);
```
"""
function sc_log_indent_push()
    @ccall libp4est.sc_log_indent_push()::Cvoid
end

"""
    sc_log_indent_pop()

Remove one space from the start of a sc's default log format.

### Prototype
```c
void sc_log_indent_pop (void);
```
"""
function sc_log_indent_pop()
    @ccall libp4est.sc_log_indent_pop()::Cvoid
end

"""
    sc_abort()

Print a stack trace, call the abort handler and then call abort ().

### Prototype
```c
void sc_abort (void) __attribute__ ((noreturn));
```
"""
function sc_abort()
    @ccall libp4est.sc_abort()::Cvoid
end

"""
    sc_abort_collective(msg)

Collective abort where only root prints a message

### Prototype
```c
void sc_abort_collective (const char *msg) __attribute__ ((noreturn));
```
"""
function sc_abort_collective(msg)
    @ccall libp4est.sc_abort_collective(msg::Cstring)::Cvoid
end

"""
    sc_package_register(log_handler, log_threshold, name, full)

Register a software package with SC. This function must only be called before additional threads are created. The logging parameters are as in [`sc_set_log_defaults`](@ref).

### Returns
Returns a unique package id.
### Prototype
```c
int sc_package_register (sc_log_handler_t log_handler, int log_threshold, const char *name, const char *full);
```
"""
function sc_package_register(log_handler, log_threshold, name, full)
    @ccall libp4est.sc_package_register(log_handler::sc_log_handler_t, log_threshold::Cint, name::Cstring, full::Cstring)::Cint
end

"""
    sc_package_is_registered(package_id)

Query whether an identifier matches a registered package.

### Parameters
* `package_id`:\\[in\\] Only a non-negative id can be registered.
### Returns
True if and only if the package id is non-negative and package is registered.
### Prototype
```c
int sc_package_is_registered (int package_id);
```
"""
function sc_package_is_registered(package_id)
    @ccall libp4est.sc_package_is_registered(package_id::Cint)::Cint
end

"""
    sc_package_lock(package_id)

Acquire a pthread mutex lock. If configured without --enable-pthread, this function does nothing. This function must be followed with a matching sc_package_unlock.

### Parameters
* `package_id`:\\[in\\] Either -1 for an undefined package or an id returned from sc_package_register. Depending on the value, the appropriate mutex is chosen. Thus, we may overlap locking calls with distinct package\\_id.
### Prototype
```c
void sc_package_lock (int package_id);
```
"""
function sc_package_lock(package_id)
    @ccall libp4est.sc_package_lock(package_id::Cint)::Cvoid
end

"""
    sc_package_unlock(package_id)

Release a pthread mutex lock. If configured without --enable-pthread, this function does nothing. This function must be follow a matching sc_package_lock.

### Parameters
* `package_id`:\\[in\\] Either -1 for an undefined package or an id returned from sc_package_register. Depending on the value, the appropriate mutex is chosen. Thus, we may overlap locking calls with distinct package\\_id.
### Prototype
```c
void sc_package_unlock (int package_id);
```
"""
function sc_package_unlock(package_id)
    @ccall libp4est.sc_package_unlock(package_id::Cint)::Cvoid
end

"""
    sc_package_set_verbosity(package_id, log_priority)

Set the logging verbosity of a registered package. This can be called at any point in the program, any number of times. It can only lower the verbosity at and below the value of [`SC_LP_THRESHOLD`](@ref).

### Parameters
* `package_id`:\\[in\\] Must be a registered package identifier.
### Prototype
```c
void sc_package_set_verbosity (int package_id, int log_priority);
```
"""
function sc_package_set_verbosity(package_id, log_priority)
    @ccall libp4est.sc_package_set_verbosity(package_id::Cint, log_priority::Cint)::Cvoid
end

"""
    sc_package_set_abort_alloc_mismatch(package_id, set_abort)

Set the unregister behavior of [`sc_package_unregister`](@ref)().

### Parameters
* `package_id`:\\[in\\] Must be -1 for the default package or the identifier of a registered package.
* `set_abort`:\\[in\\] True if [`sc_package_unregister`](@ref)() should abort if the number of allocs does not match the number of frees; false otherwise.
### Prototype
```c
void sc_package_set_abort_alloc_mismatch (int package_id, int set_abort);
```
"""
function sc_package_set_abort_alloc_mismatch(package_id, set_abort)
    @ccall libp4est.sc_package_set_abort_alloc_mismatch(package_id::Cint, set_abort::Cint)::Cvoid
end

"""
    sc_package_unregister(package_id)

Unregister a software package with SC. This function must only be called after additional threads are finished.

### Prototype
```c
void sc_package_unregister (int package_id);
```
"""
function sc_package_unregister(package_id)
    @ccall libp4est.sc_package_unregister(package_id::Cint)::Cvoid
end

"""
    sc_package_print_summary(log_priority)

Print a summary of all packages registered with SC. Uses the [`SC_LC_GLOBAL`](@ref) log category which by default only prints on rank 0.

### Parameters
* `log_priority`:\\[in\\] Priority passed to sc log functions.
### Prototype
```c
void sc_package_print_summary (int log_priority);
```
"""
function sc_package_print_summary(log_priority)
    @ccall libp4est.sc_package_print_summary(log_priority::Cint)::Cvoid
end

"""
    sc_init(mpicomm, catch_signals, print_backtrace, log_handler, log_threshold)

### Prototype
```c
void sc_init (sc_MPI_Comm mpicomm, int catch_signals, int print_backtrace, sc_log_handler_t log_handler, int log_threshold);
```
"""
function sc_init(mpicomm, catch_signals, print_backtrace, log_handler, log_threshold)
    @ccall libp4est.sc_init(mpicomm::MPI_Comm, catch_signals::Cint, print_backtrace::Cint, log_handler::sc_log_handler_t, log_threshold::Cint)::Cvoid
end

"""
    sc_finalize()

Unregisters all packages, runs the memory check, removes the signal handlers and resets sc\\_identifier and sc\\_root\\_*. This function aborts on any inconsistency found unless the global variable default\\_abort\\_mismatch is false. This function is optional. This function does not require [`sc_init`](@ref) to be called first.

### Prototype
```c
void sc_finalize (void);
```
"""
function sc_finalize()
    @ccall libp4est.sc_finalize()::Cvoid
end

"""
    sc_finalize_noabort()

Unregisters all packages, runs the memory check, removes the signal handlers and resets sc\\_identifier and sc\\_root\\_*. This function never aborts but returns the number of errors encountered. This function is optional. This function does not require [`sc_init`](@ref) to be called first.

### Returns
0 when everything is consistent, nonzero otherwise.
### Prototype
```c
int sc_finalize_noabort (void);
```
"""
function sc_finalize_noabort()
    @ccall libp4est.sc_finalize_noabort()::Cint
end

"""
    sc_is_root()

Identify the root process. Only meaningful between [`sc_init`](@ref) and [`sc_finalize`](@ref) and with a communicator that is not [`sc_MPI_COMM_NULL`](@ref) (otherwise always true).

### Returns
Return true for the root process and false otherwise.
### Prototype
```c
int sc_is_root (void);
```
"""
function sc_is_root()
    @ccall libp4est.sc_is_root()::Cint
end

"""
    sc_strcopy(dest, size, src)

Provide a string copy function.

### Parameters
* `dest`:\\[out\\] Buffer of length at least *size*. On output, not touched if NULL or *size* == 0.
* `size`:\\[in\\] Allocation length of *dest*.
* `src`:\\[in\\] Null-terminated string.
### Returns
Equivalent to sc_snprintf (dest, size, "s", src).
### Prototype
```c
void sc_strcopy (char *dest, size_t size, const char *src);
```
"""
function sc_strcopy(dest, size, src)
    @ccall libp4est.sc_strcopy(dest::Cstring, size::Csize_t, src::Cstring)::Cvoid
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function sc_snprintf(str, size, format, va_list...)
        :(@ccall(libp4est.sc_snprintf(str::Cstring, size::Csize_t, format::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

"""
    sc_version()

Return the full version of libsc.

### Returns
Return the version of libsc using the format `VERSION\\_MAJOR.VERSION\\_MINOR.VERSION\\_POINT`, where `VERSION_POINT` can contain dots and characters, e.g. to indicate the additional number of commits and a git commit hash.
### Prototype
```c
const char *sc_version (void);
```
"""
function sc_version()
    @ccall libp4est.sc_version()::Cstring
end

"""
    sc_version_major()

Return the major version of libsc.

### Returns
Return the major version of libsc.
### Prototype
```c
int sc_version_major (void);
```
"""
function sc_version_major()
    @ccall libp4est.sc_version_major()::Cint
end

"""
    sc_version_minor()

Return the minor version of libsc.

### Returns
Return the minor version of libsc.
### Prototype
```c
int sc_version_minor (void);
```
"""
function sc_version_minor()
    @ccall libp4est.sc_version_minor()::Cint
end

# typedef unsigned int ( * sc_hash_function_t ) ( const void * v , const void * u )
"""
Function to compute a hash value of an object.

### Parameters
* `v`:\\[in\\] The object to hash.
* `u`:\\[in\\] Arbitrary user data.
### Returns
Returns an unsigned integer.
"""
const sc_hash_function_t = Ptr{Cvoid}

# typedef int ( * sc_equal_function_t ) ( const void * v1 , const void * v2 , const void * u )
"""
Function to check equality of two objects.

### Parameters
* `u`:\\[in\\] Arbitrary user data.
### Returns
Returns false if *v1 is unequal *v2 and true otherwise.
"""
const sc_equal_function_t = Ptr{Cvoid}

# typedef int ( * sc_hash_foreach_t ) ( void * * v , const void * u )
"""
Function to call on every data item of a hash table.

### Parameters
* `v`:\\[in\\] The address of the pointer to the current object.
* `u`:\\[in\\] Arbitrary user data.
### Returns
Return true if the traversal should continue, false to stop.
"""
const sc_hash_foreach_t = Ptr{Cvoid}

"""
    sc_array_memory_used(array, is_dynamic)

Calculate the memory used by an array.

### Parameters
* `array`:\\[in\\] The array.
* `is_dynamic`:\\[in\\] True if created with [`sc_array_new`](@ref), false if initialized with [`sc_array_init`](@ref)
### Returns
Memory used in bytes.
### Prototype
```c
size_t sc_array_memory_used (sc_array_t * array, int is_dynamic);
```
"""
function sc_array_memory_used(array, is_dynamic)
    @ccall libp4est.sc_array_memory_used(array::Ptr{sc_array_t}, is_dynamic::Cint)::Csize_t
end

"""
    sc_array_new(elem_size)

Creates a new array structure with 0 elements.

### Parameters
* `elem_size`:\\[in\\] Size of one array element in bytes.
### Returns
Return an allocated array of zero length.
### Prototype
```c
sc_array_t *sc_array_new (size_t elem_size);
```
"""
function sc_array_new(elem_size)
    @ccall libp4est.sc_array_new(elem_size::Csize_t)::Ptr{sc_array_t}
end

"""
    sc_array_new_view(array, offset, length)

Creates a new view of an existing [`sc_array_t`](@ref).

### Parameters
* `array`:\\[in\\] The array must not be resized while view is alive.
* `offset`:\\[in\\] The offset of the viewed section in element units. This offset cannot be changed until the view is reset.
* `length`:\\[in\\] The length of the viewed section in element units. The view cannot be resized to exceed this length.
### Prototype
```c
sc_array_t *sc_array_new_view (sc_array_t * array, size_t offset, size_t length);
```
"""
function sc_array_new_view(array, offset, length)
    @ccall libp4est.sc_array_new_view(array::Ptr{sc_array_t}, offset::Csize_t, length::Csize_t)::Ptr{sc_array_t}
end

"""
    sc_array_new_data(base, elem_size, elem_count)

Creates a new view of an existing plain C array.

### Parameters
* `base`:\\[in\\] The data must not be moved while view is alive.
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `elem_count`:\\[in\\] The length of the view in element units. The view cannot be resized to exceed this length.
### Prototype
```c
sc_array_t *sc_array_new_data (void *base, size_t elem_size, size_t elem_count);
```
"""
function sc_array_new_data(base, elem_size, elem_count)
    @ccall libp4est.sc_array_new_data(base::Ptr{Cvoid}, elem_size::Csize_t, elem_count::Csize_t)::Ptr{sc_array_t}
end

"""
    sc_array_destroy(array)

Destroys an array structure.

### Parameters
* `array`:\\[in\\] The array to be destroyed.
### Prototype
```c
void sc_array_destroy (sc_array_t * array);
```
"""
function sc_array_destroy(array)
    @ccall libp4est.sc_array_destroy(array::Ptr{sc_array_t})::Cvoid
end

"""
    sc_array_destroy_null(parray)

Destroys an array structure and sets the pointer to NULL.

### Parameters
* `parray`:\\[in,out\\] Pointer to address of array to be destroyed. On output, *parray is NULL.
### Prototype
```c
void sc_array_destroy_null (sc_array_t ** parray);
```
"""
function sc_array_destroy_null(parray)
    @ccall libp4est.sc_array_destroy_null(parray::Ptr{Ptr{sc_array_t}})::Cvoid
end

"""
    sc_array_init(array, elem_size)

Initializes an already allocated (or static) array structure.

### Parameters
* `array`:\\[in,out\\] Array structure to be initialized.
* `elem_size`:\\[in\\] Size of one array element in bytes.
### Prototype
```c
void sc_array_init (sc_array_t * array, size_t elem_size);
```
"""
function sc_array_init(array, elem_size)
    @ccall libp4est.sc_array_init(array::Ptr{sc_array_t}, elem_size::Csize_t)::Cvoid
end

"""
    sc_array_init_size(array, elem_size, elem_count)

Initializes an already allocated (or static) array structure and allocates a given number of elements. Deprecated: use sc_array_init_count.

### Parameters
* `array`:\\[in,out\\] Array structure to be initialized.
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `elem_count`:\\[in\\] Number of initial array elements.
### Prototype
```c
void sc_array_init_size (sc_array_t * array, size_t elem_size, size_t elem_count);
```
"""
function sc_array_init_size(array, elem_size, elem_count)
    @ccall libp4est.sc_array_init_size(array::Ptr{sc_array_t}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

"""
    sc_array_init_count(array, elem_size, elem_count)

Initializes an already allocated (or static) array structure and allocates a given number of elements. This function supersedes sc_array_init_size.

### Parameters
* `array`:\\[in,out\\] Array structure to be initialized.
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `elem_count`:\\[in\\] Number of initial array elements.
### Prototype
```c
void sc_array_init_count (sc_array_t * array, size_t elem_size, size_t elem_count);
```
"""
function sc_array_init_count(array, elem_size, elem_count)
    @ccall libp4est.sc_array_init_count(array::Ptr{sc_array_t}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

"""
    sc_array_init_view(view, array, offset, length)

Initializes an already allocated (or static) view from existing [`sc_array_t`](@ref). The array view returned does not require [`sc_array_reset`](@ref) (doesn't hurt though).

### Parameters
* `view`:\\[in,out\\] Array structure to be initialized.
* `array`:\\[in\\] The array must not be resized while view is alive.
* `offset`:\\[in\\] The offset of the viewed section in element units. This offset cannot be changed until the view is reset.
* `length`:\\[in\\] The length of the view in element units. The view cannot be resized to exceed this length. It is not necessary to call [`sc_array_reset`](@ref) later.
### Prototype
```c
void sc_array_init_view (sc_array_t * view, sc_array_t * array, size_t offset, size_t length);
```
"""
function sc_array_init_view(view, array, offset, length)
    @ccall libp4est.sc_array_init_view(view::Ptr{sc_array_t}, array::Ptr{sc_array_t}, offset::Csize_t, length::Csize_t)::Cvoid
end

"""
    sc_array_init_data(view, base, elem_size, elem_count)

Initializes an already allocated (or static) view from given plain C data. The array view returned does not require [`sc_array_reset`](@ref) (doesn't hurt though).

### Parameters
* `view`:\\[in,out\\] Array structure to be initialized.
* `base`:\\[in\\] The data must not be moved while view is alive.
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `elem_count`:\\[in\\] The length of the view in element units. The view cannot be resized to exceed this length. It is not necessary to call [`sc_array_reset`](@ref) later.
### Prototype
```c
void sc_array_init_data (sc_array_t * view, void *base, size_t elem_size, size_t elem_count);
```
"""
function sc_array_init_data(view, base, elem_size, elem_count)
    @ccall libp4est.sc_array_init_data(view::Ptr{sc_array_t}, base::Ptr{Cvoid}, elem_size::Csize_t, elem_count::Csize_t)::Cvoid
end

"""
    sc_array_memset(array, c)

Run memset on the array storage. We pass the character to memset unchanged. Thus, care must be taken when setting values below -1 or above 127, just as with standard memset (3).

### Parameters
* `array`:\\[in,out\\] This array's storage will be overwritten.
* `c`:\\[in\\] Character to overwrite every byte with.
### Prototype
```c
void sc_array_memset (sc_array_t * array, int c);
```
"""
function sc_array_memset(array, c)
    @ccall libp4est.sc_array_memset(array::Ptr{sc_array_t}, c::Cint)::Cvoid
end

"""
    sc_array_reset(array)

Sets the array count to zero and frees all elements. This function turns a view into a newly initialized array.

!!! note

    Calling [`sc_array_init`](@ref), then any array operations, then [`sc_array_reset`](@ref) is memory neutral. As an exception, the two functions [`sc_array_init_view`](@ref) and [`sc_array_init_data`](@ref) do not require a subsequent call to [`sc_array_reset`](@ref). Regardless, it is legal to call [`sc_array_reset`](@ref) anyway.

### Parameters
* `array`:\\[in,out\\] Array structure to be reset.
### Prototype
```c
void sc_array_reset (sc_array_t * array);
```
"""
function sc_array_reset(array)
    @ccall libp4est.sc_array_reset(array::Ptr{sc_array_t})::Cvoid
end

"""
    sc_array_truncate(array)

Sets the array count to zero, but does not free elements. Not allowed for views.

!!! note

    This is intended to allow an [`sc_array`](@ref) to be used as a reusable buffer, where the "high water mark" of the buffer is preserved, so that O(log (max n)) reallocs occur over the life of the buffer.

### Parameters
* `array`:\\[in,out\\] Array structure to be truncated.
### Prototype
```c
void sc_array_truncate (sc_array_t * array);
```
"""
function sc_array_truncate(array)
    @ccall libp4est.sc_array_truncate(array::Ptr{sc_array_t})::Cvoid
end

"""
    sc_array_rewind(array, new_count)

Shorten an array without reallocating it.

### Parameters
* `array`:\\[in,out\\] The element count of this array is modified.
* `new_count`:\\[in\\] Must be less or equal than the **array**'s count. If it is less, the number of elements in the array is reduced without reallocating memory. The exception is a **new_count** of zero specified for an array that is not a view: In this case sc_array_reset is equivalent.
### Prototype
```c
void sc_array_rewind (sc_array_t * array, size_t new_count);
```
"""
function sc_array_rewind(array, new_count)
    @ccall libp4est.sc_array_rewind(array::Ptr{sc_array_t}, new_count::Csize_t)::Cvoid
end

"""
    sc_array_resize(array, new_count)

Sets the element count to new\\_count. If the array is not a view, reallocation takes place occasionally. If the array is a view, new\\_count must not be greater than the element count of the view when it was created. The original offset of the view cannot be changed.

### Parameters
* `array`:\\[in,out\\] The element count and address is modified.
* `new_count`:\\[in\\] New element count of the array. If it is zero and the array is not a view, the effect equals sc_array_reset.
### Prototype
```c
void sc_array_resize (sc_array_t * array, size_t new_count);
```
"""
function sc_array_resize(array, new_count)
    @ccall libp4est.sc_array_resize(array::Ptr{sc_array_t}, new_count::Csize_t)::Cvoid
end

"""
    sc_array_copy(dest, src)

Copy the contents of one array into another. Both arrays must have equal element sizes. The source array may be a view. We use memcpy (3): If the two arrays overlap, results are undefined.

### Parameters
* `dest`:\\[in\\] Array (not a view) will be resized and get new data.
* `src`:\\[in\\] Array used as source of new data, will not be changed.
### Prototype
```c
void sc_array_copy (sc_array_t * dest, sc_array_t * src);
```
"""
function sc_array_copy(dest, src)
    @ccall libp4est.sc_array_copy(dest::Ptr{sc_array_t}, src::Ptr{sc_array_t})::Cvoid
end

"""
    sc_array_copy_into(dest, dest_offset, src)

Copy the contents of one array into some portion of another. Both arrays must have equal element sizes. Either array may be a view. The destination array must be large enough. We use memcpy (3): If the two arrays overlap, results are undefined.

### Parameters
* `dest`:\\[in\\] Array will be written into. Its element count must be at least **dest_offset** + **src**->elem_count.
* `dest_offset`:\\[in\\] First index in **dest** array to be overwritten. As every index, it refers to elements, not bytes.
* `src`:\\[in\\] Array used as source of new data, will not be changed.
### Prototype
```c
void sc_array_copy_into (sc_array_t * dest, size_t dest_offset, sc_array_t * src);
```
"""
function sc_array_copy_into(dest, dest_offset, src)
    @ccall libp4est.sc_array_copy_into(dest::Ptr{sc_array_t}, dest_offset::Csize_t, src::Ptr{sc_array_t})::Cvoid
end

"""
    sc_array_move_part(dest, dest_offset, src, src_offset, count)

Copy part of one array into another using memmove (3). Both arrays must have equal element sizes. Either array may be a view. The destination array must be large enough. We use memmove (3): The two arrays may overlap.

### Parameters
* `dest`:\\[in\\] Array will be written into. Its element count must be at least **dest_offset** + **count**.
* `dest_offset`:\\[in\\] First index in **dest** array to be overwritten. As every index, it refers to elements, not bytes.
* `src`:\\[in\\] Array will be read from. Its element count must be at least **src_offset** + **count**.
* `src_offset`:\\[in\\] First index in **src** array to be used. As every index, it refers to elements, not bytes.
* `count`:\\[in\\] Number of entries copied.
### Prototype
```c
void sc_array_move_part (sc_array_t * dest, size_t dest_offset, sc_array_t * src, size_t src_offset, size_t count);
```
"""
function sc_array_move_part(dest, dest_offset, src, src_offset, count)
    @ccall libp4est.sc_array_move_part(dest::Ptr{sc_array_t}, dest_offset::Csize_t, src::Ptr{sc_array_t}, src_offset::Csize_t, count::Csize_t)::Cvoid
end

"""
    sc_array_sort(array, compar)

Sorts the array in ascending order wrt. the comparison function.

### Parameters
* `array`:\\[in\\] The array to sort.
* `compar`:\\[in\\] The comparison function to be used.
### Prototype
```c
void sc_array_sort (sc_array_t * array, int (*compar) (const void *, const void *));
```
"""
function sc_array_sort(array, compar)
    @ccall libp4est.sc_array_sort(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cvoid
end

"""
    sc_array_is_sorted(array, compar)

Check whether the array is sorted wrt. the comparison function.

### Parameters
* `array`:\\[in\\] The array to check.
* `compar`:\\[in\\] The comparison function to be used.
### Returns
True if array is sorted, false otherwise.
### Prototype
```c
int sc_array_is_sorted (sc_array_t * array, int (*compar) (const void *, const void *));
```
"""
function sc_array_is_sorted(array, compar)
    @ccall libp4est.sc_array_is_sorted(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cint
end

"""
    sc_array_is_equal(array, other)

Check whether two arrays have equal size, count, and content. Either array may be a view. Both arrays will not be changed.

### Parameters
* `array`:\\[in\\] One array to be compared.
* `other`:\\[in\\] A second array to be compared.
### Returns
True if array and other are equal, false otherwise.
### Prototype
```c
int sc_array_is_equal (sc_array_t * array, sc_array_t * other);
```
"""
function sc_array_is_equal(array, other)
    @ccall libp4est.sc_array_is_equal(array::Ptr{sc_array_t}, other::Ptr{sc_array_t})::Cint
end

"""
    sc_array_uniq(array, compar)

Removed duplicate entries from a sorted array. This function is not allowed for views.

### Parameters
* `array`:\\[in,out\\] The array size will be reduced as necessary.
* `compar`:\\[in\\] The comparison function to be used.
### Prototype
```c
void sc_array_uniq (sc_array_t * array, int (*compar) (const void *, const void *));
```
"""
function sc_array_uniq(array, compar)
    @ccall libp4est.sc_array_uniq(array::Ptr{sc_array_t}, compar::Ptr{Cvoid})::Cvoid
end

"""
    sc_array_bsearch(array, key, compar)

Performs a binary search on an array. The array must be sorted.

### Parameters
* `array`:\\[in\\] A sorted array to search in.
* `key`:\\[in\\] An element to be searched for.
* `compar`:\\[in\\] The comparison function to be used.
### Returns
Returns the index into array for the item found, or -1.
### Prototype
```c
ssize_t sc_array_bsearch (sc_array_t * array, const void *key, int (*compar) (const void *, const void *));
```
"""
function sc_array_bsearch(array, key, compar)
    @ccall libp4est.sc_array_bsearch(array::Ptr{sc_array_t}, key::Ptr{Cvoid}, compar::Ptr{Cvoid})::Cssize_t
end

# typedef size_t ( * sc_array_type_t ) ( sc_array_t * array , size_t index , void * data )
"""
Function to determine the enumerable type of an object in an array.

### Parameters
* `array`:\\[in\\] Array containing the object.
* `index`:\\[in\\] The location of the object.
* `data`:\\[in\\] Arbitrary user data.
"""
const sc_array_type_t = Ptr{Cvoid}

"""
    sc_array_split(array, offsets, num_types, type_fn, data)

Compute the offsets of groups of enumerable types in an array.

### Parameters
* `array`:\\[in\\] Array that is sorted in ascending order by type. If k indexes *array*, then 0 <= *type_fn* (*array*, k, *data*) < *num_types*.
* `offsets`:\\[in,out\\] An initialized array of type size\\_t that is resized to *num_types* + 1 entries. The indices j of *array* that contain objects of type k are *offsets*[k] <= j < *offsets*[k + 1]. If there are no objects of type k, then *offsets*[k] = *offset*[k + 1].
* `num_types`:\\[in\\] The number of possible types of objects in *array*.
* `type_fn`:\\[in\\] Returns the type of an object in the array.
* `data`:\\[in\\] Arbitrary user data passed to *type_fn*.
### Prototype
```c
void sc_array_split (sc_array_t * array, sc_array_t * offsets, size_t num_types, sc_array_type_t type_fn, void *data);
```
"""
function sc_array_split(array, offsets, num_types, type_fn, data)
    @ccall libp4est.sc_array_split(array::Ptr{sc_array_t}, offsets::Ptr{sc_array_t}, num_types::Csize_t, type_fn::sc_array_type_t, data::Ptr{Cvoid})::Cvoid
end

"""
    sc_array_is_permutation(array)

Determine whether *array* is an array of size\\_t's whose entries include every integer 0 <= i < array->elem\\_count.

### Parameters
* `array`:\\[in\\] An array.
### Returns
Returns 1 if array contains size\\_t elements whose entries include every integer 0 <= i < *array*->elem_count, 0 otherwise.
### Prototype
```c
int sc_array_is_permutation (sc_array_t * array);
```
"""
function sc_array_is_permutation(array)
    @ccall libp4est.sc_array_is_permutation(array::Ptr{sc_array_t})::Cint
end

"""
    sc_array_permute(array, newindices, keepperm)

Given permutation *newindices*, permute *array* in place. The data that on input is contained in *array*[i] will be contained in *array*[newindices[i]] on output. The entries of newindices will be altered unless *keepperm* is true.

### Parameters
* `array`:\\[in,out\\] An array.
* `newindices`:\\[in,out\\] Permutation array (see [`sc_array_is_permutation`](@ref)).
* `keepperm`:\\[in\\] If true, *newindices* will be unchanged by the algorithm; if false, *newindices* will be the identity permutation on output, but the algorithm will only use O(1) space.
### Prototype
```c
void sc_array_permute (sc_array_t * array, sc_array_t * newindices, int keepperm);
```
"""
function sc_array_permute(array, newindices, keepperm)
    @ccall libp4est.sc_array_permute(array::Ptr{sc_array_t}, newindices::Ptr{sc_array_t}, keepperm::Cint)::Cvoid
end

"""
    sc_array_checksum(array)

Computes the adler32 checksum of array data (see zlib documentation). This is a faster checksum than crc32, and it works with zeros as data.

### Prototype
```c
unsigned int sc_array_checksum (sc_array_t * array);
```
"""
function sc_array_checksum(array)
    @ccall libp4est.sc_array_checksum(array::Ptr{sc_array_t})::Cuint
end

"""
    sc_array_pqueue_add(array, temp, compar)

Adds an element to a priority queue. PQUEUE FUNCTIONS ARE UNTESTED AND CURRENTLY DISABLED. This function is not allowed for views. The priority queue is implemented as a heap in ascending order. A heap is a binary tree where the children are not less than their parent. Assumes that elements [0]..[elem\\_count-2] form a valid heap. Then propagates [elem\\_count-1] upward by swapping if necessary.

!!! note

    If the return value is zero for all elements in an array, the array is sorted linearly and unchanged.

### Parameters
* `temp`:\\[in\\] Pointer to unused allocated memory of elem\\_size.
* `compar`:\\[in\\] The comparison function to be used.
### Returns
Returns the number of swap operations.
### Prototype
```c
size_t sc_array_pqueue_add (sc_array_t * array, void *temp, int (*compar) (const void *, const void *));
```
"""
function sc_array_pqueue_add(array, temp, compar)
    @ccall libp4est.sc_array_pqueue_add(array::Ptr{sc_array_t}, temp::Ptr{Cvoid}, compar::Ptr{Cvoid})::Csize_t
end

"""
    sc_array_pqueue_pop(array, result, compar)

Pops the smallest element from a priority queue. PQUEUE FUNCTIONS ARE UNTESTED AND CURRENTLY DISABLED. This function is not allowed for views. This function assumes that the array forms a valid heap in ascending order.

!!! note

    This function resizes the array to elem\\_count-1.

### Parameters
* `result`:\\[out\\] Pointer to unused allocated memory of elem\\_size.
* `compar`:\\[in\\] The comparison function to be used.
### Returns
Returns the number of swap operations.
### Prototype
```c
size_t sc_array_pqueue_pop (sc_array_t * array, void *result, int (*compar) (const void *, const void *));
```
"""
function sc_array_pqueue_pop(array, result, compar)
    @ccall libp4est.sc_array_pqueue_pop(array::Ptr{sc_array_t}, result::Ptr{Cvoid}, compar::Ptr{Cvoid})::Csize_t
end

"""
    sc_array_index(array, iz)

### Prototype
```c
static inline void * sc_array_index (sc_array_t * array, size_t iz);
```
"""
function sc_array_index(array, iz)
    @ccall libp4est.sc_array_index(array::Ptr{sc_array_t}, iz::Csize_t)::Ptr{Cvoid}
end

"""
    sc_array_index_null(array, iz)

### Prototype
```c
static inline void * sc_array_index_null (sc_array_t * array, size_t iz);
```
"""
function sc_array_index_null(array, iz)
    @ccall libp4est.sc_array_index_null(array::Ptr{sc_array_t}, iz::Csize_t)::Ptr{Cvoid}
end

"""
    sc_array_index_int(array, i)

### Prototype
```c
static inline void * sc_array_index_int (sc_array_t * array, int i);
```
"""
function sc_array_index_int(array, i)
    @ccall libp4est.sc_array_index_int(array::Ptr{sc_array_t}, i::Cint)::Ptr{Cvoid}
end

"""
    sc_array_index_long(array, l)

### Prototype
```c
static inline void * sc_array_index_long (sc_array_t * array, long l);
```
"""
function sc_array_index_long(array, l)
    @ccall libp4est.sc_array_index_long(array::Ptr{sc_array_t}, l::Clong)::Ptr{Cvoid}
end

"""
    sc_array_index_ssize_t(array, is)

### Prototype
```c
static inline void * sc_array_index_ssize_t (sc_array_t * array, ssize_t is);
```
"""
function sc_array_index_ssize_t(array, is)
    @ccall libp4est.sc_array_index_ssize_t(array::Ptr{sc_array_t}, is::Cssize_t)::Ptr{Cvoid}
end

"""
    sc_array_index_int16(array, i16)

### Prototype
```c
static inline void * sc_array_index_int16 (sc_array_t * array, int16_t i16);
```
"""
function sc_array_index_int16(array, i16)
    @ccall libp4est.sc_array_index_int16(array::Ptr{sc_array_t}, i16::Int16)::Ptr{Cvoid}
end

"""
    sc_array_position(array, element)

### Prototype
```c
static inline size_t sc_array_position (sc_array_t * array, void *element);
```
"""
function sc_array_position(array, element)
    @ccall libp4est.sc_array_position(array::Ptr{sc_array_t}, element::Ptr{Cvoid})::Csize_t
end

"""
    sc_array_pop(array)

### Prototype
```c
static inline void * sc_array_pop (sc_array_t * array);
```
"""
function sc_array_pop(array)
    @ccall libp4est.sc_array_pop(array::Ptr{sc_array_t})::Ptr{Cvoid}
end

"""
    sc_array_push_count(array, add_count)

### Prototype
```c
static inline void * sc_array_push_count (sc_array_t * array, size_t add_count);
```
"""
function sc_array_push_count(array, add_count)
    @ccall libp4est.sc_array_push_count(array::Ptr{sc_array_t}, add_count::Csize_t)::Ptr{Cvoid}
end

"""
    sc_array_push(array)

### Prototype
```c
static inline void * sc_array_push (sc_array_t * array);
```
"""
function sc_array_push(array)
    @ccall libp4est.sc_array_push(array::Ptr{sc_array_t})::Ptr{Cvoid}
end

"""
    sc_mstamp

A data container to create memory items of the same size. Allocations are bundled so it's fast for small memory sizes. The items created will remain valid until the container is destroyed. There is no option to return an item to the container. See sc_mempool_t for that purpose.

| Field        | Note                            |
| :----------- | :------------------------------ |
| elem\\_size  | Input parameter: size per item  |
| per\\_stamp  | Number of items per stamp       |
| stamp\\_size | Bytes allocated in a stamp      |
| cur\\_snext  | Next number within a stamp      |
| current      | Memory of current stamp         |
| remember     | Collects all stamps             |
"""
struct sc_mstamp
    elem_size::Csize_t
    per_stamp::Csize_t
    stamp_size::Csize_t
    cur_snext::Csize_t
    current::Cstring
    remember::sc_array_t
end

"""A data container to create memory items of the same size. Allocations are bundled so it's fast for small memory sizes. The items created will remain valid until the container is destroyed. There is no option to return an item to the container. See sc_mempool_t for that purpose."""
const sc_mstamp_t = sc_mstamp

"""
    sc_mstamp_init(mst, stamp_unit, elem_size)

Initialize a memory stamp container. We provide allocation of fixed-size memory items without allocating new memory in every request. Instead we block the allocations in what we call a stamp of multiple items. Even if no allocations are done, the container's internal memory must be freed eventually by sc_mstamp_reset.

### Parameters
* `mst`:\\[in,out\\] Legal pointer to a stamp structure.
* `stamp_unit`:\\[in\\] Size of each memory block that we allocate. If it is larger than the element size, we may place more than one element in it. Passing 0 is legal and forces stamps that hold one item each.
* `elem_size`:\\[in\\] Size of each item. Passing 0 is legal. In that case, sc_mstamp_alloc returns NULL.
### Prototype
```c
void sc_mstamp_init (sc_mstamp_t * mst, size_t stamp_unit, size_t elem_size);
```
"""
function sc_mstamp_init(mst, stamp_unit, elem_size)
    @ccall libp4est.sc_mstamp_init(mst::Ptr{sc_mstamp_t}, stamp_unit::Csize_t, elem_size::Csize_t)::Cvoid
end

"""
    sc_mstamp_reset(mst)

Free all memory in a stamp structure and all items previously returned.

### Parameters
* `Properly`:\\[in,out\\] initialized stamp container. On output, the structure is undefined.
### Prototype
```c
void sc_mstamp_reset (sc_mstamp_t * mst);
```
"""
function sc_mstamp_reset(mst)
    @ccall libp4est.sc_mstamp_reset(mst::Ptr{sc_mstamp_t})::Cvoid
end

"""
    sc_mstamp_truncate(mst)

Free all memory in a stamp structure and initialize it anew. Equivalent to calling sc_mstamp_reset followed by sc_mstamp_init with the same stamp\\_unit and elem\\_size.

### Parameters
* `Properly`:\\[in,out\\] initialized stamp container. On output, its elements have been freed and it is ready for further use.
### Prototype
```c
void sc_mstamp_truncate (sc_mstamp_t * mst);
```
"""
function sc_mstamp_truncate(mst)
    @ccall libp4est.sc_mstamp_truncate(mst::Ptr{sc_mstamp_t})::Cvoid
end

"""
    sc_mstamp_alloc(mst)

Return a new item. The memory returned will stay legal until container is destroyed or truncated.

### Parameters
* `Properly`:\\[in,out\\] initialized stamp container.
### Returns
Pointer to an item ready to use. Legal until sc_stamp_destroy or sc_stamp_truncate is called on mst.
### Prototype
```c
void *sc_mstamp_alloc (sc_mstamp_t * mst);
```
"""
function sc_mstamp_alloc(mst)
    @ccall libp4est.sc_mstamp_alloc(mst::Ptr{sc_mstamp_t})::Ptr{Cvoid}
end

"""
    sc_mstamp_memory_used(mst)

Return memory size in bytes of all data allocated in the container.

### Parameters
* `Properly`:\\[in\\] initialized stamp container.
### Returns
Total container memory size in bytes.
### Prototype
```c
size_t sc_mstamp_memory_used (sc_mstamp_t * mst);
```
"""
function sc_mstamp_memory_used(mst)
    @ccall libp4est.sc_mstamp_memory_used(mst::Ptr{sc_mstamp_t})::Csize_t
end

"""
    sc_mempool

The [`sc_mempool`](@ref) object provides a large pool of equal-size elements. The pool grows dynamically for element allocation. Elements are referenced by their address which never changes. Elements can be freed (that is, returned to the pool) and are transparently reused. If the zero\\_and\\_persist option is selected, new elements are initialized to all zeros on creation, and the contents of an element are not touched between freeing and re-returning it.

| Field                | Note                             |
| :------------------- | :------------------------------- |
| elem\\_size          | size of a single element         |
| elem\\_count         | number of valid elements         |
| zero\\_and\\_persist | Boolean; is set in constructor.  |
| mstamp               | fixed-size chunk allocator       |
| freed                | buffers the freed elements       |
"""
struct sc_mempool
    elem_size::Csize_t
    elem_count::Csize_t
    zero_and_persist::Cint
    mstamp::sc_mstamp_t
    freed::sc_array_t
end

"""The [`sc_mempool`](@ref) object provides a large pool of equal-size elements. The pool grows dynamically for element allocation. Elements are referenced by their address which never changes. Elements can be freed (that is, returned to the pool) and are transparently reused. If the zero\\_and\\_persist option is selected, new elements are initialized to all zeros on creation, and the contents of an element are not touched between freeing and re-returning it."""
const sc_mempool_t = sc_mempool

"""
    sc_mempool_memory_used(mempool)

Calculate the memory used by a memory pool.

### Parameters
* `array`:\\[in\\] The memory pool.
### Returns
Memory used in bytes.
### Prototype
```c
size_t sc_mempool_memory_used (sc_mempool_t * mempool);
```
"""
function sc_mempool_memory_used(mempool)
    @ccall libp4est.sc_mempool_memory_used(mempool::Ptr{sc_mempool_t})::Csize_t
end

"""
    sc_mempool_new(elem_size)

Creates a new mempool structure with the zero\\_and\\_persist option off. The contents of any elements returned by [`sc_mempool_alloc`](@ref) are undefined.

### Parameters
* `elem_size`:\\[in\\] Size of one element in bytes.
### Returns
Returns an allocated and initialized memory pool.
### Prototype
```c
sc_mempool_t *sc_mempool_new (size_t elem_size);
```
"""
function sc_mempool_new(elem_size)
    @ccall libp4est.sc_mempool_new(elem_size::Csize_t)::Ptr{sc_mempool_t}
end

"""
    sc_mempool_new_zero_and_persist(elem_size)

Creates a new mempool structure with the zero\\_and\\_persist option on. The memory of newly created elements is zero'd out, and the contents of an element are not touched between freeing and re-returning it.

### Parameters
* `elem_size`:\\[in\\] Size of one element in bytes.
### Returns
Returns an allocated and initialized memory pool.
### Prototype
```c
sc_mempool_t *sc_mempool_new_zero_and_persist (size_t elem_size);
```
"""
function sc_mempool_new_zero_and_persist(elem_size)
    @ccall libp4est.sc_mempool_new_zero_and_persist(elem_size::Csize_t)::Ptr{sc_mempool_t}
end

"""
    sc_mempool_init(mempool, elem_size)

Same as [`sc_mempool_new`](@ref), but for an already allocated [`sc_mempool_t`](@ref) pointer.

### Prototype
```c
void sc_mempool_init (sc_mempool_t * mempool, size_t elem_size);
```
"""
function sc_mempool_init(mempool, elem_size)
    @ccall libp4est.sc_mempool_init(mempool::Ptr{sc_mempool_t}, elem_size::Csize_t)::Cvoid
end

"""
    sc_mempool_destroy(mempool)

Destroy a mempool structure. All elements that are still in use are invalidated.

### Parameters
* `mempool`:\\[in,out\\] Its memory is freed.
### Prototype
```c
void sc_mempool_destroy (sc_mempool_t * mempool);
```
"""
function sc_mempool_destroy(mempool)
    @ccall libp4est.sc_mempool_destroy(mempool::Ptr{sc_mempool_t})::Cvoid
end

"""
    sc_mempool_destroy_null(pmempool)

Destroy a mempool structure. All elements that are still in use are invalidated.

### Parameters
* `pmempool`:\\[in,out\\] Address of pointer to memory pool. Its memory is freed, pointer is NULLed.
### Prototype
```c
void sc_mempool_destroy_null (sc_mempool_t ** pmempool);
```
"""
function sc_mempool_destroy_null(pmempool)
    @ccall libp4est.sc_mempool_destroy_null(pmempool::Ptr{Ptr{sc_mempool_t}})::Cvoid
end

"""
    sc_mempool_reset(mempool)

Same as [`sc_mempool_destroy`](@ref), but does not free the pointer

### Prototype
```c
void sc_mempool_reset (sc_mempool_t * mempool);
```
"""
function sc_mempool_reset(mempool)
    @ccall libp4est.sc_mempool_reset(mempool::Ptr{sc_mempool_t})::Cvoid
end

"""
    sc_mempool_truncate(mempool)

Invalidates all previously returned pointers, resets count to 0.

### Prototype
```c
void sc_mempool_truncate (sc_mempool_t * mempool);
```
"""
function sc_mempool_truncate(mempool)
    @ccall libp4est.sc_mempool_truncate(mempool::Ptr{sc_mempool_t})::Cvoid
end

"""
    sc_mempool_alloc(mempool)

### Prototype
```c
static inline void * sc_mempool_alloc (sc_mempool_t * mempool);
```
"""
function sc_mempool_alloc(mempool)
    @ccall libp4est.sc_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{Cvoid}
end

"""
    sc_mempool_free(mempool, elem)

### Prototype
```c
static inline void sc_mempool_free (sc_mempool_t * mempool, void *elem);
```
"""
function sc_mempool_free(mempool, elem)
    @ccall libp4est.sc_mempool_free(mempool::Ptr{sc_mempool_t}, elem::Ptr{Cvoid})::Cvoid
end

"""
    sc_link

The [`sc_link`](@ref) structure is one link of a linked list.
"""
struct sc_link
    data::Ptr{Cvoid}
    next::Ptr{sc_link}
end

"""The [`sc_link`](@ref) structure is one link of a linked list."""
const sc_link_t = sc_link

"""
    sc_list

The [`sc_list`](@ref) object provides a linked list.
"""
struct sc_list
    elem_count::Csize_t
    first::Ptr{sc_link_t}
    last::Ptr{sc_link_t}
    allocator_owned::Cint
    allocator::Ptr{sc_mempool_t}
end

"""The [`sc_list`](@ref) object provides a linked list."""
const sc_list_t = sc_list

"""
    sc_list_memory_used(list, is_dynamic)

Calculate the total memory used by a list.

### Parameters
* `list`:\\[in\\] The list.
* `is_dynamic`:\\[in\\] True if created with [`sc_list_new`](@ref), false if initialized with [`sc_list_init`](@ref)
### Returns
Memory used in bytes.
### Prototype
```c
size_t sc_list_memory_used (sc_list_t * list, int is_dynamic);
```
"""
function sc_list_memory_used(list, is_dynamic)
    @ccall libp4est.sc_list_memory_used(list::Ptr{sc_list_t}, is_dynamic::Cint)::Csize_t
end

"""
    sc_list_new(allocator)

Allocate a new, empty linked list.

### Parameters
* `allocator`:\\[in\\] Memory allocator for [`sc_link_t`](@ref), can be NULL in which case an internal allocator is created.
### Returns
Pointer to a newly allocated, empty list object.
### Prototype
```c
sc_list_t *sc_list_new (sc_mempool_t * allocator);
```
"""
function sc_list_new(allocator)
    @ccall libp4est.sc_list_new(allocator::Ptr{sc_mempool_t})::Ptr{sc_list_t}
end

"""
    sc_list_destroy(list)

Destroy a linked list structure in O(N).

!!! note

    If allocator was provided in [`sc_list_new`](@ref), it will not be destroyed.

### Parameters
* `list`:\\[in,out\\] All memory allocated for this list is freed.
### Prototype
```c
void sc_list_destroy (sc_list_t * list);
```
"""
function sc_list_destroy(list)
    @ccall libp4est.sc_list_destroy(list::Ptr{sc_list_t})::Cvoid
end

"""
    sc_list_init(list, allocator)

Initialize a list object with an external link allocator.

### Parameters
* `list`:\\[in,out\\] List structure to be initialized.
* `allocator`:\\[in\\] External memory allocator for [`sc_link_t`](@ref), which must exist already.
### Prototype
```c
void sc_list_init (sc_list_t * list, sc_mempool_t * allocator);
```
"""
function sc_list_init(list, allocator)
    @ccall libp4est.sc_list_init(list::Ptr{sc_list_t}, allocator::Ptr{sc_mempool_t})::Cvoid
end

"""
    sc_list_reset(list)

Remove all elements from a list in O(N).

!!! note

    Calling [`sc_list_init`](@ref), then any list operations, then [`sc_list_reset`](@ref) is memory neutral.

### Parameters
* `list`:\\[in,out\\] List structure to be emptied.
### Prototype
```c
void sc_list_reset (sc_list_t * list);
```
"""
function sc_list_reset(list)
    @ccall libp4est.sc_list_reset(list::Ptr{sc_list_t})::Cvoid
end

"""
    sc_list_unlink(list)

Unlink all list elements without returning them to the mempool. This runs in O(1) but is dangerous because the link memory stays alive.

### Parameters
* `list`:\\[in,out\\] List structure to be unlinked.
### Prototype
```c
void sc_list_unlink (sc_list_t * list);
```
"""
function sc_list_unlink(list)
    @ccall libp4est.sc_list_unlink(list::Ptr{sc_list_t})::Cvoid
end

"""
    sc_list_prepend(list, data)

Insert a list element at the beginning of the list.

### Parameters
* `list`:\\[in,out\\] Valid list object.
* `data`:\\[in\\] A new link is created holding this data.
### Returns
The link that has been created for data.
### Prototype
```c
sc_link_t *sc_list_prepend (sc_list_t * list, void *data);
```
"""
function sc_list_prepend(list, data)
    @ccall libp4est.sc_list_prepend(list::Ptr{sc_list_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

"""
    sc_list_append(list, data)

Insert a list element at the end of the list.

### Parameters
* `list`:\\[in,out\\] Valid list object.
* `data`:\\[in\\] A new link is created holding this data.
### Returns
The link that has been created for data.
### Prototype
```c
sc_link_t *sc_list_append (sc_list_t * list, void *data);
```
"""
function sc_list_append(list, data)
    @ccall libp4est.sc_list_append(list::Ptr{sc_list_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

"""
    sc_list_insert(list, pred, data)

Insert an element after a given list position.

### Parameters
* `list`:\\[in,out\\] Valid list object.
* `pred`:\\[in,out\\] The predecessor of the element to be inserted.
* `data`:\\[in\\] A new link is created holding this data.
### Returns
The link that has been created for data.
### Prototype
```c
sc_link_t *sc_list_insert (sc_list_t * list, sc_link_t * pred, void *data);
```
"""
function sc_list_insert(list, pred, data)
    @ccall libp4est.sc_list_insert(list::Ptr{sc_list_t}, pred::Ptr{sc_link_t}, data::Ptr{Cvoid})::Ptr{sc_link_t}
end

"""
    sc_list_remove(list, pred)

Remove an element after a given list position.

### Parameters
* `list`:\\[in,out\\] Valid, non-empty list object.
* `pred`:\\[in\\] The predecessor of the element to be removed. If *pred* == NULL, the first element is removed, which is equivalent to calling [`sc_list_pop`](@ref) (list).
### Returns
The data of the removed and freed link.
### Prototype
```c
void *sc_list_remove (sc_list_t * list, sc_link_t * pred);
```
"""
function sc_list_remove(list, pred)
    @ccall libp4est.sc_list_remove(list::Ptr{sc_list_t}, pred::Ptr{sc_link_t})::Ptr{Cvoid}
end

"""
    sc_list_pop(list)

Remove an element from the front of the list.

### Parameters
* `list`:\\[in,out\\] Valid, non-empty list object.
### Returns
Returns the data of the removed first list element.
### Prototype
```c
void *sc_list_pop (sc_list_t * list);
```
"""
function sc_list_pop(list)
    @ccall libp4est.sc_list_pop(list::Ptr{sc_list_t})::Ptr{Cvoid}
end

"""
    sc_hash

The [`sc_hash`](@ref) implements a hash table. It uses an array which has linked lists as elements.

| Field        | Note                                   |
| :----------- | :------------------------------------- |
| elem\\_count | total number of objects contained      |
| slots        | the slot count is slots->elem\\_count  |
| user\\_data  | user data passed to hash function      |
| allocator    | must allocate [`sc_link_t`](@ref)      |
"""
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

"""The [`sc_hash`](@ref) implements a hash table. It uses an array which has linked lists as elements."""
const sc_hash_t = sc_hash

"""
    sc_hash_function_string(s, u)

Compute a hash value from a null-terminated string. This hash function is NOT cryptographically safe! Use libcrypt then.

### Parameters
* `s`:\\[in\\] Null-terminated string to be hashed.
* `u`:\\[in\\] Not used.
### Returns
The computed hash value as an unsigned integer.
### Prototype
```c
unsigned int sc_hash_function_string (const void *s, const void *u);
```
"""
function sc_hash_function_string(s, u)
    @ccall libp4est.sc_hash_function_string(s::Ptr{Cvoid}, u::Ptr{Cvoid})::Cuint
end

"""
    sc_hash_memory_used(hash)

Calculate the memory used by a hash table.

### Parameters
* `hash`:\\[in\\] The hash table.
### Returns
Memory used in bytes.
### Prototype
```c
size_t sc_hash_memory_used (sc_hash_t * hash);
```
"""
function sc_hash_memory_used(hash)
    @ccall libp4est.sc_hash_memory_used(hash::Ptr{sc_hash_t})::Csize_t
end

"""
    sc_hash_new(hash_fn, equal_fn, user_data, allocator)

Create a new hash table. The number of hash slots is chosen dynamically.

### Parameters
* `hash_fn`:\\[in\\] Function to compute the hash value.
* `equal_fn`:\\[in\\] Function to test two objects for equality.
* `user_data`:\\[in\\] User data passed through to the hash function.
* `allocator`:\\[in\\] Memory allocator for [`sc_link_t`](@ref), can be NULL.
### Prototype
```c
sc_hash_t *sc_hash_new (sc_hash_function_t hash_fn, sc_equal_function_t equal_fn, void *user_data, sc_mempool_t * allocator);
```
"""
function sc_hash_new(hash_fn, equal_fn, user_data, allocator)
    @ccall libp4est.sc_hash_new(hash_fn::sc_hash_function_t, equal_fn::sc_equal_function_t, user_data::Ptr{Cvoid}, allocator::Ptr{sc_mempool_t})::Ptr{sc_hash_t}
end

"""
    sc_hash_destroy(hash)

Destroy a hash table.

If the allocator is owned, this runs in O(1), otherwise in O(N).

!!! note

    If allocator was provided in [`sc_hash_new`](@ref), it will not be destroyed.

### Prototype
```c
void sc_hash_destroy (sc_hash_t * hash);
```
"""
function sc_hash_destroy(hash)
    @ccall libp4est.sc_hash_destroy(hash::Ptr{sc_hash_t})::Cvoid
end

"""
    sc_hash_destroy_null(phash)

Destroy a hash table and set its pointer to NULL. Destruction is done using sc_hash_destroy.

### Parameters
* `phash`:\\[in,out\\] Address of pointer to hash table. On output, pointer is NULLed.
### Prototype
```c
void sc_hash_destroy_null (sc_hash_t ** phash);
```
"""
function sc_hash_destroy_null(phash)
    @ccall libp4est.sc_hash_destroy_null(phash::Ptr{Ptr{sc_hash_t}})::Cvoid
end

"""
    sc_hash_truncate(hash)

Remove all entries from a hash table in O(N).

If the allocator is owned, it calls [`sc_hash_unlink`](@ref) and [`sc_mempool_truncate`](@ref). Otherwise, it calls [`sc_list_reset`](@ref) on every hash slot which is slower.

### Prototype
```c
void sc_hash_truncate (sc_hash_t * hash);
```
"""
function sc_hash_truncate(hash)
    @ccall libp4est.sc_hash_truncate(hash::Ptr{sc_hash_t})::Cvoid
end

"""
    sc_hash_unlink(hash)

Unlink all hash elements without returning them to the mempool.

If the allocator is not owned, this runs faster than [`sc_hash_truncate`](@ref), but is dangerous because of potential memory leaks.

### Parameters
* `hash`:\\[in,out\\] Hash structure to be unlinked.
### Prototype
```c
void sc_hash_unlink (sc_hash_t * hash);
```
"""
function sc_hash_unlink(hash)
    @ccall libp4est.sc_hash_unlink(hash::Ptr{sc_hash_t})::Cvoid
end

"""
    sc_hash_unlink_destroy(hash)

Same effect as unlink and destroy, but in O(1). This is dangerous because of potential memory leaks.

### Parameters
* `hash`:\\[in\\] Hash structure to be unlinked and destroyed.
### Prototype
```c
void sc_hash_unlink_destroy (sc_hash_t * hash);
```
"""
function sc_hash_unlink_destroy(hash)
    @ccall libp4est.sc_hash_unlink_destroy(hash::Ptr{sc_hash_t})::Cvoid
end

"""
    sc_hash_lookup(hash, v, found)

Check if an object is contained in the hash table.

### Parameters
* `v`:\\[in\\] The object to be looked up.
* `found`:\\[out\\] If found != NULL, *found is set to the address of the pointer to the already contained object if the object is found. You can assign to **found to override.
### Returns
Returns true if object is found, false otherwise.
### Prototype
```c
int sc_hash_lookup (sc_hash_t * hash, void *v, void ***found);
```
"""
function sc_hash_lookup(hash, v, found)
    @ccall libp4est.sc_hash_lookup(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Ptr{Cvoid}}})::Cint
end

"""
    sc_hash_insert_unique(hash, v, found)

Insert an object into a hash table if it is not contained already.

### Parameters
* `v`:\\[in\\] The object to be inserted.
* `found`:\\[out\\] If found != NULL, *found is set to the address of the pointer to the already contained, or if not present, the new object. You can assign to **found to override.
### Returns
Returns true if object is added, false if it is already contained.
### Prototype
```c
int sc_hash_insert_unique (sc_hash_t * hash, void *v, void ***found);
```
"""
function sc_hash_insert_unique(hash, v, found)
    @ccall libp4est.sc_hash_insert_unique(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Ptr{Cvoid}}})::Cint
end

"""
    sc_hash_remove(hash, v, found)

Remove an object from a hash table.

### Parameters
* `v`:\\[in\\] The object to be removed.
* `found`:\\[out\\] If found != NULL, *found is set to the object that is removed if that exists.
### Returns
Returns true if object is found, false if is not contained.
### Prototype
```c
int sc_hash_remove (sc_hash_t * hash, void *v, void **found);
```
"""
function sc_hash_remove(hash, v, found)
    @ccall libp4est.sc_hash_remove(hash::Ptr{sc_hash_t}, v::Ptr{Cvoid}, found::Ptr{Ptr{Cvoid}})::Cint
end

"""
    sc_hash_foreach(hash, fn)

Invoke a callback for every member of the hash table. The functions hash\\_fn and equal\\_fn are not called by this function.

### Prototype
```c
void sc_hash_foreach (sc_hash_t * hash, sc_hash_foreach_t fn);
```
"""
function sc_hash_foreach(hash, fn)
    @ccall libp4est.sc_hash_foreach(hash::Ptr{sc_hash_t}, fn::sc_hash_foreach_t)::Cvoid
end

"""
    sc_hash_print_statistics(package_id, log_priority, hash)

Compute and print statistical information about the occupancy.

### Prototype
```c
void sc_hash_print_statistics (int package_id, int log_priority, sc_hash_t * hash);
```
"""
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

"""
    sc_hash_array

The [`sc_hash_array`](@ref) implements an array backed up by a hash table. This enables O(1) access for array elements.
"""
struct sc_hash_array
    a::sc_array_t
    internal_data::sc_hash_array_data_t
    h::Ptr{sc_hash_t}
end

"""The [`sc_hash_array`](@ref) implements an array backed up by a hash table. This enables O(1) access for array elements."""
const sc_hash_array_t = sc_hash_array

"""
    sc_hash_array_memory_used(ha)

Calculate the memory used by a hash array.

### Parameters
* `ha`:\\[in\\] The hash array.
### Returns
Memory used in bytes.
### Prototype
```c
size_t sc_hash_array_memory_used (sc_hash_array_t * ha);
```
"""
function sc_hash_array_memory_used(ha)
    @ccall libp4est.sc_hash_array_memory_used(ha::Ptr{sc_hash_array_t})::Csize_t
end

"""
    sc_hash_array_new(elem_size, hash_fn, equal_fn, user_data)

Create a new hash array.

### Parameters
* `elem_size`:\\[in\\] Size of one array element in bytes.
* `hash_fn`:\\[in\\] Function to compute the hash value.
* `equal_fn`:\\[in\\] Function to test two objects for equality.
### Prototype
```c
sc_hash_array_t *sc_hash_array_new (size_t elem_size, sc_hash_function_t hash_fn, sc_equal_function_t equal_fn, void *user_data);
```
"""
function sc_hash_array_new(elem_size, hash_fn, equal_fn, user_data)
    @ccall libp4est.sc_hash_array_new(elem_size::Csize_t, hash_fn::sc_hash_function_t, equal_fn::sc_equal_function_t, user_data::Ptr{Cvoid})::Ptr{sc_hash_array_t}
end

"""
    sc_hash_array_destroy(hash_array)

Destroy a hash array.

### Prototype
```c
void sc_hash_array_destroy (sc_hash_array_t * hash_array);
```
"""
function sc_hash_array_destroy(hash_array)
    @ccall libp4est.sc_hash_array_destroy(hash_array::Ptr{sc_hash_array_t})::Cvoid
end

"""
    sc_hash_array_is_valid(hash_array)

Check the internal consistency of a hash array.

### Prototype
```c
int sc_hash_array_is_valid (sc_hash_array_t * hash_array);
```
"""
function sc_hash_array_is_valid(hash_array)
    @ccall libp4est.sc_hash_array_is_valid(hash_array::Ptr{sc_hash_array_t})::Cint
end

"""
    sc_hash_array_truncate(hash_array)

Remove all elements from the hash array.

### Parameters
* `hash_array`:\\[in,out\\] Hash array to truncate.
### Prototype
```c
void sc_hash_array_truncate (sc_hash_array_t * hash_array);
```
"""
function sc_hash_array_truncate(hash_array)
    @ccall libp4est.sc_hash_array_truncate(hash_array::Ptr{sc_hash_array_t})::Cvoid
end

"""
    sc_hash_array_lookup(hash_array, v, position)

Check if an object is contained in a hash array.

### Parameters
* `v`:\\[in\\] A pointer to the object.
* `position`:\\[out\\] If position != NULL, *position is set to the array position of the already contained object if found.
### Returns
Returns true if object is found, false otherwise.
### Prototype
```c
int sc_hash_array_lookup (sc_hash_array_t * hash_array, void *v, size_t *position);
```
"""
function sc_hash_array_lookup(hash_array, v, position)
    @ccall libp4est.sc_hash_array_lookup(hash_array::Ptr{sc_hash_array_t}, v::Ptr{Cvoid}, position::Ptr{Csize_t})::Cint
end

"""
    sc_hash_array_insert_unique(hash_array, v, position)

Insert an object into a hash array if it is not contained already. The object is not copied into the array. Use the return value for that. New objects are guaranteed to be added at the end of the array.

### Parameters
* `v`:\\[in\\] A pointer to the object. Used for search only.
* `position`:\\[out\\] If position != NULL, *position is set to the array position of the already contained, or if not present, the new object.
### Returns
Returns NULL if the object is already contained. Otherwise returns its new address in the array.
### Prototype
```c
void *sc_hash_array_insert_unique (sc_hash_array_t * hash_array, void *v, size_t *position);
```
"""
function sc_hash_array_insert_unique(hash_array, v, position)
    @ccall libp4est.sc_hash_array_insert_unique(hash_array::Ptr{sc_hash_array_t}, v::Ptr{Cvoid}, position::Ptr{Csize_t})::Ptr{Cvoid}
end

"""
    sc_hash_array_rip(hash_array, rip)

Extract the array data from a hash array and destroy everything else.

### Parameters
* `hash_array`:\\[in\\] The hash array is destroyed after extraction.
* `rip`:\\[in\\] Array structure that will be overwritten. All previous array data (if any) will be leaked. The filled array can be freed with [`sc_array_reset`](@ref).
### Prototype
```c
void sc_hash_array_rip (sc_hash_array_t * hash_array, sc_array_t * rip);
```
"""
function sc_hash_array_rip(hash_array, rip)
    @ccall libp4est.sc_hash_array_rip(hash_array::Ptr{sc_hash_array_t}, rip::Ptr{sc_array_t})::Cvoid
end

"""
    sc_recycle_array

The [`sc_recycle_array`](@ref) object provides an array of slots that can be reused.

It keeps a list of free slots in the array which will be used for insertion while available. Otherwise, the array is grown.
"""
struct sc_recycle_array
    elem_count::Csize_t
    a::sc_array_t
    f::sc_array_t
end

"""
The [`sc_recycle_array`](@ref) object provides an array of slots that can be reused.

It keeps a list of free slots in the array which will be used for insertion while available. Otherwise, the array is grown.
"""
const sc_recycle_array_t = sc_recycle_array

"""
    sc_recycle_array_init(rec_array, elem_size)

Initialize a recycle array.

### Parameters
* `elem_size`:\\[in\\] Size of the objects to be stored in the array.
### Prototype
```c
void sc_recycle_array_init (sc_recycle_array_t * rec_array, size_t elem_size);
```
"""
function sc_recycle_array_init(rec_array, elem_size)
    @ccall libp4est.sc_recycle_array_init(rec_array::Ptr{sc_recycle_array_t}, elem_size::Csize_t)::Cvoid
end

"""
    sc_recycle_array_reset(rec_array)

Reset a recycle array.

As with all \\_reset functions, calling \\_init, then any array operations, then \\_reset is memory neutral.

### Prototype
```c
void sc_recycle_array_reset (sc_recycle_array_t * rec_array);
```
"""
function sc_recycle_array_reset(rec_array)
    @ccall libp4est.sc_recycle_array_reset(rec_array::Ptr{sc_recycle_array_t})::Cvoid
end

"""
    sc_recycle_array_insert(rec_array, position)

Insert an object into the recycle array. The object is not copied into the array. Use the return value for that.

### Parameters
* `position`:\\[out\\] If position != NULL, *position is set to the array position of the inserted object.
### Returns
Returns the new address of the object in the array.
### Prototype
```c
void *sc_recycle_array_insert (sc_recycle_array_t * rec_array, size_t *position);
```
"""
function sc_recycle_array_insert(rec_array, position)
    @ccall libp4est.sc_recycle_array_insert(rec_array::Ptr{sc_recycle_array_t}, position::Ptr{Csize_t})::Ptr{Cvoid}
end

"""
    sc_recycle_array_remove(rec_array, position)

Remove an object from the recycle array. It must be valid.

### Parameters
* `position`:\\[in\\] Index into the array for the object to remove.
### Returns
The pointer to the removed object. Will be valid as long as no other function is called on this recycle array.
### Prototype
```c
void *sc_recycle_array_remove (sc_recycle_array_t * rec_array, size_t position);
```
"""
function sc_recycle_array_remove(rec_array, position)
    @ccall libp4est.sc_recycle_array_remove(rec_array::Ptr{sc_recycle_array_t}, position::Csize_t)::Ptr{Cvoid}
end

"""
    sc_io_error_t

Error values for io.

| Enumerator              | Note                                                                         |
| :---------------------- | :--------------------------------------------------------------------------- |
| SC\\_IO\\_ERROR\\_NONE  | The value of zero means no error.                                            |
| SC\\_IO\\_ERROR\\_FATAL | The io object is now disfunctional.                                          |
| SC\\_IO\\_ERROR\\_AGAIN | Another io operation may resolve it. The function just returned was a noop.  |
"""
@cenum sc_io_error_t::Int32 begin
    SC_IO_ERROR_NONE = 0
    SC_IO_ERROR_FATAL = -1
    SC_IO_ERROR_AGAIN = -2
end

"""
    sc_io_mode_t

| Enumerator              | Note                         |
| :---------------------- | :--------------------------- |
| SC\\_IO\\_MODE\\_WRITE  | Semantics as "w" in fopen.   |
| SC\\_IO\\_MODE\\_APPEND | Semantics as "a" in fopen.   |
| SC\\_IO\\_MODE\\_LAST   | Invalid entry to close list  |
"""
@cenum sc_io_mode_t::UInt32 begin
    SC_IO_MODE_WRITE = 0
    SC_IO_MODE_APPEND = 1
    SC_IO_MODE_LAST = 2
end

"""
    sc_io_encode_t

| Enumerator              | Note                         |
| :---------------------- | :--------------------------- |
| SC\\_IO\\_ENCODE\\_LAST | Invalid entry to close list  |
"""
@cenum sc_io_encode_t::UInt32 begin
    SC_IO_ENCODE_NONE = 0
    SC_IO_ENCODE_LAST = 1
end

"""
    sc_io_type_t

| Enumerator            | Note                         |
| :-------------------- | :--------------------------- |
| SC\\_IO\\_TYPE\\_LAST | Invalid entry to close list  |
"""
@cenum sc_io_type_t::UInt32 begin
    SC_IO_TYPE_BUFFER = 0
    SC_IO_TYPE_FILENAME = 1
    SC_IO_TYPE_FILEFILE = 2
    SC_IO_TYPE_LAST = 3
end

"""
    sc_io_sink

| Field          | Note                          |
| :------------- | :---------------------------- |
| buffer\\_bytes | distinguish from array elems  |
"""
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

"""
    sc_io_source

| Field          | Note                          |
| :------------- | :---------------------------- |
| buffer\\_bytes | distinguish from array elems  |
"""
struct sc_io_source
    iotype::sc_io_type_t
    encode::sc_io_encode_t
    buffer::Ptr{sc_array_t}
    buffer_bytes::Csize_t
    file::Ptr{Libc.FILE}
    bytes_in::Csize_t
    bytes_out::Csize_t
    mirror::Ptr{sc_io_sink_t}
    mirror_buffer::Ptr{sc_array_t}
end

const sc_io_source_t = sc_io_source

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function sc_io_sink_new(iotype, mode, encode, va_list...)
        :(@ccall(libp4est.sc_io_sink_new(iotype::sc_io_type_t, mode::sc_io_mode_t, encode::sc_io_encode_t; $(to_c_type_pairs(va_list)...))::Ptr{sc_io_sink_t}))
    end

"""
    sc_io_sink_destroy(sink)

Free data sink. Calls [`sc_io_sink_complete`](@ref) and discards the final counts. Errors from complete lead to SC\\_IO\\_ERROR\\_FATAL returned from this function. Call [`sc_io_sink_complete`](@ref) yourself if bytes\\_out is of interest.

### Parameters
* `sink`:\\[in,out\\] The sink object to complete and free.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_sink_destroy (sc_io_sink_t * sink);
```
"""
function sc_io_sink_destroy(sink)
    @ccall libp4est.sc_io_sink_destroy(sink::Ptr{sc_io_sink_t})::Cint
end

"""
    sc_io_sink_write(sink, data, bytes_avail)

Write data to a sink. Data may be buffered and sunk in a later call. The internal counters sink->bytes\\_in and sink->bytes\\_out are updated.

### Parameters
* `sink`:\\[in,out\\] The sink object to write to.
* `data`:\\[in\\] Data passed into sink.
* `bytes_avail`:\\[in\\] Number of data bytes passed in.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_sink_write (sc_io_sink_t * sink, const void *data, size_t bytes_avail);
```
"""
function sc_io_sink_write(sink, data, bytes_avail)
    @ccall libp4est.sc_io_sink_write(sink::Ptr{sc_io_sink_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t)::Cint
end

"""
    sc_io_sink_complete(sink, bytes_in, bytes_out)

Flush all buffered output data to sink. This function may return SC\\_IO\\_ERROR\\_AGAIN if another write is required. Currently this may happen if BUFFER requires an integer multiple of bytes. If successful, the updated value of bytes read and written is returned in bytes\\_in/out, and the sink status is reset as if the sink had just been created. In particular, the bytes counters are reset to zero. The internal state of the sink is not changed otherwise. It is legal to continue writing to the sink hereafter. The sink actions taken depend on its type. BUFFER, FILEFILE: none. FILENAME: call fclose on sink->file.

### Parameters
* `sink`:\\[in,out\\] The sink object to write to.
* `bytes_in`:\\[in,out\\] Bytes received since the last new or complete call. May be NULL.
* `bytes_out`:\\[in,out\\] Bytes written since the last new or complete call. May be NULL.
### Returns
0 if completed, nonzero on error.
### Prototype
```c
int sc_io_sink_complete (sc_io_sink_t * sink, size_t * bytes_in, size_t * bytes_out);
```
"""
function sc_io_sink_complete(sink, bytes_in, bytes_out)
    @ccall libp4est.sc_io_sink_complete(sink::Ptr{sc_io_sink_t}, bytes_in::Ptr{Csize_t}, bytes_out::Ptr{Csize_t})::Cint
end

"""
    sc_io_sink_align(sink, bytes_align)

Align sink to a byte boundary by writing zeros.

### Parameters
* `sink`:\\[in,out\\] The sink object to align.
* `bytes_align`:\\[in\\] Byte boundary.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_sink_align (sc_io_sink_t * sink, size_t bytes_align);
```
"""
function sc_io_sink_align(sink, bytes_align)
    @ccall libp4est.sc_io_sink_align(sink::Ptr{sc_io_sink_t}, bytes_align::Csize_t)::Cint
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function sc_io_source_new(iotype, encode, va_list...)
        :(@ccall(libp4est.sc_io_source_new(iotype::sc_io_type_t, encode::sc_io_encode_t; $(to_c_type_pairs(va_list)...))::Ptr{sc_io_source_t}))
    end

"""
    sc_io_source_destroy(source)

Free data source. Calls [`sc_io_source_complete`](@ref) and requires it to return no error. This is to avoid discarding buffered data that has not been passed to read.

### Parameters
* `source`:\\[in,out\\] The source object to free.
### Returns
0 on success. Nonzero if an error is encountered or is\\_complete returns one.
### Prototype
```c
int sc_io_source_destroy (sc_io_source_t * source);
```
"""
function sc_io_source_destroy(source)
    @ccall libp4est.sc_io_source_destroy(source::Ptr{sc_io_source_t})::Cint
end

"""
    sc_io_source_read(source, data, bytes_avail, bytes_out)

Read data from a source. The internal counters source->bytes\\_in and source->bytes\\_out are updated. Data is read until the data buffer has not enough room anymore, or source becomes empty. It is possible that data already read internally remains in the source object for the next call. Call [`sc_io_source_complete`](@ref) and check its return value to find out. Returns an error if bytes\\_out is NULL and less than bytes\\_avail are read.

### Parameters
* `source`:\\[in,out\\] The source object to read from.
* `data`:\\[in\\] Data buffer for reading from sink. If NULL the output data will be thrown away.
* `bytes_avail`:\\[in\\] Number of bytes available in data buffer.
* `bytes_out`:\\[in,out\\] If not NULL, byte count read into data buffer. Otherwise, requires to read exactly bytes\\_avail.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_source_read (sc_io_source_t * source, void *data, size_t bytes_avail, size_t * bytes_out);
```
"""
function sc_io_source_read(source, data, bytes_avail, bytes_out)
    @ccall libp4est.sc_io_source_read(source::Ptr{sc_io_source_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t, bytes_out::Ptr{Csize_t})::Cint
end

"""
    sc_io_source_complete(source, bytes_in, bytes_out)

Determine whether all data buffered from source has been returned by read. If it returns SC\\_IO\\_ERROR\\_AGAIN, another [`sc_io_source_read`](@ref) is required. If the call returns no error, the internal counters source->bytes\\_in and source->bytes\\_out are returned to the caller if requested, and reset to 0. The internal state of the source is not changed otherwise. It is legal to continue reading from the source hereafter.

### Parameters
* `source`:\\[in,out\\] The source object to read from.
* `bytes_in`:\\[in,out\\] If not NULL and true is returned, the total size of the data sourced.
* `bytes_out`:\\[in,out\\] If not NULL and true is returned, total bytes passed out by source\\_read.
### Returns
SC\\_IO\\_ERROR\\_AGAIN if buffered data remaining. Otherwise return ERROR\\_NONE and reset counters.
### Prototype
```c
int sc_io_source_complete (sc_io_source_t * source, size_t * bytes_in, size_t * bytes_out);
```
"""
function sc_io_source_complete(source, bytes_in, bytes_out)
    @ccall libp4est.sc_io_source_complete(source::Ptr{sc_io_source_t}, bytes_in::Ptr{Csize_t}, bytes_out::Ptr{Csize_t})::Cint
end

"""
    sc_io_source_align(source, bytes_align)

Align source to a byte boundary by skipping.

### Parameters
* `source`:\\[in,out\\] The source object to align.
* `bytes_align`:\\[in\\] Byte boundary.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_source_align (sc_io_source_t * source, size_t bytes_align);
```
"""
function sc_io_source_align(source, bytes_align)
    @ccall libp4est.sc_io_source_align(source::Ptr{sc_io_source_t}, bytes_align::Csize_t)::Cint
end

"""
    sc_io_source_activate_mirror(source)

Activate a buffer that mirrors (i.e., stores) the data that was read.

### Parameters
* `source`:\\[in,out\\] The source object to activate mirror in.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_source_activate_mirror (sc_io_source_t * source);
```
"""
function sc_io_source_activate_mirror(source)
    @ccall libp4est.sc_io_source_activate_mirror(source::Ptr{sc_io_source_t})::Cint
end

"""
    sc_io_source_read_mirror(source, data, bytes_avail, bytes_out)

Read data from the source's mirror. Same behaviour as [`sc_io_source_read`](@ref).

### Parameters
* `source`:\\[in,out\\] The source object to read mirror data from.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int sc_io_source_read_mirror (sc_io_source_t * source, void *data, size_t bytes_avail, size_t * bytes_out);
```
"""
function sc_io_source_read_mirror(source, data, bytes_avail, bytes_out)
    @ccall libp4est.sc_io_source_read_mirror(source::Ptr{sc_io_source_t}, data::Ptr{Cvoid}, bytes_avail::Csize_t, bytes_out::Ptr{Csize_t})::Cint
end

"""
    sc_vtk_write_binary(vtkfile, numeric_data, byte_length)

This function writes numeric binary data in VTK base64 encoding.

### Parameters
* `vtkfile`: Stream opened for writing.
* `numeric_data`: A pointer to a numeric data array.
* `byte_length`: The length of the data array in bytes.
### Returns
Returns 0 on success, -1 on file error.
### Prototype
```c
int sc_vtk_write_binary (FILE * vtkfile, char *numeric_data, size_t byte_length);
```
"""
function sc_vtk_write_binary(vtkfile, numeric_data, byte_length)
    @ccall libp4est.sc_vtk_write_binary(vtkfile::Ptr{Libc.FILE}, numeric_data::Cstring, byte_length::Csize_t)::Cint
end

"""
    sc_vtk_write_compressed(vtkfile, numeric_data, byte_length)

This function writes numeric binary data in VTK compressed format.

### Parameters
* `vtkfile`: Stream opened for writing.
* `numeric_data`: A pointer to a numeric data array.
* `byte_length`: The length of the data array in bytes.
### Returns
Returns 0 on success, -1 on file error.
### Prototype
```c
int sc_vtk_write_compressed (FILE * vtkfile, char *numeric_data, size_t byte_length);
```
"""
function sc_vtk_write_compressed(vtkfile, numeric_data, byte_length)
    @ccall libp4est.sc_vtk_write_compressed(vtkfile::Ptr{Libc.FILE}, numeric_data::Cstring, byte_length::Csize_t)::Cint
end

"""
    sc_fwrite(ptr, size, nmemb, file, errmsg)

Write memory content to a file.

!!! note

    This function aborts on file errors.

### Parameters
* `ptr`:\\[in\\] Data array to write to disk.
* `size`:\\[in\\] Size of one array member.
* `nmemb`:\\[in\\] Number of array members.
* `file`:\\[in,out\\] File pointer, must be opened for writing.
* `errmsg`:\\[in\\] Error message passed to [`SC_CHECK_ABORT`](@ref).
### Prototype
```c
void sc_fwrite (const void *ptr, size_t size, size_t nmemb, FILE * file, const char *errmsg);
```
"""
function sc_fwrite(ptr, size, nmemb, file, errmsg)
    @ccall libp4est.sc_fwrite(ptr::Ptr{Cvoid}, size::Csize_t, nmemb::Csize_t, file::Ptr{Libc.FILE}, errmsg::Cstring)::Cvoid
end

"""
    sc_fread(ptr, size, nmemb, file, errmsg)

Read file content into memory.

!!! note

    This function aborts on file errors.

### Parameters
* `ptr`:\\[out\\] Data array to read from disk.
* `size`:\\[in\\] Size of one array member.
* `nmemb`:\\[in\\] Number of array members.
* `file`:\\[in,out\\] File pointer, must be opened for reading.
* `errmsg`:\\[in\\] Error message passed to [`SC_CHECK_ABORT`](@ref).
### Prototype
```c
void sc_fread (void *ptr, size_t size, size_t nmemb, FILE * file, const char *errmsg);
```
"""
function sc_fread(ptr, size, nmemb, file, errmsg)
    @ccall libp4est.sc_fread(ptr::Ptr{Cvoid}, size::Csize_t, nmemb::Csize_t, file::Ptr{Libc.FILE}, errmsg::Cstring)::Cvoid
end

"""
    sc_fflush_fsync_fclose(file)

Best effort to flush a file's data to disc and close it.

### Parameters
* `file`:\\[in,out\\] File open for writing.
### Prototype
```c
void sc_fflush_fsync_fclose (FILE * file);
```
"""
function sc_fflush_fsync_fclose(file)
    @ccall libp4est.sc_fflush_fsync_fclose(file::Ptr{Libc.FILE})::Cvoid
end

"""
    sc_mpi_read(mpifile, ptr, zcount, t, errmsg)

### Prototype
```c
void sc_mpi_read (MPI_File mpifile, const void *ptr, size_t zcount, sc_MPI_Datatype t, const char *errmsg);
```
"""
function sc_mpi_read(mpifile, ptr, zcount, t, errmsg)
    @ccall libp4est.sc_mpi_read(mpifile::MPI_File, ptr::Ptr{Cvoid}, zcount::Csize_t, t::MPI_Datatype, errmsg::Cstring)::Cvoid
end

"""
    sc_mpi_write(mpifile, ptr, zcount, t, errmsg)

### Prototype
```c
void sc_mpi_write (MPI_File mpifile, const void *ptr, size_t zcount, sc_MPI_Datatype t, const char *errmsg);
```
"""
function sc_mpi_write(mpifile, ptr, zcount, t, errmsg)
    @ccall libp4est.sc_mpi_write(mpifile::MPI_File, ptr::Ptr{Cvoid}, zcount::Csize_t, t::MPI_Datatype, errmsg::Cstring)::Cvoid
end

"""
    p4est_comm_tag

Tags for MPI messages
"""
@cenum p4est_comm_tag::UInt32 begin
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

"""Tags for MPI messages"""
const p4est_comm_tag_t = p4est_comm_tag

# no prototype is found for this function at p4est_base.h:325:1, please use with caution
"""
    p4est_log_indent_push()

### Prototype
```c
static inline void p4est_log_indent_push ();
```
"""
function p4est_log_indent_push()
    @ccall libp4est.p4est_log_indent_push()::Cvoid
end

# no prototype is found for this function at p4est_base.h:331:1, please use with caution
"""
    p4est_log_indent_pop()

### Prototype
```c
static inline void p4est_log_indent_pop ();
```
"""
function p4est_log_indent_pop()
    @ccall libp4est.p4est_log_indent_pop()::Cvoid
end

"""
    p4est_init(log_handler, log_threshold)

Registers [`p4est`](@ref) with the SC Library and sets the logging behavior. This function is optional. This function must only be called before additional threads are created. If this function is not called or called with log\\_handler == NULL, the default SC log handler will be used. If this function is not called or called with log\\_threshold == [`SC_LP_DEFAULT`](@ref), the default SC log threshold will be used. The default SC log settings can be changed with [`sc_set_log_defaults`](@ref) ().

### Prototype
```c
void p4est_init (sc_log_handler_t log_handler, int log_threshold);
```
"""
function p4est_init(log_handler, log_threshold)
    @ccall libp4est.p4est_init(log_handler::sc_log_handler_t, log_threshold::Cint)::Cvoid
end

"""
    p4est_topidx_hash2(tt)

### Prototype
```c
static inline unsigned p4est_topidx_hash2 (const p4est_topidx_t * tt);
```
"""
function p4est_topidx_hash2(tt)
    @ccall libp4est.p4est_topidx_hash2(tt::Ptr{p4est_topidx_t})::Cuint
end

"""
    p4est_topidx_hash3(tt)

### Prototype
```c
static inline unsigned p4est_topidx_hash3 (const p4est_topidx_t * tt);
```
"""
function p4est_topidx_hash3(tt)
    @ccall libp4est.p4est_topidx_hash3(tt::Ptr{p4est_topidx_t})::Cuint
end

"""
    p4est_topidx_hash4(tt)

### Prototype
```c
static inline unsigned p4est_topidx_hash4 (const p4est_topidx_t * tt);
```
"""
function p4est_topidx_hash4(tt)
    @ccall libp4est.p4est_topidx_hash4(tt::Ptr{p4est_topidx_t})::Cuint
end

"""
    p4est_topidx_is_sorted(t, length)

### Prototype
```c
static inline int p4est_topidx_is_sorted (p4est_topidx_t * t, int length);
```
"""
function p4est_topidx_is_sorted(t, length)
    @ccall libp4est.p4est_topidx_is_sorted(t::Ptr{p4est_topidx_t}, length::Cint)::Cint
end

"""
    p4est_topidx_bsort(t, length)

### Prototype
```c
static inline void p4est_topidx_bsort (p4est_topidx_t * t, int length);
```
"""
function p4est_topidx_bsort(t, length)
    @ccall libp4est.p4est_topidx_bsort(t::Ptr{p4est_topidx_t}, length::Cint)::Cvoid
end

"""
    p4est_partition_cut_uint64(global_num, p, num_procs)

### Prototype
```c
static inline uint64_t p4est_partition_cut_uint64 (uint64_t global_num, int p, int num_procs);
```
"""
function p4est_partition_cut_uint64(global_num, p, num_procs)
    @ccall libp4est.p4est_partition_cut_uint64(global_num::UInt64, p::Cint, num_procs::Cint)::UInt64
end

"""
    p4est_partition_cut_gloidx(global_num, p, num_procs)

### Prototype
```c
static inline p4est_gloidx_t p4est_partition_cut_gloidx (p4est_gloidx_t global_num, int p, int num_procs);
```
"""
function p4est_partition_cut_gloidx(global_num, p, num_procs)
    @ccall libp4est.p4est_partition_cut_gloidx(global_num::p4est_gloidx_t, p::Cint, num_procs::Cint)::p4est_gloidx_t
end

"""
    p4est_version()

Return the full version of [`p4est`](@ref).

### Returns
Return the version of [`p4est`](@ref) using the format `VERSION\\_MAJOR.VERSION\\_MINOR.VERSION\\_POINT`, where `VERSION_POINT` can contain dots and characters, e.g. to indicate the additional number of commits and a git commit hash.
### Prototype
```c
const char *p4est_version (void);
```
"""
function p4est_version()
    @ccall libp4est.p4est_version()::Cstring
end

"""
    p4est_version_major()

Return the major version of [`p4est`](@ref).

### Returns
Return the major version of [`p4est`](@ref).
### Prototype
```c
int p4est_version_major (void);
```
"""
function p4est_version_major()
    @ccall libp4est.p4est_version_major()::Cint
end

"""
    p4est_version_minor()

Return the minor version of [`p4est`](@ref).

### Returns
Return the minor version of [`p4est`](@ref).
### Prototype
```c
int p4est_version_minor (void);
```
"""
function p4est_version_minor()
    @ccall libp4est.p4est_version_minor()::Cint
end

"""
    p4est_connect_type_t

Characterize a type of adjacency.

Several functions involve relationships between neighboring trees and/or quadrants, and their behavior depends on how one defines adjacency: 1) entities are adjacent if they share a face, or 2) entities are adjacent if they share a face or corner. [`p4est_connect_type_t`](@ref) is used to choose the desired behavior. This enum must fit into an int8\\_t.
"""
@cenum p4est_connect_type_t::UInt32 begin
    P4EST_CONNECT_FACE = 21
    P4EST_CONNECT_CORNER = 22
    P4EST_CONNECT_FULL = 22
end

"""
    p4est_connectivity_encode_t

Typedef for serialization method.

| Enumerator                   | Note                              |
| :--------------------------- | :-------------------------------- |
| P4EST\\_CONN\\_ENCODE\\_LAST | Invalid entry to close the list.  |
"""
@cenum p4est_connectivity_encode_t::UInt32 begin
    P4EST_CONN_ENCODE_NONE = 0
    P4EST_CONN_ENCODE_LAST = 1
end

"""
    p4est_connect_type_int(btype)

Convert the [`p4est_connect_type_t`](@ref) into a number.

### Parameters
* `btype`:\\[in\\] The balance type to convert.
### Returns
Returns 1 or 2.
### Prototype
```c
int p4est_connect_type_int (p4est_connect_type_t btype);
```
"""
function p4est_connect_type_int(btype)
    @ccall libp4est.p4est_connect_type_int(btype::p4est_connect_type_t)::Cint
end

"""
    p4est_connect_type_string(btype)

Convert the [`p4est_connect_type_t`](@ref) into a const string.

### Parameters
* `btype`:\\[in\\] The balance type to convert.
### Returns
Returns a pointer to a constant string.
### Prototype
```c
const char *p4est_connect_type_string (p4est_connect_type_t btype);
```
"""
function p4est_connect_type_string(btype)
    @ccall libp4est.p4est_connect_type_string(btype::p4est_connect_type_t)::Cstring
end

"""
    p4est_connectivity

This structure holds the 2D inter-tree connectivity information. Identification of arbitrary faces and corners is possible.

The arrays tree\\_to\\_* are stored in z ordering. For corners the order wrt. yx is 00 01 10 11. For faces the order is -x +x -y +y. They are allocated [0][0]..[0][3]..[num\\_trees-1][0]..[num\\_trees-1][3].

The values for tree\\_to\\_face are 0..7 where ttf % 4 gives the face number and ttf / 4 the face orientation code. The orientation is 0 for edges that are aligned in z-order, and 1 for edges that are running opposite in z-order.

It is valid to specify num\\_vertices as 0. In this case vertices and tree\\_to\\_vertex are set to NULL. Otherwise the vertex coordinates are stored in the array vertices as [0][0]..[0][2]..[num\\_vertices-1][0]..[num\\_vertices-1][2].

The corners are only stored when they connect trees. In this case tree\\_to\\_corner indexes into *ctt_offset*. Otherwise the tree\\_to\\_corner entry must be -1 and this corner is ignored. If num\\_corners == 0, tree\\_to\\_corner and corner\\_to\\_* arrays are set to NULL.

The arrays corner\\_to\\_* store a variable number of entries per corner. For corner c these are at position [ctt\\_offset[c]]..[ctt\\_offset[c+1]-1]. Their number for corner c is ctt\\_offset[c+1] - ctt\\_offset[c]. The entries encode all trees adjacent to corner c. The size of the corner\\_to\\_* arrays is num\\_ctt = ctt\\_offset[num\\_corners].

The *\\_to\\_attr arrays may have arbitrary contents defined by the user.

| Field                | Note                                                                                 |
| :------------------- | :----------------------------------------------------------------------------------- |
| num\\_vertices       | the number of vertices that define the *embedding* of the forest (not the topology)  |
| num\\_trees          | the number of trees                                                                  |
| num\\_corners        | the number of corners that help define topology                                      |
| vertices             | an array of size (3 * *num_vertices*)                                                |
| tree\\_to\\_vertex   | embed each tree into  ```c++ R^3 ```  for e.g. visualization (see p4est\\_vtk.h)     |
| tree\\_attr\\_bytes  | bytes per tree in tree\\_to\\_attr                                                   |
| tree\\_to\\_attr     | not touched by [`p4est`](@ref)                                                       |
| tree\\_to\\_tree     | (4 * *num_trees*) neighbors across faces                                             |
| tree\\_to\\_face     | (4 * *num_trees*) face to face+orientation (see description)                         |
| tree\\_to\\_corner   | (4 * *num_trees*) or NULL (see description)                                          |
| ctt\\_offset         | corner to offset in *corner_to_tree* and *corner_to_corner*                          |
| corner\\_to\\_tree   | list of trees that meet at a corner                                                  |
| corner\\_to\\_corner | list of tree-corners that meet at a corner                                           |
"""
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

"""
This structure holds the 2D inter-tree connectivity information. Identification of arbitrary faces and corners is possible.

The arrays tree\\_to\\_* are stored in z ordering. For corners the order wrt. yx is 00 01 10 11. For faces the order is -x +x -y +y. They are allocated [0][0]..[0][3]..[num\\_trees-1][0]..[num\\_trees-1][3].

The values for tree\\_to\\_face are 0..7 where ttf % 4 gives the face number and ttf / 4 the face orientation code. The orientation is 0 for edges that are aligned in z-order, and 1 for edges that are running opposite in z-order.

It is valid to specify num\\_vertices as 0. In this case vertices and tree\\_to\\_vertex are set to NULL. Otherwise the vertex coordinates are stored in the array vertices as [0][0]..[0][2]..[num\\_vertices-1][0]..[num\\_vertices-1][2].

The corners are only stored when they connect trees. In this case tree\\_to\\_corner indexes into *ctt_offset*. Otherwise the tree\\_to\\_corner entry must be -1 and this corner is ignored. If num\\_corners == 0, tree\\_to\\_corner and corner\\_to\\_* arrays are set to NULL.

The arrays corner\\_to\\_* store a variable number of entries per corner. For corner c these are at position [ctt\\_offset[c]]..[ctt\\_offset[c+1]-1]. Their number for corner c is ctt\\_offset[c+1] - ctt\\_offset[c]. The entries encode all trees adjacent to corner c. The size of the corner\\_to\\_* arrays is num\\_ctt = ctt\\_offset[num\\_corners].

The *\\_to\\_attr arrays may have arbitrary contents defined by the user.
"""
const p4est_connectivity_t = p4est_connectivity

"""
    p4est_connectivity_memory_used(conn)

Calculate memory usage of a connectivity structure.

### Parameters
* `conn`:\\[in\\] Connectivity structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p4est_connectivity_memory_used (p4est_connectivity_t * conn);
```
"""
function p4est_connectivity_memory_used(conn)
    @ccall libp4est.p4est_connectivity_memory_used(conn::Ptr{p4est_connectivity_t})::Csize_t
end

struct p4est_corner_transform_t
    ntree::p4est_topidx_t
    ncorner::Int8
end

struct p4est_corner_info_t
    icorner::p4est_topidx_t
    corner_transforms::sc_array_t
end

"""
    p4est_connectivity_face_neighbor_face_corner(fc, f, nf, o)

Transform a face corner across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `fc`:\\[in\\] A face corner number in 0..1.
* `f`:\\[in\\] A face that the face corner number *fc* is relative to.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The face corner number relative to the neighbor's face.
### Prototype
```c
int p4est_connectivity_face_neighbor_face_corner (int fc, int f, int nf, int o);
```
"""
function p4est_connectivity_face_neighbor_face_corner(fc, f, nf, o)
    @ccall libp4est.p4est_connectivity_face_neighbor_face_corner(fc::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p4est_connectivity_face_neighbor_corner(c, f, nf, o)

Transform a corner across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `c`:\\[in\\] A corner number in 0..3.
* `f`:\\[in\\] A face number that touches the corner *c*.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The number of the corner seen from the neighbor tree.
### Prototype
```c
int p4est_connectivity_face_neighbor_corner (int c, int f, int nf, int o);
```
"""
function p4est_connectivity_face_neighbor_corner(c, f, nf, o)
    @ccall libp4est.p4est_connectivity_face_neighbor_corner(c::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p4est_connectivity_new(num_vertices, num_trees, num_corners, num_ctt)

Allocate a connectivity structure. The attribute fields are initialized to NULL.

### Parameters
* `num_vertices`:\\[in\\] Number of total vertices (i.e. geometric points).
* `num_trees`:\\[in\\] Number of trees in the forest.
* `num_corners`:\\[in\\] Number of tree-connecting corners.
* `num_ctt`:\\[in\\] Number of total trees in corner\\_to\\_tree array.
### Returns
A connectivity structure with allocated arrays.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_corners, p4est_topidx_t num_ctt);
```
"""
function p4est_connectivity_new(num_vertices, num_trees, num_corners, num_ctt)
    @ccall libp4est.p4est_connectivity_new(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_corners::p4est_topidx_t, num_ctt::p4est_topidx_t)::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_copy(num_vertices, num_trees, num_corners, vertices, ttv, ttt, ttf, ttc, coff, ctt, ctc)

Allocate a connectivity structure and populate from constants. The attribute fields are initialized to NULL.

### Parameters
* `num_vertices`:\\[in\\] Number of total vertices (i.e. geometric points).
* `num_trees`:\\[in\\] Number of trees in the forest.
* `num_corners`:\\[in\\] Number of tree-connecting corners.
* `coff`:\\[in\\] Corner-to-tree offsets (num\\_corners + 1 values). This must always be non-NULL; in trivial cases it is just a pointer to a p4est\\_topix value of 0.
### Returns
The connectivity is checked for validity.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_copy (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_corners, const double *vertices, const p4est_topidx_t * ttv, const p4est_topidx_t * ttt, const int8_t * ttf, const p4est_topidx_t * ttc, const p4est_topidx_t * coff, const p4est_topidx_t * ctt, const int8_t * ctc);
```
"""
function p4est_connectivity_new_copy(num_vertices, num_trees, num_corners, vertices, ttv, ttt, ttf, ttc, coff, ctt, ctc)
    @ccall libp4est.p4est_connectivity_new_copy(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_corners::p4est_topidx_t, vertices::Ptr{Cdouble}, ttv::Ptr{p4est_topidx_t}, ttt::Ptr{p4est_topidx_t}, ttf::Ptr{Int8}, ttc::Ptr{p4est_topidx_t}, coff::Ptr{p4est_topidx_t}, ctt::Ptr{p4est_topidx_t}, ctc::Ptr{Int8})::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_bcast(conn_in, root, comm)

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_bcast (p4est_connectivity_t * conn_in, int root, sc_MPI_Comm comm);
```
"""
function p4est_connectivity_bcast(conn_in, root, comm)
    @ccall libp4est.p4est_connectivity_bcast(conn_in::Ptr{p4est_connectivity_t}, root::Cint, comm::Cint)::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_destroy(connectivity)

Destroy a connectivity structure. Also destroy all attributes.

### Prototype
```c
void p4est_connectivity_destroy (p4est_connectivity_t * connectivity);
```
"""
function p4est_connectivity_destroy(connectivity)
    @ccall libp4est.p4est_connectivity_destroy(connectivity::Ptr{p4est_connectivity_t})::Cvoid
end

"""
    p4est_connectivity_set_attr(conn, bytes_per_tree)

Allocate or free the attribute fields in a connectivity.

### Parameters
* `conn`:\\[in,out\\] The conn->*\\_to\\_attr fields must either be NULL or previously be allocated by this function.
* `bytes_per_tree`:\\[in\\] If 0, tree\\_to\\_attr is freed (being NULL is ok). If positive, requested space is allocated.
### Prototype
```c
void p4est_connectivity_set_attr (p4est_connectivity_t * conn, size_t bytes_per_tree);
```
"""
function p4est_connectivity_set_attr(conn, bytes_per_tree)
    @ccall libp4est.p4est_connectivity_set_attr(conn::Ptr{p4est_connectivity_t}, bytes_per_tree::Csize_t)::Cvoid
end

"""
    p4est_connectivity_is_valid(connectivity)

Examine a connectivity structure.

### Returns
Returns true if structure is valid, false otherwise.
### Prototype
```c
int p4est_connectivity_is_valid (p4est_connectivity_t * connectivity);
```
"""
function p4est_connectivity_is_valid(connectivity)
    @ccall libp4est.p4est_connectivity_is_valid(connectivity::Ptr{p4est_connectivity_t})::Cint
end

"""
    p4est_connectivity_is_equal(conn1, conn2)

Check two connectivity structures for equality.

### Returns
Returns true if structures are equal, false otherwise.
### Prototype
```c
int p4est_connectivity_is_equal (p4est_connectivity_t * conn1, p4est_connectivity_t * conn2);
```
"""
function p4est_connectivity_is_equal(conn1, conn2)
    @ccall libp4est.p4est_connectivity_is_equal(conn1::Ptr{p4est_connectivity_t}, conn2::Ptr{p4est_connectivity_t})::Cint
end

"""
    p4est_connectivity_sink(conn, sink)

Write connectivity to a sink object.

### Parameters
* `conn`:\\[in\\] The connectivity to be written.
* `sink`:\\[in,out\\] The connectivity is written into this sink.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int p4est_connectivity_sink (p4est_connectivity_t * conn, sc_io_sink_t * sink);
```
"""
function p4est_connectivity_sink(conn, sink)
    @ccall libp4est.p4est_connectivity_sink(conn::Ptr{p4est_connectivity_t}, sink::Ptr{sc_io_sink_t})::Cint
end

"""
    p4est_connectivity_deflate(conn, code)

Allocate memory and store the connectivity information there.

### Parameters
* `conn`:\\[in\\] The connectivity structure to be exported to memory.
* `code`:\\[in\\] Encoding and compression method for serialization.
### Returns
Newly created array that contains the information.
### Prototype
```c
sc_array_t *p4est_connectivity_deflate (p4est_connectivity_t * conn, p4est_connectivity_encode_t code);
```
"""
function p4est_connectivity_deflate(conn, code)
    @ccall libp4est.p4est_connectivity_deflate(conn::Ptr{p4est_connectivity_t}, code::p4est_connectivity_encode_t)::Ptr{sc_array_t}
end

"""
    p4est_connectivity_save(filename, connectivity)

Save a connectivity structure to disk.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `connectivity`:\\[in\\] Valid connectivity structure.
### Returns
Returns 0 on success, nonzero on file error.
### Prototype
```c
int p4est_connectivity_save (const char *filename, p4est_connectivity_t * connectivity);
```
"""
function p4est_connectivity_save(filename, connectivity)
    @ccall libp4est.p4est_connectivity_save(filename::Cstring, connectivity::Ptr{p4est_connectivity_t})::Cint
end

"""
    p4est_connectivity_source(source)

Read connectivity from a source object.

### Parameters
* `source`:\\[in,out\\] The connectivity is read from this source.
### Returns
The newly created connectivity, or NULL on error.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_source (sc_io_source_t * source);
```
"""
function p4est_connectivity_source(source)
    @ccall libp4est.p4est_connectivity_source(source::Ptr{sc_io_source_t})::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_inflate(buffer)

Create new connectivity from a memory buffer.

### Parameters
* `buffer`:\\[in\\] The connectivity is created from this memory buffer.
### Returns
The newly created connectivity, or NULL on error.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_inflate (sc_array_t * buffer);
```
"""
function p4est_connectivity_inflate(buffer)
    @ccall libp4est.p4est_connectivity_inflate(buffer::Ptr{sc_array_t})::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_load(filename, bytes)

Load a connectivity structure from disk.

### Parameters
* `filename`:\\[in\\] Name of the file to read.
* `bytes`:\\[in,out\\] Size in bytes of connectivity on disk or NULL.
### Returns
Returns valid connectivity, or NULL on file error.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_load (const char *filename, size_t *bytes);
```
"""
function p4est_connectivity_load(filename, bytes)
    @ccall libp4est.p4est_connectivity_load(filename::Cstring, bytes::Ptr{Csize_t})::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_unitsquare()

Create a connectivity structure for the unit square.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_unitsquare (void);
```
"""
function p4est_connectivity_new_unitsquare()
    @ccall libp4est.p4est_connectivity_new_unitsquare()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_periodic()

Create a connectivity structure for an all-periodic unit square.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_periodic (void);
```
"""
function p4est_connectivity_new_periodic()
    @ccall libp4est.p4est_connectivity_new_periodic()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_rotwrap()

Create a connectivity structure for a periodic unit square. The left and right faces are identified, and bottom and top opposite.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_rotwrap (void);
```
"""
function p4est_connectivity_new_rotwrap()
    @ccall libp4est.p4est_connectivity_new_rotwrap()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_twotrees(l_face, r_face, orientation)

Create a connectivity structure for two trees being rotated w.r.t. each other in a user-defined way

### Parameters
* `l_face`:\\[in\\] index of left face
* `r_face`:\\[in\\] index of right face
* `orientation`:\\[in\\] orientation of trees w.r.t. each other
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_twotrees (int l_face, int r_face, int orientation);
```
"""
function p4est_connectivity_new_twotrees(l_face, r_face, orientation)
    @ccall libp4est.p4est_connectivity_new_twotrees(l_face::Cint, r_face::Cint, orientation::Cint)::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_corner()

Create a connectivity structure for a three-tree mesh around a corner.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_corner (void);
```
"""
function p4est_connectivity_new_corner()
    @ccall libp4est.p4est_connectivity_new_corner()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_pillow()

Create a connectivity structure for two trees on top of each other.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_pillow (void);
```
"""
function p4est_connectivity_new_pillow()
    @ccall libp4est.p4est_connectivity_new_pillow()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_moebius()

Create a connectivity structure for a five-tree moebius band.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_moebius (void);
```
"""
function p4est_connectivity_new_moebius()
    @ccall libp4est.p4est_connectivity_new_moebius()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_star()

Create a connectivity structure for a six-tree star.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_star (void);
```
"""
function p4est_connectivity_new_star()
    @ccall libp4est.p4est_connectivity_new_star()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_cubed()

Create a connectivity structure for the six sides of a unit cube. The ordering of the trees is as follows: 0 1 2 3 <-- 3: axis-aligned top side 4 5. This choice has been made for maximum symmetry (see tree\\_to\\_* in .c file).

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_cubed (void);
```
"""
function p4est_connectivity_new_cubed()
    @ccall libp4est.p4est_connectivity_new_cubed()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_disk_nonperiodic()

Create a connectivity structure for a five-tree flat spherical disk. This disk can just as well be used as a square to test non-Cartesian maps. Without any mapping this connectivity covers the square [-3, 3]**2.

### Returns
Initialized and usable connectivity.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_disk_nonperiodic (void);
```
"""
function p4est_connectivity_new_disk_nonperiodic()
    @ccall libp4est.p4est_connectivity_new_disk_nonperiodic()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_disk(periodic_a, periodic_b)

Create a connectivity structure for a five-tree flat spherical disk. This disk can just as well be used as a square to test non-Cartesian maps. Without any mapping this connectivity covers the square [-3, 3]**2.

!!! note

    The API of this function has changed to accept two arguments. You can query the #define [`P4EST_CONN_DISK_PERIODIC`](@ref) to check whether the new version with the argument is in effect.

The ordering of the trees is as follows: 4 1 2 3 0.

The outside x faces may be identified topologically. The outside y faces may be identified topologically. Both identifications may be specified simultaneously. The general shape and periodicity are the same as those obtained with p4est_connectivity_new_brick (1, 1, periodic\\_a, periodic\\_b).

When setting *periodic_a* and *periodic_b* to false, the result is the same as that of p4est_connectivity_new_disk_nonperiodic.

### Parameters
* `periodic_a`:\\[in\\] Bool to make disk periodic in x direction.
* `periodic_b`:\\[in\\] Bool to make disk periodic in y direction.
### Returns
Initialized and usable connectivity.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_disk (int periodic_a, int periodic_b);
```
"""
function p4est_connectivity_new_disk(periodic_a, periodic_b)
    @ccall libp4est.p4est_connectivity_new_disk(periodic_a::Cint, periodic_b::Cint)::Ptr{p4est_connectivity_t}
end

# no prototype is found for this function at p4est_connectivity.h:475:23, please use with caution
"""
    p4est_connectivity_new_icosahedron()

Create a connectivity for mapping the sphere using an icosahedron.

The regular icosadron is a polyhedron with 20 faces, each of which is an equilateral triangle. To build the [`p4est`](@ref) connectivity, we group faces 2 by 2 to from 10 quadrangles, and thus 10 trees.

This connectivity is meant to be used together with p4est_geometry_new_icosahedron to map the sphere.

The flat connectivity looks like that: Vextex numbering:

A00 A01 A02 A03 A04 / \\ / \\ / \\ / \\ / \\ A05---A06---A07---A08---A09---A10 \\ / \\ / \\ / \\ / \\ / \\ A11---A12---A13---A14---A15---A16 \\ / \\ / \\ / \\ / \\ / A17 A18 A19 A20 A21

Origin in A05.

Tree numbering:

0 2 4 6 8 1 3 5 7 9

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_icosahedron ();
```
"""
function p4est_connectivity_new_icosahedron()
    @ccall libp4est.p4est_connectivity_new_icosahedron()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_shell2d()

Create a connectivity structure that builds a 2d spherical shell. p8est_connectivity_new_shell

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_shell2d (void);
```
"""
function p4est_connectivity_new_shell2d()
    @ccall libp4est.p4est_connectivity_new_shell2d()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_disk2d()

Create a connectivity structure that maps a 2d disk.

This is a 5 trees connectivity meant to be used together with p4est_geometry_new_disk2d to map the disk.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_disk2d (void);
```
"""
function p4est_connectivity_new_disk2d()
    @ccall libp4est.p4est_connectivity_new_disk2d()::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_brick(mi, ni, periodic_a, periodic_b)

A rectangular m by n array of trees with configurable periodicity. The brick is periodic in x and y if periodic\\_a and periodic\\_b are true, respectively.

### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_brick (int mi, int ni, int periodic_a, int periodic_b);
```
"""
function p4est_connectivity_new_brick(mi, ni, periodic_a, periodic_b)
    @ccall libp4est.p4est_connectivity_new_brick(mi::Cint, ni::Cint, periodic_a::Cint, periodic_b::Cint)::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_new_byname(name)

Create connectivity structure from predefined catalogue.

### Parameters
* `name`:\\[in\\] Invokes connectivity\\_new\\_* function. brick23 brick (2, 3, 0, 0) corner corner cubed cubed disk disk moebius moebius periodic periodic pillow pillow rotwrap rotwrap star star unit unitsquare
### Returns
An initialized connectivity if name is defined, NULL else.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_new_byname (const char *name);
```
"""
function p4est_connectivity_new_byname(name)
    @ccall libp4est.p4est_connectivity_new_byname(name::Cstring)::Ptr{p4est_connectivity_t}
end

"""
    p4est_connectivity_refine(conn, num_per_edge)

Uniformly refine a connectivity. This is useful if you would like to uniformly refine by something other than a power of 2.

### Parameters
* `conn`:\\[in\\] A valid connectivity
* `num_per_edge`:\\[in\\] The number of new trees in each direction. Must use no more than P4EST_OLD_QMAXLEVEL bits.
### Returns
a refined connectivity.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_refine (p4est_connectivity_t * conn, int num_per_edge);
```
"""
function p4est_connectivity_refine(conn, num_per_edge)
    @ccall libp4est.p4est_connectivity_refine(conn::Ptr{p4est_connectivity_t}, num_per_edge::Cint)::Ptr{p4est_connectivity_t}
end

"""
    p4est_expand_face_transform(iface, nface, ftransform)

Fill an array with the axis combination of a face neighbor transform.

### Parameters
* `iface`:\\[in\\] The number of the originating face.
* `nface`:\\[in\\] Encoded as nface = r * 4 + nf, where nf = 0..3 is the neigbbor's connecting face number and r = 0..1 is the relative orientation to the neighbor's face. This encoding matches [`p4est_connectivity_t`](@ref).
* `ftransform`:\\[out\\] This array holds 9 integers. [0,2] The coordinate axis sequence of the origin face, the first referring to the tangential and the second to the normal. A permutation of (0, 1). [3,5] The coordinate axis sequence of the target face. [6,8] Edge reversal flag for tangential axis (boolean); face code in [0, 3] for the normal coordinate q: 0: q' = -q 1: q' = q + 1 2: q' = q - 1 3: q' = 2 - q [1,4,7] 0 (unused for compatibility with 3D).
### Prototype
```c
void p4est_expand_face_transform (int iface, int nface, int ftransform[]);
```
"""
function p4est_expand_face_transform(iface, nface, ftransform)
    @ccall libp4est.p4est_expand_face_transform(iface::Cint, nface::Cint, ftransform::Ptr{Cint})::Cvoid
end

"""
    p4est_find_face_transform(connectivity, itree, iface, ftransform)

Fill an array with the axis combinations of a tree neighbor transform.

### Parameters
* `itree`:\\[in\\] The number of the originating tree.
* `iface`:\\[in\\] The number of the originating tree's face.
* `ftransform`:\\[out\\] This array holds 9 integers. [0,2] The coordinate axis sequence of the origin face. [3,5] The coordinate axis sequence of the target face. [6,8] Edge reverse flag for axis t; face code for axis n. [1,4,7] 0 (unused for compatibility with 3D).
### Returns
The face neighbor tree if it exists, -1 otherwise.
### Prototype
```c
p4est_topidx_t p4est_find_face_transform (p4est_connectivity_t * connectivity, p4est_topidx_t itree, int iface, int ftransform[]);
```
"""
function p4est_find_face_transform(connectivity, itree, iface, ftransform)
    @ccall libp4est.p4est_find_face_transform(connectivity::Ptr{p4est_connectivity_t}, itree::p4est_topidx_t, iface::Cint, ftransform::Ptr{Cint})::p4est_topidx_t
end

"""
    p4est_find_corner_transform(connectivity, itree, icorner, ci)

Fills an array with information about corner neighbors.

### Parameters
* `itree`:\\[in\\] The number of the originating tree.
* `icorner`:\\[in\\] The number of the originating corner.
* `ci`:\\[in,out\\] A [`p4est_corner_info_t`](@ref) structure with initialized array.
### Prototype
```c
void p4est_find_corner_transform (p4est_connectivity_t * connectivity, p4est_topidx_t itree, int icorner, p4est_corner_info_t * ci);
```
"""
function p4est_find_corner_transform(connectivity, itree, icorner, ci)
    @ccall libp4est.p4est_find_corner_transform(connectivity::Ptr{p4est_connectivity_t}, itree::p4est_topidx_t, icorner::Cint, ci::Ptr{p4est_corner_info_t})::Cvoid
end

"""
    p4est_connectivity_complete(conn)

Internally connect a connectivity based on tree\\_to\\_vertex information. Periodicity that is not inherent in the list of vertices will be lost.

### Parameters
* `conn`:\\[in,out\\] The connectivity needs to have proper vertices and tree\\_to\\_vertex fields. The tree\\_to\\_tree and tree\\_to\\_face fields must be allocated and satisfy [`p4est_connectivity_is_valid`](@ref) (conn) but will be overwritten. The corner fields will be freed and allocated anew.
### Prototype
```c
void p4est_connectivity_complete (p4est_connectivity_t * conn);
```
"""
function p4est_connectivity_complete(conn)
    @ccall libp4est.p4est_connectivity_complete(conn::Ptr{p4est_connectivity_t})::Cvoid
end

"""
    p4est_connectivity_reduce(conn)

Removes corner information of a connectivity such that enough information is left to run [`p4est_connectivity_complete`](@ref) successfully. The reduced connectivity still passes [`p4est_connectivity_is_valid`](@ref).

### Parameters
* `conn`:\\[in,out\\] The connectivity to be reduced.
### Prototype
```c
void p4est_connectivity_reduce (p4est_connectivity_t * conn);
```
"""
function p4est_connectivity_reduce(conn)
    @ccall libp4est.p4est_connectivity_reduce(conn::Ptr{p4est_connectivity_t})::Cvoid
end

"""
    p4est_connectivity_permute(conn, perm, is_current_to_new)

[`p4est_connectivity_permute`](@ref) Given a permutation *perm* of the trees in a connectivity *conn*, permute the trees of *conn* in place and update *conn* to match.

### Parameters
* `conn`:\\[in,out\\] The connectivity whose trees are permuted.
* `perm`:\\[in\\] A permutation array, whose elements are size\\_t's.
* `is_current_to_new`:\\[in\\] if true, the jth entry of perm is the new index for the entry whose current index is j, otherwise the jth entry of perm is the current index of the tree whose index will be j after the permutation.
### Prototype
```c
void p4est_connectivity_permute (p4est_connectivity_t * conn, sc_array_t * perm, int is_current_to_new);
```
"""
function p4est_connectivity_permute(conn, perm, is_current_to_new)
    @ccall libp4est.p4est_connectivity_permute(conn::Ptr{p4est_connectivity_t}, perm::Ptr{sc_array_t}, is_current_to_new::Cint)::Cvoid
end

"""
    p4est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)

[`p4est_connectivity_join_faces`](@ref) This function takes an existing valid connectivity *conn* and modifies it by joining two tree faces that are currently boundary faces.

### Parameters
* `conn`:\\[in,out\\] connectivity that will be altered.
* `tree_left`:\\[in\\] tree that will be on the left side of the joined faces.
* `tree_right`:\\[in\\] tree that will be on the right side of the joined faces.
* `face_left`:\\[in\\] face of *tree_left* that will be joined.
* `face_right`:\\[in\\] face of *tree_right* that will be joined.
* `orientation`:\\[in\\] the orientation of *face_left* and *face_right* once joined (see the description of [`p4est_connectivity_t`](@ref) to understand orientation).
### Prototype
```c
void p4est_connectivity_join_faces (p4est_connectivity_t * conn, p4est_topidx_t tree_left, p4est_topidx_t tree_right, int face_left, int face_right, int orientation);
```
"""
function p4est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)
    @ccall libp4est.p4est_connectivity_join_faces(conn::Ptr{p4est_connectivity_t}, tree_left::p4est_topidx_t, tree_right::p4est_topidx_t, face_left::Cint, face_right::Cint, orientation::Cint)::Cvoid
end

"""
    p4est_connectivity_is_equivalent(conn1, conn2)

[`p4est_connectivity_is_equivalent`](@ref) This function compares two connectivities for equivalence: it returns *true* if they are the same connectivity, or if they have the same topology. The definition of topological sameness is strict: there is no attempt made to determine whether permutation and/or rotation of the trees makes the connectivities equivalent.

### Parameters
* `conn1`:\\[in\\] a valid connectivity
* `conn2`:\\[out\\] a valid connectivity
### Prototype
```c
int p4est_connectivity_is_equivalent (p4est_connectivity_t * conn1, p4est_connectivity_t * conn2);
```
"""
function p4est_connectivity_is_equivalent(conn1, conn2)
    @ccall libp4est.p4est_connectivity_is_equivalent(conn1::Ptr{p4est_connectivity_t}, conn2::Ptr{p4est_connectivity_t})::Cint
end

"""
    p4est_corner_array_index(array, it)

### Prototype
```c
static inline p4est_corner_transform_t * p4est_corner_array_index (sc_array_t * array, size_t it);
```
"""
function p4est_corner_array_index(array, it)
    @ccall libp4est.p4est_corner_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_corner_transform_t}
end

"""
    p4est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)

Read an ABAQUS input file from a file stream.

This utility function reads a basic ABAQUS file supporting element type with the prefix C2D4, CPS4, and S4 in 2D and of type C3D8 reading them as bilinear quadrilateral and trilinear hexahedral trees respectively.

A basic 2D mesh is given below. The `*Node` section gives the vertex number and x, y, and z components for each vertex. The `*Element` section gives the 4 vertices in 2D (8 vertices in 3D) of each element in counter clockwise order. So in 2D the nodes are given as:

4 3 +-------------------+ | | | | | | | | | | | | +-------------------+ 1 2

and in 3D they are given as:

8 7 +---------------------+ |\\ |\\ | \\ | \\ | \\ | \\ | \\ | \\ | 5+---------------------+6 | | | | +----|----------------+ | 4\\ | 3 \\ | \\ | \\ | \\ | \\ | \\| \\| +---------------------+ 1 2

```c++
 *Heading
  box.inp
 *Node
 1,  -5, -5, 0
 2,   5, -5, 0
 3,   5,  5, 0
 4,  -5,  5, 0
 5,   0, -5, 0
 6,   5,  0, 0
 7,   0,  5, 0
 8,  -5,  0, 0
 9,   1, -1, 0
 10,  0,  0, 0
 11, -2,  1, 0
 *Element, type=CPS4, ELSET=Surface1
 1,  1, 10, 11, 8
 2,  3, 10, 9,  6
 3,  9, 10, 1,  5
 4,  7,  4, 8, 11
 5, 11, 10, 3,  7
 6,  2,  6, 9,  5
```

This code can be called two ways. The first, when `vertex`==NULL and `tree_to_vertex`==NULL, is used to count the number of trees and vertices in the connectivity to be generated by the `.inp` mesh in the *stream*. The second, when `vertices`!=NULL and `tree_to_vertex`!=NULL, fill `vertices` and `tree_to_vertex`. In this case `num_vertices` and `num_trees` need to be set to the maximum number of entries allocated in `vertices` and `tree_to_vertex`.

### Parameters
* `stream`:\\[in,out\\] file stream to read the connectivity from
* `num_vertices`:\\[in,out\\] the number of vertices in the connectivity
* `num_trees`:\\[in,out\\] the number of trees in the connectivity
* `vertices`:\\[out\\] the list of `vertices` of the connectivity
* `tree_to_vertex`:\\[out\\] the `tree_to_vertex` map of the connectivity
### Returns
0 if successful and nonzero if not
### Prototype
```c
int p4est_connectivity_read_inp_stream (FILE * stream, p4est_topidx_t * num_vertices, p4est_topidx_t * num_trees, double *vertices, p4est_topidx_t * tree_to_vertex);
```
"""
function p4est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)
    @ccall libp4est.p4est_connectivity_read_inp_stream(stream::Ptr{Libc.FILE}, num_vertices::Ptr{p4est_topidx_t}, num_trees::Ptr{p4est_topidx_t}, vertices::Ptr{Cdouble}, tree_to_vertex::Ptr{p4est_topidx_t})::Cint
end

"""
    p4est_connectivity_read_inp(filename)

Create a [`p4est`](@ref) connectivity from an ABAQUS input file.

This utility function reads a basic ABAQUS file supporting element type with the prefix C2D4, CPS4, and S4 in 2D and of type C3D8 reading them as bilinear quadrilateral and trilinear hexahedral trees respectively.

A basic 2D mesh is given below. The `*Node` section gives the vertex number and x, y, and z components for each vertex. The `*Element` section gives the 4 vertices in 2D (8 vertices in 3D) of each element in counter clockwise order. So in 2D the nodes are given as:

4 3 +-------------------+ | | | | | | | | | | | | +-------------------+ 1 2

and in 3D they are given as:

8 7 +---------------------+ |\\ |\\ | \\ | \\ | \\ | \\ | \\ | \\ | 5+---------------------+6 | | | | +----|----------------+ | 4\\ | 3 \\ | \\ | \\ | \\ | \\ | \\| \\| +---------------------+ 1 2

```c++
 *Heading
  box.inp
 *Node
 1,  -5, -5, 0
 2,   5, -5, 0
 3,   5,  5, 0
 4,  -5,  5, 0
 5,   0, -5, 0
 6,   5,  0, 0
 7,   0,  5, 0
 8,  -5,  0, 0
 9,   1, -1, 0
 10,  0,  0, 0
 11, -2,  1, 0
 *Element, type=CPS4, ELSET=Surface1
 1,  1, 10, 11, 8
 2,  3, 10, 9,  6
 3,  9, 10, 1,  5
 4,  7,  4, 8, 11
 5, 11, 10, 3,  7
 6,  2,  6, 9,  5
```

This function reads a mesh from *filename* and returns an associated [`p4est`](@ref) connectivity.

### Parameters
* `filename`:\\[in\\] file to read the connectivity from
### Returns
an allocated connectivity associated with the mesh in *filename* or NULL if an error occurred.
### Prototype
```c
p4est_connectivity_t *p4est_connectivity_read_inp (const char *filename);
```
"""
function p4est_connectivity_read_inp(filename)
    @ccall libp4est.p4est_connectivity_read_inp(filename::Cstring)::Ptr{p4est_connectivity_t}
end

"""
    p4est_tree

The [`p4est`](@ref) tree datatype

| Field              | Note                                                               |
| :----------------- | :----------------------------------------------------------------- |
| quadrants          | locally stored quadrants                                           |
| first\\_desc       | first local descendant                                             |
| last\\_desc        | last local descendant                                              |
| quadrants\\_offset | cumulative sum over earlier trees on this processor (locals only)  |
| maxlevel           | highest local quadrant level                                       |
"""
struct p4est_tree
    quadrants::sc_array_t
    first_desc::p4est_quadrant_t
    last_desc::p4est_quadrant_t
    quadrants_offset::p4est_locidx_t
    quadrants_per_level::NTuple{31, p4est_locidx_t}
    maxlevel::Int8
end

"""The [`p4est`](@ref) tree datatype"""
const p4est_tree_t = p4est_tree

"""
    p4est_inspect

Data pertaining to selecting, inspecting, and profiling algorithms. A pointer to this structure is hooked into the [`p4est`](@ref) main structure.

The balance\\_ranges and balance\\_notify* times are collected whenever an inspect structure is present in [`p4est`](@ref).

| Field                           | Note                                                                                                                                        |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------ |
| use\\_balance\\_ranges          | Use sc\\_ranges to determine the asymmetric communication pattern. If *use_balance_ranges* is false (the default), sc\\_notify is used.     |
| use\\_balance\\_ranges\\_notify | If true, call both sc\\_ranges and sc\\_notify and verify consistency. Which is actually used is still determined by *use_balance_ranges*.  |
| use\\_balance\\_verify          | Verify sc\\_ranges and/or sc\\_notify as applicable.                                                                                        |
| balance\\_max\\_ranges          | If positive and smaller than p4est\\_num ranges, overrides it                                                                               |
| balance\\_ranges                | time spent in sc\\_ranges                                                                                                                   |
| balance\\_notify                | time spent in sc\\_notify                                                                                                                   |
| balance\\_notify\\_allgather    | time spent in sc\\_notify\\_allgather                                                                                                       |
"""
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

"""Data pertaining to selecting, inspecting, and profiling algorithms. A pointer to this structure is hooked into the [`p4est`](@ref) main structure. Declared in p4est\\_extended.h. Used to profile important algorithms."""
const p4est_inspect_t = p4est_inspect

"""
    p4est

| Field                     | Note                                                                                                             |
| :------------------------ | :--------------------------------------------------------------------------------------------------------------- |
| mpisize                   | number of MPI processes                                                                                          |
| mpirank                   | this process's MPI rank                                                                                          |
| mpicomm\\_owned           | flag if communicator is owned                                                                                    |
| data\\_size               | size of per-quadrant p.user\\_data (see [`p4est_quadrant_t`](@ref)::[`p4est_quadrant_data`](@ref)::user\\_data)  |
| user\\_pointer            | convenience pointer for users, never touched by [`p4est`](@ref)                                                  |
| revision                  | Gets bumped on mesh change                                                                                       |
| first\\_local\\_tree      | 0-based index of first local tree, must be -1 for an empty processor                                             |
| last\\_local\\_tree       | 0-based index of last local tree, must be -2 for an empty processor                                              |
| local\\_num\\_quadrants   | number of quadrants on all trees on this processor                                                               |
| global\\_num\\_quadrants  | number of quadrants on all trees on all processors                                                               |
| global\\_first\\_quadrant | first global quadrant index for each process and 1 beyond                                                        |
| global\\_first\\_position | first smallest possible quad for each process and 1 beyond                                                       |
| connectivity              | connectivity structure, not owned                                                                                |
| trees                     | array of all trees                                                                                               |
| user\\_data\\_pool        | memory allocator for user data                                                                                   |
| quadrant\\_pool           | memory allocator for temporary quadrants                                                                         |
| inspect                   | algorithmic switches                                                                                             |
"""
struct p4est
    mpicomm::MPI_Comm
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

"""The [`p4est`](@ref) forest datatype"""
const p4est_t = p4est

"""
    p4est_memory_used(p4est_)

Calculate local memory usage of a forest structure. Not collective. The memory used on the current rank is returned. The connectivity structure is not counted since it is not owned; use p4est\\_connectivity\\_memory\\_usage ([`p4est`](@ref)->connectivity).

### Parameters
* `p4est`:\\[in\\] Valid forest structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p4est_memory_used (p4est_t * p4est);
```
"""
function p4est_memory_used(p4est_)
    @ccall libp4est.p4est_memory_used(p4est_::Ptr{p4est_t})::Csize_t
end

"""
    p4est_revision(p4est_)

Return the revision counter of the forest. Not collective, even though the revision value is the same on all ranks. A newly created forest starts with a revision counter of zero. Every refine, coarsen, partition, and balance that actually changes the mesh increases the counter by one. Operations with no effect keep the old value.

### Parameters
* `p8est`:\\[in\\] The forest must be valid.
### Returns
Non-negative number.
### Prototype
```c
long p4est_revision (p4est_t * p4est);
```
"""
function p4est_revision(p4est_)
    @ccall libp4est.p4est_revision(p4est_::Ptr{p4est_t})::Clong
end

# typedef void ( * p4est_init_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
"""
Callback function prototype to initialize the quadrant's user data.

### Parameters
* `p4est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrant`:\\[in,out\\] the quadrant to be initialized: if data\\_size > 0, the data to be initialized is at *quadrant*->p.user_data; otherwise, the non-pointer user data (such as *quadrant*->p.user_int) can be initialized
"""
const p4est_init_t = Ptr{Cvoid}

# typedef int ( * p4est_refine_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
"""
Callback function prototype to decide for refinement.

### Parameters
* `p4est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrant`:\\[in\\] the quadrant that may be refined
### Returns
nonzero if the quadrant shall be refined.
"""
const p4est_refine_t = Ptr{Cvoid}

# typedef int ( * p4est_coarsen_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrants [ ] )
"""
Callback function prototype to decide for coarsening.

### Parameters
* `p4est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrants`:\\[in\\] Pointers to 4 siblings in Morton ordering.
### Returns
nonzero if the quadrants shall be replaced with their parent.
"""
const p4est_coarsen_t = Ptr{Cvoid}

# typedef int ( * p4est_weight_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant )
"""
Callback function prototype to calculate weights for partitioning.

!!! note

    Global sum of weights must fit into a 64bit integer.

### Parameters
* `p4est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
### Returns
a 32bit integer >= 0 as the quadrant weight.
"""
const p4est_weight_t = Ptr{Cvoid}

"""
    p4est_qcoord_to_vertex(connectivity, treeid, x, y, vxyz)

Transform a quadrant coordinate into the space spanned by tree vertices.

### Parameters
* `connectivity`:\\[in\\] Connectivity must provide the vertices.
* `treeid`:\\[in\\] Identify the tree that contains x, y.
* `x,`:\\[in\\] y Quadrant coordinates relative to treeid.
* `vxyz`:\\[out\\] Transformed coordinates in vertex space.
### Prototype
```c
void p4est_qcoord_to_vertex (p4est_connectivity_t * connectivity, p4est_topidx_t treeid, p4est_qcoord_t x, p4est_qcoord_t y, double vxyz[3]);
```
"""
function p4est_qcoord_to_vertex(connectivity, treeid, x, y, vxyz)
    @ccall libp4est.p4est_qcoord_to_vertex(connectivity::Ptr{p4est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

"""
    p4est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)

### Prototype
```c
p4est_t *p4est_new (sc_MPI_Comm mpicomm, p4est_connectivity_t * connectivity, size_t data_size, p4est_init_t init_fn, void *user_pointer);
```
"""
function p4est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_new(mpicomm::MPI_Comm, connectivity::Ptr{p4est_connectivity_t}, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p4est_t}
end

"""
    p4est_destroy(p4est_)

Destroy a [`p4est`](@ref).

!!! note

    The connectivity structure is not destroyed with the [`p4est`](@ref).

### Prototype
```c
void p4est_destroy (p4est_t * p4est);
```
"""
function p4est_destroy(p4est_)
    @ccall libp4est.p4est_destroy(p4est_::Ptr{p4est_t})::Cvoid
end

"""
    p4est_copy(input, copy_data)

Make a deep copy of a [`p4est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless. The inspect member of the copy is set to NULL. The revision counter of the copy is set to zero.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
### Returns
Returns a valid [`p4est`](@ref) that does not depend on the input, except for borrowing the same connectivity. Its revision counter is 0.
### Prototype
```c
p4est_t *p4est_copy (p4est_t * input, int copy_data);
```
"""
function p4est_copy(input, copy_data)
    @ccall libp4est.p4est_copy(input::Ptr{p4est_t}, copy_data::Cint)::Ptr{p4est_t}
end

"""
    p4est_reset_data(p4est_, data_size, init_fn, user_pointer)

Reset user pointer and element data. When the data size is changed the quadrant data is freed and allocated. The initialization callback is invoked on each quadrant. Old user\\_data content is disregarded.

### Parameters
* `data_size`:\\[in\\] This is the size of data for each quadrant which can be zero. Then user\\_data\\_pool is set to NULL.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically. May be NULL.
* `user_pointer`:\\[in\\] Assign to the user\\_pointer member of the [`p4est`](@ref) before init\\_fn is called the first time.
### Prototype
```c
void p4est_reset_data (p4est_t * p4est, size_t data_size, p4est_init_t init_fn, void *user_pointer);
```
"""
function p4est_reset_data(p4est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_reset_data(p4est_::Ptr{p4est_t}, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

"""
    p4est_refine(p4est_, refine_recursive, refine_fn, init_fn)

Refine a forest.

### Parameters
* `p4est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn gets called, or use [`p4est_refine_ext`](@ref) in p4est\\_extended.h and examine whether replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data of newly created quadrants, which is already allocated. This function pointer may be NULL.
### Prototype
```c
void p4est_refine (p4est_t * p4est, int refine_recursive, p4est_refine_t refine_fn, p4est_init_t init_fn);
```
"""
function p4est_refine(p4est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p4est_refine(p4est_::Ptr{p4est_t}, refine_recursive::Cint, refine_fn::p4est_refine_t, init_fn::p4est_init_t)::Cvoid
end

"""
    p4est_coarsen(p4est_, coarsen_recursive, coarsen_fn, init_fn)

Coarsen a forest.

### Parameters
* `p4est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p4est_coarsen (p4est_t * p4est, int coarsen_recursive, p4est_coarsen_t coarsen_fn, p4est_init_t init_fn);
```
"""
function p4est_coarsen(p4est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p4est_coarsen(p4est_::Ptr{p4est_t}, coarsen_recursive::Cint, coarsen_fn::p4est_coarsen_t, init_fn::p4est_init_t)::Cvoid
end

"""
    p4est_balance(p4est_, btype, init_fn)

2:1 balance the size differences of neighboring elements in a forest.

### Parameters
* `p4est`:\\[in,out\\] The [`p4est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face or corner/full). Corner balance is almost never required when discretizing a PDE; just causes smoother mesh grading.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p4est_balance (p4est_t * p4est, p4est_connect_type_t btype, p4est_init_t init_fn);
```
"""
function p4est_balance(p4est_, btype, init_fn)
    @ccall libp4est.p4est_balance(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, init_fn::p4est_init_t)::Cvoid
end

"""
    p4est_partition(p4est_, allow_for_coarsening, weight_fn)

Equally partition the forest. The partition can be by element count or by a user-defined weight.

The forest will be partitioned between processors such that they have an approximately equal number of quadrants (or sum of weights).

On one process, the function noops and does not call the weight callback. Otherwise, the weight callback is called once per quadrant in order.

### Parameters
* `p4est`:\\[in,out\\] The forest that will be partitioned.
* `allow_for_coarsening`:\\[in\\] Slightly modify partition such that quadrant families are not split between ranks.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning. When running with mpisize == 1, never called. Otherwise, called in order for all quadrants if not NULL. A weighting function with constant weight 1 on each quadrant is equivalent to weight\\_fn == NULL but other constant weightings may result in different uniform partitionings.
### Prototype
```c
void p4est_partition (p4est_t * p4est, int allow_for_coarsening, p4est_weight_t weight_fn);
```
"""
function p4est_partition(p4est_, allow_for_coarsening, weight_fn)
    @ccall libp4est.p4est_partition(p4est_::Ptr{p4est_t}, allow_for_coarsening::Cint, weight_fn::p4est_weight_t)::Cvoid
end

"""
    p4est_checksum(p4est_)

Compute the checksum for a forest. Based on quadrant arrays only. It is independent of partition and mpisize.

### Returns
Returns the checksum on processor 0 only. 0 on other processors.
### Prototype
```c
unsigned p4est_checksum (p4est_t * p4est);
```
"""
function p4est_checksum(p4est_)
    @ccall libp4est.p4est_checksum(p4est_::Ptr{p4est_t})::Cuint
end

"""
    p4est_checksum_partition(p4est_)

Compute a partition-dependent checksum for a forest.

### Returns
Returns the checksum on processor 0 only. 0 on other processors.
### Prototype
```c
unsigned p4est_checksum_partition (p4est_t * p4est);
```
"""
function p4est_checksum_partition(p4est_)
    @ccall libp4est.p4est_checksum_partition(p4est_::Ptr{p4est_t})::Cuint
end

"""
    p4est_save(filename, p4est_, save_data)

Save the complete connectivity/[`p4est`](@ref) data to disk.

This is a collective operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations.

By default, we write the current processor count and partition into the file header. This makes the file depend on mpisize. For changing this see [`p4est_save_ext`](@ref)() in p4est\\_extended.h.

The revision counter is not saved to the file, since that would make files different that come from different revisions but store the same mesh.

!!! note

    Aborts on file errors.

!!! note

    If [`p4est`](@ref) is not configured to use MPI-IO, some processes return from this function before the file is complete, in which case immediate read-access to the file may require a call to [`sc_MPI_Barrier`](@ref).

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p4est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
### Prototype
```c
void p4est_save (const char *filename, p4est_t * p4est, int save_data);
```
"""
function p4est_save(filename, p4est_, save_data)
    @ccall libp4est.p4est_save(filename::Cstring, p4est_::Ptr{p4est_t}, save_data::Cint)::Cvoid
end

"""
    p4est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)

### Prototype
```c
p4est_t *p4est_load (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, void *user_pointer, p4est_connectivity_t ** connectivity);
```
"""
function p4est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p4est_load(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

"""
    p4est_tree_array_index(array, it)

### Prototype
```c
static inline p4est_tree_t * p4est_tree_array_index (sc_array_t * array, p4est_topidx_t it);
```
"""
function p4est_tree_array_index(array, it)
    @ccall libp4est.p4est_tree_array_index(array::Ptr{sc_array_t}, it::p4est_topidx_t)::Ptr{p4est_tree_t}
end

"""
    p4est_quadrant_array_index(array, it)

### Prototype
```c
static inline p4est_quadrant_t * p4est_quadrant_array_index (sc_array_t * array, size_t it);
```
"""
function p4est_quadrant_array_index(array, it)
    @ccall libp4est.p4est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_quadrant_t}
end

"""
    p4est_quadrant_array_push(array)

### Prototype
```c
static inline p4est_quadrant_t * p4est_quadrant_array_push (sc_array_t * array);
```
"""
function p4est_quadrant_array_push(array)
    @ccall libp4est.p4est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p4est_quadrant_t}
end

"""
    p4est_quadrant_mempool_alloc(mempool)

### Prototype
```c
static inline p4est_quadrant_t * p4est_quadrant_mempool_alloc (sc_mempool_t * mempool);
```
"""
function p4est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p4est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p4est_quadrant_t}
end

"""
    p4est_quadrant_list_pop(list)

### Prototype
```c
static inline p4est_quadrant_t * p4est_quadrant_list_pop (sc_list_t * list);
```
"""
function p4est_quadrant_list_pop(list)
    @ccall libp4est.p4est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p4est_quadrant_t}
end

"""
    p4est_ghost_t

quadrants that neighbor the local domain

| Field                           | Note                                                                                                                           |
| :------------------------------ | :----------------------------------------------------------------------------------------------------------------------------- |
| btype                           | which neighbors are in the ghost layer                                                                                         |
| ghosts                          | array of [`p4est_quadrant_t`](@ref) type                                                                                       |
| tree\\_offsets                  | num\\_trees + 1 ghost indices                                                                                                  |
| proc\\_offsets                  | mpisize + 1 ghost indices                                                                                                      |
| mirrors                         | array of [`p4est_quadrant_t`](@ref) type                                                                                       |
| mirror\\_tree\\_offsets         | num\\_trees + 1 mirror indices                                                                                                 |
| mirror\\_proc\\_mirrors         | indices into mirrors grouped by outside processor rank and ascending within each rank                                          |
| mirror\\_proc\\_offsets         | mpisize + 1 indices into  mirror\\_proc\\_mirrors                                                                              |
| mirror\\_proc\\_fronts          | like mirror\\_proc\\_mirrors, but limited to the outermost octants. This is NULL until [`p4est_ghost_expand`](@ref) is called  |
| mirror\\_proc\\_front\\_offsets | NULL until [`p4est_ghost_expand`](@ref) is called                                                                              |
"""
struct p4est_ghost_t
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
end

"""
    p4est_ghost_is_valid(p4est_, ghost)

Examine if a ghost structure is valid. Test if within a ghost-structure the array ghosts is in p4est\\_quadrant\\_compare\\_piggy order. Test if local\\_num in piggy3 data member of the quadrants in ghosts and mirrors are in ascending order (ascending within each rank for ghost).

Test if the [`p4est_locidx_t`](@ref) arrays are in ascending order (for mirror\\_proc\\_mirrors ascending within each rank)

### Parameters
* `p4est`:\\[in\\] the forest.
* `ghost`:\\[in\\] Ghost layer structure.
### Returns
true if *ghost* is valid
### Prototype
```c
int p4est_ghost_is_valid (p4est_t * p4est, p4est_ghost_t * ghost);
```
"""
function p4est_ghost_is_valid(p4est_, ghost)
    @ccall libp4est.p4est_ghost_is_valid(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cint
end

"""
    p4est_ghost_memory_used(ghost)

Calculate the memory usage of the ghost layer.

### Parameters
* `ghost`:\\[in\\] Ghost layer structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p4est_ghost_memory_used (p4est_ghost_t * ghost);
```
"""
function p4est_ghost_memory_used(ghost)
    @ccall libp4est.p4est_ghost_memory_used(ghost::Ptr{p4est_ghost_t})::Csize_t
end

"""
    p4est_quadrant_find_owner(p4est_, treeid, face, q)

Gets the processor id of a quadrant's owner. The quadrant can lie outside of a tree across faces (and only faces).

!!! warning

    Does not work for tree edge or corner neighbors.

### Parameters
* `p4est`:\\[in\\] The forest in which to search for a quadrant.
* `treeid`:\\[in\\] The tree to which the quadrant belongs.
* `face`:\\[in\\] Supply a face direction if known, or -1 otherwise.
* `q`:\\[in\\] The quadrant that is being searched for.
### Returns
Processor id of the owner or -1 if the quadrant lies outside of the mesh.
### Prototype
```c
int p4est_quadrant_find_owner (p4est_t * p4est, p4est_topidx_t treeid, int face, const p4est_quadrant_t * q);
```
"""
function p4est_quadrant_find_owner(p4est_, treeid, face, q)
    @ccall libp4est.p4est_quadrant_find_owner(p4est_::Ptr{p4est_t}, treeid::p4est_topidx_t, face::Cint, q::Ptr{p4est_quadrant_t})::Cint
end

"""
    p4est_ghost_new(p4est_, btype)

Builds the ghost layer.

This will gather the quadrants from each neighboring proc to build one layer of face and corner based ghost elements around the ones they own.

### Parameters
* `p4est`:\\[in\\] The forest for which the ghost layer will be generated.
* `btype`:\\[in\\] Which ghosts to include (across face, corner or full).
### Returns
A fully initialized ghost layer.
### Prototype
```c
p4est_ghost_t *p4est_ghost_new (p4est_t * p4est, p4est_connect_type_t btype);
```
"""
function p4est_ghost_new(p4est_, btype)
    @ccall libp4est.p4est_ghost_new(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t)::Ptr{p4est_ghost_t}
end

"""
    p4est_ghost_destroy(ghost)

Frees all memory used for the ghost layer.

### Prototype
```c
void p4est_ghost_destroy (p4est_ghost_t * ghost);
```
"""
function p4est_ghost_destroy(ghost)
    @ccall libp4est.p4est_ghost_destroy(ghost::Ptr{p4est_ghost_t})::Cvoid
end

"""
    p4est_ghost_bsearch(ghost, which_proc, which_tree, q)

Conduct binary search for exact match on a range of the ghost layer.

### Parameters
* `ghost`:\\[in\\] The ghost layer.
* `which_proc`:\\[in\\] The owner of the searched quadrant. Can be -1.
* `which_tree`:\\[in\\] The tree of the searched quadrant. Can be -1.
* `q`:\\[in\\] Valid quadrant is searched in the ghost layer.
### Returns
Offset in the ghost layer, or -1 if not found.
### Prototype
```c
ssize_t p4est_ghost_bsearch (p4est_ghost_t * ghost, int which_proc, p4est_topidx_t which_tree, const p4est_quadrant_t * q);
```
"""
function p4est_ghost_bsearch(ghost, which_proc, which_tree, q)
    @ccall libp4est.p4est_ghost_bsearch(ghost::Ptr{p4est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p4est_quadrant_t})::Cssize_t
end

"""
    p4est_ghost_contains(ghost, which_proc, which_tree, q)

Conduct binary search for ancestor on range of the ghost layer.

### Parameters
* `ghost`:\\[in\\] The ghost layer.
* `which_proc`:\\[in\\] The owner of the searched quadrant. Can be -1.
* `which_tree`:\\[in\\] The tree of the searched quadrant. Can be -1.
* `q`:\\[in\\] Valid quadrant's ancestor is searched.
### Returns
Offset in the ghost layer, or -1 if not found.
### Prototype
```c
ssize_t p4est_ghost_contains (p4est_ghost_t * ghost, int which_proc, p4est_topidx_t which_tree, const p4est_quadrant_t * q);
```
"""
function p4est_ghost_contains(ghost, which_proc, which_tree, q)
    @ccall libp4est.p4est_ghost_contains(ghost::Ptr{p4est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p4est_quadrant_t})::Cssize_t
end

"""
    p4est_face_quadrant_exists(p4est_, ghost, treeid, q, face, hang, owner_rank)

Checks if quadrant exists in the local forest or the ghost layer.

For quadrants across tree boundaries it checks if the quadrant exists across any face, but not across corners.

### Parameters
* `p4est`:\\[in\\] The forest in which to search for *q*.
* `ghost`:\\[in\\] The ghost layer in which to search for *q*.
* `treeid`:\\[in\\] The tree to which *q* belongs.
* `q`:\\[in\\] The quadrant that is being searched for.
* `face`:\\[in,out\\] On input, face id across which *q* was created. On output, the neighbor's face number augmented by orientation, so face is in 0..7.
* `hang`:\\[in,out\\] If not NULL, signals that q is bigger than the quadrant it came from. The child id of that originating quadrant is passed into hang. On output, hang holds the hanging face number of *q* that is in contact with its originator.
* `owner_rank`:\\[out\\] Filled with the rank of the owner if it is found and undefined otherwise.
### Returns
Returns the local number of *q* if the quadrant exists in the local forest or in the ghost\\_layer. Otherwise, returns -2 for a domain boundary and -1 if not found.
### Prototype
```c
p4est_locidx_t p4est_face_quadrant_exists (p4est_t * p4est, p4est_ghost_t * ghost, p4est_topidx_t treeid, const p4est_quadrant_t * q, int *face, int *hang, int *owner_rank);
```
"""
function p4est_face_quadrant_exists(p4est_, ghost, treeid, q, face, hang, owner_rank)
    @ccall libp4est.p4est_face_quadrant_exists(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p4est_quadrant_t}, face::Ptr{Cint}, hang::Ptr{Cint}, owner_rank::Ptr{Cint})::p4est_locidx_t
end

"""
    p4est_quadrant_exists(p4est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)

Checks if quadrant exists in the local forest or the ghost layer.

For quadrants across tree corners it checks if the quadrant exists in any of the corner neighbors, thus it can execute multiple queries.

### Parameters
* `p4est`:\\[in\\] The forest in which to search for *q*
* `ghost`:\\[in\\] The ghost layer in which to search for *q*
* `treeid`:\\[in\\] The tree to which *q* belongs (can be extended).
* `q`:\\[in\\] The quadrant that is being searched for.
* `exists_arr`:\\[in,out\\] Must exist and be of of elem\\_size = sizeof (int) for inter-tree corner cases. Is resized by this function to one entry for each corner search and set to true/false depending on its existence in the local forest or ghost\\_layer.
* `rproc_arr`:\\[in,out\\] If not NULL is filled with one rank per query.
* `rquad_arr`:\\[in,out\\] If not NULL is filled with one quadrant per query. Its piggy3 member is defined as well.
### Returns
true if the quadrant exists in the local forest or in the ghost\\_layer, and false if doesn't exist in either.
### Prototype
```c
int p4est_quadrant_exists (p4est_t * p4est, p4est_ghost_t * ghost, p4est_topidx_t treeid, const p4est_quadrant_t * q, sc_array_t * exists_arr, sc_array_t * rproc_arr, sc_array_t * rquad_arr);
```
"""
function p4est_quadrant_exists(p4est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)
    @ccall libp4est.p4est_quadrant_exists(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p4est_quadrant_t}, exists_arr::Ptr{sc_array_t}, rproc_arr::Ptr{sc_array_t}, rquad_arr::Ptr{sc_array_t})::Cint
end

"""
    p4est_is_balanced(p4est_, btype)

Check a forest to see if it is balanced.

This function builds the ghost layer and discards it when done.

### Parameters
* `p4est`:\\[in\\] The [`p4est`](@ref) to be tested.
* `btype`:\\[in\\] Balance type (face, corner or default, full).
### Returns
Returns true if balanced, false otherwise.
### Prototype
```c
int p4est_is_balanced (p4est_t * p4est, p4est_connect_type_t btype);
```
"""
function p4est_is_balanced(p4est_, btype)
    @ccall libp4est.p4est_is_balanced(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t)::Cint
end

"""
    p4est_ghost_checksum(p4est_, ghost)

Compute the parallel checksum of a ghost layer.

### Parameters
* `p4est`:\\[in\\] The MPI information of this [`p4est`](@ref) will be used.
* `ghost`:\\[in\\] A ghost layer obtained from the [`p4est`](@ref).
### Returns
Parallel checksum on rank 0, 0 otherwise.
### Prototype
```c
unsigned p4est_ghost_checksum (p4est_t * p4est, p4est_ghost_t * ghost);
```
"""
function p4est_ghost_checksum(p4est_, ghost)
    @ccall libp4est.p4est_ghost_checksum(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cuint
end

"""
    p4est_ghost_exchange_data(p4est_, ghost, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. Send the data stored in the quadrant's user\\_data. This is either the pointer variable itself if [`p4est`](@ref)->data_size is 0, or the content of the referenced memory field if [`p4est`](@ref)->data\\_size is positive.

### Parameters
* `p4est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghost quadrants in sequence. If [`p4est`](@ref)->data\\_size is 0, must at least hold sizeof (void *) bytes for each, otherwise [`p4est`](@ref)->data\\_size each.
### Prototype
```c
void p4est_ghost_exchange_data (p4est_t * p4est, p4est_ghost_t * ghost, void *ghost_data);
```
"""
function p4est_ghost_exchange_data(p4est_, ghost, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_data(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p4est_ghost_exchange

Transient storage for asynchronous ghost exchange.

| Field       | Note                                           |
| :---------- | :--------------------------------------------- |
| is\\_custom | False for [`p4est_ghost_exchange_data`](@ref)  |
| is\\_levels | Are we restricted to levels or not             |
| minlevel    | Meaningful with is\\_levels                    |
| maxlevel    |                                                |
"""
struct p4est_ghost_exchange
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
end

"""Transient storage for asynchronous ghost exchange."""
const p4est_ghost_exchange_t = p4est_ghost_exchange

"""
    p4est_ghost_exchange_data_begin(p4est_, ghost, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p4est_ghost_exchange_data`](@ref). The return type is always non-NULL and must be passed to [`p4est_ghost_exchange_data_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion.

### Parameters
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p4est_ghost_exchange_t *p4est_ghost_exchange_data_begin (p4est_t * p4est, p4est_ghost_t * ghost, void *ghost_data);
```
"""
function p4est_ghost_exchange_data_begin(p4est_, ghost, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_data_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

"""
    p4est_ghost_exchange_data_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `Data`:\\[in,out\\] created ONLY by [`p4est_ghost_exchange_data_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p4est_ghost_exchange_data_end (p4est_ghost_exchange_t * exc);
```
"""
function p4est_ghost_exchange_data_end(exc)
    @ccall libp4est.p4est_ghost_exchange_data_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

"""
    p4est_ghost_exchange_custom(p4est_, ghost, data_size, mirror_data, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. The data size is the same for all quadrants and can be chosen arbitrarily.

### Parameters
* `p4est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `data_size`:\\[in\\] The data size to transfer per quadrant.
* `mirror_data`:\\[in\\] One data pointer per mirror quadrant as input.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghosts in sequence, which must hold at least `data_size` for each ghost.
### Prototype
```c
void p4est_ghost_exchange_custom (p4est_t * p4est, p4est_ghost_t * ghost, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p4est_ghost_exchange_custom(p4est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p4est_ghost_exchange_custom_begin(p4est_, ghost, data_size, mirror_data, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p4est_ghost_exchange_custom`](@ref). The return type is always non-NULL and must be passed to [`p4est_ghost_exchange_custom_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion. The mirror data can be safely discarded right after this function returns since it is copied into internal send buffers.

### Parameters
* `mirror_data`:\\[in\\] Not required to stay alive any longer.
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p4est_ghost_exchange_t *p4est_ghost_exchange_custom_begin (p4est_t * p4est, p4est_ghost_t * ghost, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p4est_ghost_exchange_custom_begin(p4est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

"""
    p4est_ghost_exchange_custom_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `Data`:\\[in,out\\] created ONLY by [`p4est_ghost_exchange_custom_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p4est_ghost_exchange_custom_end (p4est_ghost_exchange_t * exc);
```
"""
function p4est_ghost_exchange_custom_end(exc)
    @ccall libp4est.p4est_ghost_exchange_custom_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

"""
    p4est_ghost_exchange_custom_levels(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. The data size is the same for all quadrants and can be chosen arbitrarily. This function restricts the transfer to a range of refinement levels. The memory for quadrants outside the level range is not dereferenced.

### Parameters
* `p4est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `minlevel`:\\[in\\] Level of the largest quads to be exchanged. Use <= 0 for no restriction.
* `maxlevel`:\\[in\\] Level of the smallest quads to be exchanged. Use >= [`P4EST_QMAXLEVEL`](@ref) for no restriction.
* `data_size`:\\[in\\] The data size to transfer per quadrant.
* `mirror_data`:\\[in\\] One data pointer per mirror quadrant as input.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghosts in sequence, which must hold at least `data_size` for each ghost.
### Prototype
```c
void p4est_ghost_exchange_custom_levels (p4est_t * p4est, p4est_ghost_t * ghost, int minlevel, int maxlevel, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p4est_ghost_exchange_custom_levels(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_levels(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p4est_ghost_exchange_custom_levels_begin(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p4est_ghost_exchange_custom_levels`](@ref). The return type is always non-NULL and must be passed to [`p4est_ghost_exchange_custom_levels_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion. The mirror data can be safely discarded right after this function returns since it is copied into internal send buffers.

### Parameters
* `mirror_data`:\\[in\\] Not required to stay alive any longer.
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p4est_ghost_exchange_t *p4est_ghost_exchange_custom_levels_begin (p4est_t * p4est, p4est_ghost_t * ghost, int minlevel, int maxlevel, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p4est_ghost_exchange_custom_levels_begin(p4est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p4est_ghost_exchange_custom_levels_begin(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p4est_ghost_exchange_t}
end

"""
    p4est_ghost_exchange_custom_levels_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `Data`:\\[in,out\\] created ONLY by [`p4est_ghost_exchange_custom_levels_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p4est_ghost_exchange_custom_levels_end (p4est_ghost_exchange_t * exc);
```
"""
function p4est_ghost_exchange_custom_levels_end(exc)
    @ccall libp4est.p4est_ghost_exchange_custom_levels_end(exc::Ptr{p4est_ghost_exchange_t})::Cvoid
end

"""
    p4est_ghost_expand(p4est_, ghost)

Expand the size of the ghost layer and mirrors by one additional layer of adjacency.

### Parameters
* `p4est`:\\[in\\] The forest from which the ghost layer was generated.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p4est_ghost_expand (p4est_t * p4est, p4est_ghost_t * ghost);
```
"""
function p4est_ghost_expand(p4est_, ghost)
    @ccall libp4est.p4est_ghost_expand(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

"""
    p4est_mesh_t

This structure contains complete mesh information on a 2:1 balanced forest. It stores the locally relevant neighborhood, that is, all locally owned quadrants and one layer of adjacent ghost quadrants and their owners.

For each local quadrant, its tree number is stored in quad\\_to\\_tree. The quad\\_to\\_tree array is NULL by default and can be enabled using p4est_mesh_new_ext. For each ghost quadrant, its owner rank is stored in ghost\\_to\\_proc. For each level, an array of local quadrant numbers is stored in quad\\_level. The quad\\_level array is NULL by default and can be enabled using p4est_mesh_new_ext.

The quad\\_to\\_quad list stores one value for each local quadrant's face. This value is in 0..local\\_num\\_quadrants-1 for local quadrants, or in local\\_num\\_quadrants + (0..ghost\\_num\\_quadrants-1) for ghost quadrants.

The quad\\_to\\_face list has equally many entries that are either: 1. A value of v = 0..7 indicates one same-size neighbor. This value is decoded as v = r * 4 + nf, where nf = 0..3 is the neighbor's connecting face number and r = 0..1 is the relative orientation of the neighbor's face; see [`p4est_connectivity`](@ref).h. 2. A value of v = 8..23 indicates a double-size neighbor. This value is decoded as v = 8 + h * 8 + r * 4 + nf, where r and nf are as above and h = 0..1 is the number of the subface. h designates the subface of the large neighbor that the quadrant touches (this is the same as the large neighbor's face corner). 3. A value of v = -8..-1 indicates two half-size neighbors. In this case the corresponding quad\\_to\\_quad index points into the quad\\_to\\_half array that stores two quadrant numbers per index, and the orientation of the smaller faces follows from 8 + v. The entries of quad\\_to\\_half encode between local and ghost quadrant in the same way as the quad\\_to\\_quad values described above. The small neighbors in quad\\_to\\_half are stored in the sequence of the face corners of this, i.e., the large quadrant.

A quadrant on the boundary of the forest sees itself and its face number.

The quad\\_to\\_corner list stores corner neighbors that are not face neighbors. On the inside of a tree, there is precisely one such neighbor per corner. In this case, its index is encoded as described above for quad\\_to\\_quad. The neighbor's matching corner number is always diagonally opposite, that is, corner number ^ 3.

On the inside of an inter-tree face, we have precisely one corner neighbor. If a corner is an inter-tree corner, then the number of corner neighbors may be any non-negative number. In both cases, the quad\\_to\\_corner value is in local\\_num\\_quadrants + local\\_num\\_ghosts + [0 .. local\\_num\\_corners - 1]. After subtracting the number of local and ghost quadrants, it indexes into corner\\_offset, which encodes a group of corner neighbors. Each group contains the quadrant numbers encoded as usual for quad\\_to\\_quad in corner\\_quad, and the corner number from the neighbor as corner\\_corner.

Corners with no diagonal neighbor at all are assigned the value -3. This only happens on the domain boundary, which is necessarily a tree boundary. Corner-neighbors for hanging nodes are assigned the value -1.

TODO: In case of an inter-tree corner neighbor relation in a brick-like situation (exactly one neighbor, diagonally opposite corner number), use the same encoding as for corners within a tree.

| Field             | Note                                                                                                                                                                                                           |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| quad\\_to\\_tree  | tree index for each local quad. Is NULL by default, but may be enabled by p4est_mesh_new_ext.                                                                                                                  |
| ghost\\_to\\_proc | processor for each ghost quad                                                                                                                                                                                  |
| quad\\_to\\_quad  | one index for each of the 4 faces                                                                                                                                                                              |
| quad\\_to\\_face  | encodes orientation/2:1 status                                                                                                                                                                                 |
| quad\\_to\\_half  | stores half-size neighbors                                                                                                                                                                                     |
| quad\\_level      | Stores lists of per-level quads. The array has entries indexed by 0..[`P4EST_QMAXLEVEL`](@ref) inclusive that are arrays of local quadrant ids. Is NULL by default, but may be enabled by p4est_mesh_new_ext.  |
"""
struct p4est_mesh_t
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
end

"""
    p4est_mesh_face_neighbor_t

This structure can be used as the status of a face neighbor iterator. It always contains the face and subface of the neighbor to be processed.
"""
struct p4est_mesh_face_neighbor_t
    p4est::Ptr{p4est_t}
    ghost::Ptr{p4est_ghost_t}
    mesh::Ptr{p4est_mesh_t}
    which_tree::p4est_topidx_t
    quadrant_id::p4est_locidx_t
    quadrant_code::p4est_locidx_t
    face::Cint
    subface::Cint
    current_qtq::p4est_locidx_t
end

"""
    p4est_mesh_memory_used(mesh)

Calculate the memory usage of the mesh structure.

### Parameters
* `mesh`:\\[in\\] Mesh structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p4est_mesh_memory_used (p4est_mesh_t * mesh);
```
"""
function p4est_mesh_memory_used(mesh)
    @ccall libp4est.p4est_mesh_memory_used(mesh::Ptr{p4est_mesh_t})::Csize_t
end

"""
    p4est_mesh_new(p4est_, ghost, btype)

Create a p4est\\_mesh structure. This function does not populate the quad\\_to\\_tree and quad\\_level fields. To populate them, use p4est_mesh_new_ext.

### Parameters
* `p4est`:\\[in\\] A forest that is fully 2:1 balanced.
* `ghost`:\\[in\\] The ghost layer created from the provided [`p4est`](@ref).
* `btype`:\\[in\\] Determines the highest codimension of neighbors.
### Returns
A fully allocated mesh structure.
### Prototype
```c
p4est_mesh_t *p4est_mesh_new (p4est_t * p4est, p4est_ghost_t * ghost, p4est_connect_type_t btype);
```
"""
function p4est_mesh_new(p4est_, ghost, btype)
    @ccall libp4est.p4est_mesh_new(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, btype::p4est_connect_type_t)::Ptr{p4est_mesh_t}
end

"""
    p4est_mesh_destroy(mesh)

Destroy a p4est\\_mesh structure.

### Parameters
* `mesh`:\\[in\\] Mesh structure previously created by [`p4est_mesh_new`](@ref).
### Prototype
```c
void p4est_mesh_destroy (p4est_mesh_t * mesh);
```
"""
function p4est_mesh_destroy(mesh)
    @ccall libp4est.p4est_mesh_destroy(mesh::Ptr{p4est_mesh_t})::Cvoid
end

"""
    p4est_mesh_get_quadrant(p4est_, mesh, qid)

Access a process-local quadrant inside a forest. Needs a mesh with populated quad\\_to\\_tree array. This is a special case of p4est_mesh_quadrant_cumulative.

### Parameters
* `p4est`:\\[in\\] The forest.
* `mesh`:\\[in\\] The mesh.
* `qid`:\\[in\\] Process-local id of the quadrant (cumulative over trees).
### Returns
A pointer to the requested quadrant.
### Prototype
```c
p4est_quadrant_t *p4est_mesh_get_quadrant (p4est_t * p4est, p4est_mesh_t * mesh, p4est_locidx_t qid);
```
"""
function p4est_mesh_get_quadrant(p4est_, mesh, qid)
    @ccall libp4est.p4est_mesh_get_quadrant(p4est_::Ptr{p4est_t}, mesh::Ptr{p4est_mesh_t}, qid::p4est_locidx_t)::Ptr{p4est_quadrant_t}
end

"""
    p4est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)

Lookup neighboring quads of quadrant in a specific direction.

### Parameters
* `p4est`:\\[in\\] Forest to be worked with.
* `ghost`:\\[in\\] Ghost layer.
* `mesh`:\\[in\\] Mesh structure.
* `curr_quad_id`:\\[in\\] Process-local id of current quad.
* `direction`:\\[in\\] Direction i in which to look for adjacent quadrants is encoded as follows: 0 .. 3 neighbor(-s) across face i, 4 .. 7 neighbor(-s) across corner i-4. TODO: Allow any combination of empty output arrays.
* `neighboring_quads`:\\[out\\] Array containing neighboring quad(-s). Needs to be empty on input, size of [`p4est_quadrant_t`](@ref) *. May be NULL, then **neighboring_qids** must not be NULL.
* `neighboring_qids`:\\[out\\] Array containing quadrant ids for neighboring quadrants. May be NULL, then no neighboring qids are collected. If non-NULL the array needs to be empty and will contain int. CAUTION: Note, that the encodings differ from the encodings saved in the mesh. TODO: Encodings are the same as in p4est\\_mesh for all quadrants. TODO: Ghosts can be encoded by returning the quad\\_to\\_quad convention in qid. For ghost quadrants, we add -300 to the values in p4est\\_mesh. This means that values below -100 belong to ghosts, values above to locals. Positive values are for local quadrants, negative values indicate ghost quadrants. Faces: 1 .. 8 => same size neighbor (r * 4 + nf) + 1; nf = 0 .. 3 face index; r = 0 .. 1 relative orientation 9 .. 24 => double size neighbor 9 + h * 8 + r * 4 + nf; h = 0 .. 1 number of the subface; r, nf as above 25 .. 32 => half-size neighbors 25 + r * 4 + nf; r, nf as above Corners: 1 .. 4 => size not encoded for corners nc + 1; nc = 0 .. 3 corner index
* `neighboring_encs`:\\[out\\] Array containing encodings for neighboring quads. Needs to be empty, contains int.
### Prototype
```c
p4est_locidx_t p4est_mesh_get_neighbors (p4est_t * p4est, p4est_ghost_t * ghost, p4est_mesh_t * mesh, p4est_locidx_t curr_quad_id, p4est_locidx_t direction, sc_array_t * neighboring_quads, sc_array_t * neighboring_encs, sc_array_t * neighboring_qids);
```
"""
function p4est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)
    @ccall libp4est.p4est_mesh_get_neighbors(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, curr_quad_id::p4est_locidx_t, direction::p4est_locidx_t, neighboring_quads::Ptr{sc_array_t}, neighboring_encs::Ptr{sc_array_t}, neighboring_qids::Ptr{sc_array_t})::p4est_locidx_t
end

"""
    p4est_mesh_quadrant_cumulative(p4est_, mesh, cumulative_id, which_tree, quadrant_id)

Find a quadrant based on its cumulative number in the local forest. If the quad\\_to\\_tree field of the mesh structure exists, this is O(1). Otherwise, we perform a binary search over the processor-local trees.

### Parameters
* `p4est`:\\[in\\] Forest to be worked with.
* `mesh`:\\[in\\] A mesh derived from the forest.
* `cumulative_id`:\\[in\\] Cumulative index over all trees of quadrant. Must refer to a local (non-ghost) quadrant.
* `which_tree`:\\[in,out\\] If not NULL, the input value can be -1 or an initial guess for the quadrant's tree and output is the tree of returned quadrant.
* `quadrant_id`:\\[out\\] If not NULL, the number of quadrant in tree.
### Returns
The identified quadrant.
### Prototype
```c
p4est_quadrant_t *p4est_mesh_quadrant_cumulative (p4est_t * p4est, p4est_mesh_t * mesh, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id);
```
"""
function p4est_mesh_quadrant_cumulative(p4est_, mesh, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p4est_mesh_quadrant_cumulative(p4est_::Ptr{p4est_t}, mesh::Ptr{p4est_mesh_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p4est_quadrant_t}
end

"""
    p4est_mesh_face_neighbor_init2(mfn, p4est_, ghost, mesh, which_tree, quadrant_id)

Initialize a mesh neighbor iterator by quadrant index.

### Parameters
* `mfn`:\\[out\\] A [`p4est_mesh_face_neighbor_t`](@ref) to be initialized.
* `which_tree`:\\[in\\] Tree of quadrant whose neighbors are looped over.
* `quadrant_id`:\\[in\\] Index relative to which\\_tree of quadrant.
### Prototype
```c
void p4est_mesh_face_neighbor_init2 (p4est_mesh_face_neighbor_t * mfn, p4est_t * p4est, p4est_ghost_t * ghost, p4est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_locidx_t quadrant_id);
```
"""
function p4est_mesh_face_neighbor_init2(mfn, p4est_, ghost, mesh, which_tree, quadrant_id)
    @ccall libp4est.p4est_mesh_face_neighbor_init2(mfn::Ptr{p4est_mesh_face_neighbor_t}, p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, which_tree::p4est_topidx_t, quadrant_id::p4est_locidx_t)::Cvoid
end

"""
    p4est_mesh_face_neighbor_init(mfn, p4est_, ghost, mesh, which_tree, quadrant)

Initialize a mesh neighbor iterator by quadrant pointer.

### Parameters
* `mfn`:\\[out\\] A [`p4est_mesh_face_neighbor_t`](@ref) to be initialized.
* `which_tree`:\\[in\\] Tree of quadrant whose neighbors are looped over.
* `quadrant`:\\[in\\] Pointer to quadrant contained in which\\_tree.
### Prototype
```c
void p4est_mesh_face_neighbor_init (p4est_mesh_face_neighbor_t * mfn, p4est_t * p4est, p4est_ghost_t * ghost, p4est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant);
```
"""
function p4est_mesh_face_neighbor_init(mfn, p4est_, ghost, mesh, which_tree, quadrant)
    @ccall libp4est.p4est_mesh_face_neighbor_init(mfn::Ptr{p4est_mesh_face_neighbor_t}, p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, mesh::Ptr{p4est_mesh_t}, which_tree::p4est_topidx_t, quadrant::Ptr{p4est_quadrant_t})::Cvoid
end

"""
    p4est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)

Move the iterator forward to loop around neighbors of the quadrant.

### Parameters
* `mfn`:\\[in,out\\] Internal status of the iterator.
* `ntree`:\\[out\\] If not NULL, the tree number of the neighbor.
* `nquad`:\\[out\\] If not NULL, the quadrant number within tree. For ghosts instead the number in ghost layer.
* `nface`:\\[out\\] If not NULL, neighbor's face as in [`p4est_mesh_t`](@ref).
* `nrank`:\\[out\\] If not NULL, the owner process of the neighbor.
### Returns
Either a real quadrant or one from the ghost layer. Returns NULL when the iterator is done.
### Prototype
```c
p4est_quadrant_t *p4est_mesh_face_neighbor_next (p4est_mesh_face_neighbor_t * mfn, p4est_topidx_t * ntree, p4est_locidx_t * nquad, int *nface, int *nrank);
```
"""
function p4est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)
    @ccall libp4est.p4est_mesh_face_neighbor_next(mfn::Ptr{p4est_mesh_face_neighbor_t}, ntree::Ptr{p4est_topidx_t}, nquad::Ptr{p4est_locidx_t}, nface::Ptr{Cint}, nrank::Ptr{Cint})::Ptr{p4est_quadrant_t}
end

"""
    p4est_mesh_face_neighbor_data(mfn, ghost_data)

Get the user data for the current face neighbor.

### Parameters
* `mfn`:\\[in\\] Internal status of the iterator.
* `ghost_data`:\\[in\\] Data for the ghost quadrants that has been synchronized with [`p4est_ghost_exchange_data`](@ref).
### Returns
A pointer to the user data for the current neighbor.
### Prototype
```c
void *p4est_mesh_face_neighbor_data (p4est_mesh_face_neighbor_t * mfn, void *ghost_data);
```
"""
function p4est_mesh_face_neighbor_data(mfn, ghost_data)
    @ccall libp4est.p4est_mesh_face_neighbor_data(mfn::Ptr{p4est_mesh_face_neighbor_t}, ghost_data::Ptr{Cvoid})::Ptr{Cvoid}
end

"""
    p4est_iter_volume_info

The information that is available to the user-defined [`p4est_iter_volume_t`](@ref) callback function.

*treeid* gives the index in [`p4est`](@ref)->trees of the tree to which *quad* belongs. *quadid* gives the index of *quad* within *tree*'s quadrants array.

| Field  | Note                                                    |
| :----- | :------------------------------------------------------ |
| quad   | the quadrant of the callback                            |
| quadid | id in *quad*'s tree array (see [`p4est_tree_t`](@ref))  |
| treeid | the tree containing *quad*                              |
"""
struct p4est_iter_volume_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
    treeid::p4est_topidx_t
end

"""
The information that is available to the user-defined [`p4est_iter_volume_t`](@ref) callback function.

*treeid* gives the index in [`p4est`](@ref)->trees of the tree to which *quad* belongs. *quadid* gives the index of *quad* within *tree*'s quadrants array.
"""
const p4est_iter_volume_info_t = p4est_iter_volume_info

# typedef void ( * p4est_iter_volume_t ) ( p4est_iter_volume_info_t * info , void * user_data )
"""
The prototype for a function that [`p4est_iterate`](@ref) will execute at every quadrant local to the current process.

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p4est_iterate`](@ref)()
"""
const p4est_iter_volume_t = Ptr{Cvoid}

struct p4est_iter_face_side_data
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{p4est_iter_face_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_327}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_328}(x + 0)
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

"""
    p4est_iter_face_side

Information about one side of a face in the forest.

If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If the face is hanging, then the quadrants are listed in z-order. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1.

| Field        | Note                                                 |
| :----------- | :--------------------------------------------------- |
| treeid       | the tree on this side                                |
| face         | which quadrant side the face touches                 |
| is\\_hanging | boolean: one full quad (0) or two smaller quads (1)  |
"""
struct p4est_iter_face_side
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{p4est_iter_face_side}, f::Symbol)
    f === :treeid && return Ptr{p4est_topidx_t}(x + 0)
    f === :face && return Ptr{Int8}(x + 4)
    f === :is_hanging && return Ptr{Int8}(x + 5)
    f === :is && return Ptr{p4est_iter_face_side_data}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::p4est_iter_face_side, f::Symbol)
    r = Ref{p4est_iter_face_side}(x)
    ptr = Base.unsafe_convert(Ptr{p4est_iter_face_side}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p4est_iter_face_side}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""
Information about one side of a face in the forest.

If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If the face is hanging, then the quadrants are listed in z-order. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1.
"""
const p4est_iter_face_side_t = p4est_iter_face_side

"""
    p4est_iter_face_info

The information that is available to the user-defined [`p4est_iter_face_t`](@ref) callback.

The orientation is 0 if the face is within one tree; otherwise, it is the same as the orientation value between the two trees given in the connectivity. If the face is on the outside boundary of the forest, then there is only one side. If tree\\_boundary is false, the face is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the face. When tree\\_boundary is true, its value is P4EST\\_CONNECT\\_FACE.

| Field           | Note                                                                                                |
| :-------------- | :-------------------------------------------------------------------------------------------------- |
| orientation     | the orientation of the sides to each other, as in the definition of [`p4est_connectivity_t`](@ref)  |
| tree\\_boundary | boolean: interior face (0), tree boundary face (true)                                               |
"""
struct p4est_iter_face_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    orientation::Int8
    tree_boundary::Int8
    sides::sc_array_t
end

"""
The information that is available to the user-defined [`p4est_iter_face_t`](@ref) callback.

The orientation is 0 if the face is within one tree; otherwise, it is the same as the orientation value between the two trees given in the connectivity. If the face is on the outside boundary of the forest, then there is only one side. If tree\\_boundary is false, the face is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the face. When tree\\_boundary is true, its value is P4EST\\_CONNECT\\_FACE.
"""
const p4est_iter_face_info_t = p4est_iter_face_info

# typedef void ( * p4est_iter_face_t ) ( p4est_iter_face_info_t * info , void * user_data )
"""
The prototype for a function that [`p4est_iterate`](@ref) will execute wherever two quadrants share a face: the face can be a 2:1 hanging face, it does not have to be conformal.

!!! note

    the forest must be face balanced for [`p4est_iterate`](@ref)() to execute a callback function on faces (see [`p4est_balance`](@ref)()).

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p4est_iterate`](@ref)()
"""
const p4est_iter_face_t = Ptr{Cvoid}

"""
    p4est_iter_corner_side

Information about one side of a corner in the forest. If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1.

the *faces* field provides some additional information about the local topology: if side[i]->faces[j] == side[k]->faces[l], this indicates that there is a common face between these two sides of the corner.

| Field      | Note                                                 |
| :--------- | :--------------------------------------------------- |
| treeid     | the tree that contains *quad*                        |
| corner     | which of the quadrant's corners touches this corner  |
| is\\_ghost | boolean: local (0) or ghost (1)                      |
| quadid     | the index in the tree or ghost array                 |
| faces      | internal work data                                   |
"""
struct p4est_iter_corner_side
    treeid::p4est_topidx_t
    corner::Int8
    is_ghost::Int8
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
    faces::NTuple{2, Int8}
end

"""
Information about one side of a corner in the forest. If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1.

the *faces* field provides some additional information about the local topology: if side[i]->faces[j] == side[k]->faces[l], this indicates that there is a common face between these two sides of the corner.
"""
const p4est_iter_corner_side_t = p4est_iter_corner_side

"""
    p4est_iter_corner_info

The information that is available to the user-defined [`p4est_iter_corner_t`](@ref) callback.

If tree\\_boundary is false, the corner is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the corner. When tree\\_boundary is true, its value is P4EST\\_CONNECT\\_FACE/CORNER depending on the location of the corner relative to the tree.

| Field           | Note                                                   |
| :-------------- | :----------------------------------------------------- |
| tree\\_boundary | boolean: interior face (0), tree boundary face (true)  |
| sides           | array of type [`p4est_iter_corner_side_t`](@ref) type  |
"""
struct p4est_iter_corner_info
    p4est::Ptr{p4est_t}
    ghost_layer::Ptr{p4est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
end

"""
The information that is available to the user-defined [`p4est_iter_corner_t`](@ref) callback.

If tree\\_boundary is false, the corner is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the corner. When tree\\_boundary is true, its value is P4EST\\_CONNECT\\_FACE/CORNER depending on the location of the corner relative to the tree.
"""
const p4est_iter_corner_info_t = p4est_iter_corner_info

# typedef void ( * p4est_iter_corner_t ) ( p4est_iter_corner_info_t * info , void * user_data )
"""
The prototype for a function that [`p4est_iterate`](@ref) will execute wherever quadrants meet at a conformal corner

i.e. the callback will not execute on a hanging corner.

!!! note

    the forest does not need to be corner balanced for [`p4est_iterate`](@ref)() to correctly execute a callback function at corners, only face balanced (see [`p4est_balance`](@ref)()).

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p4est_iterate`](@ref)()
"""
const p4est_iter_corner_t = Ptr{Cvoid}

"""
    p4est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner)

Execute user supplied callbacks at every volume, face, and corner in the local forest.

[`p4est_iterate`](@ref) executes the user-supplied callback functions at every volume, face, and corner in the local forest. The ghost\\_layer may be NULL. The *user_data* pointer is not touched by [`p4est_iterate`](@ref), but is passed to each of the callbacks. Any of the callbacks may be NULL. The callback functions are interspersed with each other, i.e. some face callbacks will occur between volume callbacks, and some corner callbacks will occur between face callbacks:

1) volume callbacks occur in the sorted Morton-index order. 2) a face callback is not executed until after the volume callbacks have been executed for the quadrants that share it. 3) a corner callback is not executed until the face callbacks have been executed for all faces that touch the corner. 4) it is not always the case that every face callback for a given quadrant is executed before any of the corner callbacks. 5) callbacks are not executed at faces or corners that only involve ghost quadrants, i.e. that are not adjacent in the local section of the forest.

### Parameters
* `p4est`:\\[in\\] the forest
* `ghost_layer`:\\[in\\] optional: when not given, callbacks at the boundaries of the local partition cannot provide quadrant data about ghost quadrants: missing ([`p4est_quadrant_t`](@ref) *) pointers are set to NULL, missing indices are set to -1.
* `user_data`:\\[in,out\\] optional context to supply to each callback
* `iter_volume`:\\[in\\] callback function for every quadrant's interior
* `iter_face`:\\[in\\] callback function for every face between quadrants
* `iter_corner`:\\[in\\] callback function for every corner between quadrants
### Prototype
```c
void p4est_iterate (p4est_t * p4est, p4est_ghost_t * ghost_layer, void *user_data, p4est_iter_volume_t iter_volume, p4est_iter_face_t iter_face, p4est_iter_corner_t iter_corner);
```
"""
function p4est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner)
    @ccall libp4est.p4est_iterate(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p4est_iter_volume_t, iter_face::p4est_iter_face_t, iter_corner::p4est_iter_corner_t)::Cvoid
end

"""
    p4est_iter_cside_array_index_int(array, it)

### Prototype
```c
static inline p4est_iter_corner_side_t * p4est_iter_cside_array_index_int (sc_array_t * array, int it);
```
"""
function p4est_iter_cside_array_index_int(array, it)
    @ccall libp4est.p4est_iter_cside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_iter_corner_side_t}
end

"""
    p4est_iter_cside_array_index(array, it)

### Prototype
```c
static inline p4est_iter_corner_side_t * p4est_iter_cside_array_index (sc_array_t * array, size_t it);
```
"""
function p4est_iter_cside_array_index(array, it)
    @ccall libp4est.p4est_iter_cside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_iter_corner_side_t}
end

"""
    p4est_iter_fside_array_index_int(array, it)

### Prototype
```c
static inline p4est_iter_face_side_t * p4est_iter_fside_array_index_int (sc_array_t * array, int it);
```
"""
function p4est_iter_fside_array_index_int(array, it)
    @ccall libp4est.p4est_iter_fside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_iter_face_side_t}
end

"""
    p4est_iter_fside_array_index(array, it)

### Prototype
```c
static inline p4est_iter_face_side_t * p4est_iter_fside_array_index (sc_array_t * array, size_t it);
```
"""
function p4est_iter_fside_array_index(array, it)
    @ccall libp4est.p4est_iter_fside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_iter_face_side_t}
end

const p4est_lnodes_code_t = Int8

struct p4est_lnodes
    mpicomm::MPI_Comm
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
end

"""
Store a parallel numbering of Lobatto points of a given degree > 0.

Each element has degree+1 nodes per face and vnodes = (degree+1)^2 nodes per volume. num\\_local\\_elements is the number of local quadrants in the [`p4est`](@ref). element\\_nodes is of dimension vnodes * num\\_local\\_elements and lists the nodes of each element in lexicographic yx-order (x varies fastest); so for degree == 2, this is the layout of nodes:

f\\_3 c\\_2 c\\_3 6---7---8 | | f\\_0 3 4 5 f\\_1 | | 0---1---2 c\\_0 c\\_1 f\\_2

element\\_nodes indexes into the set of local nodes, layed out as follows: local nodes = [<-----owned\\_count----->|<-----nonlocal\\_nodes----->] = [<----------------num\\_local\\_nodes----------------->] nonlocal\\_nodes contains the globally unique numbers for independent nodes that are owned by other processes; for local nodes, the globally unique numbers are given by i + global\\_offset, where i is the local number. Hanging nodes are always local and don't have a global number. They index the geometrically corresponding independent nodes of a neighbor.

Whether nodes are hanging or not is decided based on the element faces. This information is encoded in face\\_code with one int8\\_t per element. If no faces are hanging, the value is zero, otherwise the face\\_code is interpreted by [`p4est_lnodes_decode`](@ref).

Independent nodes can be shared by multiple MPI ranks. The owner rank of a node is the one from the lowest numbered element on the lowest numbered octree *touching* the node.

What is meant by *touching*? A quadrant is said to touch all faces/corners that are incident on it, and by extension all nodes that are contained in those faces/corners.

X +-----------+ o | | o | | +-----+ o | p | | q | o | | | | o | | +-----+ O +-----------+

In this example degree = 6. There are 5 nodes that live on the face between q and p, and one at each corner of that face. The face is incident on q, so q owns the nodes on the face (provided q is from a lower tree or has a lower index than p). The lower corner is incident on q, so q owns it as well. The upper corner is not incident on q, so q cannot own it.

global\\_owned\\_count contains the number of independent nodes owned by each process.

The sharers array contains items of type [`p4est_lnodes_rank_t`](@ref) that hold the ranks that own or share independent local nodes. If there are no shared nodes on this processor, it is empty. Otherwise, it is sorted by rank and the current process is included.

degree < 0 indicates that the lnodes data structure is being used to number the quadrant boundary object (faces and corners) rather than the \$C^0\$ Lobatto nodes:

if degree == -1, then one node is assigned per face, and no nodes are assigned per volume or per corner: this numbering can be used for low-order Raviart-Thomas elements. In this case, vnodes == 4, and the nodes are listed in face-order:

f\\_3 c\\_2 c\\_3 +---3---+ | | f\\_0 0 1 f\\_1 | | +---2---+ c\\_0 c\\_1 f\\_2

if degree == -2, then one node is assigned per face and per corner and no nodes are assigned per volume. In this case, vnodes == 8, and the nodes are listed in face-order, followed by corner-order:

f\\_3 c\\_2 c\\_3 6---3---7 | | f\\_0 0 1 f\\_1 | | 4---2---5 c\\_0 c\\_1 f\\_2
"""
const p4est_lnodes_t = p4est_lnodes

"""
    p4est_lnodes_rank

The structure stored in the sharers array.

shared\\_nodes is a sorted array of [`p4est_locidx_t`](@ref) that indexes into local nodes. The shared\\_nodes array has a contiguous (or empty) section of nodes owned by the current rank. shared\\_mine\\_offset and shared\\_mine\\_count identify this section by indexing the shared\\_nodes array, not the local nodes array. owned\\_offset and owned\\_count define the section of local nodes that is owned by the listed rank (the section may be empty). For the current process these coincide with those in [`p4est_lnodes_t`](@ref).
"""
struct p4est_lnodes_rank
    rank::Cint
    shared_nodes::sc_array_t
    shared_mine_offset::p4est_locidx_t
    shared_mine_count::p4est_locidx_t
    owned_offset::p4est_locidx_t
    owned_count::p4est_locidx_t
end

"""
The structure stored in the sharers array.

shared\\_nodes is a sorted array of [`p4est_locidx_t`](@ref) that indexes into local nodes. The shared\\_nodes array has a contiguous (or empty) section of nodes owned by the current rank. shared\\_mine\\_offset and shared\\_mine\\_count identify this section by indexing the shared\\_nodes array, not the local nodes array. owned\\_offset and owned\\_count define the section of local nodes that is owned by the listed rank (the section may be empty). For the current process these coincide with those in [`p4est_lnodes_t`](@ref).
"""
const p4est_lnodes_rank_t = p4est_lnodes_rank

"""
    p4est_lnodes_decode(face_code, hanging_face)

### Prototype
```c
static inline int p4est_lnodes_decode (p4est_lnodes_code_t face_code, int hanging_face[4]);
```
"""
function p4est_lnodes_decode(face_code, hanging_face)
    @ccall libp4est.p4est_lnodes_decode(face_code::p4est_lnodes_code_t, hanging_face::Ptr{Cint})::Cint
end

"""
    p4est_lnodes_new(p4est_, ghost_layer, degree)

### Prototype
```c
p4est_lnodes_t *p4est_lnodes_new (p4est_t * p4est, p4est_ghost_t * ghost_layer, int degree);
```
"""
function p4est_lnodes_new(p4est_, ghost_layer, degree)
    @ccall libp4est.p4est_lnodes_new(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, degree::Cint)::Ptr{p4est_lnodes_t}
end

"""
    p4est_lnodes_destroy(lnodes)

### Prototype
```c
void p4est_lnodes_destroy (p4est_lnodes_t * lnodes);
```
"""
function p4est_lnodes_destroy(lnodes)
    @ccall libp4est.p4est_lnodes_destroy(lnodes::Ptr{p4est_lnodes_t})::Cvoid
end

"""
    p4est_ghost_support_lnodes(p4est_, lnodes, ghost)

Expand the ghost layer to include the support of all nodes supported on the local partition.

### Parameters
* `p4est`:\\[in\\] The forest from which the ghost layer was generated.
* `lnodes`:\\[in\\] The nodes to support.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p4est_ghost_support_lnodes (p4est_t * p4est, p4est_lnodes_t * lnodes, p4est_ghost_t * ghost);
```
"""
function p4est_ghost_support_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p4est_ghost_support_lnodes(p4est_::Ptr{p4est_t}, lnodes::Ptr{p4est_lnodes_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

"""
    p4est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)

Expand the ghost layer as in [`p4est_ghost_expand`](@ref)(), but use node support to define adjacency instead of geometric adjacency.

### Parameters
* `p4est`:\\[in\\] The forest from which the ghost layer was generated.
* `lnodes`:\\[in\\] The nodes to support.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p4est_ghost_expand_by_lnodes (p4est_t * p4est, p4est_lnodes_t * lnodes, p4est_ghost_t * ghost);
```
"""
function p4est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p4est_ghost_expand_by_lnodes(p4est_::Ptr{p4est_t}, lnodes::Ptr{p4est_lnodes_t}, ghost::Ptr{p4est_ghost_t})::Cvoid
end

"""
    p4est_partition_lnodes(p4est_, ghost, degree, partition_for_coarsening)

Partition using weights based on the number of nodes assigned to each element in lnodes

### Parameters
* `p4est`:\\[in,out\\] the forest to be repartitioned
* `ghost`:\\[in\\] the ghost layer
* `degree`:\\[in\\] the degree that would be passed to [`p4est_lnodes_new`](@ref)()
* `partition_for_coarsening`:\\[in\\] whether the partition should allow coarsening (i.e. group siblings who might merge)
### Prototype
```c
void p4est_partition_lnodes (p4est_t * p4est, p4est_ghost_t * ghost, int degree, int partition_for_coarsening);
```
"""
function p4est_partition_lnodes(p4est_, ghost, degree, partition_for_coarsening)
    @ccall libp4est.p4est_partition_lnodes(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, degree::Cint, partition_for_coarsening::Cint)::Cvoid
end

"""
    p4est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_corner, partition_for_coarsening)

Partition using weights that are broken down by where they reside: in volumes, on faces, or on corners.

### Prototype
```c
void p4est_partition_lnodes_detailed (p4est_t * p4est, p4est_ghost_t * ghost, int nodes_per_volume, int nodes_per_face, int nodes_per_corner, int partition_for_coarsening);
```
"""
function p4est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_corner, partition_for_coarsening)
    @ccall libp4est.p4est_partition_lnodes_detailed(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, nodes_per_volume::Cint, nodes_per_face::Cint, nodes_per_corner::Cint, partition_for_coarsening::Cint)::Cvoid
end

"""
    p4est_lnodes_buffer

[`p4est_lnodes_buffer_t`](@ref) handles the communication of data associated with nodes.

*send_buffers* is an array of arrays: one buffer for each process to which the current process sends node-data. It should not be altered between a shared\\_*\\_begin and a shared\\_*\\_end call.

*recv_buffers* is an array of arrays that is used in lnodes\\_share\\_all\\_*. *recv_buffers*[j] corresponds with lnodes->sharers[j]: it is the same length as *lnodes*->sharers[j]->shared_nodes. At the completion of lnodes\\_share\\_all or lnodes\\_share\\_all\\_end, recv\\_buffers[j] contains the node-data from the process lnodes->sharers[j]->rank (unless j is the current rank, in which case recv\\_buffers[j] is empty).
"""
struct p4est_lnodes_buffer
    requests::Ptr{sc_array_t}
    send_buffers::Ptr{sc_array_t}
    recv_buffers::Ptr{sc_array_t}
end

"""
[`p4est_lnodes_buffer_t`](@ref) handles the communication of data associated with nodes.

*send_buffers* is an array of arrays: one buffer for each process to which the current process sends node-data. It should not be altered between a shared\\_*\\_begin and a shared\\_*\\_end call.

*recv_buffers* is an array of arrays that is used in lnodes\\_share\\_all\\_*. *recv_buffers*[j] corresponds with lnodes->sharers[j]: it is the same length as *lnodes*->sharers[j]->shared_nodes. At the completion of lnodes\\_share\\_all or lnodes\\_share\\_all\\_end, recv\\_buffers[j] contains the node-data from the process lnodes->sharers[j]->rank (unless j is the current rank, in which case recv\\_buffers[j] is empty).
"""
const p4est_lnodes_buffer_t = p4est_lnodes_buffer

"""
    p4est_lnodes_share_owned_begin(node_data, lnodes)

[`p4est_lnodes_share_owned_begin`](@ref)

*node_data* is a user-defined array of arbitrary type, where each entry is associated with the *lnodes* local nodes entry of matching index. For every local nodes entry that is owned by a process other than the current one, the value in the *node_data* array of the owning process is written directly into the *node_data* array of the current process. Values of *node_data* are not guaranteed to be sent or received until the *buffer* created by [`p4est_lnodes_share_owned_begin`](@ref) is passed to [`p4est_lnodes_share_owned_end`](@ref).

To be memory neutral, the *buffer* created by [`p4est_lnodes_share_owned_begin`](@ref) must be destroying with [`p4est_lnodes_buffer_destroy`](@ref) (it is not destroyed by [`p4est_lnodes_share_owned_end`](@ref)).

### Prototype
```c
p4est_lnodes_buffer_t *p4est_lnodes_share_owned_begin (sc_array_t * node_data, p4est_lnodes_t * lnodes);
```
"""
function p4est_lnodes_share_owned_begin(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_owned_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

"""
    p4est_lnodes_share_owned_end(buffer)

### Prototype
```c
void p4est_lnodes_share_owned_end (p4est_lnodes_buffer_t * buffer);
```
"""
function p4est_lnodes_share_owned_end(buffer)
    @ccall libp4est.p4est_lnodes_share_owned_end(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

"""
    p4est_lnodes_share_owned(node_data, lnodes)

Equivalent to calling [`p4est_lnodes_share_owned_end`](@ref) directly after [`p4est_lnodes_share_owned_begin`](@ref). Use if there is no local work that can be done to mask the communication cost.

### Prototype
```c
void p4est_lnodes_share_owned (sc_array_t * node_data, p4est_lnodes_t * lnodes);
```
"""
function p4est_lnodes_share_owned(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_owned(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Cvoid
end

"""
    p4est_lnodes_share_all_begin(node_data, lnodes)

[`p4est_lnodes_share_all_begin`](@ref)

*node_data* is a user\\_defined array of arbitrary type, where each entry is associated with the lnodes local nodes entry of matching index. For every process that shares an entry with the current one, the value in the *node_data* array of that process is written into a *buffer*->recv_buffers entry as described above. The user can then perform some arbitrary work that requires the data from all processes that share a node (such as reduce, max, min, etc.). When the work concludes, the *buffer* should be destroyed with [`p4est_lnodes_buffer_destroy`](@ref).

Values of *node_data* are not guaranteed to be sent, and *buffer*->recv_buffer entries are not guaranteed to be received until the *buffer* created by [`p4est_lnodes_share_all_begin`](@ref) is passed to [`p4est_lnodes_share_all_end`](@ref).

### Prototype
```c
p4est_lnodes_buffer_t *p4est_lnodes_share_all_begin (sc_array_t * node_data, p4est_lnodes_t * lnodes);
```
"""
function p4est_lnodes_share_all_begin(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_all_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

"""
    p4est_lnodes_share_all_end(buffer)

### Prototype
```c
void p4est_lnodes_share_all_end (p4est_lnodes_buffer_t * buffer);
```
"""
function p4est_lnodes_share_all_end(buffer)
    @ccall libp4est.p4est_lnodes_share_all_end(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

"""
    p4est_lnodes_share_all(node_data, lnodes)

Equivalent to calling [`p4est_lnodes_share_all_end`](@ref) directly after [`p4est_lnodes_share_all_begin`](@ref). Use if there is no local work that can be done to mask the communication cost.

### Returns
A fully initialized buffer that contains the received data. After processing this data, the buffer must be freed with [`p4est_lnodes_buffer_destroy`](@ref).
### Prototype
```c
p4est_lnodes_buffer_t *p4est_lnodes_share_all (sc_array_t * node_data, p4est_lnodes_t * lnodes);
```
"""
function p4est_lnodes_share_all(node_data, lnodes)
    @ccall libp4est.p4est_lnodes_share_all(node_data::Ptr{sc_array_t}, lnodes::Ptr{p4est_lnodes_t})::Ptr{p4est_lnodes_buffer_t}
end

"""
    p4est_lnodes_buffer_destroy(buffer)

### Prototype
```c
void p4est_lnodes_buffer_destroy (p4est_lnodes_buffer_t * buffer);
```
"""
function p4est_lnodes_buffer_destroy(buffer)
    @ccall libp4est.p4est_lnodes_buffer_destroy(buffer::Ptr{p4est_lnodes_buffer_t})::Cvoid
end

"""
    p4est_lnodes_rank_array_index_int(array, it)

### Prototype
```c
static inline p4est_lnodes_rank_t * p4est_lnodes_rank_array_index_int (sc_array_t * array, int it);
```
"""
function p4est_lnodes_rank_array_index_int(array, it)
    @ccall libp4est.p4est_lnodes_rank_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p4est_lnodes_rank_t}
end

"""
    p4est_lnodes_rank_array_index(array, it)

### Prototype
```c
static inline p4est_lnodes_rank_t * p4est_lnodes_rank_array_index (sc_array_t * array, size_t it);
```
"""
function p4est_lnodes_rank_array_index(array, it)
    @ccall libp4est.p4est_lnodes_rank_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p4est_lnodes_rank_t}
end

"""
    p4est_lnodes_global_index(lnodes, lidx)

### Prototype
```c
static inline p4est_gloidx_t p4est_lnodes_global_index (p4est_lnodes_t * lnodes, p4est_locidx_t lidx);
```
"""
function p4est_lnodes_global_index(lnodes, lidx)
    @ccall libp4est.p4est_lnodes_global_index(lnodes::Ptr{p4est_lnodes_t}, lidx::p4est_locidx_t)::p4est_gloidx_t
end

"""A datatype to handle the linear id in 2D."""
const p4est_lid_t = UInt64

# typedef void ( * p4est_replace_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , int num_outgoing , p4est_quadrant_t * outgoing [ ] , int num_incoming , p4est_quadrant_t * incoming [ ] )
"""
Callback function prototype to replace one set of quadrants with another.

This is used by extended routines when the quadrants of an existing, valid [`p4est`](@ref) are changed. The callback allows the user to make changes to newly initialized quadrants before the quadrants that they replace are destroyed.

If the mesh is being refined, num\\_outgoing will be 1 and num\\_incoming will be 4, and vice versa if the mesh is being coarsened.

### Parameters
* `num_outgoing`:\\[in\\] The number of outgoing quadrants.
* `outgoing`:\\[in\\] The outgoing quadrants: after the callback, the user\\_data, if [`p4est`](@ref)->data_size is nonzero, will be destroyed.
* `num_incoming`:\\[in\\] The number of incoming quadrants.
* `incoming`:\\[in,out\\] The incoming quadrants: prior to the callback, the user\\_data, if [`p4est`](@ref)->data_size is nonzero, is allocated, and the [`p4est_init_t`](@ref) callback, if it has been provided, will be called.
"""
const p4est_replace_t = Ptr{Cvoid}

"""
    p4est_lid_compare(a, b)

Compare the [`p4est_lid_t`](@ref) *a* and the [`p4est_lid_t`](@ref) *b*.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Returns
Returns -1 if a < b, 1 if a > b and 0 if a == b.
### Prototype
```c
int p4est_lid_compare (const p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_compare(a, b)
    @ccall libp4est.p4est_lid_compare(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cint
end

"""
    p4est_lid_is_equal(a, b)

Checks if the [`p4est_lid_t`](@ref) *a* and the [`p4est_lid_t`](@ref) *b* are equal.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Returns
Returns a true value if *a* and *b* are equal, false otherwise
### Prototype
```c
int p4est_lid_is_equal (const p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_is_equal(a, b)
    @ccall libp4est.p4est_lid_is_equal(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cint
end

"""
    p4est_lid_init(input, high, low)

Initializes an unsigned 64 bit integer. *high* is just a a placeholder to use the same interface in 3D.

### Parameters
* `input`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
* `high`:\\[in\\] The given high bits must be zero.
* `low`:\\[in\\] The given low bits to initialize *input*.
### Prototype
```c
void p4est_lid_init (p4est_lid_t * input, uint64_t high, uint64_t low);
```
"""
function p4est_lid_init(input, high, low)
    @ccall libp4est.p4est_lid_init(input::Ptr{p4est_lid_t}, high::UInt64, low::UInt64)::Cvoid
end

"""
    p4est_lid_set_zero(input)

Initializes a linear index to zero.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p4est_lid_set_zero (p4est_lid_t * input);
```
"""
function p4est_lid_set_zero(input)
    @ccall libp4est.p4est_lid_set_zero(input::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_set_one(input)

Initializes a linear index to one.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p4est_lid_set_one (p4est_lid_t * input);
```
"""
function p4est_lid_set_one(input)
    @ccall libp4est.p4est_lid_set_one(input::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_set_uint64(input, u)

Initializes a linear index to an unsigned 64 bit integer.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p4est_lid_set_uint64 (p4est_lid_t * input, uint64_t u);
```
"""
function p4est_lid_set_uint64(input, u)
    @ccall libp4est.p4est_lid_set_uint64(input::Ptr{p4est_lid_t}, u::UInt64)::Cvoid
end

"""
    p4est_lid_chk_bit(input, bit_number)

Returns the bit\\_number-th bit of *input*. This function checks a bit of an existing, initialized value.

### Parameters
* `input`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `bit_number`:\\[in\\] The bit (counted from the right hand side) that is checked by logical and. Require 0 <= *bit_number* < 64.
### Returns
True if bit is set, false if not.
### Prototype
```c
int p4est_lid_chk_bit (const p4est_lid_t * input, int bit_number);
```
"""
function p4est_lid_chk_bit(input, bit_number)
    @ccall libp4est.p4est_lid_chk_bit(input::Ptr{p4est_lid_t}, bit_number::Cint)::Cint
end

"""
    p4est_lid_set_bit(input, bit_number)

Sets the exponent-th bit of *a* to one. This function modifies an existing, initialized value.

### Parameters
* `input`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref).
* `bit_number`:\\[in\\] The bit (counted from the right hand side) that is set to one by logical or. Require 0 <= *bit_number* < 64.
### Prototype
```c
void p4est_lid_set_bit (p4est_lid_t * input, int bit_number);
```
"""
function p4est_lid_set_bit(input, bit_number)
    @ccall libp4est.p4est_lid_set_bit(input::Ptr{p4est_lid_t}, bit_number::Cint)::Cvoid
end

"""
    p4est_lid_copy(input, output)

Copies an initialized [`p4est_lid_t`](@ref) to a [`p4est_lid_t`](@ref).

### Parameters
* `input`:\\[in\\] A pointer to the [`p4est_lid_t`](@ref) that is copied.
* `output`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). The low bits of *output* will be set to the low bits of *input* and high bits are ignored.
### Prototype
```c
void p4est_lid_copy (const p4est_lid_t * input, p4est_lid_t * output);
```
"""
function p4est_lid_copy(input, output)
    @ccall libp4est.p4est_lid_copy(input::Ptr{p4est_lid_t}, output::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_add(a, b, result)

Adds the uint128\\_t *b* to the uint128\\_t *a*. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref). The sum *a* + *b* will be saved in *result*.
### Prototype
```c
void p4est_lid_add (const p4est_lid_t * a, const p4est_lid_t * b, p4est_lid_t * result);
```
"""
function p4est_lid_add(a, b, result)
    @ccall libp4est.p4est_lid_add(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_sub(a, b, result)

Substracts the [`p4est_lid_t`](@ref) *b* from the [`p4est_lid_t`](@ref) *a*. This function assumes that the result is >= 0. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref). The difference *a* - *b* will be saved in *result*.
### Prototype
```c
void p4est_lid_sub (const p4est_lid_t * a, const p4est_lid_t * b, p4est_lid_t * result);
```
"""
function p4est_lid_sub(a, b, result)
    @ccall libp4est.p4est_lid_sub(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_bitwise_neg(a, result)

Calculates the bitwise negation of the uint128\\_t *a*. *a* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref). The bitwise negation of *a* will be saved in *result*.
### Prototype
```c
void p4est_lid_bitwise_neg (const p4est_lid_t * a, p4est_lid_t * result);
```
"""
function p4est_lid_bitwise_neg(a, result)
    @ccall libp4est.p4est_lid_bitwise_neg(a::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_bitwise_or(a, b, result)

Calculates the bitwise or of the uint128\\_t *a* and *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref). The bitwise or of *a* and *b* will be saved in *result*.
### Prototype
```c
void p4est_lid_bitwise_or (const p4est_lid_t * a, const p4est_lid_t * b, p4est_lid_t * result);
```
"""
function p4est_lid_bitwise_or(a, b, result)
    @ccall libp4est.p4est_lid_bitwise_or(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_bitwise_and(a, b, result)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref). The bitwise and of *a* and *b* will be saved. in *result*.
### Prototype
```c
void p4est_lid_bitwise_and (const p4est_lid_t * a, const p4est_lid_t * b, p4est_lid_t * result);
```
"""
function p4est_lid_bitwise_and(a, b, result)
    @ccall libp4est.p4est_lid_bitwise_and(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t}, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_shift_right(input, shift_count, result)

Calculates the bit right shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the left. If *shift_count* >= 64, *result* is 0. All bits right from the zeroth bit (counted from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). The right shifted number will be saved in *result*.
### Prototype
```c
void p4est_lid_shift_right (const p4est_lid_t * input, unsigned shift_count, p4est_lid_t * result);
```
"""
function p4est_lid_shift_right(input, shift_count, result)
    @ccall libp4est.p4est_lid_shift_right(input::Ptr{p4est_lid_t}, shift_count::Cuint, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_shift_left(input, shift_count, result)

Calculates the bit left shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the right. If *shift_count* >= 64, *result* is 0. All bits left from the 63th bit (counted zero based from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). The left shifted number will be saved in *result*.
### Prototype
```c
void p4est_lid_shift_left (const p4est_lid_t * input, unsigned shift_count, p4est_lid_t * result);
```
"""
function p4est_lid_shift_left(input, shift_count, result)
    @ccall libp4est.p4est_lid_shift_left(input::Ptr{p4est_lid_t}, shift_count::Cuint, result::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_add_inplace(a, b)

Adds the [`p4est_lid_t`](@ref) *b* to the [`p4est_lid_t`](@ref) *a*. The result is saved in *a*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). *a* will be overwritten by *a* + *b*.
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Prototype
```c
void p4est_lid_add_inplace (p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_add_inplace(a, b)
    @ccall libp4est.p4est_lid_add_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_sub_inplace(a, b)

Substracts the uint128\\_t *b* from the uint128\\_t *a*. The result is saved in *a*. *a* == *b* is allowed. This function assumes that the result is >= 0.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). *a* will be overwritten by *a* - *b*.
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Prototype
```c
void p4est_lid_sub_inplace (p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_sub_inplace(a, b)
    @ccall libp4est.p4est_lid_sub_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_bitwise_or_inplace(a, b)

Calculates the bitwise or of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). The bitwise or will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Prototype
```c
void p4est_lid_bitwise_or_inplace (p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_bitwise_or_inplace(a, b)
    @ccall libp4est.p4est_lid_bitwise_or_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_lid_bitwise_and_inplace(a, b)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p4est_lid_t`](@ref). The bitwise and will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`p4est_lid_t`](@ref).
### Prototype
```c
void p4est_lid_bitwise_and_inplace (p4est_lid_t * a, const p4est_lid_t * b);
```
"""
function p4est_lid_bitwise_and_inplace(a, b)
    @ccall libp4est.p4est_lid_bitwise_and_inplace(a::Ptr{p4est_lid_t}, b::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_quadrant_linear_id_ext128(quadrant, level, id)

Computes the linear position as [`p4est_lid_t`](@ref) of a quadrant in a uniform grid. The grid and quadrant levels need not coincide. If they do, this is the inverse of p4est_quadrant_set_morton.

!!! note

    The user\\_data of *quadrant* is never modified.

### Parameters
* `quadrant`:\\[in\\] Quadrant whose linear index will be computed. If the quadrant is smaller than the grid (has a higher quadrant->level), the result is computed from its ancestor at the grid's level. If the quadrant has a smaller level than the grid (it is bigger than a grid cell), the grid cell sharing its lower left corner is used as reference.
* `level`:\\[in\\] The level of the regular grid compared to which the linear position is to be computed.
* `id`:\\[in,out\\] A pointer to an allocated or static [`p4est_lid_t`](@ref). id will be the linear position of this quadrant on a uniform grid.
### Prototype
```c
void p4est_quadrant_linear_id_ext128 (const p4est_quadrant_t * quadrant, int level, p4est_lid_t * id);
```
"""
function p4est_quadrant_linear_id_ext128(quadrant, level, id)
    @ccall libp4est.p4est_quadrant_linear_id_ext128(quadrant::Ptr{p4est_quadrant_t}, level::Cint, id::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_quadrant_set_morton_ext128(quadrant, level, id)

Set quadrant Morton indices based on linear position given as [`p4est_lid_t`](@ref) in uniform grid. This is the inverse operation of p4est_quadrant_linear_id.

!!! note

    The user\\_data of *quadrant* is never modified.

### Parameters
* `quadrant`:\\[in,out\\] Quadrant whose Morton indices will be set.
* `level`:\\[in\\] Level of the grid and of the resulting quadrant.
* `id`:\\[in\\] Linear index of the quadrant on a uniform grid.
### Prototype
```c
void p4est_quadrant_set_morton_ext128 (p4est_quadrant_t * quadrant, int level, const p4est_lid_t * id);
```
"""
function p4est_quadrant_set_morton_ext128(quadrant, level, id)
    @ccall libp4est.p4est_quadrant_set_morton_ext128(quadrant::Ptr{p4est_quadrant_t}, level::Cint, id::Ptr{p4est_lid_t})::Cvoid
end

"""
    p4est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)

### Prototype
```c
p4est_t *p4est_new_ext (sc_MPI_Comm mpicomm, p4est_connectivity_t * connectivity, p4est_locidx_t min_quadrants, int min_level, int fill_uniform, size_t data_size, p4est_init_t init_fn, void *user_pointer);
```
"""
function p4est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p4est_new_ext(mpicomm::MPI_Comm, connectivity::Ptr{p4est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p4est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p4est_t}
end

"""
    p4est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)

Create a new mesh.

### Parameters
* `p4est`:\\[in\\] A forest that is fully 2:1 balanced.
* `ghost`:\\[in\\] The ghost layer created from the provided [`p4est`](@ref).
* `compute_tree_index`:\\[in\\] Boolean to decide whether to allocate and compute the quad\\_to\\_tree list.
* `compute_level_lists`:\\[in\\] Boolean to decide whether to compute the level lists in quad\\_level.
* `btype`:\\[in\\] Currently ignored, only face neighbors are stored.
### Returns
A fully allocated mesh structure.
### Prototype
```c
p4est_mesh_t *p4est_mesh_new_ext (p4est_t * p4est, p4est_ghost_t * ghost, int compute_tree_index, int compute_level_lists, p4est_connect_type_t btype);
```
"""
function p4est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)
    @ccall libp4est.p4est_mesh_new_ext(p4est_::Ptr{p4est_t}, ghost::Ptr{p4est_ghost_t}, compute_tree_index::Cint, compute_level_lists::Cint, btype::p4est_connect_type_t)::Ptr{p4est_mesh_t}
end

"""
    p4est_copy_ext(input, copy_data, duplicate_mpicomm)

Make a deep copy of a [`p4est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless. The inspect member of the copy is set to NULL. The revision counter of the copy is set to zero.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
* `duplicate_mpicomm`:\\[in\\] If true, MPI communicator is copied.
### Returns
Returns a valid [`p4est`](@ref) that does not depend on the input, except for borrowing the same connectivity. Its revision counter is 0.
### Prototype
```c
p4est_t *p4est_copy_ext (p4est_t * input, int copy_data, int duplicate_mpicomm);
```
"""
function p4est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p4est_copy_ext(input::Ptr{p4est_t}, copy_data::Cint, duplicate_mpicomm::MPI_Comm)::Ptr{p4est_t}
end

"""
    p4est_refine_ext(p4est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)

Refine a forest with a bounded refinement level and a replace option.

### Parameters
* `p4est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `maxlevel`:\\[in\\] Maximum allowed refinement level (inclusive). If this is negative the level is restricted only by the compile-time constant QMAXLEVEL in [`p4est`](@ref).h.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn or replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data for newly created quadrants, which is guaranteed to be allocated. This function pointer may be NULL.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace; may be NULL.
### Prototype
```c
void p4est_refine_ext (p4est_t * p4est, int refine_recursive, int maxlevel, p4est_refine_t refine_fn, p4est_init_t init_fn, p4est_replace_t replace_fn);
```
"""
function p4est_refine_ext(p4est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p4est_refine_ext(p4est_::Ptr{p4est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p4est_refine_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

"""
    p4est_coarsen_ext(p4est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)

Coarsen a forest.

### Parameters
* `p4est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `callback_orphans`:\\[in\\] Boolean to enable calling coarsen\\_fn even on non-families. In this case, the second quadrant pointer in the argument list of the callback is NULL, subsequent pointers are undefined, and the return value is ignored. If coarsen\\_recursive is true, it is possible that a quadrant is called once or more as an orphan and eventually becomes part of a family. With coarsen\\_recursive false and callback\\_orphans true, it is guaranteed that every quadrant is passed exactly once into the coarsen\\_fn callback.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p4est_coarsen_ext (p4est_t * p4est, int coarsen_recursive, int callback_orphans, p4est_coarsen_t coarsen_fn, p4est_init_t init_fn, p4est_replace_t replace_fn);
```
"""
function p4est_coarsen_ext(p4est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p4est_coarsen_ext(p4est_::Ptr{p4est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p4est_coarsen_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

"""
    p4est_balance_ext(p4est_, btype, init_fn, replace_fn)

2:1 balance the size differences of neighboring elements in a forest.

### Parameters
* `p4est`:\\[in,out\\] The [`p4est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face or corner/full). Corner balance is almost never required when discretizing a PDE; just causes smoother mesh grading.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p4est_balance_ext (p4est_t * p4est, p4est_connect_type_t btype, p4est_init_t init_fn, p4est_replace_t replace_fn);
```
"""
function p4est_balance_ext(p4est_, btype, init_fn, replace_fn)
    @ccall libp4est.p4est_balance_ext(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

"""
    p4est_balance_subtree_ext(p4est_, btype, which_tree, init_fn, replace_fn)

### Prototype
```c
void p4est_balance_subtree_ext (p4est_t * p4est, p4est_connect_type_t btype, p4est_topidx_t which_tree, p4est_init_t init_fn, p4est_replace_t replace_fn);
```
"""
function p4est_balance_subtree_ext(p4est_, btype, which_tree, init_fn, replace_fn)
    @ccall libp4est.p4est_balance_subtree_ext(p4est_::Ptr{p4est_t}, btype::p4est_connect_type_t, which_tree::p4est_topidx_t, init_fn::p4est_init_t, replace_fn::p4est_replace_t)::Cvoid
end

"""
    p4est_partition_ext(p4est_, partition_for_coarsening, weight_fn)

Repartition the forest.

The forest is partitioned between processors such that each processor has an approximately equal number of quadrants (or weight).

### Parameters
* `p4est`:\\[in,out\\] The forest that will be partitioned.
* `partition_for_coarsening`:\\[in\\] If true, the partition is modified to allow one level of coarsening.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning. A weighting function with constant weight 1 on each quadrant is equivalent to weight\\_fn == NULL but other constant weightings may result in different uniform partitionings.
### Returns
The global number of shipped quadrants
### Prototype
```c
p4est_gloidx_t p4est_partition_ext (p4est_t * p4est, int partition_for_coarsening, p4est_weight_t weight_fn);
```
"""
function p4est_partition_ext(p4est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p4est_partition_ext(p4est_::Ptr{p4est_t}, partition_for_coarsening::Cint, weight_fn::p4est_weight_t)::p4est_gloidx_t
end

"""
    p4est_partition_for_coarsening(p4est_, num_quadrants_in_proc)

Correct partition to allow one level of coarsening.

### Parameters
* `p4est`:\\[in\\] forest whose partition is corrected
* `num_quadrants_in_proc`:\\[in,out\\] partition that will be corrected
### Returns
absolute number of moved quadrants
### Prototype
```c
p4est_gloidx_t p4est_partition_for_coarsening (p4est_t * p4est, p4est_locidx_t * num_quadrants_in_proc);
```
"""
function p4est_partition_for_coarsening(p4est_, num_quadrants_in_proc)
    @ccall libp4est.p4est_partition_for_coarsening(p4est_::Ptr{p4est_t}, num_quadrants_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

"""
    p4est_iterate_ext(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner, remote)

[`p4est_iterate_ext`](@ref) adds the option *remote*: if this is false, then it is the same as [`p4est_iterate`](@ref); if this is true, then corner callbacks are also called on corners for hanging faces touched by local quadrants.

### Prototype
```c
void p4est_iterate_ext (p4est_t * p4est, p4est_ghost_t * ghost_layer, void *user_data, p4est_iter_volume_t iter_volume, p4est_iter_face_t iter_face, p4est_iter_corner_t iter_corner, int remote);
```
"""
function p4est_iterate_ext(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_corner, remote)
    @ccall libp4est.p4est_iterate_ext(p4est_::Ptr{p4est_t}, ghost_layer::Ptr{p4est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p4est_iter_volume_t, iter_face::p4est_iter_face_t, iter_corner::p4est_iter_corner_t, remote::Cint)::Cvoid
end

"""
    p4est_save_ext(filename, p4est_, save_data, save_partition)

Save the complete connectivity/[`p4est`](@ref) data to disk. This is a collective operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations. See [`p4est_load_ext`](@ref) for information on the autopartition parameter.

!!! note

    Aborts on file errors.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p4est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
* `save_partition`:\\[in\\] If false, save file as if 1 core was used. If true, save core count and partition. Advantage: Partition can be recovered on loading with same mpisize and autopartition false. Disadvantage: Makes the file depend on mpisize. Either way the file can be loaded with autopartition true.
### Prototype
```c
void p4est_save_ext (const char *filename, p4est_t * p4est, int save_data, int save_partition);
```
"""
function p4est_save_ext(filename, p4est_, save_data, save_partition)
    @ccall libp4est.p4est_save_ext(filename::Cstring, p4est_::Ptr{p4est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

"""
    p4est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)

### Prototype
```c
p4est_t *p4est_load_ext (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, int autopartition, int broadcasthead, void *user_pointer, p4est_connectivity_t ** connectivity);
```
"""
function p4est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p4est_load_ext(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

"""
    p4est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)

### Prototype
```c
p4est_t *p4est_source_ext (sc_io_source_t * src, sc_MPI_Comm mpicomm, size_t data_size, int load_data, int autopartition, int broadcasthead, void *user_pointer, p4est_connectivity_t ** connectivity);
```
"""
function p4est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p4est_source_ext(src::Ptr{sc_io_source_t}, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p4est_connectivity_t}})::Ptr{p4est_t}
end

"""
    p4est_get_plex_data_ext(p4est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)

Create the data necessary to create a PETsc DMPLEX representation of a forest, as well as the accompanying lnodes and ghost layer. The forest must be at least face balanced (see [`p4est_balance`](@ref)()). See test/test\\_plex2.c for example usage.

All arrays should be initialized to hold sizeof ([`p4est_locidx_t`](@ref)), except for *out_remotes*, which should be initialized to hold (2 * sizeof ([`p4est_locidx_t`](@ref))).

### Parameters
* `p4est`:\\[in\\] the forest
* `ghost`:\\[out\\] the ghost layer
* `lnodes`:\\[out\\] the lnodes
* `ctype`:\\[in\\] the type of adjacency for the overlap
* `overlap`:\\[in\\] the number of layers of overlap (zero is acceptable)
* `first_local_quad`:\\[out\\] the local quadrants are assigned contiguous plex indices, starting with this index
* `out_points_per_dim`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cone_sizes`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cones`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cone_orientations`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_vertex_coords`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_children`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_parents`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_childids`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_leaves`:\\[in,out\\] filled with argument for PetscSFSetGraph()
* `out_remotes`:\\[in,out\\] filled with argument for PetscSFSetGraph()
* `custom_numbering`:\\[in\\] Whether or use the default numbering (0) of DMPlex child ids or the custom (1).
### Prototype
```c
void p4est_get_plex_data_ext (p4est_t * p4est, p4est_ghost_t ** ghost, p4est_lnodes_t ** lnodes, p4est_connect_type_t ctype, int overlap, p4est_locidx_t * first_local_quad, sc_array_t * out_points_per_dim, sc_array_t * out_cone_sizes, sc_array_t * out_cones, sc_array_t * out_cone_orientations, sc_array_t * out_vertex_coords, sc_array_t * out_children, sc_array_t * out_parents, sc_array_t * out_childids, sc_array_t * out_leaves, sc_array_t * out_remotes, int custom_numbering);
```
"""
function p4est_get_plex_data_ext(p4est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)
    @ccall libp4est.p4est_get_plex_data_ext(p4est_::Ptr{p4est_t}, ghost::Ptr{Ptr{p4est_ghost_t}}, lnodes::Ptr{Ptr{p4est_lnodes_t}}, ctype::p4est_connect_type_t, overlap::Cint, first_local_quad::Ptr{p4est_locidx_t}, out_points_per_dim::Ptr{sc_array_t}, out_cone_sizes::Ptr{sc_array_t}, out_cones::Ptr{sc_array_t}, out_cone_orientations::Ptr{sc_array_t}, out_vertex_coords::Ptr{sc_array_t}, out_children::Ptr{sc_array_t}, out_parents::Ptr{sc_array_t}, out_childids::Ptr{sc_array_t}, out_leaves::Ptr{sc_array_t}, out_remotes::Ptr{sc_array_t}, custom_numbering::Cint)::Cvoid
end

"""
    p4est_find_partition(num_procs, search_in, my_begin, my_end, _begin, _end)

Binary search in partition array. Given two targets *my_begin* and *my_end*, find offsets such that `search\\_in[begin] >= my\\_begin`, `my\\_end <= search\\_in[end]`. If more than one index satisfies the conditions, then the minimal index is the result. If there is no index that satisfies the conditions, then *begin* and *end* are tried to set equal such that `search\\_in[begin] >= my\\_end`. If *my_begin* is less or equal than the smallest value of *search_in* *begin* is set to 0 and if *my_end* is bigger or equal than the largest value of *search_in* *end* is set to *num_procs* - 1. If none of the above conditions is satisfied, the output is not well defined. We require `my\\_begin <= my\\_begin'.

### Parameters
* `num_procs`:\\[in\\] Number of processes to get the length of *search_in*.
* `search_in`:\\[in\\] The sorted array (ascending) in that the function will search. If `k` indexes search\\_in, then `0 <= k < num\\_procs`.
* `my_begin`:\\[in\\] The first target that defines the start of the search window.
* `my_end`:\\[in\\] The second target that defines the end of the search window.
* `begin`:\\[in,out\\] The first offset such that `search\\_in[begin] >= my\\_begin`.
* `end`:\\[in,out\\] The second offset such that `my\\_end <= search\\_in[end]`.
### Prototype
```c
void p4est_find_partition (const int num_procs, p4est_gloidx_t * search_in, p4est_gloidx_t my_begin, p4est_gloidx_t my_end, p4est_gloidx_t * begin, p4est_gloidx_t * end);
```
"""
function p4est_find_partition(num_procs, search_in, my_begin, my_end, _begin, _end)
    @ccall libp4est.p4est_find_partition(num_procs::Cint, search_in::Ptr{p4est_gloidx_t}, my_begin::p4est_gloidx_t, my_end::p4est_gloidx_t, _begin::Ptr{p4est_gloidx_t}, _end::Ptr{p4est_gloidx_t})::Cvoid
end

"""
    p4est_find_lower_bound(array, q, guess)

Find the lowest position tq in a quadrant array such that tq >= q.

### Returns
Returns the id of the matching quadrant or -1 if array < q or the array is empty.
### Prototype
```c
ssize_t p4est_find_lower_bound (sc_array_t * array, const p4est_quadrant_t * q, size_t guess);
```
"""
function p4est_find_lower_bound(array, q, guess)
    @ccall libp4est.p4est_find_lower_bound(array::Ptr{sc_array_t}, q::Ptr{p4est_quadrant_t}, guess::Csize_t)::Cssize_t
end

"""
    p4est_find_higher_bound(array, q, guess)

Find the highest position tq in a quadrant array such that tq <= q.

### Returns
Returns the id of the matching quadrant or -1 if array > q or the array is empty.
### Prototype
```c
ssize_t p4est_find_higher_bound (sc_array_t * array, const p4est_quadrant_t * q, size_t guess);
```
"""
function p4est_find_higher_bound(array, q, guess)
    @ccall libp4est.p4est_find_higher_bound(array::Ptr{sc_array_t}, q::Ptr{p4est_quadrant_t}, guess::Csize_t)::Cssize_t
end

"""
    p4est_find_quadrant_cumulative(p4est_, cumulative_id, which_tree, quadrant_id)

Search a local quadrant by its cumulative number in the forest.

We perform a binary search over the processor-local trees, which means that it is advisable NOT to use this function if possible, and to try to maintain O(1) tree context information in the calling code.

### Parameters
* `p4est`:\\[in\\] Forest to be worked with.
* `cumulative_id`:\\[in\\] Cumulative index over all trees of quadrant.
* `which_tree`:\\[in,out\\] If not NULL, the input value can be -1 or an initial guess for the quadrant's tree. An initial guess must be the index of a nonempty local tree. Output is the tree of returned quadrant.
* `quadrant_id`:\\[out\\] If not NULL, the number of quadrant in tree.
### Returns
The identified quadrant.
### Prototype
```c
p4est_quadrant_t *p4est_find_quadrant_cumulative (p4est_t * p4est, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id);
```
"""
function p4est_find_quadrant_cumulative(p4est_, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p4est_find_quadrant_cumulative(p4est_::Ptr{p4est_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p4est_quadrant_t}
end

"""
    p4est_split_array(array, level, indices)

Split an array of quadrants by the children of an ancestor.

Given a sorted **array** of quadrants that have a common ancestor at level **level**, compute the **indices** of the first quadrant in each of the common ancestor's children at level **level** + 1.

### Parameters
* `array`:\\[in\\] The sorted array of quadrants of level > **level**.
* `level`:\\[in\\] The level at which there is a common ancestor.
* `indices`:\\[in,out\\] The indices of the first quadrant in each of the ancestors's children, plus an additional index on the end. The quadrants of **array** that are descendants of child i have indices between indices[i] and indices[i + 1] - 1. If indices[i] = indices[i+1], this indicates that no quadrant in the array is contained in child i.
### Prototype
```c
void p4est_split_array (sc_array_t * array, int level, size_t indices[]);
```
"""
function p4est_split_array(array, level, indices)
    @ccall libp4est.p4est_split_array(array::Ptr{sc_array_t}, level::Cint, indices::Ptr{Csize_t})::Cvoid
end

"""
    p4est_find_range_boundaries(lq, uq, level, faces, corners)

Find the boundary points touched by a range of quadrants.

Given two smallest quadrants, **lq** and **uq**, that mark the first and the last quadrant in a range of quadrants, determine which portions of the tree boundary the range touches.

### Parameters
* `lq`:\\[in\\] The smallest quadrant at the start of the range: if NULL, the tree's first quadrant is taken to be the start of the range.
* `uq`:\\[in\\] The smallest quadrant at the end of the range: if NULL, the tree's last quadrant is taken to be the end of the range.
* `level`:\\[in\\] The level of the containing quadrant whose boundaries are tested: 0 if we want to test the boundaries of the whole tree.
* `faces`:\\[in,out\\] An array of size 4 that is filled: faces[i] is true if the range touches that face.
* `corners`:\\[in,out\\] An array of size 4 that is filled: corners[i] is true if the range touches that corner. **faces** or **corners** may be NULL.
### Returns
Returns an int32\\_t encoded with the same information in **faces** and **corners**: the first (least) four bits represent the four faces, the next four bits represent the four corners.
### Prototype
```c
int32_t p4est_find_range_boundaries (p4est_quadrant_t * lq, p4est_quadrant_t * uq, int level, int faces[], int corners[]);
```
"""
function p4est_find_range_boundaries(lq, uq, level, faces, corners)
    @ccall libp4est.p4est_find_range_boundaries(lq::Ptr{p4est_quadrant_t}, uq::Ptr{p4est_quadrant_t}, level::Cint, faces::Ptr{Cint}, corners::Ptr{Cint})::Int32
end

# typedef int ( * p4est_search_local_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant , p4est_locidx_t local_num , void * point )
"""
Callback function to query the match of a "point" with a quadrant.

This function can be called in two roles: Per-quadrant, in which case the parameter **point** is NULL, or per-point, possibly many times per quadrant.

### Parameters
* `p4est`:\\[in\\] The forest to be queried.
* `which_tree`:\\[in\\] The tree id under consideration.
* `quadrant`:\\[in\\] The quadrant under consideration. This quadrant may be coarser than the quadrants that are contained in the forest (an ancestor), in which case it is a temporary variable and not part of the forest storage. Otherwise, it is a leaf and points directly into the forest storage.
* `local_num`:\\[in\\] If the quadrant is not a leaf, this is < 0. Otherwise it is the (non-negative) index of the quadrant relative to the processor-local storage.
* `point`:\\[in\\] Representation of a "point"; user-defined. If **point** is NULL, the callback may be used to prepare quadrant-related search meta data.
### Returns
If **point** is NULL, true if the search confined to **quadrant** should be executed, false to skip it. Else, true if point may be contained in the quadrant and false otherwise; the return value has no effect on a leaf.
"""
const p4est_search_local_t = Ptr{Cvoid}

"""This typedef is provided for backwards compatibility."""
const p4est_search_query_t = p4est_search_local_t

"""
    p4est_search_local(p4est_, call_post, quadrant_fn, point_fn, points)

Search through the local part of a forest. The search is especially efficient if multiple targets, called "points" below, are searched for simultaneously.

The search runs over all local quadrants and proceeds recursively top-down. For each tree, it may start at the root of that tree, or further down at the root of the subtree that contains all of the tree's local quadrants. Likewise, some intermediate levels in the recursion may be skipped if the processor-local part is contained in a single deeper subtree. The outer loop is thus a depth-first, processor-local forest traversal. Each quadrant in that loop either is a leaf, or a (direct or indirect) strict ancestor of a leaf. On entering a new quadrant, a user-provided quadrant-callback is executed.

As a convenience, the user may provide anonymous "points" that are tracked down the forest. This way one search call may be used for multiple targets. The set of points that potentially matches a given quadrant diminishes from the root down to the leaves: For each quadrant, an inner loop over the potentially matching points executes a point-callback for each candidate that determines whether the point may be a match. If not, it is discarded in the current branch, otherwise it is passed to the next deeper level. The callback is allowed to return true for the same point and more than one quadrant; in this case more than one matching quadrant may be identified. The callback is also allowed to return false for all children of a quadrant that it returned true for earlier. If the point callback returns false for all points relevant to a quadrant, the recursion stops. The points can really be anything, [`p4est`](@ref) does not perform any interpretation, just passes the pointer along to the callback function.

If points are present and the first quadrant callback returned true, we execute it a second time after calling the point callback for all current points. This can be used to gather and postprocess information about the points more easily. If it returns false, the recursion stops.

If the points are a NULL array, they are ignored and the recursion proceeds by querying the per-quadrant callback. If the points are not NULL but an empty array, the recursion will stop immediately!

### Parameters
* `p4est`:\\[in\\] The forest to be searched.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] Executed once when a quadrant is entered, and once when it is left (the second time only if points are present and the first call returned true). This quadrant is always local, if not completely then at least one descendant of it. If the callback returns false, this quadrant and its descendants are excluded from the search recursion. Its **point** argument is always NULL. Callback may be NULL in which case it is ignored.
* `point_fn`:\\[in\\] If **points** is not NULL, must be not NULL. Shall return true for any possible matching point. If **points** is NULL, this callback is ignored.
* `points`:\\[in\\] User-defined array of "points". If NULL, only the **quadrant_fn** callback is executed. If that is NULL, this function noops. If not NULL, the **point_fn** is called on its members during the search.
### Prototype
```c
void p4est_search_local (p4est_t * p4est, int call_post, p4est_search_local_t quadrant_fn, p4est_search_local_t point_fn, sc_array_t * points);
```
"""
function p4est_search_local(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p4est_search_local(p4est_::Ptr{p4est_t}, call_post::Cint, quadrant_fn::p4est_search_local_t, point_fn::p4est_search_local_t, points::Ptr{sc_array_t})::Cvoid
end

"""
    p4est_search(p4est_, quadrant_fn, point_fn, points)

This function is provided for backwards compatibility. We call p4est_search_local with call\\_post = 0.

### Prototype
```c
void p4est_search (p4est_t * p4est, p4est_search_query_t quadrant_fn, p4est_search_query_t point_fn, sc_array_t * points);
```
"""
function p4est_search(p4est_, quadrant_fn, point_fn, points)
    @ccall libp4est.p4est_search(p4est_::Ptr{p4est_t}, quadrant_fn::p4est_search_query_t, point_fn::p4est_search_query_t, points::Ptr{sc_array_t})::Cvoid
end

# typedef int ( * p4est_search_partition_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant , int pfirst , int plast , void * point )
"""
Callback function for the partition recursion.

### Parameters
* `p4est`:\\[in\\] The forest to traverse. Its local quadrants are never accessed.
* `which_tree`:\\[in\\] The tree number under consideration.
* `quadrant`:\\[in\\] This quadrant is not from local forest storage, and its user data is undefined. It represents the branch of the forest in the top-down recursion.
* `pfirst`:\\[in\\] The lowest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `plast`:\\[in\\] The highest processor that owns part of **quadrant**. Guaranteed to be non-empty. If this is equal to **pfirst**, then the recursion will stop for **quadrant**'s branch after this function returns.
* `point`:\\[in,out\\] Pointer to a user-defined point object. If called per-quadrant, this is NULL.
### Returns
If false, the recursion at quadrant is terminated. If true, it continues if **pfirst** < **plast**.
"""
const p4est_search_partition_t = Ptr{Cvoid}

"""
    p4est_search_partition(p4est_, call_post, quadrant_fn, point_fn, points)

Traverse the global partition top-down. We proceed top-down through the partition, identically on all processors except for the results of two user-provided callbacks. The recursion will only go down branches that are split between multiple processors. The callback functions can be used to stop a branch recursion even for split branches. This function offers the option to search for arbitrary user-defined points analogously to p4est_search_local.

!!! note

    Traversing the whole processor partition will be at least O(P), so sensible use of the callback function is advised to cut it short.

### Parameters
* `p4est`:\\[in\\] The forest to traverse. Its local quadrants are never accessed.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] This function controls the recursion, which only continues deeper if this callback returns true for a branch quadrant. It is allowed to set this to NULL.
* `point_fn`:\\[in\\] This function decides per-point whether it is followed down the recursion. Must be non-NULL if **points** are not NULL.
* `points`:\\[in\\] User-provided array of **points** that are passed to the callback **point_fn**. See p4est_search_local for details.
### Prototype
```c
void p4est_search_partition (p4est_t * p4est, int call_post, p4est_search_partition_t quadrant_fn, p4est_search_partition_t point_fn, sc_array_t * points);
```
"""
function p4est_search_partition(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p4est_search_partition(p4est_::Ptr{p4est_t}, call_post::Cint, quadrant_fn::p4est_search_partition_t, point_fn::p4est_search_partition_t, points::Ptr{sc_array_t})::Cvoid
end

# typedef int ( * p4est_search_all_t ) ( p4est_t * p4est , p4est_topidx_t which_tree , p4est_quadrant_t * quadrant , int pfirst , int plast , p4est_locidx_t local_num , void * point )
"""
Callback function for the top-down search through the whole forest.

### Parameters
* `p4est`:\\[in\\] The forest to search. We recurse through the trees one after another.
* `which_tree`:\\[in\\] The current tree number.
* `quadrant`:\\[in\\] The current quadrant in the recursion. This quadrant is either a non-leaf tree branch or a leaf. If the quadrant is contained in the local partition, we know which, otherwise we don't. Let us first consider the situation when **quadrant** is local, which is indicated by both **pfirst** and **plast** being equal to [`p4est`](@ref)->mpirank. Then the parameter **local_num** is negative for non-leaves and the number of the quadrant as a leaf in local storage otherwise. Only if the quadrant is a local leaf, it points to the actual local storage and can be used to access user data etc., and the recursion terminates. The other possibility is that **pfirst** < **plast**, in which case we proceed with the recursion, or both are equal to the same remote rank, in which case the recursion terminates. Either way, the quadrant is not from local forest storage.
* `pfirst`:\\[in\\] The lowest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `plast`:\\[in\\] The highest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `local_num`:\\[in\\] If **quadrant** is a local leaf, this number is the index of the leaf in local quadrant storage. Else, this is a negative value.
* `point`:\\[in,out\\] User-defined representation of a point. This parameter distinguishes two uses of the callback. For each quadrant, the callback is first called with a NULL point, and if this callback returns true, once for each point tracked in this branch. The return value for a point determines whether it shall be tracked further down the branch or not, and has no effect on a local leaf. The call with a NULL point is intended to prepare quadrant-related search meta data that is common to all points, and/or to efficiently terminate the recursion for all points in the branch in one call.
### Returns
If false, the recursion at **quadrant** terminates. If true, it continues if **pfirst** < **plast** or if they are both equal to [`p4est`](@ref)->mpirank and the recursion has not reached a leaf yet.
"""
const p4est_search_all_t = Ptr{Cvoid}

"""
    p4est_search_all(p4est_, call_post, quadrant_fn, point_fn, points)

Perform a top-down search on the whole forest.

This function combines the functionality of p4est_search_local and p4est_search_partition; their documentation applies for the most part.

The recursion proceeds from the root quadrant of each tree until (a) we encounter a remote quadrant that covers only one processor, or (b) we encounter a local leaf quadrant. In other words, we proceed with the recursion into a quadrant's children if (a) the quadrant is split between two or more processors, no matter whether one of them is the calling processor or not, or (b) if the quadrant is on the local processor but we have not reached a leaf yet.

The search can track one or more points, which are abstract placeholders. They are matched against the quadrants traversed using a callback function. The result of the callback function can be used to stop a recursion early. The user determines how a point is interpreted, we only pass it around.

Note that in the remote case (a), we may terminate the recursion even if the quadrant is not a leaf, which we have no means of knowing. Still, this case is sufficient to determine the processor ownership of a point.

!!! note

    This is a very powerful function that can become slow if not used carefully.

!!! note

    As with the two other search functions in this file, calling it once with many points is generally much faster than calling it once for each point. Using multiple points also allows for a per-quadrant termination of the recursion in addition to a more costly per-point termination.

!!! note

    This function works fine when used for the special cases that either the partition or the local quadrants are not of interest. However, in the case of querying only local information we expect that p4est_search_local will be faster since it employs specific local optimizations.

### Parameters
* `p4est`:\\[in\\] The forest to be searched.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] Executed once for each quadrant that is entered. If the callback returns false, this quadrant and its descendants are excluded from the search, and the points in this branch are not queried further. Its **point** argument is always NULL. Callback may be NULL in which case it is ignored.
* `point_fn`:\\[in\\] Executed once for each point that is relevant for a quadrant of the search. If it returns true, the point is tracked further down that branch, else it is discarded from the queries for the children. If **points** is not NULL, this callback must be not NULL. If **points** is NULL, it is not called.
* `points`:\\[in\\] User-defined array of points. We do not interpret a point, just pass it into the callbacks. If NULL, only the **quadrant_fn** callback is executed. If that is NULL, the whole function noops. If not NULL, the **point_fn** is called on its members during the search.
### Prototype
```c
void p4est_search_all (p4est_t * p4est, int call_post, p4est_search_all_t quadrant_fn, p4est_search_all_t point_fn, sc_array_t * points);
```
"""
function p4est_search_all(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p4est_search_all(p4est_::Ptr{p4est_t}, call_post::Cint, quadrant_fn::p4est_search_all_t, point_fn::p4est_search_all_t, points::Ptr{sc_array_t})::Cvoid
end

struct p6est_quadrant_data
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{p6est_quadrant_data}, f::Symbol)
    f === :user_data && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :user_long && return Ptr{Clong}(x + 0)
    f === :user_int && return Ptr{Cint}(x + 0)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :piggy1 && return Ptr{__JL_Ctag_317}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_318}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_319}(x + 0)
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

"""
    p2est_quadrant

A 1D quadrant datatype: this is used to encode a "layer" of a column in the 2D+1D AMR scheme.

| Field | Note                                            |
| :---- | :---------------------------------------------- |
| z     | vertical coordinate                             |
| level | level of refinement                             |
| pad8  | padding                                         |
| pad16 |                                                 |
| p     | a union of additional data attached to a layer  |
"""
struct p2est_quadrant
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{p2est_quadrant}, f::Symbol)
    f === :z && return Ptr{p4est_qcoord_t}(x + 0)
    f === :level && return Ptr{Int8}(x + 4)
    f === :pad8 && return Ptr{Int8}(x + 5)
    f === :pad16 && return Ptr{Int16}(x + 6)
    f === :p && return Ptr{p6est_quadrant_data}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::p2est_quadrant, f::Symbol)
    r = Ref{p2est_quadrant}(x)
    ptr = Base.unsafe_convert(Ptr{p2est_quadrant}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p2est_quadrant}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""A 1D quadrant datatype: this is used to encode a "layer" of a column in the 2D+1D AMR scheme."""
const p2est_quadrant_t = p2est_quadrant

"""
    p8est_connect_type_t

Characterize a type of adjacency.

Several functions involve relationships between neighboring trees and/or quadrants, and their behavior depends on how one defines adjacency: 1) entities are adjacent if they share a face, or 2) entities are adjacent if they share a face or corner, or 3) entities are adjacent if they share a face, corner or edge. [`p8est_connect_type_t`](@ref) is used to choose the desired behavior. This enum must fit into an int8\\_t.
"""
@cenum p8est_connect_type_t::UInt32 begin
    P8EST_CONNECT_FACE = 31
    P8EST_CONNECT_EDGE = 32
    P8EST_CONNECT_CORNER = 33
    P8EST_CONNECT_FULL = 33
end

"""
    p8est_connectivity_encode_t

Typedef for serialization method.

| Enumerator                   | Note                              |
| :--------------------------- | :-------------------------------- |
| P8EST\\_CONN\\_ENCODE\\_LAST | Invalid entry to close the list.  |
"""
@cenum p8est_connectivity_encode_t::UInt32 begin
    P8EST_CONN_ENCODE_NONE = 0
    P8EST_CONN_ENCODE_LAST = 1
end

"""
    p8est_connect_type_int(btype)

Convert the [`p8est_connect_type_t`](@ref) into a number.

### Parameters
* `btype`:\\[in\\] The balance type to convert.
### Returns
Returns 1, 2 or 3.
### Prototype
```c
int p8est_connect_type_int (p8est_connect_type_t btype);
```
"""
function p8est_connect_type_int(btype)
    @ccall libp4est.p8est_connect_type_int(btype::p8est_connect_type_t)::Cint
end

"""
    p8est_connect_type_string(btype)

Convert the [`p8est_connect_type_t`](@ref) into a const string.

### Parameters
* `btype`:\\[in\\] The balance type to convert.
### Returns
Returns a pointer to a constant string.
### Prototype
```c
const char *p8est_connect_type_string (p8est_connect_type_t btype);
```
"""
function p8est_connect_type_string(btype)
    @ccall libp4est.p8est_connect_type_string(btype::p8est_connect_type_t)::Cstring
end

"""
    p8est_connectivity

This structure holds the 3D inter-tree connectivity information. Identification of arbitrary faces, edges and corners is possible.

The arrays tree\\_to\\_* are stored in z ordering. For corners the order wrt. zyx is 000 001 010 011 100 101 110 111. For faces the order is -x +x -y +y -z +z. They are allocated [0][0]..[0][N-1]..[num\\_trees-1][0]..[num\\_trees-1][N-1]. where N is 6 for tree and face, 8 for corner, 12 for edge.

The values for tree\\_to\\_face are in 0..23 where ttf % 6 gives the face number and ttf / 6 the face orientation code. The orientation is determined as follows. Let my\\_face and other\\_face be the two face numbers of the connecting trees in 0..5. Then the first face corner of the lower of my\\_face and other\\_face connects to a face corner numbered 0..3 in the higher of my\\_face and other\\_face. The face orientation is defined as this number. If my\\_face == other\\_face, treating either of both faces as the lower one leads to the same result.

It is valid to specify num\\_vertices as 0. In this case vertices and tree\\_to\\_vertex are set to NULL. Otherwise the vertex coordinates are stored in the array vertices as [0][0]..[0][2]..[num\\_vertices-1][0]..[num\\_vertices-1][2].

The edges are only stored when they connect trees. In this case tree\\_to\\_edge indexes into *ett_offset*. Otherwise the tree\\_to\\_edge entry must be -1 and this edge is ignored. If num\\_edges == 0, tree\\_to\\_edge and edge\\_to\\_* arrays are set to NULL.

The arrays edge\\_to\\_* store a variable number of entries per edge. For edge e these are at position [ett\\_offset[e]]..[ett\\_offset[e+1]-1]. Their number for edge e is ett\\_offset[e+1] - ett\\_offset[e]. The entries encode all trees adjacent to edge e. The size of the edge\\_to\\_* arrays is num\\_ett = ett\\_offset[num\\_edges]. The edge\\_to\\_edge array holds values in 0..23, where the lower 12 indicate one edge orientation and the higher 12 the opposite edge orientation.

The corners are only stored when they connect trees. In this case tree\\_to\\_corner indexes into *ctt_offset*. Otherwise the tree\\_to\\_corner entry must be -1 and this corner is ignored. If num\\_corners == 0, tree\\_to\\_corner and corner\\_to\\_* arrays are set to NULL.

The arrays corner\\_to\\_* store a variable number of entries per corner. For corner c these are at position [ctt\\_offset[c]]..[ctt\\_offset[c+1]-1]. Their number for corner c is ctt\\_offset[c+1] - ctt\\_offset[c]. The entries encode all trees adjacent to corner c. The size of the corner\\_to\\_* arrays is num\\_ctt = ctt\\_offset[num\\_corners].

The *\\_to\\_attr arrays may have arbitrary contents defined by the user.

| Field                | Note                                                                                 |
| :------------------- | :----------------------------------------------------------------------------------- |
| num\\_vertices       | the number of vertices that define the *embedding* of the forest (not the topology)  |
| num\\_trees          | the number of trees                                                                  |
| num\\_edges          | the number of edges that help define the topology                                    |
| num\\_corners        | the number of corners that help define the topology                                  |
| vertices             | an array of size (3 * *num_vertices*)                                                |
| tree\\_to\\_vertex   | embed each tree into  ```c++ R^3 ```  for e.g. visualization (see p8est\\_vtk.h)     |
| tree\\_attr\\_bytes  | bytes per tree in tree\\_to\\_attr                                                   |
| tree\\_to\\_attr     | not touched by [`p4est`](@ref)                                                       |
| tree\\_to\\_tree     | (6 * *num_trees*) neighbors across faces                                             |
| tree\\_to\\_face     | (6 * *num_trees*) face to face+orientation (see description)                         |
| tree\\_to\\_edge     | (12 * *num_trees*) or NULL (see description)                                         |
| ett\\_offset         | edge to offset in *edge_to_tree* and *edge_to_edge*                                  |
| edge\\_to\\_tree     | list of trees that meet at an edge                                                   |
| edge\\_to\\_edge     | list of tree-edges+orientations that meet at an edge (see description)               |
| tree\\_to\\_corner   | (8 * *num_trees*) or NULL (see description)                                          |
| ctt\\_offset         | corner to offset in *corner_to_tree* and *corner_to_corner*                          |
| corner\\_to\\_tree   | list of trees that meet at a corner                                                  |
| corner\\_to\\_corner | list of tree-corners that meet at a corner                                           |
"""
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

"""
This structure holds the 3D inter-tree connectivity information. Identification of arbitrary faces, edges and corners is possible.

The arrays tree\\_to\\_* are stored in z ordering. For corners the order wrt. zyx is 000 001 010 011 100 101 110 111. For faces the order is -x +x -y +y -z +z. They are allocated [0][0]..[0][N-1]..[num\\_trees-1][0]..[num\\_trees-1][N-1]. where N is 6 for tree and face, 8 for corner, 12 for edge.

The values for tree\\_to\\_face are in 0..23 where ttf % 6 gives the face number and ttf / 6 the face orientation code. The orientation is determined as follows. Let my\\_face and other\\_face be the two face numbers of the connecting trees in 0..5. Then the first face corner of the lower of my\\_face and other\\_face connects to a face corner numbered 0..3 in the higher of my\\_face and other\\_face. The face orientation is defined as this number. If my\\_face == other\\_face, treating either of both faces as the lower one leads to the same result.

It is valid to specify num\\_vertices as 0. In this case vertices and tree\\_to\\_vertex are set to NULL. Otherwise the vertex coordinates are stored in the array vertices as [0][0]..[0][2]..[num\\_vertices-1][0]..[num\\_vertices-1][2].

The edges are only stored when they connect trees. In this case tree\\_to\\_edge indexes into *ett_offset*. Otherwise the tree\\_to\\_edge entry must be -1 and this edge is ignored. If num\\_edges == 0, tree\\_to\\_edge and edge\\_to\\_* arrays are set to NULL.

The arrays edge\\_to\\_* store a variable number of entries per edge. For edge e these are at position [ett\\_offset[e]]..[ett\\_offset[e+1]-1]. Their number for edge e is ett\\_offset[e+1] - ett\\_offset[e]. The entries encode all trees adjacent to edge e. The size of the edge\\_to\\_* arrays is num\\_ett = ett\\_offset[num\\_edges]. The edge\\_to\\_edge array holds values in 0..23, where the lower 12 indicate one edge orientation and the higher 12 the opposite edge orientation.

The corners are only stored when they connect trees. In this case tree\\_to\\_corner indexes into *ctt_offset*. Otherwise the tree\\_to\\_corner entry must be -1 and this corner is ignored. If num\\_corners == 0, tree\\_to\\_corner and corner\\_to\\_* arrays are set to NULL.

The arrays corner\\_to\\_* store a variable number of entries per corner. For corner c these are at position [ctt\\_offset[c]]..[ctt\\_offset[c+1]-1]. Their number for corner c is ctt\\_offset[c+1] - ctt\\_offset[c]. The entries encode all trees adjacent to corner c. The size of the corner\\_to\\_* arrays is num\\_ctt = ctt\\_offset[num\\_corners].

The *\\_to\\_attr arrays may have arbitrary contents defined by the user.
"""
const p8est_connectivity_t = p8est_connectivity

"""
    p8est_connectivity_memory_used(conn)

Calculate memory usage of a connectivity structure.

### Parameters
* `conn`:\\[in\\] Connectivity structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p8est_connectivity_memory_used (p8est_connectivity_t * conn);
```
"""
function p8est_connectivity_memory_used(conn)
    @ccall libp4est.p8est_connectivity_memory_used(conn::Ptr{p8est_connectivity_t})::Csize_t
end

struct p8est_edge_transform_t
    ntree::p4est_topidx_t
    nedge::Int8
    naxis::NTuple{3, Int8}
    nflip::Int8
    corners::Int8
end

struct p8est_edge_info_t
    iedge::Int8
    edge_transforms::sc_array_t
end

struct p8est_corner_transform_t
    ntree::p4est_topidx_t
    ncorner::Int8
end

struct p8est_corner_info_t
    icorner::p4est_topidx_t
    corner_transforms::sc_array_t
end

"""
    p8est_connectivity_face_neighbor_corner_set(c, f, nf, set)

Transform a corner across one of the adjacent faces into a neighbor tree. It expects a face permutation index that has been precomputed.

### Parameters
* `c`:\\[in\\] A corner number in 0..7.
* `f`:\\[in\\] A face number that touches the corner *c*.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `set`:\\[in\\] A value from *p8est_face_permutation_sets* that is obtained using *f*, *nf*, and a valid orientation: ref = p8est\\_face\\_permutation\\_refs[f][nf]; set = p8est\\_face\\_permutation\\_sets[ref][orientation];
### Returns
The corner number in 0..7 seen from the other face.
### Prototype
```c
int p8est_connectivity_face_neighbor_corner_set (int c, int f, int nf, int set);
```
"""
function p8est_connectivity_face_neighbor_corner_set(c, f, nf, set)
    @ccall libp4est.p8est_connectivity_face_neighbor_corner_set(c::Cint, f::Cint, nf::Cint, set::Cint)::Cint
end

"""
    p8est_connectivity_face_neighbor_face_corner(fc, f, nf, o)

Transform a face corner across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `fc`:\\[in\\] A face corner number in 0..3.
* `f`:\\[in\\] A face that the face corner *fc* is relative to.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The face corner number relative to the neighbor's face.
### Prototype
```c
int p8est_connectivity_face_neighbor_face_corner (int fc, int f, int nf, int o);
```
"""
function p8est_connectivity_face_neighbor_face_corner(fc, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_face_corner(fc::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_face_neighbor_corner(c, f, nf, o)

Transform a corner across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `c`:\\[in\\] A corner number in 0..7.
* `f`:\\[in\\] A face number that touches the corner *c*.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The number of the corner seen from the neighbor tree.
### Prototype
```c
int p8est_connectivity_face_neighbor_corner (int c, int f, int nf, int o);
```
"""
function p8est_connectivity_face_neighbor_corner(c, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_corner(c::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_face_neighbor_face_edge(fe, f, nf, o)

Transform a face-edge across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `fe`:\\[in\\] A face edge number in 0..3.
* `f`:\\[in\\] A face number that touches the edge *e*.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The face edge number seen from the neighbor tree.
### Prototype
```c
int p8est_connectivity_face_neighbor_face_edge (int fe, int f, int nf, int o);
```
"""
function p8est_connectivity_face_neighbor_face_edge(fe, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_face_edge(fe::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_face_neighbor_edge(e, f, nf, o)

Transform an edge across one of the adjacent faces into a neighbor tree. This version expects the neighbor face and orientation separately.

### Parameters
* `e`:\\[in\\] A edge number in 0..11.
* `f`:\\[in\\] A face 0..5 that touches the edge *e*.
* `nf`:\\[in\\] A neighbor face that is on the other side of .
* `o`:\\[in\\] The orientation between tree boundary faces *f* and .
### Returns
The edge's number seen from the neighbor.
### Prototype
```c
int p8est_connectivity_face_neighbor_edge (int e, int f, int nf, int o);
```
"""
function p8est_connectivity_face_neighbor_edge(e, f, nf, o)
    @ccall libp4est.p8est_connectivity_face_neighbor_edge(e::Cint, f::Cint, nf::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_edge_neighbor_edge_corner(ec, o)

Transform an edge corner across one of the adjacent edges into a neighbor tree.

### Parameters
* `ec`:\\[in\\] An edge corner number in 0..1.
* `o`:\\[in\\] The orientation of a tree boundary edge connection.
### Returns
The edge corner number seen from the other tree.
### Prototype
```c
int p8est_connectivity_edge_neighbor_edge_corner (int ec, int o);
```
"""
function p8est_connectivity_edge_neighbor_edge_corner(ec, o)
    @ccall libp4est.p8est_connectivity_edge_neighbor_edge_corner(ec::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_edge_neighbor_corner(c, e, ne, o)

Transform a corner across one of the adjacent edges into a neighbor tree. This version expects the neighbor edge and orientation separately.

### Parameters
* `c`:\\[in\\] A corner number in 0..7.
* `e`:\\[in\\] An edge 0..11 that touches the corner *c*.
* `ne`:\\[in\\] A neighbor edge that is on the other side of *.*
* `o`:\\[in\\] The orientation between tree boundary edges *e* and *.*
### Returns
Corner number seen from the neighbor.
### Prototype
```c
int p8est_connectivity_edge_neighbor_corner (int c, int e, int ne, int o);
```
"""
function p8est_connectivity_edge_neighbor_corner(c, e, ne, o)
    @ccall libp4est.p8est_connectivity_edge_neighbor_corner(c::Cint, e::Cint, ne::Cint, o::Cint)::Cint
end

"""
    p8est_connectivity_new(num_vertices, num_trees, num_edges, num_ett, num_corners, num_ctt)

Allocate a connectivity structure. The attribute fields are initialized to NULL.

### Parameters
* `num_vertices`:\\[in\\] Number of total vertices (i.e. geometric points).
* `num_trees`:\\[in\\] Number of trees in the forest.
* `num_edges`:\\[in\\] Number of tree-connecting edges.
* `num_ett`:\\[in\\] Number of total trees in edge\\_to\\_tree array.
* `num_corners`:\\[in\\] Number of tree-connecting corners.
* `num_ctt`:\\[in\\] Number of total trees in corner\\_to\\_tree array.
### Returns
A connectivity structure with allocated arrays.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_edges, p4est_topidx_t num_ett, p4est_topidx_t num_corners, p4est_topidx_t num_ctt);
```
"""
function p8est_connectivity_new(num_vertices, num_trees, num_edges, num_ett, num_corners, num_ctt)
    @ccall libp4est.p8est_connectivity_new(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_edges::p4est_topidx_t, num_ett::p4est_topidx_t, num_corners::p4est_topidx_t, num_ctt::p4est_topidx_t)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_copy(num_vertices, num_trees, num_edges, num_corners, vertices, ttv, ttt, ttf, tte, eoff, ett, ete, ttc, coff, ctt, ctc)

Allocate a connectivity structure and populate from constants. The attribute fields are initialized to NULL.

### Parameters
* `num_vertices`:\\[in\\] Number of total vertices (i.e. geometric points).
* `num_trees`:\\[in\\] Number of trees in the forest.
* `num_edges`:\\[in\\] Number of tree-connecting edges.
* `num_corners`:\\[in\\] Number of tree-connecting corners.
* `eoff`:\\[in\\] Edge-to-tree offsets (num\\_edges + 1 values). This must always be non-NULL; in trivial cases it is just a pointer to a p4est\\_topix value of 0.
* `coff`:\\[in\\] Corner-to-tree offsets (num\\_corners + 1 values). This must always be non-NULL; in trivial cases it is just a pointer to a p4est\\_topix value of 0.
### Returns
The connectivity is checked for validity.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_copy (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_edges, p4est_topidx_t num_corners, const double *vertices, const p4est_topidx_t * ttv, const p4est_topidx_t * ttt, const int8_t * ttf, const p4est_topidx_t * tte, const p4est_topidx_t * eoff, const p4est_topidx_t * ett, const int8_t * ete, const p4est_topidx_t * ttc, const p4est_topidx_t * coff, const p4est_topidx_t * ctt, const int8_t * ctc);
```
"""
function p8est_connectivity_new_copy(num_vertices, num_trees, num_edges, num_corners, vertices, ttv, ttt, ttf, tte, eoff, ett, ete, ttc, coff, ctt, ctc)
    @ccall libp4est.p8est_connectivity_new_copy(num_vertices::p4est_topidx_t, num_trees::p4est_topidx_t, num_edges::p4est_topidx_t, num_corners::p4est_topidx_t, vertices::Ptr{Cdouble}, ttv::Ptr{p4est_topidx_t}, ttt::Ptr{p4est_topidx_t}, ttf::Ptr{Int8}, tte::Ptr{p4est_topidx_t}, eoff::Ptr{p4est_topidx_t}, ett::Ptr{p4est_topidx_t}, ete::Ptr{Int8}, ttc::Ptr{p4est_topidx_t}, coff::Ptr{p4est_topidx_t}, ctt::Ptr{p4est_topidx_t}, ctc::Ptr{Int8})::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_bcast(conn_in, root, comm)

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_bcast (p8est_connectivity_t * conn_in, int root, sc_MPI_Comm comm);
```
"""
function p8est_connectivity_bcast(conn_in, root, comm)
    @ccall libp4est.p8est_connectivity_bcast(conn_in::Ptr{p8est_connectivity_t}, root::Cint, comm::Cint)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_destroy(connectivity)

Destroy a connectivity structure. Also destroy all attributes.

### Prototype
```c
void p8est_connectivity_destroy (p8est_connectivity_t * connectivity);
```
"""
function p8est_connectivity_destroy(connectivity)
    @ccall libp4est.p8est_connectivity_destroy(connectivity::Ptr{p8est_connectivity_t})::Cvoid
end

"""
    p8est_connectivity_set_attr(conn, bytes_per_tree)

Allocate or free the attribute fields in a connectivity.

### Parameters
* `conn`:\\[in,out\\] The conn->*\\_to\\_attr fields must either be NULL or previously be allocated by this function.
* `bytes_per_tree`:\\[in\\] If 0, tree\\_to\\_attr is freed (being NULL is ok). If positive, requested space is allocated.
### Prototype
```c
void p8est_connectivity_set_attr (p8est_connectivity_t * conn, size_t bytes_per_tree);
```
"""
function p8est_connectivity_set_attr(conn, bytes_per_tree)
    @ccall libp4est.p8est_connectivity_set_attr(conn::Ptr{p8est_connectivity_t}, bytes_per_tree::Csize_t)::Cvoid
end

"""
    p8est_connectivity_is_valid(connectivity)

Examine a connectivity structure.

### Returns
Returns true if structure is valid, false otherwise.
### Prototype
```c
int p8est_connectivity_is_valid (p8est_connectivity_t * connectivity);
```
"""
function p8est_connectivity_is_valid(connectivity)
    @ccall libp4est.p8est_connectivity_is_valid(connectivity::Ptr{p8est_connectivity_t})::Cint
end

"""
    p8est_connectivity_is_equal(conn1, conn2)

Check two connectivity structures for equality.

### Returns
Returns true if structures are equal, false otherwise.
### Prototype
```c
int p8est_connectivity_is_equal (p8est_connectivity_t * conn1, p8est_connectivity_t * conn2);
```
"""
function p8est_connectivity_is_equal(conn1, conn2)
    @ccall libp4est.p8est_connectivity_is_equal(conn1::Ptr{p8est_connectivity_t}, conn2::Ptr{p8est_connectivity_t})::Cint
end

"""
    p8est_connectivity_sink(conn, sink)

Write connectivity to a sink object.

### Parameters
* `conn`:\\[in\\] The connectivity to be written.
* `sink`:\\[in,out\\] The connectivity is written into this sink.
### Returns
0 on success, nonzero on error.
### Prototype
```c
int p8est_connectivity_sink (p8est_connectivity_t * conn, sc_io_sink_t * sink);
```
"""
function p8est_connectivity_sink(conn, sink)
    @ccall libp4est.p8est_connectivity_sink(conn::Ptr{p8est_connectivity_t}, sink::Ptr{sc_io_sink_t})::Cint
end

"""
    p8est_connectivity_deflate(conn, code)

Allocate memory and store the connectivity information there.

### Parameters
* `conn`:\\[in\\] The connectivity structure to be exported to memory.
* `code`:\\[in\\] Encoding and compression method for serialization.
### Returns
Newly created array that contains the information.
### Prototype
```c
sc_array_t *p8est_connectivity_deflate (p8est_connectivity_t * conn, p8est_connectivity_encode_t code);
```
"""
function p8est_connectivity_deflate(conn, code)
    @ccall libp4est.p8est_connectivity_deflate(conn::Ptr{p8est_connectivity_t}, code::p8est_connectivity_encode_t)::Ptr{sc_array_t}
end

"""
    p8est_connectivity_save(filename, connectivity)

Save a connectivity structure to disk.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `connectivity`:\\[in\\] Valid connectivity structure.
### Returns
Returns 0 on success, nonzero on file error.
### Prototype
```c
int p8est_connectivity_save (const char *filename, p8est_connectivity_t * connectivity);
```
"""
function p8est_connectivity_save(filename, connectivity)
    @ccall libp4est.p8est_connectivity_save(filename::Cstring, connectivity::Ptr{p8est_connectivity_t})::Cint
end

"""
    p8est_connectivity_source(source)

Read connectivity from a source object.

### Parameters
* `source`:\\[in,out\\] The connectivity is read from this source.
### Returns
The newly created connectivity, or NULL on error.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_source (sc_io_source_t * source);
```
"""
function p8est_connectivity_source(source)
    @ccall libp4est.p8est_connectivity_source(source::Ptr{sc_io_source_t})::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_inflate(buffer)

Create new connectivity from a memory buffer.

### Parameters
* `buffer`:\\[in\\] The connectivity is created from this memory buffer.
### Returns
The newly created connectivity, or NULL on error.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_inflate (sc_array_t * buffer);
```
"""
function p8est_connectivity_inflate(buffer)
    @ccall libp4est.p8est_connectivity_inflate(buffer::Ptr{sc_array_t})::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_load(filename, bytes)

Load a connectivity structure from disk.

### Parameters
* `filename`:\\[in\\] Name of the file to read.
* `bytes`:\\[out\\] Size in bytes of connectivity on disk or NULL.
### Returns
Returns valid connectivity, or NULL on file error.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_load (const char *filename, size_t *bytes);
```
"""
function p8est_connectivity_load(filename, bytes)
    @ccall libp4est.p8est_connectivity_load(filename::Cstring, bytes::Ptr{Csize_t})::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_unitcube()

Create a connectivity structure for the unit cube.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_unitcube (void);
```
"""
function p8est_connectivity_new_unitcube()
    @ccall libp4est.p8est_connectivity_new_unitcube()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_periodic()

Create a connectivity structure for an all-periodic unit cube.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_periodic (void);
```
"""
function p8est_connectivity_new_periodic()
    @ccall libp4est.p8est_connectivity_new_periodic()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_rotwrap()

Create a connectivity structure for a mostly periodic unit cube. The left and right faces are identified, and bottom and top rotated. Front and back are not identified.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_rotwrap (void);
```
"""
function p8est_connectivity_new_rotwrap()
    @ccall libp4est.p8est_connectivity_new_rotwrap()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_twocubes()

Create a connectivity structure that contains two cubes.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_twocubes (void);
```
"""
function p8est_connectivity_new_twocubes()
    @ccall libp4est.p8est_connectivity_new_twocubes()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_twotrees(l_face, r_face, orientation)

Create a connectivity structure for two trees being rotated w.r.t. each other in a user-defined way.

### Parameters
* `l_face`:\\[in\\] index of left face
* `r_face`:\\[in\\] index of right face
* `orientation`:\\[in\\] orientation of trees w.r.t. each other
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_twotrees (int l_face, int r_face, int orientation);
```
"""
function p8est_connectivity_new_twotrees(l_face, r_face, orientation)
    @ccall libp4est.p8est_connectivity_new_twotrees(l_face::Cint, r_face::Cint, orientation::Cint)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_twowrap()

Create a connectivity structure that contains two cubes where the two far ends are identified periodically.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_twowrap (void);
```
"""
function p8est_connectivity_new_twowrap()
    @ccall libp4est.p8est_connectivity_new_twowrap()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_rotcubes()

Create a connectivity structure that contains a few cubes. These are rotated against each other to stress the topology routines.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_rotcubes (void);
```
"""
function p8est_connectivity_new_rotcubes()
    @ccall libp4est.p8est_connectivity_new_rotcubes()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_brick(m, n, p, periodic_a, periodic_b, periodic_c)

An m by n by p array with periodicity in x, y, and z if periodic\\_a, periodic\\_b, and periodic\\_c are true, respectively.

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_brick (int m, int n, int p, int periodic_a, int periodic_b, int periodic_c);
```
"""
function p8est_connectivity_new_brick(m, n, p, periodic_a, periodic_b, periodic_c)
    @ccall libp4est.p8est_connectivity_new_brick(m::Cint, n::Cint, p::Cint, periodic_a::Cint, periodic_b::Cint, periodic_c::Cint)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_shell()

Create a connectivity structure that builds a spherical shell. It is made up of six connected parts [-1,1]x[-1,1]x[1,2]. This connectivity reuses vertices and relies on a geometry transformation. It is thus not suitable for [`p8est_connectivity_complete`](@ref).

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_shell (void);
```
"""
function p8est_connectivity_new_shell()
    @ccall libp4est.p8est_connectivity_new_shell()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_sphere()

Create a connectivity structure that builds a solid sphere. It is made up of two layers and a cube in the center. This connectivity reuses vertices and relies on a geometry transformation. It is thus not suitable for [`p8est_connectivity_complete`](@ref).

### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_sphere (void);
```
"""
function p8est_connectivity_new_sphere()
    @ccall libp4est.p8est_connectivity_new_sphere()::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_torus(nSegments)

Create a connectivity structure that builds a revolution torus.

This connectivity reuses vertices and relies on a geometry transformation. It is thus not suitable for [`p8est_connectivity_complete`](@ref).

This connectivity reuses ideas from disk2d connectivity. More precisely the torus is divided into segments arround the revolution axis, each segments is made of 5 trees (à la disk2d). The total number of trees if 5 times the number of segments.

This connectivity is meant to be used with p8est_geometry_new_torus

### Parameters
* `nSegments`:\\[in\\] number of trees along the great circle
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_torus (int nSegments);
```
"""
function p8est_connectivity_new_torus(nSegments)
    @ccall libp4est.p8est_connectivity_new_torus(nSegments::Cint)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_new_byname(name)

Create connectivity structure from predefined catalogue.

### Parameters
* `name`:\\[in\\] Invokes connectivity\\_new\\_* function. brick235 brick (2, 3, 5, 0, 0, 0) periodic periodic rotcubes rotcubes rotwrap rotwrap shell shell sphere sphere twocubes twocubes twowrap twowrap unit unitcube
### Returns
An initialized connectivity if name is defined, NULL else.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_new_byname (const char *name);
```
"""
function p8est_connectivity_new_byname(name)
    @ccall libp4est.p8est_connectivity_new_byname(name::Cstring)::Ptr{p8est_connectivity_t}
end

"""
    p8est_connectivity_refine(conn, num_per_edge)

Uniformly refine a connectivity. This is useful if you would like to uniformly refine by something other than a power of 2.

### Parameters
* `conn`:\\[in\\] A valid connectivity
* `num_per_edge`:\\[in\\] The number of new trees in each direction. Must use no more than P8EST_OLD_QMAXLEVEL bits.
### Returns
a refined connectivity.
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_refine (p8est_connectivity_t * conn, int num_per_edge);
```
"""
function p8est_connectivity_refine(conn, num_per_edge)
    @ccall libp4est.p8est_connectivity_refine(conn::Ptr{p8est_connectivity_t}, num_per_edge::Cint)::Ptr{p8est_connectivity_t}
end

"""
    p8est_expand_face_transform(iface, nface, ftransform)

Fill an array with the axis combination of a face neighbor transform.

### Parameters
* `iface`:\\[in\\] The number of the originating face.
* `nface`:\\[in\\] Encoded as nface = r * 6 + nf, where nf = 0..5 is the neigbbor's connecting face number and r = 0..3 is the relative orientation to the neighbor's face. This encoding matches [`p8est_connectivity_t`](@ref).
* `ftransform`:\\[out\\] This array holds 9 integers. [0]..[2] The coordinate axis sequence of the origin face, the first two referring to the tangentials and the third to the normal. A permutation of (0, 1, 2). [3]..[5] The coordinate axis sequence of the target face. [6]..[8] Edge reversal flags for tangential axes (boolean); face code in [0, 3] for the normal coordinate q: 0: q' = -q 1: q' = q + 1 2: q' = q - 1 3: q' = 2 - q
### Prototype
```c
void p8est_expand_face_transform (int iface, int nface, int ftransform[]);
```
"""
function p8est_expand_face_transform(iface, nface, ftransform)
    @ccall libp4est.p8est_expand_face_transform(iface::Cint, nface::Cint, ftransform::Ptr{Cint})::Cvoid
end

"""
    p8est_find_face_transform(connectivity, itree, iface, ftransform)

Fill an array with the axis combination of a face neighbor transform.

### Parameters
* `itree`:\\[in\\] The number of the originating tree.
* `iface`:\\[in\\] The number of the originating tree's face.
* `ftransform`:\\[out\\] This array holds 9 integers. [0]..[2] The coordinate axis sequence of the origin face. [3]..[5] The coordinate axis sequence of the target face. [6]..[8] Edge reverse flag for axes t1, t2; face code for n.
### Returns
The face neighbor tree if it exists, -1 otherwise.
### Prototype
```c
p4est_topidx_t p8est_find_face_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int iface, int ftransform[]);
```
"""
function p8est_find_face_transform(connectivity, itree, iface, ftransform)
    @ccall libp4est.p8est_find_face_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, iface::Cint, ftransform::Ptr{Cint})::p4est_topidx_t
end

"""
    p8est_find_edge_transform(connectivity, itree, iedge, ei)

Fills an array with information about edge neighbors.

### Parameters
* `itree`:\\[in\\] The number of the originating tree.
* `iedge`:\\[in\\] The number of the originating edge.
* `ei`:\\[in,out\\] A [`p8est_edge_info_t`](@ref) structure with initialized array.
### Prototype
```c
void p8est_find_edge_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int iedge, p8est_edge_info_t * ei);
```
"""
function p8est_find_edge_transform(connectivity, itree, iedge, ei)
    @ccall libp4est.p8est_find_edge_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, iedge::Cint, ei::Ptr{p8est_edge_info_t})::Cvoid
end

"""
    p8est_find_corner_transform(connectivity, itree, icorner, ci)

Fills an array with information about corner neighbors.

### Parameters
* `itree`:\\[in\\] The number of the originating tree.
* `icorner`:\\[in\\] The number of the originating corner.
* `ci`:\\[in,out\\] A [`p8est_corner_info_t`](@ref) structure with initialized array.
### Prototype
```c
void p8est_find_corner_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int icorner, p8est_corner_info_t * ci);
```
"""
function p8est_find_corner_transform(connectivity, itree, icorner, ci)
    @ccall libp4est.p8est_find_corner_transform(connectivity::Ptr{p8est_connectivity_t}, itree::p4est_topidx_t, icorner::Cint, ci::Ptr{p8est_corner_info_t})::Cvoid
end

"""
    p8est_connectivity_complete(conn)

Internally connect a connectivity based on tree\\_to\\_vertex information. Periodicity that is not inherent in the list of vertices will be lost.

### Parameters
* `conn`:\\[in,out\\] The connectivity needs to have proper vertices and tree\\_to\\_vertex fields. The tree\\_to\\_tree and tree\\_to\\_face fields must be allocated and satisfy [`p8est_connectivity_is_valid`](@ref) (conn) but will be overwritten. The edge and corner fields will be freed and allocated anew.
### Prototype
```c
void p8est_connectivity_complete (p8est_connectivity_t * conn);
```
"""
function p8est_connectivity_complete(conn)
    @ccall libp4est.p8est_connectivity_complete(conn::Ptr{p8est_connectivity_t})::Cvoid
end

"""
    p8est_connectivity_reduce(conn)

Removes corner and edge information of a connectivity such that enough information is left to run [`p8est_connectivity_complete`](@ref) successfully. The reduced connectivity still passes [`p8est_connectivity_is_valid`](@ref).

### Parameters
* `conn`:\\[in,out\\] The connectivity to be reduced.
### Prototype
```c
void p8est_connectivity_reduce (p8est_connectivity_t * conn);
```
"""
function p8est_connectivity_reduce(conn)
    @ccall libp4est.p8est_connectivity_reduce(conn::Ptr{p8est_connectivity_t})::Cvoid
end

"""
    p8est_connectivity_permute(conn, perm, is_current_to_new)

[`p8est_connectivity_permute`](@ref) Given a permutation *perm* of the trees in a connectivity *conn*, permute the trees of *conn* in place and update *conn* to match.

### Parameters
* `conn`:\\[in,out\\] The connectivity whose trees are permuted.
* `perm`:\\[in\\] A permutation array, whose elements are size\\_t's.
* `is_current_to_new`:\\[in\\] if true, the jth entry of perm is the new index for the entry whose current index is j, otherwise the jth entry of perm is the current index of the tree whose index will be j after the permutation.
### Prototype
```c
void p8est_connectivity_permute (p8est_connectivity_t * conn, sc_array_t * perm, int is_current_to_new);
```
"""
function p8est_connectivity_permute(conn, perm, is_current_to_new)
    @ccall libp4est.p8est_connectivity_permute(conn::Ptr{p8est_connectivity_t}, perm::Ptr{sc_array_t}, is_current_to_new::Cint)::Cvoid
end

"""
    p8est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)

[`p8est_connectivity_join_faces`](@ref) This function takes an existing valid connectivity *conn* and modifies it by joining two tree faces that are currently boundary faces.

### Parameters
* `conn`:\\[in,out\\] connectivity that will be altered.
* `tree_left`:\\[in\\] tree that will be on the left side of the joined faces.
* `tree_right`:\\[in\\] tree that will be on the right side of the joined faces.
* `face_left`:\\[in\\] face of *tree_left* that will be joined.
* `face_right`:\\[in\\] face of *tree_right* that will be joined.
* `orientation`:\\[in\\] the orientation of *face_left* and *face_right* once joined (see the description of [`p8est_connectivity_t`](@ref) to understand orientation).
### Prototype
```c
void p8est_connectivity_join_faces (p8est_connectivity_t * conn, p4est_topidx_t tree_left, p4est_topidx_t tree_right, int face_left, int face_right, int orientation);
```
"""
function p8est_connectivity_join_faces(conn, tree_left, tree_right, face_left, face_right, orientation)
    @ccall libp4est.p8est_connectivity_join_faces(conn::Ptr{p8est_connectivity_t}, tree_left::p4est_topidx_t, tree_right::p4est_topidx_t, face_left::Cint, face_right::Cint, orientation::Cint)::Cvoid
end

"""
    p8est_connectivity_is_equivalent(conn1, conn2)

[`p8est_connectivity_is_equivalent`](@ref) This function compares two connectivities for equivalence: it returns *true* if they are the same connectivity, or if they have the same topology. The definition of topological sameness is strict: there is no attempt made to determine whether permutation and/or rotation of the trees makes the connectivities equivalent.

### Parameters
* `conn1`:\\[in\\] a valid connectivity
* `conn2`:\\[out\\] a valid connectivity
### Prototype
```c
int p8est_connectivity_is_equivalent (p8est_connectivity_t * conn1, p8est_connectivity_t * conn2);
```
"""
function p8est_connectivity_is_equivalent(conn1, conn2)
    @ccall libp4est.p8est_connectivity_is_equivalent(conn1::Ptr{p8est_connectivity_t}, conn2::Ptr{p8est_connectivity_t})::Cint
end

"""
    p8est_edge_array_index(array, it)

### Prototype
```c
static inline p8est_edge_transform_t * p8est_edge_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_edge_array_index(array, it)
    @ccall libp4est.p8est_edge_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_edge_transform_t}
end

"""
    p8est_corner_array_index(array, it)

### Prototype
```c
static inline p8est_corner_transform_t * p8est_corner_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_corner_array_index(array, it)
    @ccall libp4est.p8est_corner_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_corner_transform_t}
end

"""
    p8est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)

Read an ABAQUS input file from a file stream.

This utility function reads a basic ABAQUS file supporting element type with the prefix C2D4, CPS4, and S4 in 2D and of type C3D8 reading them as bilinear quadrilateral and trilinear hexahedral trees respectively.

A basic 2D mesh is given below. The `*Node` section gives the vertex number and x, y, and z components for each vertex. The `*Element` section gives the 4 vertices in 2D (8 vertices in 3D) of each element in counter clockwise order. So in 2D the nodes are given as:

4 3 +-------------------+ | | | | | | | | | | | | +-------------------+ 1 2

and in 3D they are given as:

8 7 +---------------------+ |\\ |\\ | \\ | \\ | \\ | \\ | \\ | \\ | 5+---------------------+6 | | | | +----|----------------+ | 4\\ | 3 \\ | \\ | \\ | \\ | \\ | \\| \\| +---------------------+ 1 2

```c++
 *Heading
  box.inp
 *Node
     1,    5,   -5,    5
     2,    5,    5,    5
     3,    5,    0,    5
     4,   -5,    5,    5
     5,    0,    5,    5
     6,   -5,   -5,    5
     7,   -5,    0,    5
     8,    0,   -5,    5
     9,    0,    0,    5
    10,    5,    5,   -5
    11,    5,   -5,   -5
    12,    5,    0,   -5
    13,   -5,   -5,   -5
    14,    0,   -5,   -5
    15,   -5,    5,   -5
    16,   -5,    0,   -5
    17,    0,    5,   -5
    18,    0,    0,   -5
    19,   -5,   -5,    0
    20,    5,   -5,    0
    21,    0,   -5,    0
    22,   -5,    5,    0
    23,   -5,    0,    0
    24,    5,    5,    0
    25,    0,    5,    0
    26,    5,    0,    0
    27,    0,    0,    0
 *Element, type=C3D8, ELSET=EB1
     1,       6,      19,      23,       7,       8,      21,      27,       9
     2,      19,      13,      16,      23,      21,      14,      18,      27
     3,       7,      23,      22,       4,       9,      27,      25,       5
     4,      23,      16,      15,      22,      27,      18,      17,      25
     5,       8,      21,      27,       9,       1,      20,      26,       3
     6,      21,      14,      18,      27,      20,      11,      12,      26
     7,       9,      27,      25,       5,       3,      26,      24,       2
     8,      27,      18,      17,      25,      26,      12,      10,      24
```

This code can be called two ways. The first, when `vertex`==NULL and `tree_to_vertex`==NULL, is used to count the number of trees and vertices in the connectivity to be generated by the `.inp` mesh in the *stream*. The second, when `vertices`!=NULL and `tree_to_vertex`!=NULL, fill `vertices` and `tree_to_vertex`. In this case `num_vertices` and `num_trees` need to be set to the maximum number of entries allocated in `vertices` and `tree_to_vertex`.

### Parameters
* `stream`:\\[in,out\\] file stream to read the connectivity from
* `num_vertices`:\\[in,out\\] the number of vertices in the connectivity
* `num_trees`:\\[in,out\\] the number of trees in the connectivity
* `vertices`:\\[out\\] the list of `vertices` of the connectivity
* `tree_to_vertex`:\\[out\\] the `tree_to_vertex` map of the connectivity
### Returns
0 if successful and nonzero if not
### Prototype
```c
int p8est_connectivity_read_inp_stream (FILE * stream, p4est_topidx_t * num_vertices, p4est_topidx_t * num_trees, double *vertices, p4est_topidx_t * tree_to_vertex);
```
"""
function p8est_connectivity_read_inp_stream(stream, num_vertices, num_trees, vertices, tree_to_vertex)
    @ccall libp4est.p8est_connectivity_read_inp_stream(stream::Ptr{Libc.FILE}, num_vertices::Ptr{p4est_topidx_t}, num_trees::Ptr{p4est_topidx_t}, vertices::Ptr{Cdouble}, tree_to_vertex::Ptr{p4est_topidx_t})::Cint
end

"""
    p8est_connectivity_read_inp(filename)

Create a [`p4est`](@ref) connectivity from an ABAQUS input file.

This utility function reads a basic ABAQUS file supporting element type with the prefix C2D4, CPS4, and S4 in 2D and of type C3D8 reading them as bilinear quadrilateral and trilinear hexahedral trees respectively.

A basic 2D mesh is given below. The `*Node` section gives the vertex number and x, y, and z components for each vertex. The `*Element` section gives the 4 vertices in 2D (8 vertices in 3D) of each element in counter clockwise order. So in 2D the nodes are given as:

4 3 +-------------------+ | | | | | | | | | | | | +-------------------+ 1 2

and in 3D they are given as:

8 7 +---------------------+ |\\ |\\ | \\ | \\ | \\ | \\ | \\ | \\ | 5+---------------------+6 | | | | +----|----------------+ | 4\\ | 3 \\ | \\ | \\ | \\ | \\ | \\| \\| +---------------------+ 1 2

```c++
 *Heading
  box.inp
 *Node
     1,    5,   -5,    5
     2,    5,    5,    5
     3,    5,    0,    5
     4,   -5,    5,    5
     5,    0,    5,    5
     6,   -5,   -5,    5
     7,   -5,    0,    5
     8,    0,   -5,    5
     9,    0,    0,    5
    10,    5,    5,   -5
    11,    5,   -5,   -5
    12,    5,    0,   -5
    13,   -5,   -5,   -5
    14,    0,   -5,   -5
    15,   -5,    5,   -5
    16,   -5,    0,   -5
    17,    0,    5,   -5
    18,    0,    0,   -5
    19,   -5,   -5,    0
    20,    5,   -5,    0
    21,    0,   -5,    0
    22,   -5,    5,    0
    23,   -5,    0,    0
    24,    5,    5,    0
    25,    0,    5,    0
    26,    5,    0,    0
    27,    0,    0,    0
 *Element, type=C3D8, ELSET=EB1
     1,       6,      19,      23,       7,       8,      21,      27,       9
     2,      19,      13,      16,      23,      21,      14,      18,      27
     3,       7,      23,      22,       4,       9,      27,      25,       5
     4,      23,      16,      15,      22,      27,      18,      17,      25
     5,       8,      21,      27,       9,       1,      20,      26,       3
     6,      21,      14,      18,      27,      20,      11,      12,      26
     7,       9,      27,      25,       5,       3,      26,      24,       2
     8,      27,      18,      17,      25,      26,      12,      10,      24
```

This function reads a mesh from *filename* and returns an associated [`p4est`](@ref) connectivity.

### Parameters
* `filename`:\\[in\\] file to read the connectivity from
### Returns
an allocated connectivity associated with the mesh in *filename*
### Prototype
```c
p8est_connectivity_t *p8est_connectivity_read_inp (const char *filename);
```
"""
function p8est_connectivity_read_inp(filename)
    @ccall libp4est.p8est_connectivity_read_inp(filename::Cstring)::Ptr{p8est_connectivity_t}
end

"""
    p6est_connectivity

This structure holds the 2D+1D inter-tree connectivity information. It is essentially a wrapper of the 2D p4est\\_connecitivity\\_t datatype, with some additional information about how the third dimension is embedded.

| Field          | Note                                                                                                                                           |
| :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| conn4          | the 2D connecitvity; owned; vertices interpreted as the vertices of the bottom of the sheet                                                    |
| top\\_vertices | if NULL, uniform vertical profile, otherwise the vertices of the top of the sheet: should be the same size as *conn4*->tree_to_vertex; owned.  |
| height         | if *top_vertices* == NULL, this gives the offset from the bottom of the sheet to the top                                                       |
"""
struct p6est_connectivity
    conn4::Ptr{p4est_connectivity_t}
    top_vertices::Ptr{Cdouble}
    height::NTuple{3, Cdouble}
end

"""This structure holds the 2D+1D inter-tree connectivity information. It is essentially a wrapper of the 2D p4est\\_connecitivity\\_t datatype, with some additional information about how the third dimension is embedded."""
const p6est_connectivity_t = p6est_connectivity

"""
    p6est_connectivity_new(conn4, top_vertices, height)

Create a [`p6est_connectivity_t`](@ref) from a [`p4est_connectivity_t`](@ref). All fields are copied, so all inputs can be safey destroyed.

### Parameters
* `conn4`:\\[in\\] the 2D connectivity
* `top_vertices`:\\[in\\] if NULL, then the sheet has a uniform vertical profile; otherwise, *top_vertices* gives teh vertices of the top of the sheet; should be the same size as *conn4*->tree_to_vertex
* `height`:\\[in\\] if *top_vertices* == NULL, then this gives the offset fro the bottom of the sheet to the top.
### Returns
the 2D+1D connectivity information.
### Prototype
```c
p6est_connectivity_t *p6est_connectivity_new (p4est_connectivity_t * conn4, double *top_vertices, double height[3]);
```
"""
function p6est_connectivity_new(conn4, top_vertices, height)
    @ccall libp4est.p6est_connectivity_new(conn4::Ptr{p4est_connectivity_t}, top_vertices::Ptr{Cdouble}, height::Ptr{Cdouble})::Ptr{p6est_connectivity_t}
end

"""
    p6est_connectivity_destroy(conn)

Destroy a [`p6est_connectivity`](@ref) structure

### Prototype
```c
void p6est_connectivity_destroy (p6est_connectivity_t * conn);
```
"""
function p6est_connectivity_destroy(conn)
    @ccall libp4est.p6est_connectivity_destroy(conn::Ptr{p6est_connectivity_t})::Cvoid
end

"""
    p6est_tree_get_vertices(conn, which_tree, vertices)

Get the vertices of the corners of a tree.

### Parameters
* `conn`:\\[in\\] the 2D+1D connectivity structure
* `which_tree`:\\[in\\] a tree in the forest
* `vertices`:\\[out\\] the coordinates of the corners of the tree
### Prototype
```c
void p6est_tree_get_vertices (p6est_connectivity_t * conn, p4est_topidx_t which_tree, double vertices[24]);
```
"""
function p6est_tree_get_vertices(conn, which_tree, vertices)
    @ccall libp4est.p6est_tree_get_vertices(conn::Ptr{p6est_connectivity_t}, which_tree::p4est_topidx_t, vertices::Ptr{Cdouble})::Cvoid
end

"""
    p6est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)

Transform a quadrant coordinate into the space spanned by tree vertices.

### Parameters
* `connectivity`:\\[in\\] Connectivity must provide the vertices.
* `treeid`:\\[in\\] Identify the tree that contains x, y.
* `x,`:\\[in\\] y Quadrant coordinates relative to treeid.
* `vxy`:\\[out\\] Transformed coordinates in vertex space.
### Prototype
```c
void p6est_qcoord_to_vertex (p6est_connectivity_t * connectivity, p4est_topidx_t treeid, p4est_qcoord_t x, p4est_qcoord_t y, p4est_qcoord_t z, double vxyz[3]);
```
"""
function p6est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)
    @ccall libp4est.p6est_qcoord_to_vertex(connectivity::Ptr{p6est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, z::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

"""
    p6est

| Field                  | Note                                                                                                       |
| :--------------------- | :--------------------------------------------------------------------------------------------------------- |
| mpisize                | number of MPI processes                                                                                    |
| mpirank                | this process's MPI rank                                                                                    |
| mpicomm\\_owned        | whether this communicator is owned by the forest                                                           |
| data\\_size            | size of per-quadrant p.user\\_data (see [`p2est_quadrant_t`](@ref)::p2est\\_quadrant\\_data::user\\_data)  |
| user\\_pointer         | convenience pointer for users, never touched by [`p4est`](@ref)                                            |
| connectivity           | topology of sheet, not owned.                                                                              |
| columns                | 2D description of column layout built from *connectivity*                                                  |
| layers                 | single array that stores [`p2est_quadrant_t`](@ref) layers within columns                                  |
| user\\_data\\_pool     | memory allocator for user data                                                                             |
| layer\\_pool           | memory allocator for temporary layers                                                                      |
| global\\_first\\_layer | first global quadrant index for each process and 1 beyond                                                  |
| root\\_len             | height of the domain                                                                                       |
"""
struct p6est
    mpicomm::MPI_Comm
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
end

"""The [`p6est`](@ref) forest datatype"""
const p6est_t = p6est

# typedef void ( * p6est_init_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
"""
Callback function prototype to initialize the layers's user data.

### Parameters
* `p6est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree in the forest
* `column`:\\[in\\] the column in the tree in the forest
* `layer`:\\[in\\] the layer in the column in the tree in the forest, whose *user_data* is to be initialized
"""
const p6est_init_t = Ptr{Cvoid}

# typedef void ( * p6est_replace_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , int num_outcolumns , int num_outlayers , p4est_quadrant_t * outcolumns [ ] , p2est_quadrant_t * outlayers [ ] , int num_incolumns , int num_inlayers , p4est_quadrant_t * incolumns [ ] , p2est_quadrant_t * inlayers [ ] )
"""
Callback function prototype to transfer information from outgoing layers to incoming layers.

This is used by extended routines when the layers of an existing, valid [`p6est`](@ref) are changed. The callback allows the user to make changes to newly initialized layers before the layers that they replace are destroyed.

### Parameters
* `num_outcolumns`:\\[in\\] The number of columns that contain the outgoing layers: will be either 1 or 4.
* `num_outlayers`:\\[in\\] The number of outgoing layers: will be either 1 (a single layer is being refined), 2 (two layers are being vertically coarsened), or 4 (four layers are being horizontally coarsened).
* `outcolumns`:\\[in\\] The columns of the outgoing layers
* `outlayers`:\\[in\\] The outgoing layers: after the callback, the user\\_data, if [`p6est`](@ref)->data_size is nonzero, will be destroyed.
* `num_incolumns`:\\[in\\] The number of columns that contain the outgoing layers: will be either 1 or 4.
* `num_inlayers`:\\[in\\] The number of incoming layers: will be either 1 (coarsening), 2 (vertical refinement), or 4 (horizontal refinement)
* `incolumns`:\\[in\\] The columns of the incoming layers
* `inlayers`:\\[in,out\\] The incoming layers: prior to the callback, the user\\_data, if [`p6est`](@ref)->data_size is nonzero, is allocated, and the [`p6est_init_t`](@ref) callback, if it has been provided, will be called.
"""
const p6est_replace_t = Ptr{Cvoid}

# typedef int ( * p6est_refine_column_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column )
"""
Callback function prototype to decide whether to horizontally refine a column, i.e., horizontally refine all of the layers in the column.

### Returns
nonzero if the layer shall be refined.
"""
const p6est_refine_column_t = Ptr{Cvoid}

# typedef int ( * p6est_refine_layer_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
"""
Callback function prototype to decide whether to vertically refine a layer.

### Returns
nonzero if the layer shall be refined.
"""
const p6est_refine_layer_t = Ptr{Cvoid}

# typedef int ( * p6est_coarsen_column_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * columns [ ] )
"""
Callback function prototype to decide for horizontal coarsening.

### Parameters
* `columns`:\\[in\\] Pointers to 4 sibling columns.
### Returns
nonzero if the columns shall be replaced with their parent.
"""
const p6est_coarsen_column_t = Ptr{Cvoid}

# typedef int ( * p6est_coarsen_layer_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layers [ ] )
"""
Callback function prototype to decide for vertical coarsening.

### Parameters
* `layers`:\\[in\\] Pointers to 2 vertical sibling layers.
### Returns
nonzero if the layers shall be replaced with their parent.
"""
const p6est_coarsen_layer_t = Ptr{Cvoid}

# typedef int ( * p6est_weight_t ) ( p6est_t * p6est , p4est_topidx_t which_tree , p4est_quadrant_t * column , p2est_quadrant_t * layer )
"""
Callback function prototype to calculate weights for partitioning.

!!! note

    Global sum of weights must fit into a 64bit integer.

### Returns
a 32bit integer >= 0 as the quadrant weight.
"""
const p6est_weight_t = Ptr{Cvoid}

"""
    p6est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)

### Prototype
```c
p6est_t *p6est_new (sc_MPI_Comm mpicomm, p6est_connectivity_t * connectivity, size_t data_size, p6est_init_t init_fn, void *user_pointer);
```
"""
function p6est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new(mpicomm::MPI_Comm, connectivity::Ptr{p6est_connectivity_t}, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

"""
    p6est_new_from_p4est(p4est_, top_vertices, height, min_zlevel, data_size, init_fn, user_pointer)

Create a new forest from an already created [`p4est`](@ref) that represents columns.

### Parameters
* `p4est`:\\[in\\] A valid [`p4est`](@ref). A deep copy will be created, so this can be destroyed without affectin the new [`p6est`](@ref) object.
* `top_vertices`:\\[in\\] the same as in p6est\\_conectivity\\_new()
* `height`:\\[in\\] the same as in p6est\\_conectivity\\_new()
* `min_zlevel`:\\[in\\] the same as in [`p6est_new`](@ref)()
* `data_size`:\\[in\\] the same as in [`p6est_new`](@ref)()
* `init_fn`:\\[in\\] the same as in [`p6est_new`](@ref)()
* `user_pointer`:\\[in\\] the same as in [`p6est_new`](@ref)()
### Returns
This returns a valid forest. The user must destroy the connectivity for the new [`p6est`](@ref) independently.
### Prototype
```c
p6est_t *p6est_new_from_p4est (p4est_t * p4est, double *top_vertices, double height[3], int min_zlevel, size_t data_size, p6est_init_t init_fn, void *user_pointer);
```
"""
function p6est_new_from_p4est(p4est_, top_vertices, height, min_zlevel, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new_from_p4est(p4est_::Ptr{p4est_t}, top_vertices::Ptr{Cdouble}, height::Ptr{Cdouble}, min_zlevel::Cint, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

"""
    p6est_destroy(p6est_)

Destroy a [`p6est`](@ref).

!!! note

    The connectivity structure is not destroyed with the [`p6est`](@ref).

### Prototype
```c
void p6est_destroy (p6est_t * p6est);
```
"""
function p6est_destroy(p6est_)
    @ccall libp4est.p6est_destroy(p6est_::Ptr{p6est_t})::Cvoid
end

"""
    p6est_copy(input, copy_data)

Make a deep copy of a [`p6est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
### Returns
Returns a valid [`p6est`](@ref) that does not depend on the input.
### Prototype
```c
p6est_t *p6est_copy (p6est_t * input, int copy_data);
```
"""
function p6est_copy(input, copy_data)
    @ccall libp4est.p6est_copy(input::Ptr{p6est_t}, copy_data::Cint)::Ptr{p6est_t}
end

"""
    p6est_reset_data(p6est_, data_size, init_fn, user_pointer)

Reset user pointer and element data. When the data size is changed the quadrant data is freed and allocated. The initialization callback is invoked on each quadrant. Old user\\_data content is disregarded.

### Parameters
* `data_size`:\\[in\\] This is the size of data for each quadrant which can be zero. Then user\\_data\\_pool is set to NULL.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `user_pointer`:\\[in\\] Assign to the user\\_pointer member of the [`p6est`](@ref) before init\\_fn is called the first time.
### Prototype
```c
void p6est_reset_data (p6est_t * p6est, size_t data_size, p6est_init_t init_fn, void *user_pointer);
```
"""
function p6est_reset_data(p6est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_reset_data(p6est_::Ptr{p6est_t}, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

"""
    p6est_refine_columns(p6est_, refine_recursive, refine_fn, init_fn)

Refine the columns of a sheet.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `refine_fn`:\\[in\\] Callback function that must return true if a column shall be refined into smaller columns. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created column. Otherwise, it is called for every existing column. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn gets called, or use [`p6est_refine_columns_ext`](@ref) in p6est\\_extended.h and examine whether replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data of newly created layers within columns, which are already allocated. This function pointer may be NULL.
### Prototype
```c
void p6est_refine_columns (p6est_t * p6est, int refine_recursive, p6est_refine_column_t refine_fn, p6est_init_t init_fn);
```
"""
function p6est_refine_columns(p6est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p6est_refine_columns(p6est_::Ptr{p6est_t}, refine_recursive::Cint, refine_fn::p6est_refine_column_t, init_fn::p6est_init_t)::Cvoid
end

"""
    p6est_refine_layers(p6est_, refine_recursive, refine_fn, init_fn)

Refine the layers within the columns of a sheet.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `refine_fn`:\\[in\\] Callback function that must return true if a layer shall be refined into smaller layers. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created layer. Otherwise, it is called for every existing layer. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn gets called, or use [`p6est_refine_layers_ext`](@ref) in p6est\\_extended.h and examine whether replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data of newly created layers, which are already allocated. This function pointer may be NULL.
### Prototype
```c
void p6est_refine_layers (p6est_t * p6est, int refine_recursive, p6est_refine_layer_t refine_fn, p6est_init_t init_fn);
```
"""
function p6est_refine_layers(p6est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p6est_refine_layers(p6est_::Ptr{p6est_t}, refine_recursive::Cint, refine_fn::p6est_refine_layer_t, init_fn::p6est_init_t)::Cvoid
end

"""
    p6est_coarsen_columns(p6est_, coarsen_recursive, coarsen_fn, init_fn)

Coarsen the columns of a sheet.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of columns shall be coarsened
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p6est_coarsen_columns (p6est_t * p6est, int coarsen_recursive, p6est_coarsen_column_t coarsen_fn, p6est_init_t init_fn);
```
"""
function p6est_coarsen_columns(p6est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p6est_coarsen_columns(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, coarsen_fn::p6est_coarsen_column_t, init_fn::p6est_init_t)::Cvoid
end

"""
    p6est_coarsen_layers(p6est_, coarsen_recursive, coarsen_fn, init_fn)

Coarsen the layers of a sheet.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of layers shall be coarsened
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p6est_coarsen_layers (p6est_t * p6est, int coarsen_recursive, p6est_coarsen_layer_t coarsen_fn, p6est_init_t init_fn);
```
"""
function p6est_coarsen_layers(p6est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p6est_coarsen_layers(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, coarsen_fn::p6est_coarsen_layer_t, init_fn::p6est_init_t)::Cvoid
end

"""
    p6est_balance(p6est_, btype, init_fn)

Balance a forest.

### Parameters
* `p6est`:\\[in\\] The [`p6est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face, corner or default, full).
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p6est_balance (p6est_t * p6est, p8est_connect_type_t btype, p6est_init_t init_fn);
```
"""
function p6est_balance(p6est_, btype, init_fn)
    @ccall libp4est.p6est_balance(p6est_::Ptr{p6est_t}, btype::p8est_connect_type_t, init_fn::p6est_init_t)::Cvoid
end

@cenum p6est_comm_tag_t::UInt32 begin
    P6EST_COMM_PARTITION = 1
    P6EST_COMM_GHOST = 2
    P6EST_COMM_BALANCE = 3
end

"""
    p6est_partition(p6est_, weight_fn)

Equally partition the forest.

The forest will be partitioned between processors where they each have an approximately equal number of quadrants.

Note that [`p6est`](@ref)->layers and [`p6est`](@ref)->global_first_layers may change during this call. Address pointers referencing these objects from before [`p6est_partition`](@ref) is called become invalid.

### Parameters
* `p6est`:\\[in,out\\] The forest that will be partitioned.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning.
### Prototype
```c
p4est_gloidx_t p6est_partition (p6est_t * p6est, p6est_weight_t weight_fn);
```
"""
function p6est_partition(p6est_, weight_fn)
    @ccall libp4est.p6est_partition(p6est_::Ptr{p6est_t}, weight_fn::p6est_weight_t)::p4est_gloidx_t
end

"""
    p6est_partition_correct(p6est_, num_layers_in_proc)

### Prototype
```c
void p6est_partition_correct (p6est_t * p6est, p4est_locidx_t * num_layers_in_proc);
```
"""
function p6est_partition_correct(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_correct(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

"""
    p6est_partition_to_p4est_partition(p6est_, num_layers_in_proc, num_columns_in_proc)

### Prototype
```c
void p6est_partition_to_p4est_partition (p6est_t * p6est, p4est_locidx_t * num_layers_in_proc, p4est_locidx_t * num_columns_in_proc);
```
"""
function p6est_partition_to_p4est_partition(p6est_, num_layers_in_proc, num_columns_in_proc)
    @ccall libp4est.p6est_partition_to_p4est_partition(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t}, num_columns_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

"""
    p4est_partition_to_p6est_partition(p6est_, num_columns_in_proc, num_layers_in_proc)

### Prototype
```c
void p4est_partition_to_p6est_partition (p6est_t * p6est, p4est_locidx_t * num_columns_in_proc, p4est_locidx_t * num_layers_in_proc);
```
"""
function p4est_partition_to_p6est_partition(p6est_, num_columns_in_proc, num_layers_in_proc)
    @ccall libp4est.p4est_partition_to_p6est_partition(p6est_::Ptr{p6est_t}, num_columns_in_proc::Ptr{p4est_locidx_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::Cvoid
end

"""
    p6est_partition_for_coarsening(p6est_, num_layers_in_proc)

### Prototype
```c
p4est_gloidx_t p6est_partition_for_coarsening (p6est_t * p6est, p4est_locidx_t * num_layers_in_proc);
```
"""
function p6est_partition_for_coarsening(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_for_coarsening(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

"""
    p6est_partition_given(p6est_, num_layers_in_proc)

### Prototype
```c
p4est_gloidx_t p6est_partition_given (p6est_t * p6est, p4est_locidx_t * num_layers_in_proc);
```
"""
function p6est_partition_given(p6est_, num_layers_in_proc)
    @ccall libp4est.p6est_partition_given(p6est_::Ptr{p6est_t}, num_layers_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

"""
    p6est_checksum(p6est_)

Compute the checksum for a forest. Based on quadrant arrays only. It is independent of partition and mpisize.

### Returns
Returns the checksum on processor 0 only. 0 on other processors.
### Prototype
```c
unsigned p6est_checksum (p6est_t * p6est);
```
"""
function p6est_checksum(p6est_)
    @ccall libp4est.p6est_checksum(p6est_::Ptr{p6est_t})::Cuint
end

"""
    p6est_save(filename, p6est_, save_data)

Save the complete connectivity/[`p6est`](@ref) data to disk. This is a collective

operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations.

!!! note

    Aborts on file errors.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p6est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
### Prototype
```c
void p6est_save (const char *filename, p6est_t * p6est, int save_data);
```
"""
function p6est_save(filename, p6est_, save_data)
    @ccall libp4est.p6est_save(filename::Cstring, p6est_::Ptr{p6est_t}, save_data::Cint)::Cvoid
end

"""
    p6est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)

### Prototype
```c
p6est_t *p6est_load (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, void *user_pointer, p6est_connectivity_t ** connectivity);
```
"""
function p6est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p6est_load(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p6est_connectivity_t}})::Ptr{p6est_t}
end

"""
    p2est_quadrant_array_index(array, it)

### Prototype
```c
static inline p2est_quadrant_t * p2est_quadrant_array_index (sc_array_t * array, size_t it);
```
"""
function p2est_quadrant_array_index(array, it)
    @ccall libp4est.p2est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p2est_quadrant_t}
end

"""
    p2est_quadrant_array_push(array)

### Prototype
```c
static inline p2est_quadrant_t * p2est_quadrant_array_push (sc_array_t * array);
```
"""
function p2est_quadrant_array_push(array)
    @ccall libp4est.p2est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p2est_quadrant_t}
end

"""
    p2est_quadrant_mempool_alloc(mempool)

### Prototype
```c
static inline p2est_quadrant_t * p2est_quadrant_mempool_alloc (sc_mempool_t * mempool);
```
"""
function p2est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p2est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p2est_quadrant_t}
end

"""
    p2est_quadrant_list_pop(list)

### Prototype
```c
static inline p2est_quadrant_t * p2est_quadrant_list_pop (sc_list_t * list);
```
"""
function p2est_quadrant_list_pop(list)
    @ccall libp4est.p2est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p2est_quadrant_t}
end

"""
    p6est_layer_init_data(p6est_, which_tree, column, layer, init_fn)

### Prototype
```c
static inline void p6est_layer_init_data (p6est_t * p6est, p4est_topidx_t which_tree, p4est_quadrant_t * column, p2est_quadrant_t * layer, p6est_init_t init_fn);
```
"""
function p6est_layer_init_data(p6est_, which_tree, column, layer, init_fn)
    @ccall libp4est.p6est_layer_init_data(p6est_::Ptr{p6est_t}, which_tree::p4est_topidx_t, column::Ptr{p4est_quadrant_t}, layer::Ptr{p2est_quadrant_t}, init_fn::p6est_init_t)::Cvoid
end

"""
    p6est_layer_free_data(p6est_, layer)

### Prototype
```c
static inline void p6est_layer_free_data (p6est_t * p6est, p2est_quadrant_t * layer);
```
"""
function p6est_layer_free_data(p6est_, layer)
    @ccall libp4est.p6est_layer_free_data(p6est_::Ptr{p6est_t}, layer::Ptr{p2est_quadrant_t})::Cvoid
end

"""
    p6est_compress_columns(p6est_)

### Prototype
```c
void p6est_compress_columns (p6est_t * p6est);
```
"""
function p6est_compress_columns(p6est_)
    @ccall libp4est.p6est_compress_columns(p6est_::Ptr{p6est_t})::Cvoid
end

"""
    p6est_update_offsets(p6est_)

### Prototype
```c
void p6est_update_offsets (p6est_t * p6est);
```
"""
function p6est_update_offsets(p6est_)
    @ccall libp4est.p6est_update_offsets(p6est_::Ptr{p6est_t})::Cvoid
end

"""
    p6est_new_ext(mpicomm, connectivity, min_quadrants, min_level, min_zlevel, num_zroot, fill_uniform, data_size, init_fn, user_pointer)

### Prototype
```c
p6est_t *p6est_new_ext (sc_MPI_Comm mpicomm, p6est_connectivity_t * connectivity, p4est_locidx_t min_quadrants, int min_level, int min_zlevel, int num_zroot, int fill_uniform, size_t data_size, p6est_init_t init_fn, void *user_pointer);
```
"""
function p6est_new_ext(mpicomm, connectivity, min_quadrants, min_level, min_zlevel, num_zroot, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p6est_new_ext(mpicomm::MPI_Comm, connectivity::Ptr{p6est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, min_zlevel::Cint, num_zroot::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p6est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p6est_t}
end

"""
    p6est_copy_ext(input, copy_data, duplicate_mpicomm)

Make a deep copy of a [`p6est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless. The inspect member of the copy is set to NULL.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
* `duplicate_mpicomm`:\\[in\\] If true, MPI communicator is copied.
### Returns
Returns a valid [`p6est`](@ref) that does not depend on the input.
### Prototype
```c
p6est_t *p6est_copy_ext (p6est_t * input, int copy_data, int duplicate_mpicomm);
```
"""
function p6est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p6est_copy_ext(input::Ptr{p6est_t}, copy_data::Cint, duplicate_mpicomm::MPI_Comm)::Ptr{p6est_t}
end

"""
    p6est_save_ext(filename, p6est_, save_data, save_partition)

Save the complete connectivity/[`p6est`](@ref) data to disk.

This is a collective operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations. See [`p6est_load_ext`](@ref)() for information on the autopartition parameter.

!!! note

    Aborts on file errors.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p6est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
* `save_partition`:\\[in\\] If false, save file as if 1 core was used. If true, save core count and partition. Advantage: Partition can be recovered on loading with same mpisize and autopartition false. Disadvantage: Makes the file depend on mpisize. Either way the file can be loaded with autopartition true.
### Prototype
```c
void p6est_save_ext (const char *filename, p6est_t * p6est, int save_data, int save_partition);
```
"""
function p6est_save_ext(filename, p6est_, save_data, save_partition)
    @ccall libp4est.p6est_save_ext(filename::Cstring, p6est_::Ptr{p6est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

"""
    p6est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)

### Prototype
```c
p6est_t *p6est_load_ext (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, int autopartition, int broadcasthead, void *user_pointer, p6est_connectivity_t ** connectivity);
```
"""
function p6est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p6est_load_ext(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p6est_connectivity_t}})::Ptr{p6est_t}
end

"""
    p6est_refine_columns_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)

Horizontally refine a forest with a bounded refinement level and a replace option.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `maxlevel`:\\[in\\] Maximum allowed refinement level (inclusive). If this is negative the level is restricted only by the compile-time constant QMAXLEVEL in [`p4est`](@ref).h.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn or replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data for newly created quadrants, which is guaranteed to be allocated. This function pointer may be NULL.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace; may be NULL.
### Prototype
```c
void p6est_refine_columns_ext (p6est_t * p6est, int refine_recursive, int maxlevel, p6est_refine_column_t refine_fn, p6est_init_t init_fn, p6est_replace_t replace_fn);
```
"""
function p6est_refine_columns_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_refine_columns_ext(p6est_::Ptr{p6est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p6est_refine_column_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

"""
    p6est_refine_layers_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)

Vertically refine a forest with a bounded refinement level and a replace option.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `maxlevel`:\\[in\\] Maximum allowed refinement level (inclusive). If this is negative the level is restricted only by the compile-time constant QMAXLEVEL in [`p4est`](@ref).h.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn or replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data for newly created quadrants, which is guaranteed to be allocated. This function pointer may be NULL.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace; may be NULL.
### Prototype
```c
void p6est_refine_layers_ext (p6est_t * p6est, int refine_recursive, int maxlevel, p6est_refine_layer_t refine_fn, p6est_init_t init_fn, p6est_replace_t replace_fn);
```
"""
function p6est_refine_layers_ext(p6est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_refine_layers_ext(p6est_::Ptr{p6est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p6est_refine_layer_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

"""
    p6est_coarsen_columns_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)

Horizontally coarsen a forest.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `callback_orphans`:\\[in\\] Boolean to enable calling coarsen\\_fn even on non-families. In this case, the second quadrant pointer in the argument list of the callback is NULL, subsequent pointers are undefined, and the return value is ignored. If coarsen\\_recursive is true, it is possible that a quadrant is called once or more as an orphan and eventually becomes part of a family.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p6est_coarsen_columns_ext (p6est_t * p6est, int coarsen_recursive, int callback_orphans, p6est_coarsen_column_t coarsen_fn, p6est_init_t init_fn, p6est_replace_t replace_fn);
```
"""
function p6est_coarsen_columns_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_coarsen_columns_ext(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p6est_coarsen_column_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

"""
    p6est_coarsen_layers_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)

Vertically coarsen a forest.

### Parameters
* `p6est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `callback_orphans`:\\[in\\] Boolean to enable calling coarsen\\_fn even on non-families. In this case, the second quadrant pointer in the argument list of the callback is NULL, subsequent pointers are undefined, and the return value is ignored. If coarsen\\_recursive is true, it is possible that a quadrant is called once or more as an orphan and eventually becomes part of a family.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p6est_coarsen_layers_ext (p6est_t * p6est, int coarsen_recursive, int callback_orphans, p6est_coarsen_layer_t coarsen_fn, p6est_init_t init_fn, p6est_replace_t replace_fn);
```
"""
function p6est_coarsen_layers_ext(p6est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p6est_coarsen_layers_ext(p6est_::Ptr{p6est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p6est_coarsen_layer_t, init_fn::p6est_init_t, replace_fn::p6est_replace_t)::Cvoid
end

"""
    p6est_partition_ext(p6est_, partition_for_coarsening, weight_fn)

Repartition the forest.

The forest is partitioned between processors such that each processor has an approximately equal number of quadrants (or weight).

### Parameters
* `p6est`:\\[in,out\\] The forest that will be partitioned.
* `partition_for_coarsening`:\\[in\\] If true, the partition is modified to allow one level of coarsening.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning.
### Returns
The global number of shipped quadrants
### Prototype
```c
p4est_gloidx_t p6est_partition_ext (p6est_t * p6est, int partition_for_coarsening, p6est_weight_t weight_fn);
```
"""
function p6est_partition_ext(p6est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p6est_partition_ext(p6est_::Ptr{p6est_t}, partition_for_coarsening::Cint, weight_fn::p6est_weight_t)::p4est_gloidx_t
end

"""
    p6est_balance_ext(p6est_, btype, max_diff, min_diff, init_fn, replace_fn)

2:1 balance the size differences of neighboring elements in a forest.

### Parameters
* `p6est`:\\[in,out\\] The [`p6est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face or corner/full). Corner balance is almost never required when discretizing a PDE; just causes smoother mesh grading.
* `max_diff`:\\[in\\] The maximum difference between the horizontal refinement level and the vertical refinement level
* `min_diff`:\\[in\\] The minimum difference between the horizontal refinement level and the vertical refinement level
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p6est_balance_ext (p6est_t * p6est, p8est_connect_type_t btype, int max_diff, int min_diff, p6est_init_t init_fn, p6est_replace_t replace_fn);
```
"""
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
    f === :piggy1 && return Ptr{__JL_Ctag_320}(x + 0)
    f === :piggy2 && return Ptr{__JL_Ctag_321}(x + 0)
    f === :piggy3 && return Ptr{__JL_Ctag_322}(x + 0)
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

"""
    p8est_quadrant

The 3D quadrant (i.e., octant) datatype

| Field | Note                                               |
| :---- | :------------------------------------------------- |
| x     | coordinates                                        |
| y     |                                                    |
| z     |                                                    |
| level | level of refinement                                |
| pad8  | padding                                            |
| pad16 |                                                    |
| p     | a union of additional data attached to a quadrant  |
"""
struct p8est_quadrant
    data::NTuple{24, UInt8}
end

function Base.getproperty(x::Ptr{p8est_quadrant}, f::Symbol)
    f === :x && return Ptr{p4est_qcoord_t}(x + 0)
    f === :y && return Ptr{p4est_qcoord_t}(x + 4)
    f === :z && return Ptr{p4est_qcoord_t}(x + 8)
    f === :level && return Ptr{Int8}(x + 12)
    f === :pad8 && return Ptr{Int8}(x + 13)
    f === :pad16 && return Ptr{Int16}(x + 14)
    f === :p && return Ptr{p8est_quadrant_data}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_quadrant, f::Symbol)
    r = Ref{p8est_quadrant}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_quadrant}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_quadrant}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""The 3D quadrant (i.e., octant) datatype"""
const p8est_quadrant_t = p8est_quadrant

"""
    p8est_tree

The [`p8est`](@ref) tree datatype

| Field              | Note                                                               |
| :----------------- | :----------------------------------------------------------------- |
| quadrants          | locally stored quadrants                                           |
| first\\_desc       | first local descendant                                             |
| last\\_desc        | last local descendant                                              |
| quadrants\\_offset | cumulative sum over earlier trees on this processor (locals only)  |
| maxlevel           | highest local quadrant level                                       |
"""
struct p8est_tree
    quadrants::sc_array_t
    first_desc::p8est_quadrant_t
    last_desc::p8est_quadrant_t
    quadrants_offset::p4est_locidx_t
    quadrants_per_level::NTuple{31, p4est_locidx_t}
    maxlevel::Int8
end

"""The [`p8est`](@ref) tree datatype"""
const p8est_tree_t = p8est_tree

"""
    p8est_inspect

| Field                           | Note                                                                                                                                        |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------ |
| use\\_balance\\_ranges          | Use sc\\_ranges to determine the asymmetric communication pattern. If *use_balance_ranges* is false (the default), sc\\_notify is used.     |
| use\\_balance\\_ranges\\_notify | If true, call both sc\\_ranges and sc\\_notify and verify consistency. Which is actually used is still determined by *use_balance_ranges*.  |
| use\\_balance\\_verify          | Verify sc\\_ranges and/or sc\\_notify as applicable.                                                                                        |
| balance\\_max\\_ranges          | If positive and smaller than p8est\\_num ranges, overrides it                                                                               |
| balance\\_ranges                | time spent in sc\\_ranges                                                                                                                   |
| balance\\_notify                | time spent in sc\\_notify                                                                                                                   |
| balance\\_notify\\_allgather    | time spent in sc\\_notify\\_allgather                                                                                                       |
"""
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

"""Data pertaining to selecting, inspecting, and profiling algorithms. A pointer to this structure is hooked into the [`p8est`](@ref) main structure. Declared in p8est\\_extended.h. Used to profile important algorithms."""
const p8est_inspect_t = p8est_inspect

"""
    p8est

| Field                     | Note                                                                                                             |
| :------------------------ | :--------------------------------------------------------------------------------------------------------------- |
| mpisize                   | number of MPI processes                                                                                          |
| mpirank                   | this process's MPI rank                                                                                          |
| mpicomm\\_owned           | flag if communicator is owned                                                                                    |
| data\\_size               | size of per-quadrant p.user\\_data (see [`p8est_quadrant_t`](@ref)::[`p8est_quadrant_data`](@ref)::user\\_data)  |
| user\\_pointer            | convenience pointer for users, never touched by [`p4est`](@ref)                                                  |
| revision                  | Gets bumped on mesh change                                                                                       |
| first\\_local\\_tree      | 0-based index of first local tree, must be -1 for an empty processor                                             |
| last\\_local\\_tree       | 0-based index of last local tree, must be -2 for an empty processor                                              |
| local\\_num\\_quadrants   | number of quadrants on all trees on this processor                                                               |
| global\\_num\\_quadrants  | number of quadrants on all trees on all processors                                                               |
| global\\_first\\_quadrant | first global quadrant index for each process and 1 beyond                                                        |
| global\\_first\\_position | first smallest possible quad for each process and 1 beyond                                                       |
| connectivity              | connectivity structure, not owned                                                                                |
| trees                     | array of all trees                                                                                               |
| user\\_data\\_pool        | memory allocator for user data                                                                                   |
| quadrant\\_pool           | memory allocator for temporary quadrants                                                                         |
| inspect                   | algorithmic switches                                                                                             |
"""
struct p8est
    mpicomm::MPI_Comm
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

"""The [`p8est`](@ref) forest datatype"""
const p8est_t = p8est

"""
    p8est_memory_used(p8est_)

Calculate local memory usage of a forest structure. Not collective. The memory used on the current rank is returned. The connectivity structure is not counted since it is not owned; use p8est\\_connectivity\\_memory\\_usage ([`p8est`](@ref)->connectivity).

### Parameters
* `p8est`:\\[in\\] Valid forest structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p8est_memory_used (p8est_t * p8est);
```
"""
function p8est_memory_used(p8est_)
    @ccall libp4est.p8est_memory_used(p8est_::Ptr{p8est_t})::Csize_t
end

"""
    p8est_revision(p8est_)

Return the revision counter of the forest. Not collective, even though the revision value is the same on all ranks. A newly created forest starts with a revision counter of zero. Every refine, coarsen, partition, and balance that actually changes the mesh increases the counter by one. Operations with no effect keep the old value.

### Parameters
* `p8est`:\\[in\\] The forest must be valid.
### Returns
Non-negative number.
### Prototype
```c
long p8est_revision (p8est_t * p8est);
```
"""
function p8est_revision(p8est_)
    @ccall libp4est.p8est_revision(p8est_::Ptr{p8est_t})::Clong
end

# typedef void ( * p8est_init_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
"""
Callback function prototype to initialize the quadrant's user data.

### Parameters
* `p8est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrant`:\\[in,out\\] the quadrant to be initialized: if data\\_size > 0, the data to be initialized is at *quadrant*->p.user_data; otherwise, the non-pointer user data (such as *quadrant*->p.user_int) can be initialized
"""
const p8est_init_t = Ptr{Cvoid}

# typedef int ( * p8est_refine_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
"""
Callback function prototype to decide for refinement.

### Parameters
* `p8est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrant`:\\[in\\] the quadrant that may be refined
### Returns
nonzero if the quadrant shall be refined.
"""
const p8est_refine_t = Ptr{Cvoid}

# typedef int ( * p8est_coarsen_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrants [ ] )
"""
Callback function prototype to decide for coarsening.

### Parameters
* `p8est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
* `quadrants`:\\[in\\] Pointers to 8 siblings in Morton ordering.
### Returns
nonzero if the quadrants shall be replaced with their parent.
"""
const p8est_coarsen_t = Ptr{Cvoid}

# typedef int ( * p8est_weight_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant )
"""
Callback function prototype to calculate weights for partitioning.

!!! note

    Global sum of weights must fit into a 64bit integer.

### Parameters
* `p8est`:\\[in\\] the forest
* `which_tree`:\\[in\\] the tree containing *quadrant*
### Returns
a 32bit integer >= 0 as the quadrant weight.
"""
const p8est_weight_t = Ptr{Cvoid}

"""
    p8est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)

Transform a quadrant coordinate into the space spanned by tree vertices.

### Parameters
* `connectivity`:\\[in\\] Connectivity must provide the vertices.
* `treeid`:\\[in\\] Identify the tree that contains x, y, z.
* `x,`:\\[in\\] y, z Quadrant coordinates relative to treeid.
* `vxyz`:\\[out\\] Transformed coordinates in vertex space.
### Prototype
```c
void p8est_qcoord_to_vertex (p8est_connectivity_t * connectivity, p4est_topidx_t treeid, p4est_qcoord_t x, p4est_qcoord_t y, p4est_qcoord_t z, double vxyz[3]);
```
"""
function p8est_qcoord_to_vertex(connectivity, treeid, x, y, z, vxyz)
    @ccall libp4est.p8est_qcoord_to_vertex(connectivity::Ptr{p8est_connectivity_t}, treeid::p4est_topidx_t, x::p4est_qcoord_t, y::p4est_qcoord_t, z::p4est_qcoord_t, vxyz::Ptr{Cdouble})::Cvoid
end

"""
    p8est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)

### Prototype
```c
p8est_t *p8est_new (sc_MPI_Comm mpicomm, p8est_connectivity_t * connectivity, size_t data_size, p8est_init_t init_fn, void *user_pointer);
```
"""
function p8est_new(mpicomm, connectivity, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_new(mpicomm::MPI_Comm, connectivity::Ptr{p8est_connectivity_t}, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p8est_t}
end

"""
    p8est_destroy(p8est_)

Destroy a [`p8est`](@ref).

!!! note

    The connectivity structure is not destroyed with the [`p8est`](@ref).

### Prototype
```c
void p8est_destroy (p8est_t * p8est);
```
"""
function p8est_destroy(p8est_)
    @ccall libp4est.p8est_destroy(p8est_::Ptr{p8est_t})::Cvoid
end

"""
    p8est_copy(input, copy_data)

Make a deep copy of a [`p8est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless. The inspect member of the copy is set to NULL. The revision counter of the copy is set to zero.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
### Returns
Returns a valid [`p8est`](@ref) that does not depend on the input, except for borrowing the same connectivity. Its revision counter is 0.
### Prototype
```c
p8est_t *p8est_copy (p8est_t * input, int copy_data);
```
"""
function p8est_copy(input, copy_data)
    @ccall libp4est.p8est_copy(input::Ptr{p8est_t}, copy_data::Cint)::Ptr{p8est_t}
end

"""
    p8est_reset_data(p8est_, data_size, init_fn, user_pointer)

Reset user pointer and element data. When the data size is changed the quadrant data is freed and allocated. The initialization callback is invoked on each quadrant. Old user\\_data content is disregarded.

### Parameters
* `data_size`:\\[in\\] This is the size of data for each quadrant which can be zero. Then user\\_data\\_pool is set to NULL.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically. May be NULL.
* `user_pointer`:\\[in\\] Assign to the user\\_pointer member of the [`p8est`](@ref) before init\\_fn is called the first time.
### Prototype
```c
void p8est_reset_data (p8est_t * p8est, size_t data_size, p8est_init_t init_fn, void *user_pointer);
```
"""
function p8est_reset_data(p8est_, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_reset_data(p8est_::Ptr{p8est_t}, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Cvoid
end

"""
    p8est_refine(p8est_, refine_recursive, refine_fn, init_fn)

Refine a forest.

### Parameters
* `p8est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn gets called, or use [`p8est_refine_ext`](@ref) in p8est\\_extended.h and examine whether replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data of newly created quadrants, which is already allocated. This function pointer may be NULL.
### Prototype
```c
void p8est_refine (p8est_t * p8est, int refine_recursive, p8est_refine_t refine_fn, p8est_init_t init_fn);
```
"""
function p8est_refine(p8est_, refine_recursive, refine_fn, init_fn)
    @ccall libp4est.p8est_refine(p8est_::Ptr{p8est_t}, refine_recursive::Cint, refine_fn::p8est_refine_t, init_fn::p8est_init_t)::Cvoid
end

"""
    p8est_coarsen(p8est_, coarsen_recursive, coarsen_fn, init_fn)

Coarsen a forest.

### Parameters
* `p8est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p8est_coarsen (p8est_t * p8est, int coarsen_recursive, p8est_coarsen_t coarsen_fn, p8est_init_t init_fn);
```
"""
function p8est_coarsen(p8est_, coarsen_recursive, coarsen_fn, init_fn)
    @ccall libp4est.p8est_coarsen(p8est_::Ptr{p8est_t}, coarsen_recursive::Cint, coarsen_fn::p8est_coarsen_t, init_fn::p8est_init_t)::Cvoid
end

"""
    p8est_balance(p8est_, btype, init_fn)

2:1 balance the size differences of neighboring elements in a forest.

### Parameters
* `p8est`:\\[in,out\\] The [`p8est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face, edge, or corner/full). Examples: Finite volume or discontinuous Galerkin methods only require face balance. Continuous finite element methods usually require edge balance. Corner balance is almost never required mathematically; it just produces a smoother mesh grading.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
### Prototype
```c
void p8est_balance (p8est_t * p8est, p8est_connect_type_t btype, p8est_init_t init_fn);
```
"""
function p8est_balance(p8est_, btype, init_fn)
    @ccall libp4est.p8est_balance(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, init_fn::p8est_init_t)::Cvoid
end

"""
    p8est_partition(p8est_, allow_for_coarsening, weight_fn)

Equally partition the forest. The partition can be by element count or by a user-defined weight.

The forest will be partitioned between processors such that they have an approximately equal number of quadrants (or sum of weights).

On one process, the function noops and does not call the weight callback. Otherwise, the weight callback is called once per quadrant in order.

### Parameters
* `p8est`:\\[in,out\\] The forest that will be partitioned.
* `allow_for_coarsening`:\\[in\\] Slightly modify partition such that quadrant families are not split between ranks.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning. When running with mpisize == 1, never called. Otherwise, called in order for all quadrants if not NULL. A weighting function with constant weight 1 on each quadrant is equivalent to weight\\_fn == NULL but other constant weightings may result in different uniform partitionings.
### Prototype
```c
void p8est_partition (p8est_t * p8est, int allow_for_coarsening, p8est_weight_t weight_fn);
```
"""
function p8est_partition(p8est_, allow_for_coarsening, weight_fn)
    @ccall libp4est.p8est_partition(p8est_::Ptr{p8est_t}, allow_for_coarsening::Cint, weight_fn::p8est_weight_t)::Cvoid
end

"""
    p8est_checksum(p8est_)

Compute the checksum for a forest. Based on quadrant arrays only. It is independent of partition and mpisize.

### Returns
Returns the checksum on processor 0 only. 0 on other processors.
### Prototype
```c
unsigned p8est_checksum (p8est_t * p8est);
```
"""
function p8est_checksum(p8est_)
    @ccall libp4est.p8est_checksum(p8est_::Ptr{p8est_t})::Cuint
end

"""
    p8est_checksum_partition(p8est_)

Compute a partition-dependent checksum for a forest.

### Returns
Returns the checksum on processor 0 only. 0 on other processors.
### Prototype
```c
unsigned p8est_checksum_partition (p8est_t * p8est);
```
"""
function p8est_checksum_partition(p8est_)
    @ccall libp4est.p8est_checksum_partition(p8est_::Ptr{p8est_t})::Cuint
end

"""
    p8est_save(filename, p8est_, save_data)

Save the complete connectivity/[`p8est`](@ref) data to disk.

This is a collective operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations.

By default, we write the current processor count and partition into the file header. This makes the file depend on mpisize. For changing this see [`p8est_save_ext`](@ref)() in p8est\\_extended.h.

The revision counter is not saved to the file, since that would make files different that come from different revisions but store the same mesh.

!!! note

    Aborts on file errors.

!!! note

    If [`p4est`](@ref) is not configured to use MPI-IO, some processes return from this function before the file is complete, in which case immediate read-access to the file may require a call to [`sc_MPI_Barrier`](@ref).

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p8est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
### Prototype
```c
void p8est_save (const char *filename, p8est_t * p8est, int save_data);
```
"""
function p8est_save(filename, p8est_, save_data)
    @ccall libp4est.p8est_save(filename::Cstring, p8est_::Ptr{p8est_t}, save_data::Cint)::Cvoid
end

"""
    p8est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)

### Prototype
```c
p8est_t *p8est_load (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, void *user_pointer, p8est_connectivity_t ** connectivity);
```
"""
function p8est_load(filename, mpicomm, data_size, load_data, user_pointer, connectivity)
    @ccall libp4est.p8est_load(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

"""
    p8est_tree_array_index(array, it)

### Prototype
```c
static inline p8est_tree_t * p8est_tree_array_index (sc_array_t * array, p4est_topidx_t it);
```
"""
function p8est_tree_array_index(array, it)
    @ccall libp4est.p8est_tree_array_index(array::Ptr{sc_array_t}, it::p4est_topidx_t)::Ptr{p8est_tree_t}
end

"""
    p8est_quadrant_array_index(array, it)

### Prototype
```c
static inline p8est_quadrant_t * p8est_quadrant_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_quadrant_array_index(array, it)
    @ccall libp4est.p8est_quadrant_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_quadrant_t}
end

"""
    p8est_quadrant_array_push(array)

### Prototype
```c
static inline p8est_quadrant_t * p8est_quadrant_array_push (sc_array_t * array);
```
"""
function p8est_quadrant_array_push(array)
    @ccall libp4est.p8est_quadrant_array_push(array::Ptr{sc_array_t})::Ptr{p8est_quadrant_t}
end

"""
    p8est_quadrant_mempool_alloc(mempool)

### Prototype
```c
static inline p8est_quadrant_t * p8est_quadrant_mempool_alloc (sc_mempool_t * mempool);
```
"""
function p8est_quadrant_mempool_alloc(mempool)
    @ccall libp4est.p8est_quadrant_mempool_alloc(mempool::Ptr{sc_mempool_t})::Ptr{p8est_quadrant_t}
end

"""
    p8est_quadrant_list_pop(list)

### Prototype
```c
static inline p8est_quadrant_t * p8est_quadrant_list_pop (sc_list_t * list);
```
"""
function p8est_quadrant_list_pop(list)
    @ccall libp4est.p8est_quadrant_list_pop(list::Ptr{sc_list_t})::Ptr{p8est_quadrant_t}
end

"""
    p8est_ghost_t

quadrants that neighbor the local domain

| Field                           | Note                                                                                                                           |
| :------------------------------ | :----------------------------------------------------------------------------------------------------------------------------- |
| btype                           | which neighbors are in the ghost layer                                                                                         |
| ghosts                          | array of [`p8est_quadrant_t`](@ref) type                                                                                       |
| tree\\_offsets                  | num\\_trees + 1 ghost indices                                                                                                  |
| proc\\_offsets                  | mpisize + 1 ghost indices                                                                                                      |
| mirrors                         | array of [`p8est_quadrant_t`](@ref) type                                                                                       |
| mirror\\_tree\\_offsets         | num\\_trees + 1 mirror indices                                                                                                 |
| mirror\\_proc\\_mirrors         | indices into mirrors grouped by outside processor rank and ascending within each rank                                          |
| mirror\\_proc\\_offsets         | mpisize + 1 indices into  mirror\\_proc\\_mirrors                                                                              |
| mirror\\_proc\\_fronts          | like mirror\\_proc\\_mirrors, but limited to the outermost octants. This is NULL until [`p8est_ghost_expand`](@ref) is called  |
| mirror\\_proc\\_front\\_offsets | NULL until [`p8est_ghost_expand`](@ref) is called                                                                              |
"""
struct p8est_ghost_t
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
end

"""
    p8est_ghost_is_valid(p8est_, ghost)

Examine if a ghost structure is valid as desribed above. Test if within a ghost-structure the arrays ghosts and mirrors are in p8est\\_quadrant\\_compare\\_piggy order. Test if local\\_num in piggy3 data member of the quadrants in ghosts and mirrors are in ascending order (ascending within each rank for ghost).

Test if the [`p4est_locidx_t`](@ref) arrays are in ascending order (for mirror\\_proc\\_mirrors ascending within each rank)

### Parameters
* `p8est`:\\[in\\] the forest.
* `ghost`:\\[in\\] Ghost layer structure.
### Returns
true if *ghost* is valid
### Prototype
```c
int p8est_ghost_is_valid (p8est_t * p8est, p8est_ghost_t * ghost);
```
"""
function p8est_ghost_is_valid(p8est_, ghost)
    @ccall libp4est.p8est_ghost_is_valid(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cint
end

"""
    p8est_ghost_memory_used(ghost)

Calculate the memory usage of the ghost layer.

### Parameters
* `ghost`:\\[in\\] Ghost layer structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p8est_ghost_memory_used (p8est_ghost_t * ghost);
```
"""
function p8est_ghost_memory_used(ghost)
    @ccall libp4est.p8est_ghost_memory_used(ghost::Ptr{p8est_ghost_t})::Csize_t
end

"""
    p8est_quadrant_find_owner(p8est_, treeid, face, q)

Gets the processor id of a quadrant's owner. The quadrant can lie outside of a tree across faces (and only faces).

!!! warning

    Does not work for tree edge or corner neighbors.

### Parameters
* `p8est`:\\[in\\] The forest in which to search for a quadrant.
* `treeid`:\\[in\\] The tree to which the quadrant belongs.
* `face`:\\[in\\] Supply a face direction if known, or -1 otherwise.
* `q`:\\[in\\] The quadrant that is being searched for.
### Returns
Processor id of the owner or -1 if the quadrant lies outside of the mesh.
### Prototype
```c
int p8est_quadrant_find_owner (p8est_t * p8est, p4est_topidx_t treeid, int face, const p8est_quadrant_t * q);
```
"""
function p8est_quadrant_find_owner(p8est_, treeid, face, q)
    @ccall libp4est.p8est_quadrant_find_owner(p8est_::Ptr{p8est_t}, treeid::p4est_topidx_t, face::Cint, q::Ptr{p8est_quadrant_t})::Cint
end

"""
    p8est_ghost_new(p8est_, btype)

Builds the ghost layer.

This will gather the quadrants from each neighboring proc to build one layer of face, edge and corner based ghost elements around the ones they own.

### Parameters
* `p8est`:\\[in\\] The forest for which the ghost layer will be generated.
* `btype`:\\[in\\] Which ghosts to include (across face, edge, or corner/full).
### Returns
A fully initialized ghost layer.
### Prototype
```c
p8est_ghost_t *p8est_ghost_new (p8est_t * p8est, p8est_connect_type_t btype);
```
"""
function p8est_ghost_new(p8est_, btype)
    @ccall libp4est.p8est_ghost_new(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t)::Ptr{p8est_ghost_t}
end

"""
    p8est_ghost_destroy(ghost)

Frees all memory used for the ghost layer.

### Prototype
```c
void p8est_ghost_destroy (p8est_ghost_t * ghost);
```
"""
function p8est_ghost_destroy(ghost)
    @ccall libp4est.p8est_ghost_destroy(ghost::Ptr{p8est_ghost_t})::Cvoid
end

"""
    p8est_ghost_bsearch(ghost, which_proc, which_tree, q)

Conduct binary search for exact match on a range of the ghost layer.

### Parameters
* `ghost`:\\[in\\] The ghost layer.
* `which_proc`:\\[in\\] The owner of the searched quadrant. Can be -1.
* `which_tree`:\\[in\\] The tree of the searched quadrant. Can be -1.
* `q`:\\[in\\] Valid quadrant is searched in the ghost layer.
### Returns
Offset in the ghost layer, or -1 if not found.
### Prototype
```c
ssize_t p8est_ghost_bsearch (p8est_ghost_t * ghost, int which_proc, p4est_topidx_t which_tree, const p8est_quadrant_t * q);
```
"""
function p8est_ghost_bsearch(ghost, which_proc, which_tree, q)
    @ccall libp4est.p8est_ghost_bsearch(ghost::Ptr{p8est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p8est_quadrant_t})::Cssize_t
end

"""
    p8est_ghost_tree_contains(ghost, which_proc, which_tree, q)

Conduct binary search for ancestor on range of the ghost layer.

### Parameters
* `ghost`:\\[in\\] The ghost layer.
* `which_proc`:\\[in\\] The owner of the searched quadrant. Can be -1.
* `which_tree`:\\[in\\] The tree of the searched quadrant. Can be -1.
* `q`:\\[in\\] Valid quadrant's ancestor is searched.
### Returns
Offset in the ghost layer, or -1 if not found.
### Prototype
```c
ssize_t p8est_ghost_tree_contains (p8est_ghost_t * ghost, int which_proc, p4est_topidx_t which_tree, const p8est_quadrant_t * q);
```
"""
function p8est_ghost_tree_contains(ghost, which_proc, which_tree, q)
    @ccall libp4est.p8est_ghost_tree_contains(ghost::Ptr{p8est_ghost_t}, which_proc::Cint, which_tree::p4est_topidx_t, q::Ptr{p8est_quadrant_t})::Cssize_t
end

"""
    p8est_face_quadrant_exists(p8est_, ghost, treeid, q, face, hang, owner_rank)

Checks if quadrant exists in the local forest or the ghost layer.

For quadrants across tree boundaries it checks if the quadrant exists across any face, but not across edges or corners.

### Parameters
* `p8est`:\\[in\\] The forest in which to search for *q*.
* `ghost`:\\[in\\] The ghost layer in which to search for *q*.
* `treeid`:\\[in\\] The tree to which *q* belongs.
* `q`:\\[in\\] The quadrant that is being searched for.
* `face`:\\[in,out\\] On input, face id across which *q* was created. On output, the neighbor's face number augmented by orientation, so face is in 0..23.
* `hang`:\\[in,out\\] If not NULL, signals that q is bigger than the quadrant it came from. The child id of that originating quadrant is passed into hang. On output, hang holds the hanging face number of *q* that is in contact with its originator.
* `owner_rank`:\\[out\\] Filled with the rank of the owner if it is found and undefined otherwise.
### Returns
Returns the local number of *q* if the quadrant exists in the local forest or in the ghost\\_layer. Otherwise, returns -2 for a domain boundary and -1 if not found.
### Prototype
```c
p4est_locidx_t p8est_face_quadrant_exists (p8est_t * p8est, p8est_ghost_t * ghost, p4est_topidx_t treeid, const p8est_quadrant_t * q, int *face, int *hang, int *owner_rank);
```
"""
function p8est_face_quadrant_exists(p8est_, ghost, treeid, q, face, hang, owner_rank)
    @ccall libp4est.p8est_face_quadrant_exists(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p8est_quadrant_t}, face::Ptr{Cint}, hang::Ptr{Cint}, owner_rank::Ptr{Cint})::p4est_locidx_t
end

"""
    p8est_quadrant_exists(p8est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)

Checks if quadrant exists in the local forest or the ghost layer.

For quadrants across tree corners it checks if the quadrant exists in any of the corner neighbors, thus it can execute multiple queries.

### Parameters
* `p8est`:\\[in\\] The forest in which to search for *q*
* `ghost`:\\[in\\] The ghost layer in which to search for *q*
* `treeid`:\\[in\\] The tree to which *q* belongs (can be extended).
* `q`:\\[in\\] The quadrant that is being searched for.
* `exists_arr`:\\[in,out\\] Must exist and be of of elem\\_size = sizeof (int) for inter-tree corner cases. Is resized by this function to one entry for each corner search and set to true/false depending on its existence in the local forest or ghost\\_layer.
* `rproc_arr`:\\[in,out\\] If not NULL is filled with one rank per query.
* `rquad_arr`:\\[in,out\\] If not NULL is filled with one quadrant per query. Its piggy3 member is defined as well.
### Returns
true if the quadrant exists in the local forest or in the ghost\\_layer, and false if doesn't exist in either.
### Prototype
```c
int p8est_quadrant_exists (p8est_t * p8est, p8est_ghost_t * ghost, p4est_topidx_t treeid, const p8est_quadrant_t * q, sc_array_t * exists_arr, sc_array_t * rproc_arr, sc_array_t * rquad_arr);
```
"""
function p8est_quadrant_exists(p8est_, ghost, treeid, q, exists_arr, rproc_arr, rquad_arr)
    @ccall libp4est.p8est_quadrant_exists(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, treeid::p4est_topidx_t, q::Ptr{p8est_quadrant_t}, exists_arr::Ptr{sc_array_t}, rproc_arr::Ptr{sc_array_t}, rquad_arr::Ptr{sc_array_t})::Cint
end

"""
    p8est_is_balanced(p8est_, btype)

Check a forest to see if it is balanced.

This function builds the ghost layer and discards it when done.

### Parameters
* `p8est`:\\[in\\] The [`p8est`](@ref) to be tested.
* `btype`:\\[in\\] Balance type (face, edge, corner or default, full).
### Returns
Returns true if balanced, false otherwise.
### Prototype
```c
int p8est_is_balanced (p8est_t * p8est, p8est_connect_type_t btype);
```
"""
function p8est_is_balanced(p8est_, btype)
    @ccall libp4est.p8est_is_balanced(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t)::Cint
end

"""
    p8est_ghost_checksum(p8est_, ghost)

Compute the parallel checksum of a ghost layer.

### Parameters
* `p8est`:\\[in\\] The MPI information of this [`p8est`](@ref) will be used.
* `ghost`:\\[in\\] A ghost layer obtained from the [`p8est`](@ref).
### Returns
Parallel checksum on rank 0, 0 otherwise.
### Prototype
```c
unsigned p8est_ghost_checksum (p8est_t * p8est, p8est_ghost_t * ghost);
```
"""
function p8est_ghost_checksum(p8est_, ghost)
    @ccall libp4est.p8est_ghost_checksum(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cuint
end

"""
    p8est_ghost_exchange_data(p8est_, ghost, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. Send the data stored in the quadrant's user\\_data. This is either the pointer variable itself if [`p8est`](@ref)->data_size is 0, or the content of the referenced memory field if [`p8est`](@ref)->data\\_size is positive.

### Parameters
* `p8est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghost quadrants in sequence. If [`p8est`](@ref)->data\\_size is 0, must at least hold sizeof (void *) bytes for each, otherwise [`p8est`](@ref)->data\\_size each.
### Prototype
```c
void p8est_ghost_exchange_data (p8est_t * p8est, p8est_ghost_t * ghost, void *ghost_data);
```
"""
function p8est_ghost_exchange_data(p8est_, ghost, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_data(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p8est_ghost_exchange

Transient storage for asynchronous ghost exchange.

| Field       | Note                                           |
| :---------- | :--------------------------------------------- |
| is\\_custom | False for [`p8est_ghost_exchange_data`](@ref)  |
| is\\_levels | Are we restricted to levels or not             |
| minlevel    | Meaningful with is\\_levels                    |
| maxlevel    |                                                |
"""
struct p8est_ghost_exchange
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
end

"""Transient storage for asynchronous ghost exchange."""
const p8est_ghost_exchange_t = p8est_ghost_exchange

"""
    p8est_ghost_exchange_data_begin(p8est_, ghost, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p8est_ghost_exchange_data`](@ref). The return type is always non-NULL and must be passed to [`p8est_ghost_exchange_data_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion.

### Parameters
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p8est_ghost_exchange_t *p8est_ghost_exchange_data_begin (p8est_t * p8est, p8est_ghost_t * ghost, void *ghost_data);
```
"""
function p8est_ghost_exchange_data_begin(p8est_, ghost, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_data_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

"""
    p8est_ghost_exchange_data_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `exc`:\\[in,out\\] Created ONLY by [`p8est_ghost_exchange_data_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p8est_ghost_exchange_data_end (p8est_ghost_exchange_t * exc);
```
"""
function p8est_ghost_exchange_data_end(exc)
    @ccall libp4est.p8est_ghost_exchange_data_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

"""
    p8est_ghost_exchange_custom(p8est_, ghost, data_size, mirror_data, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. The data size is the same for all quadrants and can be chosen arbitrarily.

### Parameters
* `p8est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `data_size`:\\[in\\] The data size to transfer per quadrant.
* `mirror_data`:\\[in\\] One data pointer per mirror quadrant.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghosts in sequence, which must hold at least `data_size` for each ghost.
### Prototype
```c
void p8est_ghost_exchange_custom (p8est_t * p8est, p8est_ghost_t * ghost, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p8est_ghost_exchange_custom(p8est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p8est_ghost_exchange_custom_begin(p8est_, ghost, data_size, mirror_data, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p8est_ghost_exchange_custom`](@ref). The return type is always non-NULL and must be passed to [`p8est_ghost_exchange_custom_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion. The mirror data can be safely discarded right after this function returns since it is copied into internal send buffers.

### Parameters
* `mirror_data`:\\[in\\] Not required to stay alive any longer.
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p8est_ghost_exchange_t *p8est_ghost_exchange_custom_begin (p8est_t * p8est, p8est_ghost_t * ghost, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p8est_ghost_exchange_custom_begin(p8est_, ghost, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

"""
    p8est_ghost_exchange_custom_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `Data`:\\[in,out\\] created ONLY by [`p8est_ghost_exchange_custom_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p8est_ghost_exchange_custom_end (p8est_ghost_exchange_t * exc);
```
"""
function p8est_ghost_exchange_custom_end(exc)
    @ccall libp4est.p8est_ghost_exchange_custom_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

"""
    p8est_ghost_exchange_custom_levels(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)

Transfer data for local quadrants that are ghosts to other processors. The data size is the same for all quadrants and can be chosen arbitrarily. This function restricts the transfer to a range of refinement levels. The memory for quadrants outside the level range is not dereferenced.

### Parameters
* `p8est`:\\[in\\] The forest used for reference.
* `ghost`:\\[in\\] The ghost layer used for reference.
* `minlevel`:\\[in\\] Level of the largest quads to be exchanged. Use <= 0 for no restriction.
* `maxlevel`:\\[in\\] Level of the smallest quads to be exchanged. Use >= [`P8EST_QMAXLEVEL`](@ref) for no restriction.
* `data_size`:\\[in\\] The data size to transfer per quadrant.
* `mirror_data`:\\[in\\] One data pointer per mirror quadrant as input.
* `ghost_data`:\\[in,out\\] Pre-allocated contiguous data for all ghosts in sequence, which must hold at least `data_size` for each ghost.
### Prototype
```c
void p8est_ghost_exchange_custom_levels (p8est_t * p8est, p8est_ghost_t * ghost, int minlevel, int maxlevel, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p8est_ghost_exchange_custom_levels(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_levels(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Cvoid
end

"""
    p8est_ghost_exchange_custom_levels_begin(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)

Begin an asynchronous ghost data exchange by posting messages. The arguments are identical to [`p8est_ghost_exchange_custom_levels`](@ref). The return type is always non-NULL and must be passed to [`p8est_ghost_exchange_custom_levels_end`](@ref) to complete the exchange. The ghost data must not be accessed before completion. The mirror data can be safely discarded right after this function returns since it is copied into internal send buffers.

### Parameters
* `mirror_data`:\\[in\\] Not required to stay alive any longer.
* `ghost_data`:\\[in,out\\] Must stay alive into the completion call.
### Returns
Transient storage for messages in progress.
### Prototype
```c
p8est_ghost_exchange_t *p8est_ghost_exchange_custom_levels_begin (p8est_t * p8est, p8est_ghost_t * ghost, int minlevel, int maxlevel, size_t data_size, void **mirror_data, void *ghost_data);
```
"""
function p8est_ghost_exchange_custom_levels_begin(p8est_, ghost, minlevel, maxlevel, data_size, mirror_data, ghost_data)
    @ccall libp4est.p8est_ghost_exchange_custom_levels_begin(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, minlevel::Cint, maxlevel::Cint, data_size::Csize_t, mirror_data::Ptr{Ptr{Cvoid}}, ghost_data::Ptr{Cvoid})::Ptr{p8est_ghost_exchange_t}
end

"""
    p8est_ghost_exchange_custom_levels_end(exc)

Complete an asynchronous ghost data exchange. This function waits for all pending MPI communications.

### Parameters
* `exc`:\\[in,out\\] created ONLY by [`p8est_ghost_exchange_custom_levels_begin`](@ref). It is deallocated before this function returns.
### Prototype
```c
void p8est_ghost_exchange_custom_levels_end (p8est_ghost_exchange_t * exc);
```
"""
function p8est_ghost_exchange_custom_levels_end(exc)
    @ccall libp4est.p8est_ghost_exchange_custom_levels_end(exc::Ptr{p8est_ghost_exchange_t})::Cvoid
end

"""
    p8est_ghost_expand(p8est_, ghost)

Expand the size of the ghost layer and mirrors by one additional layer of adjacency.

### Parameters
* `p8est`:\\[in\\] The forest from which the ghost layer was generated.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p8est_ghost_expand (p8est_t * p8est, p8est_ghost_t * ghost);
```
"""
function p8est_ghost_expand(p8est_, ghost)
    @ccall libp4est.p8est_ghost_expand(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

"""
    p8est_mesh_t

This structure contains complete mesh information on a 2:1 balanced forest. It stores the locally relevant neighborhood, that is, all locally owned quadrants and one layer of adjacent ghost quadrants and their owners.

For each local quadrant, its tree number is stored in quad\\_to\\_tree. The quad\\_to\\_tree array is NULL by default and can be enabled using p8est_mesh_new_ext. For each ghost quadrant, its owner rank is stored in ghost\\_to\\_proc. For each level, an array of local quadrant numbers is stored in quad\\_level. The quad\\_level array is NULL by default and can be enabled using p8est_mesh_new_ext.

The quad\\_to\\_quad list stores one value for each local quadrant's face. This value is in 0..local\\_num\\_quadrants-1 for local quadrants, or in local\\_num\\_quadrants + (0..ghost\\_num\\_quadrants-1) for ghost quadrants.

The quad\\_to\\_face list has equally many entries that are either: 1. A value of v = 0..23 indicates one same-size neighbor. This value is decoded as v = r * 6 + nf, where nf = 0..5 is the neighbor's connecting face number and r = 0..3 is the relative orientation of the neighbor's face; see [`p8est_connectivity`](@ref).h. 2. A value of v = 24..119 indicates a double-size neighbor. This value is decoded as v = 24 + h * 24 + r * 6 + nf, where r and nf are as above and h = 0..3 is the number of the subface. h designates the subface of the large neighbor that the quadrant touches (this is the same as the large neighbor's face corner). 3. A value of v = -24..-1 indicates four half-size neighbors. In this case the corresponding quad\\_to\\_quad index points into the quad\\_to\\_half array that stores four quadrant numbers per index, and the orientation of the smaller faces follows from 24 + v. The entries of quad\\_to\\_half encode between local and ghost quadrant in the same way as the quad\\_to\\_quad values described above. The small neighbors in quad\\_to\\_half are stored in the sequence of the face corners of this, i.e., the large quadrant.

A quadrant on the boundary of the forest sees itself and its face number.

The quad\\_to\\_edge list stores edge neighbors that are not face neighbors. On the inside of a tree, there are one or two of those depending on size. Between trees, there can be any number of same- or different-sized neighbors. For same-tree same-size neighbors, we record their number in quad\\_to\\_edge by the same convention as described for quad\\_to\\_quad above. In this case, the neighbor's matching edge number is always diagonally opposite, that is, edge number ^ 3.

For half- and double-size and all inter-tree edge neighbors, the quad\\_to\\_edge value is in local\\_num\\_quadrants + local\\_num\\_ghosts + [0 .. local\\_num\\_edges - 1]. After subtracting the number of local and ghost quadrants, it indexes into edge\\_offset, which encodes a group of edge neighbors. Each member of a group may be one same/double-size quadrant or two half-size quadrants; this is determined by the value of the edge\\_edge field as follows. 1. A value of e = 0..23 indicates one same-size neighbor. This value is encoded as e = r * 12 + ne, where ne = 0..11 is the neighbor's connecting edge number and r = 0..1 indicates an edge flip. 2. A value of e = 24..71 indicates a double-size neighbor. This value is decoded as e = 24 + h * 24 + r * 12 + ne, where r and ne are as above and h = 0..1 is the number of the subedge. h designates the subedge of the large neighbor that the quadrant touches (this is the same as the large neighbor's edge corner). 3. A value of e = -24..-1 indicates two half-size neighbors. They are represented by two consecutive entries of the edge\\_quad and edge\\_edge arrays with identical values for edge\\_edge. The orientation of the smaller edges follows from 24 + e. The small neighbors in edge\\_quad are stored in the sequence of the edge corners of this, i.e., the large quadrant.

Edges with no diagonal neighbor at all are assigned the value -3. This only happens on the domain boundary, which is necessarily a tree boundary. Edge neighbors for face-hanging nodes are assigned the value -1.

The quad\\_to\\_corner list stores corner neighbors that are not face or edge neighbors. On the inside of a tree, there is precisely one such neighbor per corner. In this case, its index is encoded as described above for quad\\_to\\_quad. The neighbor's matching corner number is always diagonally opposite, that is, corner number ^ 7.

On the inside of an inter-tree face, we have precisely one corner neighbor. If a corner is across an inter-tree edge or corner, then the number of corner neighbors may be any non-negative number. In all three cases, the quad\\_to\\_corner value is in local\\_num\\_quadrants + local\\_num\\_ghosts + [0 .. local\\_num\\_corners - 1]. After subtracting the number of local and ghost quadrants, it indexes into corner\\_offset, which encodes a group of corner neighbors. Each group contains the quadrant numbers encoded as usual for quad\\_to\\_quad in corner\\_quad, and the corner number from the neighbor as corner\\_corner.

Corners with no diagonal neighbor at all are assigned the value -3. This only happens on the domain boundary, which is necessarily a tree boundary. Corner-neighbors for face- and edge-hanging nodes are assigned the value -1.

TODO: In case of an inter-tree neighbor relation in a brick-like situation (one same-size neighbor, diagonally opposite edge/corner), use the same encoding as for edges/corners within a tree.

| Field               | Note                                                                                                                                                                                                           |
| :------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| quad\\_to\\_tree    | tree index for each local quad. Is NULL by default, but may be enabled by p8est_mesh_new_ext.                                                                                                                  |
| ghost\\_to\\_proc   | processor for each ghost quad                                                                                                                                                                                  |
| quad\\_to\\_quad    | one index for each of the 6 faces                                                                                                                                                                              |
| quad\\_to\\_face    | encodes orientation/2:1 status                                                                                                                                                                                 |
| quad\\_to\\_half    | stores half-size neighbors                                                                                                                                                                                     |
| quad\\_level        | Stores lists of per-level quads. The array has entries indexed by 0..[`P4EST_QMAXLEVEL`](@ref) inclusive that are arrays of local quadrant ids. Is NULL by default, but may be enabled by p8est_mesh_new_ext.  |
| local\\_num\\_edges | unsame-size and tree-boundary edges                                                                                                                                                                            |
| quad\\_to\\_edge    | 12 indices for each local quad                                                                                                                                                                                 |
| edge\\_offset       | local\\_num\\_edges + 1 entries                                                                                                                                                                                |
| edge\\_quad         | edge\\_offset indexes into this                                                                                                                                                                                |
| edge\\_edge         | and this one too (type int8\\_t)                                                                                                                                                                               |
"""
struct p8est_mesh_t
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
end

"""
    p8est_mesh_face_neighbor_t

This structure can be used as the status of a face neighbor iterator. It always contains the face and subface of the neighbor to be processed.
"""
struct p8est_mesh_face_neighbor_t
    p4est::Ptr{p8est_t}
    ghost::Ptr{p8est_ghost_t}
    mesh::Ptr{p8est_mesh_t}
    which_tree::p4est_topidx_t
    quadrant_id::p4est_locidx_t
    quadrant_code::p4est_locidx_t
    face::Cint
    subface::Cint
    current_qtq::p4est_locidx_t
end

"""
    p8est_mesh_memory_used(mesh)

Calculate the memory usage of the mesh structure.

### Parameters
* `mesh`:\\[in\\] Mesh structure.
### Returns
Memory used in bytes.
### Prototype
```c
size_t p8est_mesh_memory_used (p8est_mesh_t * mesh);
```
"""
function p8est_mesh_memory_used(mesh)
    @ccall libp4est.p8est_mesh_memory_used(mesh::Ptr{p8est_mesh_t})::Csize_t
end

"""
    p8est_mesh_new(p8est_, ghost, btype)

Create a p8est\\_mesh structure. This function does not populate the quad\\_to\\_tree and quad\\_level fields. To populate them, use p8est_mesh_new_ext.

### Parameters
* `p8est`:\\[in\\] A forest that is fully 2:1 balanced.
* `ghost`:\\[in\\] The ghost layer created from the provided [`p4est`](@ref).
* `btype`:\\[in\\] Determines the highest codimension of neighbors.
### Returns
A fully allocated mesh structure.
### Prototype
```c
p8est_mesh_t *p8est_mesh_new (p8est_t * p8est, p8est_ghost_t * ghost, p8est_connect_type_t btype);
```
"""
function p8est_mesh_new(p8est_, ghost, btype)
    @ccall libp4est.p8est_mesh_new(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, btype::p8est_connect_type_t)::Ptr{p8est_mesh_t}
end

"""
    p8est_mesh_destroy(mesh)

Destroy a p8est\\_mesh structure.

### Parameters
* `mesh`:\\[in\\] Mesh structure previously created by [`p8est_mesh_new`](@ref).
### Prototype
```c
void p8est_mesh_destroy (p8est_mesh_t * mesh);
```
"""
function p8est_mesh_destroy(mesh)
    @ccall libp4est.p8est_mesh_destroy(mesh::Ptr{p8est_mesh_t})::Cvoid
end

"""
    p8est_mesh_get_quadrant(p4est_, mesh, qid)

Access a process-local quadrant inside a forest. Needs a mesh with populated quad\\_to\\_tree array. This is a special case of p8est_mesh_quadrant_cumulative.

### Parameters
* `p4est`:\\[in\\] The forest.
* `mesh`:\\[in\\] The mesh.
* `qid`:\\[in\\] Process-local id of the quadrant (cumulative over trees).
### Returns
A pointer to the requested quadrant.
### Prototype
```c
p8est_quadrant_t *p8est_mesh_get_quadrant (p8est_t * p4est, p8est_mesh_t * mesh, p4est_locidx_t qid);
```
"""
function p8est_mesh_get_quadrant(p4est_, mesh, qid)
    @ccall libp4est.p8est_mesh_get_quadrant(p4est_::Ptr{p8est_t}, mesh::Ptr{p8est_mesh_t}, qid::p4est_locidx_t)::Ptr{p8est_quadrant_t}
end

"""
    p8est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)

Lookup neighboring quads of quadrant in a specific direction

### Parameters
* `p4est`:\\[in\\] Forest to be worked with.
* `ghost`:\\[in\\] Ghost quadrants.
* `mesh`:\\[in\\] Mesh structure.
* `curr_quad_id`:\\[in\\] Process-local ID of current quad.
* `direction`:\\[in\\] Direction in which to look for adjacent quadrants is encoded as follows: 0 .. 5 neighbor(-s) across f\\_i, 6 .. 17 neighbor(-s) across e\\_{i-6} 18 .. 25 neighbor(-s) across c\\_{i-18}
* `neighboring_quads`:\\[out\\] Array containing neighboring quad(-s) Needs to be empty, contains [`p4est_quadrant_t`](@ref)*. May be NULL, then neighboring_qids must not be NULL.
* `neighboring_encs`:\\[out\\] Array containing encodings for neighboring quads as described below Needs to be empty, contains int. CAUTION: Note, that the encodings differ from the encodings saved in the mesh. Positive values are for local quadrants, negative values indicate ghost quadrants. Faces: 1 .. 24 => same size neighbor (r * 6 + nf) + 1; nf = 0 .. 5 face index; r = 0 .. 3 relative orientation 25 .. 120 => double size neighbor 25 + h * 24 + r * 6 + nf; h = 0 .. 3 number of the subface; r, nf as above 121 .. 144 => half size neighbors 121 + r * 6 + nf; r, nf as above Edges: 1 .. 24 => same size neighbor r * 12 + ne + 1; ne = 0 .. 11 edge index; r = 0 .. 1 relative orientation 25 .. 72 => double size neighbor 25 + h * 24 + r * 12 + ne; h = 0 .. 1 number of the subedge; r, ne as above 73 .. 96 => half size neighbors 73 + r * 12 + ne; r, ne as above Corners: 1 .. 8 => nc + 1; nc = 0 .. 7 corner index
* `neighboring_qids`:\\[out\\] Array containing quadrant ids for neighboring quadrants. May be NULL, then no neighboring qids are collected. If non-NULL the array needs to be empty and will contain int.
### Prototype
```c
p4est_locidx_t p8est_mesh_get_neighbors (p8est_t * p4est, p8est_ghost_t * ghost, p8est_mesh_t * mesh, p4est_locidx_t curr_quad_id, p4est_locidx_t direction, sc_array_t * neighboring_quads, sc_array_t * neighboring_encs, sc_array_t * neighboring_qids);
```
"""
function p8est_mesh_get_neighbors(p4est_, ghost, mesh, curr_quad_id, direction, neighboring_quads, neighboring_encs, neighboring_qids)
    @ccall libp4est.p8est_mesh_get_neighbors(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, curr_quad_id::p4est_locidx_t, direction::p4est_locidx_t, neighboring_quads::Ptr{sc_array_t}, neighboring_encs::Ptr{sc_array_t}, neighboring_qids::Ptr{sc_array_t})::p4est_locidx_t
end

"""
    p8est_mesh_quadrant_cumulative(p8est_, mesh, cumulative_id, which_tree, quadrant_id)

Find a quadrant based on its cumulative number in the local forest. If the quad\\_to\\_tree field of the mesh structure exists, this is O(1). Otherwise, we perform a binary search over the processor-local trees.

### Parameters
* `p8est`:\\[in\\] Forest to be worked with.
* `mesh`:\\[in\\] A mesh derived from the forest.
* `cumulative_id`:\\[in\\] Cumulative index over all trees of quadrant. Must refer to a local (non-ghost) quadrant.
* `which_tree`:\\[in,out\\] If not NULL, the input value can be -1 or an initial guess for the quadrant's tree and output is the tree of returned quadrant.
* `quadrant_id`:\\[out\\] If not NULL, the number of quadrant in tree.
### Returns
The identified quadrant.
### Prototype
```c
p8est_quadrant_t *p8est_mesh_quadrant_cumulative (p8est_t * p8est, p8est_mesh_t * mesh, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id);
```
"""
function p8est_mesh_quadrant_cumulative(p8est_, mesh, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p8est_mesh_quadrant_cumulative(p8est_::Ptr{p8est_t}, mesh::Ptr{p8est_mesh_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p8est_quadrant_t}
end

"""
    p8est_mesh_face_neighbor_init2(mfn, p8est_, ghost, mesh, which_tree, quadrant_id)

Initialize a mesh neighbor iterator by quadrant index.

### Parameters
* `mfn`:\\[out\\] A [`p8est_mesh_face_neighbor_t`](@ref) to be initialized.
* `which_tree`:\\[in\\] Tree of quadrant whose neighbors are looped over.
* `quadrant_id`:\\[in\\] Index relative to which\\_tree of quadrant.
### Prototype
```c
void p8est_mesh_face_neighbor_init2 (p8est_mesh_face_neighbor_t * mfn, p8est_t * p8est, p8est_ghost_t * ghost, p8est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_locidx_t quadrant_id);
```
"""
function p8est_mesh_face_neighbor_init2(mfn, p8est_, ghost, mesh, which_tree, quadrant_id)
    @ccall libp4est.p8est_mesh_face_neighbor_init2(mfn::Ptr{p8est_mesh_face_neighbor_t}, p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, which_tree::p4est_topidx_t, quadrant_id::p4est_locidx_t)::Cvoid
end

"""
    p8est_mesh_face_neighbor_init(mfn, p8est_, ghost, mesh, which_tree, quadrant)

Initialize a mesh neighbor iterator by quadrant pointer.

### Parameters
* `mfn`:\\[out\\] A [`p8est_mesh_face_neighbor_t`](@ref) to be initialized.
* `which_tree`:\\[in\\] Tree of quadrant whose neighbors are looped over.
* `quadrant`:\\[in\\] Pointer to quadrant contained in which\\_tree.
### Prototype
```c
void p8est_mesh_face_neighbor_init (p8est_mesh_face_neighbor_t * mfn, p8est_t * p8est, p8est_ghost_t * ghost, p8est_mesh_t * mesh, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant);
```
"""
function p8est_mesh_face_neighbor_init(mfn, p8est_, ghost, mesh, which_tree, quadrant)
    @ccall libp4est.p8est_mesh_face_neighbor_init(mfn::Ptr{p8est_mesh_face_neighbor_t}, p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, mesh::Ptr{p8est_mesh_t}, which_tree::p4est_topidx_t, quadrant::Ptr{p8est_quadrant_t})::Cvoid
end

"""
    p8est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)

Move the iterator forward to loop around neighbors of the quadrant.

### Parameters
* `mfn`:\\[in,out\\] Internal status of the iterator.
* `ntree`:\\[out\\] If not NULL, the tree number of the neighbor.
* `nquad`:\\[out\\] If not NULL, the quadrant number within tree. For ghosts instead the number in ghost layer.
* `nface`:\\[out\\] If not NULL, neighbor's face as in [`p8est_mesh_t`](@ref).
* `nrank`:\\[out\\] If not NULL, the owner process of the neighbor.
### Returns
Either a real quadrant or one from the ghost layer. Returns NULL when the iterator is done.
### Prototype
```c
p8est_quadrant_t *p8est_mesh_face_neighbor_next (p8est_mesh_face_neighbor_t * mfn, p4est_topidx_t * ntree, p4est_locidx_t * nquad, int *nface, int *nrank);
```
"""
function p8est_mesh_face_neighbor_next(mfn, ntree, nquad, nface, nrank)
    @ccall libp4est.p8est_mesh_face_neighbor_next(mfn::Ptr{p8est_mesh_face_neighbor_t}, ntree::Ptr{p4est_topidx_t}, nquad::Ptr{p4est_locidx_t}, nface::Ptr{Cint}, nrank::Ptr{Cint})::Ptr{p8est_quadrant_t}
end

"""
    p8est_mesh_face_neighbor_data(mfn, ghost_data)

Get the user data for the current face neighbor.

### Parameters
* `mfn`:\\[in\\] Internal status of the iterator.
* `ghost_data`:\\[in\\] Data for the ghost quadrants that has been synchronized with [`p4est_ghost_exchange_data`](@ref).
### Returns
A pointer to the user data for the current neighbor.
### Prototype
```c
void *p8est_mesh_face_neighbor_data (p8est_mesh_face_neighbor_t * mfn, void *ghost_data);
```
"""
function p8est_mesh_face_neighbor_data(mfn, ghost_data)
    @ccall libp4est.p8est_mesh_face_neighbor_data(mfn::Ptr{p8est_mesh_face_neighbor_t}, ghost_data::Ptr{Cvoid})::Ptr{Cvoid}
end

"""
    p8est_iter_volume_info

The information that is available to the user-defined [`p8est_iter_volume_t`](@ref) callback function.

*treeid* gives the index in [`p4est`](@ref)->trees of the tree to which *quad* belongs. *quadid* gives the index of *quad* within *tree*'s quadrants array.

| Field  | Note                                                    |
| :----- | :------------------------------------------------------ |
| quad   | the quadrant of the callback                            |
| quadid | id in *quad*'s tree array (see [`p8est_tree_t`](@ref))  |
| treeid | the tree containing *quad*                              |
"""
struct p8est_iter_volume_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    treeid::p4est_topidx_t
end

"""
The information that is available to the user-defined [`p8est_iter_volume_t`](@ref) callback function.

*treeid* gives the index in [`p4est`](@ref)->trees of the tree to which *quad* belongs. *quadid* gives the index of *quad* within *tree*'s quadrants array.
"""
const p8est_iter_volume_info_t = p8est_iter_volume_info

# typedef void ( * p8est_iter_volume_t ) ( p8est_iter_volume_info_t * info , void * user_data )
"""
The prototype for a function that [`p8est_iterate`](@ref)() will execute at every quadrant local to the current process.

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p8est_iterate`](@ref)()
"""
const p8est_iter_volume_t = Ptr{Cvoid}

struct p8est_iter_face_side_data
    data::NTuple{56, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_face_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_325}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_326}(x + 0)
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

"""
    p8est_iter_face_side

Information about one side of a face in the forest. If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If the face is hanging, then the quadrants are listed in z-order. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1.

| Field        | Note                                                  |
| :----------- | :---------------------------------------------------- |
| treeid       | the tree on this side                                 |
| face         | which quadrant side the face touches                  |
| is\\_hanging | boolean: one full quad (0) or four smaller quads (1)  |
"""
struct p8est_iter_face_side
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_face_side}, f::Symbol)
    f === :treeid && return Ptr{p4est_topidx_t}(x + 0)
    f === :face && return Ptr{Int8}(x + 4)
    f === :is_hanging && return Ptr{Int8}(x + 5)
    f === :is && return Ptr{p8est_iter_face_side_data}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_iter_face_side, f::Symbol)
    r = Ref{p8est_iter_face_side}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_iter_face_side}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_iter_face_side}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

"""Information about one side of a face in the forest. If a *quad* is local (*is_ghost* is false), then its *quadid* indexes the tree's quadrant array; otherwise, it indexes the ghosts array. If the face is hanging, then the quadrants are listed in z-order. If a quadrant should be present, but it is not included in the ghost layer, then quad = NULL, is\\_ghost is true, and quadid = -1."""
const p8est_iter_face_side_t = p8est_iter_face_side

"""
    p8est_iter_face_info

The information that is available to the user-defined [`p8est_iter_face_t`](@ref) callback.

The orientation is 0 if the face is within one tree; otherwise, it is the same as the orientation value between the two trees given in the connectivity. If the face is on the outside of the forest, then there is only one side. If tree\\_boundary is false, the face is on the interior of a tree. When tree\\_boundary false, sides[0] contains the lowest z-order quadrant that touches the face. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE.

| Field           | Note                                                                                                |
| :-------------- | :-------------------------------------------------------------------------------------------------- |
| orientation     | the orientation of the sides to each other, as in the definition of [`p8est_connectivity_t`](@ref)  |
| tree\\_boundary | boolean: interior face (0), tree boundary face (true)                                               |
"""
struct p8est_iter_face_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    orientation::Int8
    tree_boundary::Int8
    sides::sc_array_t
end

"""
The information that is available to the user-defined [`p8est_iter_face_t`](@ref) callback.

The orientation is 0 if the face is within one tree; otherwise, it is the same as the orientation value between the two trees given in the connectivity. If the face is on the outside of the forest, then there is only one side. If tree\\_boundary is false, the face is on the interior of a tree. When tree\\_boundary false, sides[0] contains the lowest z-order quadrant that touches the face. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE.
"""
const p8est_iter_face_info_t = p8est_iter_face_info

# typedef void ( * p8est_iter_face_t ) ( p8est_iter_face_info_t * info , void * user_data )
"""
The prototype for a function that [`p8est_iterate`](@ref)() will execute wherever two quadrants share a face: the face can be a 2:1 hanging face, it does not have to be conformal.

!!! note

    the forest must be face balanced for [`p8est_iterate`](@ref)() to execute a callback function on faces (see [`p8est_balance`](@ref)()).

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p8est_iterate`](@ref)()
"""
const p8est_iter_face_t = Ptr{Cvoid}

struct p8est_iter_edge_side_data
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_edge_side_data}, f::Symbol)
    f === :full && return Ptr{__JL_Ctag_323}(x + 0)
    f === :hanging && return Ptr{__JL_Ctag_324}(x + 0)
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

"""
    p8est_iter_edge_side

| Field        | Note                                                                                                            |
| :----------- | :-------------------------------------------------------------------------------------------------------------- |
| treeid       | the tree on this side                                                                                           |
| edge         | which quadrant side the edge touches                                                                            |
| orientation  | the orientation of each quadrant relative to this edge, as in the definition of [`p8est_connectivity_t`](@ref)  |
| is\\_hanging | boolean: one full quad (0) or two smaller quads (1)                                                             |
"""
struct p8est_iter_edge_side
    data::NTuple{48, UInt8}
end

function Base.getproperty(x::Ptr{p8est_iter_edge_side}, f::Symbol)
    f === :treeid && return Ptr{p4est_topidx_t}(x + 0)
    f === :edge && return Ptr{Int8}(x + 4)
    f === :orientation && return Ptr{Int8}(x + 5)
    f === :is_hanging && return Ptr{Int8}(x + 6)
    f === :is && return Ptr{p8est_iter_edge_side_data}(x + 8)
    f === :faces && return Ptr{NTuple{2, Int8}}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::p8est_iter_edge_side, f::Symbol)
    r = Ref{p8est_iter_edge_side}(x)
    ptr = Base.unsafe_convert(Ptr{p8est_iter_edge_side}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{p8est_iter_edge_side}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const p8est_iter_edge_side_t = p8est_iter_edge_side

"""
    p8est_iter_edge_info

The information about all sides of an edge in the forest. If tree\\_boundary is false, the edge is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the edge. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE/EDGE depending on the location of the edge relative to the tree.

| Field           | Note                                                   |
| :-------------- | :----------------------------------------------------- |
| tree\\_boundary | boolean: interior face (0), tree boundary face (true)  |
| sides           | array of [`p8est_iter_edge_side_t`](@ref) type         |
"""
struct p8est_iter_edge_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
end

"""The information about all sides of an edge in the forest. If tree\\_boundary is false, the edge is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the edge. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE/EDGE depending on the location of the edge relative to the tree."""
const p8est_iter_edge_info_t = p8est_iter_edge_info

# typedef void ( * p8est_iter_edge_t ) ( p8est_iter_edge_info_t * info , void * user_data )
"""
The prototype for a function that [`p8est_iterate`](@ref) will execute wherever the edge is an edge of all quadrants that touch it i.e. the callback will not execute on an edge the sits on a hanging face.

!!! note

    the forest must be edge balanced for [`p8est_iterate`](@ref)() to execute a callback function on edges.

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p8est_iterate`](@ref)()
"""
const p8est_iter_edge_t = Ptr{Cvoid}

"""
    p8est_iter_corner_side

| Field      | Note                                                 |
| :--------- | :--------------------------------------------------- |
| treeid     | the tree that contains *quad*                        |
| corner     | which of the quadrant's corners touches this corner  |
| is\\_ghost | boolean: local (0) or ghost (1)                      |
| quadid     | the index in the tree or ghost array                 |
| faces      | internal work data                                   |
| edges      |                                                      |
"""
struct p8est_iter_corner_side
    treeid::p4est_topidx_t
    corner::Int8
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
    faces::NTuple{3, Int8}
    edges::NTuple{3, Int8}
end

const p8est_iter_corner_side_t = p8est_iter_corner_side

"""
    p8est_iter_corner_info

The information that is availalbe to the user-defined [`p8est_iter_corner_t`](@ref) callback.

If tree\\_boundary is false, the corner is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the corner. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE/EDGE/CORNER depending on the location of the corner relative to the tree.

| Field           | Note                                                   |
| :-------------- | :----------------------------------------------------- |
| tree\\_boundary | boolean: interior face (0), tree boundary face (true)  |
| sides           | array of [`p8est_iter_corner_side_t`](@ref) type       |
"""
struct p8est_iter_corner_info
    p4est::Ptr{p8est_t}
    ghost_layer::Ptr{p8est_ghost_t}
    tree_boundary::Int8
    sides::sc_array_t
end

"""
The information that is availalbe to the user-defined [`p8est_iter_corner_t`](@ref) callback.

If tree\\_boundary is false, the corner is on the interior of a tree. When tree\\_boundary is false, sides[0] contains the lowest z-order quadrant that touches the corner. When tree\\_boundary is true, its value is P8EST\\_CONNECT\\_FACE/EDGE/CORNER depending on the location of the corner relative to the tree.
"""
const p8est_iter_corner_info_t = p8est_iter_corner_info

# typedef void ( * p8est_iter_corner_t ) ( p8est_iter_corner_info_t * info , void * user_data )
"""
The prototype for a function that [`p8est_iterate`](@ref) will execute wherever the corner is a corner for all quadrants that touch it

i.e. the callback will not execute on a corner that sits on a hanging face or edge.

!!! note

    the forest does not need to be corner balanced for [`p8est_iterate`](@ref)() to execute a callback function at corners, only face and edge balanced.

### Parameters
* `info`:\\[in\\] information about a quadrant provided to the user
* `user_data`:\\[in,out\\] the user context passed to [`p8est_iterate`](@ref)()
"""
const p8est_iter_corner_t = Ptr{Cvoid}

"""
    p8est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner)

Execute the user-supplied callback functions at every volume, face, edge and corner in the local forest.

The ghost\\_layer may be NULL. The *user_data* pointer is not touched by [`p8est_iterate`](@ref), but is passed to each of the callbacks. Any of the callback functions may be NULL. The callback functions are interspersed with each other, i.e. some face callbacks will occur between volume callbacks, and some edge callbacks will occur between face callbacks, etc.:

1) volume callbacks occur in the sorted Morton-index order. 2) a face callback is not executed until after the volume callbacks have been executed for the quadrants that share it. 3) an edge callback is not executed until the face callbacks have been executed for all faces that touch the edge. 4) a corner callback is not executed until the edge callbacks have been executed for all edges that touch the corner. 5) it is not always the case that every face callback for a given quadrant is executed before any of the edge or corner callbacks, and it is not always the case that every edge callback for a given quadrant is executed before any of the corner callbacks. 6) callbacks are not executed at faces, edges or corners that only involve ghost quadrants, i.e. that are not adjacent in the local section of the forest.

### Parameters
* `p4est`:\\[in\\] the forest
* `ghost_layer`:\\[in\\] optional: when not given, callbacks at the boundaries of the local partition cannot provide quadrant data about ghost quadrants: missing ([`p8est_quadrant_t`](@ref) *) pointers are set to NULL, missing indices are set to -1.
* `user_data`:\\[in,out\\] optional context to supply to each callback
* `iter_volume`:\\[in\\] callback function for every quadrant's interior
* `iter_face`:\\[in\\] callback function for every face between quadrants
* `iter_edge`:\\[in\\] callback function for every edge between quadrants
* `iter_corner`:\\[in\\] callback function for every corner between quadrants
### Prototype
```c
void p8est_iterate (p8est_t * p4est, p8est_ghost_t * ghost_layer, void *user_data, p8est_iter_volume_t iter_volume, p8est_iter_face_t iter_face, p8est_iter_edge_t iter_edge, p8est_iter_corner_t iter_corner);
```
"""
function p8est_iterate(p4est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner)
    @ccall libp4est.p8est_iterate(p4est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p8est_iter_volume_t, iter_face::p8est_iter_face_t, iter_edge::p8est_iter_edge_t, iter_corner::p8est_iter_corner_t)::Cvoid
end

"""
    p8est_iter_cside_array_index_int(array, it)

### Prototype
```c
static inline p8est_iter_corner_side_t * p8est_iter_cside_array_index_int (sc_array_t * array, int it);
```
"""
function p8est_iter_cside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_cside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_corner_side_t}
end

"""
    p8est_iter_cside_array_index(array, it)

### Prototype
```c
static inline p8est_iter_corner_side_t * p8est_iter_cside_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_iter_cside_array_index(array, it)
    @ccall libp4est.p8est_iter_cside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_corner_side_t}
end

"""
    p8est_iter_eside_array_index_int(array, it)

### Prototype
```c
static inline p8est_iter_edge_side_t * p8est_iter_eside_array_index_int (sc_array_t * array, int it);
```
"""
function p8est_iter_eside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_eside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_edge_side_t}
end

"""
    p8est_iter_eside_array_index(array, it)

### Prototype
```c
static inline p8est_iter_edge_side_t * p8est_iter_eside_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_iter_eside_array_index(array, it)
    @ccall libp4est.p8est_iter_eside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_edge_side_t}
end

"""
    p8est_iter_fside_array_index_int(array, it)

### Prototype
```c
static inline p8est_iter_face_side_t * p8est_iter_fside_array_index_int (sc_array_t * array, int it);
```
"""
function p8est_iter_fside_array_index_int(array, it)
    @ccall libp4est.p8est_iter_fside_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_iter_face_side_t}
end

"""
    p8est_iter_fside_array_index(array, it)

### Prototype
```c
static inline p8est_iter_face_side_t * p8est_iter_fside_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_iter_fside_array_index(array, it)
    @ccall libp4est.p8est_iter_fside_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_iter_face_side_t}
end

const p8est_lnodes_code_t = Int16

struct p8est_lnodes
    mpicomm::MPI_Comm
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
end

"""
Store a parallel numbering of Lobatto points of a given degree > 0.

Each element has degree+1 nodes per edge and vnodes = (degree+1)^3 nodes per volume. element\\_nodes is of dimension vnodes * num\\_local\\_elements and lists the nodes of each element in lexicographic yx-order (x varies fastest); element\\_nodes indexes into the set of local nodes, layed out as follows: local nodes = [<-----owned\\_count----->|<-----nonlocal\\_nodes----->] = [<----------------num\\_local\\_nodes----------------->] nonlocal\\_nodes contains the globally unique numbers for independent nodes that are owned by other processes; for local nodes, the globally unique numbers are given by i + global\\_offset, where i is the local number. Hanging nodes are always local and don't have a global number. They index the geometrically corresponding independent nodes of a neighbor.

Whether nodes are hanging or not is decided based on the element faces and edges. This information is encoded in face\\_code with one int16\\_t per element. If no faces or edges are hanging, the value is zero, otherwise the face\\_code is interpreted by [`p8est_lnodes_decode`](@ref).

Independent nodes can be shared by multiple MPI ranks. The owner rank of a node is the one from the lowest numbered element on the lowest numbered octree *touching* the node.

What is meant by *touching*? A quadrant is said to touch all faces/edges/corners that are incident on it, and by extension all nodes that are contained in those faces/edges/corners.

X +-----------+ x |\\ \\ x | \\ \\ . x | \\ \\ x X | +-----------+ +-----+ . . | | | |\\ \\ X o + | | | +-----+ o . \\ | p | + | q | o \\ | | \\| | o \\| | +-----+ O +-----------+

In this example degree = 3. There are 4 nodes that live on the face between q and p, two on each edge and one at each corner of that face. The face is incident on q, so q owns the nodes marked '.' on the face (provided q is from a lower tree or has a lower index than p). The bottom and front edges are incident on q, so q owns its nodes marked 'o' as well. The front lower corner is incident on q, so q owns its node 'O' as well. The other edges and corners are not incident on q, so q cannot own their nodes, marked 'x' and 'X'.

global\\_owned\\_count contains the number of independent nodes owned by each process.

The sharers array contains items of type [`p8est_lnodes_rank_t`](@ref) that hold the ranks that own or share independent local nodes. If there are no shared nodes on this processor, it is empty. Otherwise, it is sorted by rank and the current process is included.

degree < 0 indicates that the lnodes data structure is being used to number the quadrant boundary object (faces, edge and corners) rather than the \$C^0\$ Lobatto nodes:

if degree == -1, then one node is assigned per face, and no nodes are assigned per volume, per edge, or per corner: this numbering can be used for low-order Raviart-Thomas elements. In this case, vnodes == 6, and the nodes are listed in face-order.

if degree == -2, then one node is assigned per face and per edge and no nodes are assigned per volume or per corner. In this case, vnodes == 18, and the nodes are listed in face-order, followed by edge-order.

if degree == -3, then one node is assigned per face, per edge and per corner and no nodes are assigned per volume. In this case, vnodes == 26, and the nodes are listed in face-order, followed by edge-order, followed by corner-order.
"""
const p8est_lnodes_t = p8est_lnodes

"""
    p8est_lnodes_rank

The structure stored in the sharers array.

shared\\_nodes is a sorted array of [`p4est_locidx_t`](@ref) that indexes into local nodes. The shared\\_nodes array has a contiguous (or empty) section of nodes owned by the current rank. shared\\_mine\\_offset and shared\\_mine\\_count identify this section by indexing the shared\\_nodes array, not the local nodes array. owned\\_offset and owned\\_count define the section of local nodes that is owned by the listed rank (the section may be empty). For the current process these coincide with those in [`p8est_lnodes_t`](@ref).
"""
struct p8est_lnodes_rank
    rank::Cint
    shared_nodes::sc_array_t
    shared_mine_offset::p4est_locidx_t
    shared_mine_count::p4est_locidx_t
    owned_offset::p4est_locidx_t
    owned_count::p4est_locidx_t
end

"""
The structure stored in the sharers array.

shared\\_nodes is a sorted array of [`p4est_locidx_t`](@ref) that indexes into local nodes. The shared\\_nodes array has a contiguous (or empty) section of nodes owned by the current rank. shared\\_mine\\_offset and shared\\_mine\\_count identify this section by indexing the shared\\_nodes array, not the local nodes array. owned\\_offset and owned\\_count define the section of local nodes that is owned by the listed rank (the section may be empty). For the current process these coincide with those in [`p8est_lnodes_t`](@ref).
"""
const p8est_lnodes_rank_t = p8est_lnodes_rank

"""
    p8est_lnodes_decode(face_code, hanging_face, hanging_edge)

### Prototype
```c
static inline int p8est_lnodes_decode (p8est_lnodes_code_t face_code, int hanging_face[6], int hanging_edge[12]);
```
"""
function p8est_lnodes_decode(face_code, hanging_face, hanging_edge)
    @ccall libp4est.p8est_lnodes_decode(face_code::p8est_lnodes_code_t, hanging_face::Ptr{Cint}, hanging_edge::Ptr{Cint})::Cint
end

"""
    p8est_lnodes_new(p8est_, ghost_layer, degree)

### Prototype
```c
p8est_lnodes_t *p8est_lnodes_new (p8est_t * p8est, p8est_ghost_t * ghost_layer, int degree);
```
"""
function p8est_lnodes_new(p8est_, ghost_layer, degree)
    @ccall libp4est.p8est_lnodes_new(p8est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, degree::Cint)::Ptr{p8est_lnodes_t}
end

"""
    p8est_lnodes_destroy(lnodes)

### Prototype
```c
void p8est_lnodes_destroy (p8est_lnodes_t * lnodes);
```
"""
function p8est_lnodes_destroy(lnodes)
    @ccall libp4est.p8est_lnodes_destroy(lnodes::Ptr{p8est_lnodes_t})::Cvoid
end

"""
    p8est_partition_lnodes(p8est_, ghost, degree, partition_for_coarsening)

Partition using weights based on the number of nodes assigned to each element in lnodes

### Parameters
* `p8est`:\\[in,out\\] the forest to be repartitioned
* `ghost`:\\[in\\] the ghost layer
* `degree`:\\[in\\] the degree that would be passed to [`p8est_lnodes_new`](@ref)()
* `partition_for_coarsening`:\\[in\\] whether the partition should allow coarsening (i.e. group siblings who might merge)
### Prototype
```c
void p8est_partition_lnodes (p8est_t * p8est, p8est_ghost_t * ghost, int degree, int partition_for_coarsening);
```
"""
function p8est_partition_lnodes(p8est_, ghost, degree, partition_for_coarsening)
    @ccall libp4est.p8est_partition_lnodes(p8est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, degree::Cint, partition_for_coarsening::Cint)::Cvoid
end

"""
    p8est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_edge, nodes_per_corner, partition_for_coarsening)

Partition using weights that are broken down by where they reside: in volumes, on faces, on edges, or on corners.

### Prototype
```c
void p8est_partition_lnodes_detailed (p8est_t * p4est, p8est_ghost_t * ghost, int nodes_per_volume, int nodes_per_face, int nodes_per_edge, int nodes_per_corner, int partition_for_coarsening);
```
"""
function p8est_partition_lnodes_detailed(p4est_, ghost, nodes_per_volume, nodes_per_face, nodes_per_edge, nodes_per_corner, partition_for_coarsening)
    @ccall libp4est.p8est_partition_lnodes_detailed(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, nodes_per_volume::Cint, nodes_per_face::Cint, nodes_per_edge::Cint, nodes_per_corner::Cint, partition_for_coarsening::Cint)::Cvoid
end

"""
    p8est_ghost_support_lnodes(p8est_, lnodes, ghost)

Expand the ghost layer to include the support of all nodes supported on the local partition.

### Parameters
* `p8est`:\\[in\\] The forest from which the ghost layer was generated.
* `lnodes`:\\[in\\] The nodes to support.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p8est_ghost_support_lnodes (p8est_t * p8est, p8est_lnodes_t * lnodes, p8est_ghost_t * ghost);
```
"""
function p8est_ghost_support_lnodes(p8est_, lnodes, ghost)
    @ccall libp4est.p8est_ghost_support_lnodes(p8est_::Ptr{p8est_t}, lnodes::Ptr{p8est_lnodes_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

"""
    p8est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)

Expand the ghost layer as in [`p8est_ghost_expand`](@ref)(), but use node support to define adjacency instead of geometric adjacency.

### Parameters
* `p8est`:\\[in\\] The forest from which the ghost layer was generated.
* `lnodes`:\\[in\\] The nodes to support.
* `ghost`:\\[in,out\\] The ghost layer to be expanded.
### Prototype
```c
void p8est_ghost_expand_by_lnodes (p8est_t * p4est, p8est_lnodes_t * lnodes, p8est_ghost_t * ghost);
```
"""
function p8est_ghost_expand_by_lnodes(p4est_, lnodes, ghost)
    @ccall libp4est.p8est_ghost_expand_by_lnodes(p4est_::Ptr{p8est_t}, lnodes::Ptr{p8est_lnodes_t}, ghost::Ptr{p8est_ghost_t})::Cvoid
end

"""
    p8est_lnodes_buffer

[`p8est_lnodes_buffer_t`](@ref) handles the communication of data associated with nodes.

*send_buffers* is an array of arrays: one buffer for each process to which the current process sends node-data. It should not be altered between a shared\\_*\\_begin and a shared\\_*\\_end call.

*recv_buffers* is an array of arrays that is used in lnodes\\_share\\_all\\_*. *recv_buffers*[j] corresponds with lnodes->sharers[j]: it is the same length as *lnodes*->sharers[j]->shared_nodes. At the completion of lnodes\\_share\\_all or lnodes\\_share\\_all\\_end, recv\\_buffers[j] contains the node-data from the process lnodes->sharers[j]->rank (unless j is the current rank, in which case recv\\_buffers[j] is empty).
"""
struct p8est_lnodes_buffer
    requests::Ptr{sc_array_t}
    send_buffers::Ptr{sc_array_t}
    recv_buffers::Ptr{sc_array_t}
end

"""
[`p8est_lnodes_buffer_t`](@ref) handles the communication of data associated with nodes.

*send_buffers* is an array of arrays: one buffer for each process to which the current process sends node-data. It should not be altered between a shared\\_*\\_begin and a shared\\_*\\_end call.

*recv_buffers* is an array of arrays that is used in lnodes\\_share\\_all\\_*. *recv_buffers*[j] corresponds with lnodes->sharers[j]: it is the same length as *lnodes*->sharers[j]->shared_nodes. At the completion of lnodes\\_share\\_all or lnodes\\_share\\_all\\_end, recv\\_buffers[j] contains the node-data from the process lnodes->sharers[j]->rank (unless j is the current rank, in which case recv\\_buffers[j] is empty).
"""
const p8est_lnodes_buffer_t = p8est_lnodes_buffer

"""
    p8est_lnodes_share_owned_begin(node_data, lnodes)

[`p8est_lnodes_share_owned_begin`](@ref)

*node_data* is a user-defined array of arbitrary type, where each entry is associated with the *lnodes* local nodes entry of matching index. For every local nodes entry that is owned by a process other than the current one, the value in the *node_data* array of the owning process is written directly into the *node_data* array of the current process. Values of *node_data* are not guaranteed to be sent or received until the *buffer* created by [`p8est_lnodes_share_owned_begin`](@ref) is passed to [`p8est_lnodes_share_owned_end`](@ref).

To be memory neutral, the *buffer* created by [`p8est_lnodes_share_owned_begin`](@ref) must be destroying with [`p8est_lnodes_buffer_destroy`](@ref) (it is not destroyed by [`p8est_lnodes_share_owned_end`](@ref)).

### Prototype
```c
p8est_lnodes_buffer_t *p8est_lnodes_share_owned_begin (sc_array_t * node_data, p8est_lnodes_t * lnodes);
```
"""
function p8est_lnodes_share_owned_begin(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_owned_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

"""
    p8est_lnodes_share_owned_end(buffer)

### Prototype
```c
void p8est_lnodes_share_owned_end (p8est_lnodes_buffer_t * buffer);
```
"""
function p8est_lnodes_share_owned_end(buffer)
    @ccall libp4est.p8est_lnodes_share_owned_end(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

"""
    p8est_lnodes_share_owned(node_data, lnodes)

Equivalent to calling [`p8est_lnodes_share_owned_end`](@ref) directly after [`p8est_lnodes_share_owned_begin`](@ref). Use if there is no local work that can be done to mask the communication cost.

### Prototype
```c
void p8est_lnodes_share_owned (sc_array_t * node_data, p8est_lnodes_t * lnodes);
```
"""
function p8est_lnodes_share_owned(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_owned(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Cvoid
end

"""
    p8est_lnodes_share_all_begin(node_data, lnodes)

[`p8est_lnodes_share_all_begin`](@ref)

*node_data* is a user\\_defined array of arbitrary type, where each entry is associated with the *lnodes* local nodes entry of matching index. For every process that shares an entry with the current one, the value in the *node_data* array of that process is written into a *buffer*->recv_buffers entry as described above. The user can then perform some arbitrary work that requires the data from all processes that share a node (such as reduce, max, min, etc.). When the work concludes, the *buffer* should be destroyed with [`p8est_lnodes_buffer_destroy`](@ref).

Values of *node_data* are not guaranteed to be send, and *buffer*->recv_buffer entries are not guaranteed to be received until the *buffer* created by [`p8est_lnodes_share_all_begin`](@ref) is passed to [`p8est_lnodes_share_all_end`](@ref).

### Prototype
```c
p8est_lnodes_buffer_t *p8est_lnodes_share_all_begin (sc_array_t * node_data, p8est_lnodes_t * lnodes);
```
"""
function p8est_lnodes_share_all_begin(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_all_begin(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

"""
    p8est_lnodes_share_all_end(buffer)

### Prototype
```c
void p8est_lnodes_share_all_end (p8est_lnodes_buffer_t * buffer);
```
"""
function p8est_lnodes_share_all_end(buffer)
    @ccall libp4est.p8est_lnodes_share_all_end(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

"""
    p8est_lnodes_share_all(node_data, lnodes)

Equivalend to calling [`p8est_lnodes_share_all_end`](@ref) directly after [`p8est_lnodes_share_all_begin`](@ref). Use if there is no local work that can be done to mask the communication cost.

### Returns
A fully initialized buffer that contains the received data. After processing this data, the buffer must be freed with [`p8est_lnodes_buffer_destroy`](@ref).
### Prototype
```c
p8est_lnodes_buffer_t *p8est_lnodes_share_all (sc_array_t * node_data, p8est_lnodes_t * lnodes);
```
"""
function p8est_lnodes_share_all(node_data, lnodes)
    @ccall libp4est.p8est_lnodes_share_all(node_data::Ptr{sc_array_t}, lnodes::Ptr{p8est_lnodes_t})::Ptr{p8est_lnodes_buffer_t}
end

"""
    p8est_lnodes_buffer_destroy(buffer)

### Prototype
```c
void p8est_lnodes_buffer_destroy (p8est_lnodes_buffer_t * buffer);
```
"""
function p8est_lnodes_buffer_destroy(buffer)
    @ccall libp4est.p8est_lnodes_buffer_destroy(buffer::Ptr{p8est_lnodes_buffer_t})::Cvoid
end

"""
    p8est_lnodes_rank_array_index_int(array, it)

### Prototype
```c
static inline p8est_lnodes_rank_t * p8est_lnodes_rank_array_index_int (sc_array_t * array, int it);
```
"""
function p8est_lnodes_rank_array_index_int(array, it)
    @ccall libp4est.p8est_lnodes_rank_array_index_int(array::Ptr{sc_array_t}, it::Cint)::Ptr{p8est_lnodes_rank_t}
end

"""
    p8est_lnodes_rank_array_index(array, it)

### Prototype
```c
static inline p8est_lnodes_rank_t * p8est_lnodes_rank_array_index (sc_array_t * array, size_t it);
```
"""
function p8est_lnodes_rank_array_index(array, it)
    @ccall libp4est.p8est_lnodes_rank_array_index(array::Ptr{sc_array_t}, it::Csize_t)::Ptr{p8est_lnodes_rank_t}
end

"""
    p8est_lnodes_global_index(lnodes, lidx)

### Prototype
```c
static inline p4est_gloidx_t p8est_lnodes_global_index (p8est_lnodes_t * lnodes, p4est_locidx_t lidx);
```
"""
function p8est_lnodes_global_index(lnodes, lidx)
    @ccall libp4est.p8est_lnodes_global_index(lnodes::Ptr{p8est_lnodes_t}, lidx::p4est_locidx_t)::p4est_gloidx_t
end

"""
    sc_uint128

An unsigned 128 bit integer represented as two uint64\\_t.

| Field       | Note                           |
| :---------- | :----------------------------- |
| high\\_bits | The more significant 64 bits.  |
| low\\_bits  | The less significant 64 bits.  |
"""
struct sc_uint128
    high_bits::UInt64
    low_bits::UInt64
end

"""An unsigned 128 bit integer represented as two uint64\\_t."""
const sc_uint128_t = sc_uint128

"""
    sc_uint128_compare(a, b)

Compare the [`sc_uint128_t`](@ref) *a* and the [`sc_uint128_t`](@ref) *b*.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Returns
Returns -1 if a < b, 1 if a > b and 0 if a == b.
### Prototype
```c
int sc_uint128_compare (const void *a, const void *b);
```
"""
function sc_uint128_compare(a, b)
    @ccall libp4est.sc_uint128_compare(a::Ptr{Cvoid}, b::Ptr{Cvoid})::Cint
end

"""
    sc_uint128_is_equal(a, b)

Checks if the [`sc_uint128_t`](@ref) *a* and the [`sc_uint128_t`](@ref) *b* are equal.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Returns
Returns a true value if *a* and *b* are equal, false otherwise.
### Prototype
```c
int sc_uint128_is_equal (const sc_uint128_t * a, const sc_uint128_t * b);
```
"""
function sc_uint128_is_equal(a, b)
    @ccall libp4est.sc_uint128_is_equal(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cint
end

"""
    sc_uint128_init(a, high, low)

Initializes an unsigned 128 bit integer to a given value.

### Parameters
* `a`:\\[in,out\\] A pointer to the [`sc_uint128_t`](@ref) that will be initialized.
* `high`:\\[in\\] The given high bits to initialize *a*.
* `low`:\\[in\\] The given low bits to initialize *a*.
### Prototype
```c
void sc_uint128_init (sc_uint128_t * a, uint64_t high, uint64_t low);
```
"""
function sc_uint128_init(a, high, low)
    @ccall libp4est.sc_uint128_init(a::Ptr{sc_uint128_t}, high::UInt64, low::UInt64)::Cvoid
end

"""
    sc_uint128_chk_bit(input, exponent)

Returns the bit\\_number-th bit of *input*. This function checks a bit of an existing, initialized value.

### Parameters
* `input`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `bit_number`:\\[in\\] The bit (counted from the right hand side) that is checked by logical and. Require 0 <= *bit_number* < 128.
### Returns
True if the checked bit is set, false if not.
### Prototype
```c
int sc_uint128_chk_bit (const sc_uint128_t * input, int exponent);
```
"""
function sc_uint128_chk_bit(input, exponent)
    @ccall libp4est.sc_uint128_chk_bit(input::Ptr{sc_uint128_t}, exponent::Cint)::Cint
end

"""
    sc_uint128_set_bit(a, exponent)

Sets the exponent-th bit of *a* to one and keep all other bits. This function modifies an existing, initialized value.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref).
* `exponent`:\\[in\\] The bit (0-based from the rightmost bit) that is set to one by logical or. 0 <= *exponent* < 128.
### Prototype
```c
void sc_uint128_set_bit (sc_uint128_t * a, int exponent);
```
"""
function sc_uint128_set_bit(a, exponent)
    @ccall libp4est.sc_uint128_set_bit(a::Ptr{sc_uint128_t}, exponent::Cint)::Cvoid
end

"""
    sc_uint128_copy(input, output)

Copies an initialized [`sc_uint128_t`](@ref) to a [`sc_uint128_t`](@ref).

### Parameters
* `input`:\\[in\\] A pointer to the [`sc_uint128`](@ref) that is copied.
* `output`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). The high and low bits of *output* will be set to the high and low bits of *input*, respectively.
### Prototype
```c
void sc_uint128_copy (const sc_uint128_t * input, sc_uint128_t * output);
```
"""
function sc_uint128_copy(input, output)
    @ccall libp4est.sc_uint128_copy(input::Ptr{sc_uint128_t}, output::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_add(a, b, result)

Adds the uint128\\_t *b* to the uint128\\_t *a*. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `result`:\\[out\\] A pointer to a [`sc_uint128_t`](@ref). The sum *a* + *b* will be saved in *result*.
### Prototype
```c
void sc_uint128_add (const sc_uint128_t * a, const sc_uint128_t * b, sc_uint128_t * result);
```
"""
function sc_uint128_add(a, b, result)
    @ccall libp4est.sc_uint128_add(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_sub(a, b, result)

Subtracts the uint128\\_t *b* from the uint128\\_t *a*. This function assumes that the result is >= 0. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `result`:\\[out\\] A pointer to a [`sc_uint128_t`](@ref). The difference *a* - *b* will be saved in *result*.
### Prototype
```c
void sc_uint128_sub (const sc_uint128_t * a, const sc_uint128_t * b, sc_uint128_t * result);
```
"""
function sc_uint128_sub(a, b, result)
    @ccall libp4est.sc_uint128_sub(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_bitwise_neg(a, result)

Calculates the bitwise negation of the uint128\\_t *a*. *a* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `result`:\\[out\\] A pointer to a [`sc_uint128_t`](@ref). The bitwise negation of *a* will be saved in *result*.
### Prototype
```c
void sc_uint128_bitwise_neg (const sc_uint128_t * a, sc_uint128_t * result);
```
"""
function sc_uint128_bitwise_neg(a, result)
    @ccall libp4est.sc_uint128_bitwise_neg(a::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_bitwise_or(a, b, result)

Calculates the bitwise or of the uint128\\_t *a* and *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `result`:\\[out\\] A pointer to a [`sc_uint128_t`](@ref). The bitwise or of *a* and *b* will be saved in *result*.
### Prototype
```c
void sc_uint128_bitwise_or (const sc_uint128_t * a, const sc_uint128_t * b, sc_uint128_t * result);
```
"""
function sc_uint128_bitwise_or(a, b, result)
    @ccall libp4est.sc_uint128_bitwise_or(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_bitwise_and(a, b, result)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `result`:\\[out\\] A pointer to a [`sc_uint128_t`](@ref). The bitwise and of *a* and *b* will be saved. in *result*.
### Prototype
```c
void sc_uint128_bitwise_and (const sc_uint128_t * a, const sc_uint128_t * b, sc_uint128_t * result);
```
"""
function sc_uint128_bitwise_and(a, b, result)
    @ccall libp4est.sc_uint128_bitwise_and(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t}, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_shift_right(input, shift_count, result)

Calculates the bit right shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the left. If *shift_count* >= 128, *result* is 0. All bits right from the zeroth bit (counted from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). The right shifted number will be saved in *result*.
### Prototype
```c
void sc_uint128_shift_right (const sc_uint128_t * input, int shift_count, sc_uint128_t * result);
```
"""
function sc_uint128_shift_right(input, shift_count, result)
    @ccall libp4est.sc_uint128_shift_right(input::Ptr{sc_uint128_t}, shift_count::Cint, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_shift_left(input, shift_count, result)

Calculates the bit left shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the right. If *shift_count* >= 128, *result* is 0. All bits left from the 127th bit (counted zero based from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). The left shifted number will be saved in *result*.
### Prototype
```c
void sc_uint128_shift_left (const sc_uint128_t * input, int shift_count, sc_uint128_t * result);
```
"""
function sc_uint128_shift_left(input, shift_count, result)
    @ccall libp4est.sc_uint128_shift_left(input::Ptr{sc_uint128_t}, shift_count::Cint, result::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_add_inplace(a, b)

Adds the uint128 *b* to the uint128\\_t *a*. The result is saved in *a*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). *a* will be overwritten by *a* + *b*.
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Prototype
```c
void sc_uint128_add_inplace (sc_uint128_t * a, const sc_uint128_t * b);
```
"""
function sc_uint128_add_inplace(a, b)
    @ccall libp4est.sc_uint128_add_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_sub_inplace(a, b)

Subtracts the uint128\\_t *b* from the uint128\\_t *a*. The result is saved in *a*. *a* == *b* is allowed. This function assumes that the result is >= 0.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). *a* will be overwritten by *a* - *b*.
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Prototype
```c
void sc_uint128_sub_inplace (sc_uint128_t * a, const sc_uint128_t * b);
```
"""
function sc_uint128_sub_inplace(a, b)
    @ccall libp4est.sc_uint128_sub_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_bitwise_or_inplace(a, b)

Calculates the bitwise or of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). The bitwise or will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Prototype
```c
void sc_uint128_bitwise_or_inplace (sc_uint128_t * a, const sc_uint128_t * b);
```
"""
function sc_uint128_bitwise_or_inplace(a, b)
    @ccall libp4est.sc_uint128_bitwise_or_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

"""
    sc_uint128_bitwise_and_inplace(a, b)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`sc_uint128_t`](@ref). The bitwise and will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`sc_uint128_t`](@ref).
### Prototype
```c
void sc_uint128_bitwise_and_inplace (sc_uint128_t * a, const sc_uint128_t * b);
```
"""
function sc_uint128_bitwise_and_inplace(a, b)
    @ccall libp4est.sc_uint128_bitwise_and_inplace(a::Ptr{sc_uint128_t}, b::Ptr{sc_uint128_t})::Cvoid
end

"""A datatype to handle the linear id in 3D. We use the implementation of unsigned 128 bit integer in libsc, i.e., a struct with the members high\\_bits and low\\_bits (both uint64\\_t)."""
const p8est_lid_t = sc_uint128_t

# typedef void ( * p8est_replace_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , int num_outgoing , p8est_quadrant_t * outgoing [ ] , int num_incoming , p8est_quadrant_t * incoming [ ] )
"""
Callback function prototype to replace one set of quadrants with another.

This is used by extended routines when the quadrants of an existing, valid [`p8est`](@ref) are changed. The callback allows the user to make changes to newly initialized quadrants before the quadrants that they replace are destroyed.

If the mesh is being refined, num\\_outgoing will be 1 and num\\_incoming will be 8, and vice versa if the mesh is being coarsened.

### Parameters
* `num_outgoing`:\\[in\\] The number of outgoing quadrants.
* `outgoing`:\\[in\\] The outgoing quadrants: after the callback, the user\\_data, if [`p8est`](@ref)->data_size is nonzero, will be destroyed.
* `num_incoming`:\\[in\\] The number of incoming quadrants.
* `incoming`:\\[in,out\\] The incoming quadrants: prior to the callback, the user\\_data, if [`p8est`](@ref)->data_size is nonzero, is allocated, and the [`p8est_init_t`](@ref) callback, if it has been provided, will be called.
"""
const p8est_replace_t = Ptr{Cvoid}

"""
    p8est_lid_compare(a, b)

Compare the [`p8est_lid_t`](@ref) *a* and the [`p8est_lid_t`](@ref) *b*.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Returns
Returns -1 if a < b, 1 if a > b and 0 if a == b.
### Prototype
```c
int p8est_lid_compare (const p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_compare(a, b)
    @ccall libp4est.p8est_lid_compare(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cint
end

"""
    p8est_lid_is_equal(a, b)

Checks if the [`p8est_lid_t`](@ref) *a* and the [`p8est_lid_t`](@ref) *b* are equal.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Returns
Returns a true value if *a* and *b* are equal, false otherwise
### Prototype
```c
int p8est_lid_is_equal (const p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_is_equal(a, b)
    @ccall libp4est.p8est_lid_is_equal(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cint
end

"""
    p8est_lid_init(input, high, low)

Initializes a linear index to a given value.

### Parameters
* `a`:\\[in,out\\] A pointer to the [`p8est_lid_t`](@ref) that will be initialized.
* `high`:\\[in\\] The given high bits to intialize *a*.
* `low`:\\[in\\] The given low bits to initialize *a*.
### Prototype
```c
void p8est_lid_init (p8est_lid_t * input, uint64_t high, uint64_t low);
```
"""
function p8est_lid_init(input, high, low)
    @ccall libp4est.p8est_lid_init(input::Ptr{p8est_lid_t}, high::UInt64, low::UInt64)::Cvoid
end

"""
    p8est_lid_set_zero(input)

Initializes a linear index to zero.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p8est_lid_set_zero (p8est_lid_t * input);
```
"""
function p8est_lid_set_zero(input)
    @ccall libp4est.p8est_lid_set_zero(input::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_set_one(input)

Initializes a linear index to one.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p8est_lid_set_one (p8est_lid_t * input);
```
"""
function p8est_lid_set_one(input)
    @ccall libp4est.p8est_lid_set_one(input::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_set_uint64(input, u)

Initializes a linear index to an unsigned 64 bit integer.

### Parameters
* `input`:\\[out\\] A pointer to a [`p4est_lid_t`](@ref) that will be intialized.
### Prototype
```c
void p8est_lid_set_uint64 (p8est_lid_t * input, uint64_t u);
```
"""
function p8est_lid_set_uint64(input, u)
    @ccall libp4est.p8est_lid_set_uint64(input::Ptr{p8est_lid_t}, u::UInt64)::Cvoid
end

"""
    p8est_lid_chk_bit(input, bit_number)

Returns the bit\\_number-th bit of *input*. This function checks a bit of an existing, initialized value.

### Parameters
* `input`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `bit_number`:\\[in\\] The bit (counted from the right hand side) that is checked by logical and. Require 0 <= *bit_number* < 128.
### Returns
True if bit is set, false if not.
### Prototype
```c
int p8est_lid_chk_bit (const p8est_lid_t * input, int bit_number);
```
"""
function p8est_lid_chk_bit(input, bit_number)
    @ccall libp4est.p8est_lid_chk_bit(input::Ptr{p8est_lid_t}, bit_number::Cint)::Cint
end

"""
    p8est_lid_set_bit(input, bit_number)

Sets the exponent-th bit of *input* to one. This function modifies an existing, initialized value.

### Parameters
* `input`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref).
* `bit_number`:\\[in\\] The bit (counted from the right hand side) that is set to one by logical or. Require 0 <= *bit_number* < 128.
### Prototype
```c
void p8est_lid_set_bit (p8est_lid_t * input, int bit_number);
```
"""
function p8est_lid_set_bit(input, bit_number)
    @ccall libp4est.p8est_lid_set_bit(input::Ptr{p8est_lid_t}, bit_number::Cint)::Cvoid
end

"""
    p8est_lid_copy(input, output)

Copies an initialized [`p8est_lid_t`](@ref) to a [`p8est_lid_t`](@ref).

### Parameters
* `input`:\\[in\\] A pointer to the [`sc_uint128`](@ref) that is copied.
* `output`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). The high and low bits of *output* will be set to the high and low bits of *input*, respectively.
### Prototype
```c
void p8est_lid_copy (const p8est_lid_t * input, p8est_lid_t * output);
```
"""
function p8est_lid_copy(input, output)
    @ccall libp4est.p8est_lid_copy(input::Ptr{p8est_lid_t}, output::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_add(a, b, result)

Adds the uint128\\_t *b* to the uint128\\_t *a*. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p8est_lid_t`](@ref). The sum *a* + *b* will be saved in *result*.
### Prototype
```c
void p8est_lid_add (const p8est_lid_t * a, const p8est_lid_t * b, p8est_lid_t * result);
```
"""
function p8est_lid_add(a, b, result)
    @ccall libp4est.p8est_lid_add(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_sub(a, b, result)

Substracts the [`p8est_lid_t`](@ref) *b* from the [`p8est_lid_t`](@ref) *a*. This function assumes that the result is >= 0. *result* == *a* or *result* == *b* is not allowed. *a* == *b* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p8est_lid_t`](@ref). The difference *a* - *b* will be saved in *result*.
### Prototype
```c
void p8est_lid_sub (const p8est_lid_t * a, const p8est_lid_t * b, p8est_lid_t * result);
```
"""
function p8est_lid_sub(a, b, result)
    @ccall libp4est.p8est_lid_sub(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_bitwise_neg(a, result)

Calculates the bitwise negation of the uint128\\_t *a*. *a* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p8est_lid_t`](@ref). The bitwise negation of *a* will be saved in *result*.
### Prototype
```c
void p8est_lid_bitwise_neg (const p8est_lid_t * a, p8est_lid_t * result);
```
"""
function p8est_lid_bitwise_neg(a, result)
    @ccall libp4est.p8est_lid_bitwise_neg(a::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_bitwise_or(a, b, result)

Calculates the bitwise or of the uint128\\_t *a* and *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p8est_lid_t`](@ref). The bitwise or of *a* and *b* will be saved in *result*.
### Prototype
```c
void p8est_lid_bitwise_or (const p8est_lid_t * a, const p8est_lid_t * b, p8est_lid_t * result);
```
"""
function p8est_lid_bitwise_or(a, b, result)
    @ccall libp4est.p8est_lid_bitwise_or(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_bitwise_and(a, b, result)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *result* is allowed. Furthermore, *a* == *result* and/or *b* == *result* is allowed.

### Parameters
* `a`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `result`:\\[out\\] A pointer to a [`p8est_lid_t`](@ref). The bitwise and of *a* and *b* will be saved. in *result*.
### Prototype
```c
void p8est_lid_bitwise_and (const p8est_lid_t * a, const p8est_lid_t * b, p8est_lid_t * result);
```
"""
function p8est_lid_bitwise_and(a, b, result)
    @ccall libp4est.p8est_lid_bitwise_and(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t}, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_shift_right(input, shift_count, result)

Calculates the bit right shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the left. If *shift_count* >= 128, *result* is 0. All bits right from the zeroth bit (counted from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). The right shifted number will be saved in *result*.
### Prototype
```c
void p8est_lid_shift_right (const p8est_lid_t * input, unsigned shift_count, p8est_lid_t * result);
```
"""
function p8est_lid_shift_right(input, shift_count, result)
    @ccall libp4est.p8est_lid_shift_right(input::Ptr{p8est_lid_t}, shift_count::Cuint, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_shift_left(input, shift_count, result)

Calculates the bit left shift of uint128\\_t *input* by shift\\_count bits. We shift in zeros from the right. If *shift_count* >= 128, *result* is 0. All bits left from the 127th bit (counted zero based from the right hand side) drop out. *input* == *result* is allowed.

### Parameters
* `input`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
* `shift_count`:\\[in\\] Bits to shift. *shift_count* >= 0.
* `result`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). The left shifted number will be saved in *result*.
### Prototype
```c
void p8est_lid_shift_left (const p8est_lid_t * input, unsigned shift_count, p8est_lid_t * result);
```
"""
function p8est_lid_shift_left(input, shift_count, result)
    @ccall libp4est.p8est_lid_shift_left(input::Ptr{p8est_lid_t}, shift_count::Cuint, result::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_add_inplace(a, b)

Adds the [`p8est_lid_t`](@ref) *b* to the [`p8est_lid_t`](@ref) *a*. The result is saved in *a*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). *a* will be overwritten by *a* + *b*.
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Prototype
```c
void p8est_lid_add_inplace (p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_add_inplace(a, b)
    @ccall libp4est.p8est_lid_add_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_sub_inplace(a, b)

Substracts the uint128\\_t *b* from the uint128\\_t *a*. The result is saved in *a*. *a* == *b* is allowed. This function assumes that the result is >= 0.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). *a* will be overwritten by *a* - *b*.
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Prototype
```c
void p8est_lid_sub_inplace (p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_sub_inplace(a, b)
    @ccall libp4est.p8est_lid_sub_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_bitwise_or_inplace(a, b)

Calculates the bitwise or of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). The bitwise or will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Prototype
```c
void p8est_lid_bitwise_or_inplace (p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_bitwise_or_inplace(a, b)
    @ccall libp4est.p8est_lid_bitwise_or_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_lid_bitwise_and_inplace(a, b)

Calculates the bitwise and of the uint128\\_t *a* and the uint128\\_t *b*. *a* == *b* is allowed.

### Parameters
* `a`:\\[in,out\\] A pointer to a [`p8est_lid_t`](@ref). The bitwise and will be saved in *a*.
* `b`:\\[in\\] A pointer to a [`p8est_lid_t`](@ref).
### Prototype
```c
void p8est_lid_bitwise_and_inplace (p8est_lid_t * a, const p8est_lid_t * b);
```
"""
function p8est_lid_bitwise_and_inplace(a, b)
    @ccall libp4est.p8est_lid_bitwise_and_inplace(a::Ptr{p8est_lid_t}, b::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_quadrant_linear_id_ext128(quadrant, level, id)

Computes the linear position as [`p8est_lid_t`](@ref) of a quadrant in a uniform grid. The grid and quadrant levels need not coincide. If they do, this is the inverse of p4est_quadrant_set_morton.

!!! note

    The user\\_data of *quadrant* is never modified.

### Parameters
* `quadrant`:\\[in\\] Quadrant whose linear index will be computed. If the quadrant is smaller than the grid (has a higher quadrant->level), the result is computed from its ancestor at the grid's level. If the quadrant has a smaller level than the grid (it is bigger than a grid cell), the grid cell sharing its lower left corner is used as reference.
* `level`:\\[in\\] The level of the regular grid compared to which the linear position is to be computed.
* `id`:\\[in,out\\] A pointer to an allocated or static [`p8est_lid_t`](@ref). id will be the linear position of this quadrant on a uniform grid.
### Prototype
```c
void p8est_quadrant_linear_id_ext128 (const p8est_quadrant_t * quadrant, int level, p8est_lid_t * id);
```
"""
function p8est_quadrant_linear_id_ext128(quadrant, level, id)
    @ccall libp4est.p8est_quadrant_linear_id_ext128(quadrant::Ptr{p8est_quadrant_t}, level::Cint, id::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_quadrant_set_morton_ext128(quadrant, level, id)

Set quadrant Morton indices based on linear position given as [`p8est_lid_t`](@ref) in uniform grid. This is the inverse operation of p4est_quadrant_linear_id.

!!! note

    The user\\_data of *quadrant* is never modified.

### Parameters
* `quadrant`:\\[in,out\\] Quadrant whose Morton indices will be set.
* `level`:\\[in\\] Level of the grid and of the resulting quadrant.
* `id`:\\[in\\] Linear index of the quadrant on a uniform grid.
### Prototype
```c
void p8est_quadrant_set_morton_ext128 (p8est_quadrant_t * quadrant, int level, const p8est_lid_t * id);
```
"""
function p8est_quadrant_set_morton_ext128(quadrant, level, id)
    @ccall libp4est.p8est_quadrant_set_morton_ext128(quadrant::Ptr{p8est_quadrant_t}, level::Cint, id::Ptr{p8est_lid_t})::Cvoid
end

"""
    p8est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)

### Prototype
```c
p8est_t *p8est_new_ext (sc_MPI_Comm mpicomm, p8est_connectivity_t * connectivity, p4est_locidx_t min_quadrants, int min_level, int fill_uniform, size_t data_size, p8est_init_t init_fn, void *user_pointer);
```
"""
function p8est_new_ext(mpicomm, connectivity, min_quadrants, min_level, fill_uniform, data_size, init_fn, user_pointer)
    @ccall libp4est.p8est_new_ext(mpicomm::MPI_Comm, connectivity::Ptr{p8est_connectivity_t}, min_quadrants::p4est_locidx_t, min_level::Cint, fill_uniform::Cint, data_size::Csize_t, init_fn::p8est_init_t, user_pointer::Ptr{Cvoid})::Ptr{p8est_t}
end

"""
    p8est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)

Create a new mesh.

### Parameters
* `p8est`:\\[in\\] A forest that is fully 2:1 balanced.
* `ghost`:\\[in\\] The ghost layer created from the provided [`p4est`](@ref).
* `compute_tree_index`:\\[in\\] Boolean to decide whether to allocate and compute the quad\\_to\\_tree list.
* `compute_level_lists`:\\[in\\] Boolean to decide whether to compute the level lists in quad\\_level.
* `btype`:\\[in\\] Currently ignored, only face neighbors are stored.
### Returns
A fully allocated mesh structure.
### Prototype
```c
p8est_mesh_t *p8est_mesh_new_ext (p8est_t * p4est, p8est_ghost_t * ghost, int compute_tree_index, int compute_level_lists, p8est_connect_type_t btype);
```
"""
function p8est_mesh_new_ext(p4est_, ghost, compute_tree_index, compute_level_lists, btype)
    @ccall libp4est.p8est_mesh_new_ext(p4est_::Ptr{p8est_t}, ghost::Ptr{p8est_ghost_t}, compute_tree_index::Cint, compute_level_lists::Cint, btype::p8est_connect_type_t)::Ptr{p8est_mesh_t}
end

"""
    p8est_copy_ext(input, copy_data, duplicate_mpicomm)

Make a deep copy of a [`p8est`](@ref). The connectivity is not duplicated. Copying of quadrant user data is optional. If old and new data sizes are 0, the user\\_data field is copied regardless. The inspect member of the copy is set to NULL. The revision counter of the copy is set to zero.

### Parameters
* `copy_data`:\\[in\\] If true, data are copied. If false, data\\_size is set to 0.
* `duplicate_mpicomm`:\\[in\\] If true, MPI communicator is copied.
### Returns
Returns a valid [`p8est`](@ref) that does not depend on the input, except for borrowing the same connectivity. Its revision counter is 0.
### Prototype
```c
p8est_t *p8est_copy_ext (p8est_t * input, int copy_data, int duplicate_mpicomm);
```
"""
function p8est_copy_ext(input, copy_data, duplicate_mpicomm)
    @ccall libp4est.p8est_copy_ext(input::Ptr{p8est_t}, copy_data::Cint, duplicate_mpicomm::MPI_Comm)::Ptr{p8est_t}
end

"""
    p8est_refine_ext(p8est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)

Refine a forest with a bounded refinement level and a replace option.

### Parameters
* `p8est`:\\[in,out\\] The forest is changed in place.
* `refine_recursive`:\\[in\\] Boolean to decide on recursive refinement.
* `maxlevel`:\\[in\\] Maximum allowed refinement level (inclusive). If this is negative the level is restricted only by the compile-time constant QMAXLEVEL in [`p8est`](@ref).h.
* `refine_fn`:\\[in\\] Callback function that must return true if a quadrant shall be refined. If refine\\_recursive is true, refine\\_fn is called for every existing and newly created quadrant. Otherwise, it is called for every existing quadrant. It is possible that a refinement request made by the callback is ignored. To catch this case, you can examine whether init\\_fn or replace\\_fn gets called.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data for newly created quadrants, which is guaranteed to be allocated. This function pointer may be NULL.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace; may be NULL.
### Prototype
```c
void p8est_refine_ext (p8est_t * p8est, int refine_recursive, int maxlevel, p8est_refine_t refine_fn, p8est_init_t init_fn, p8est_replace_t replace_fn);
```
"""
function p8est_refine_ext(p8est_, refine_recursive, maxlevel, refine_fn, init_fn, replace_fn)
    @ccall libp4est.p8est_refine_ext(p8est_::Ptr{p8est_t}, refine_recursive::Cint, maxlevel::Cint, refine_fn::p8est_refine_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

"""
    p8est_coarsen_ext(p8est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)

Coarsen a forest.

### Parameters
* `p8est`:\\[in,out\\] The forest is changed in place.
* `coarsen_recursive`:\\[in\\] Boolean to decide on recursive coarsening.
* `callback_orphans`:\\[in\\] Boolean to enable calling coarsen\\_fn even on non-families. In this case, the second quadrant pointer in the argument list of the callback is NULL, subsequent pointers are undefined, and the return value is ignored. If coarsen\\_recursive is true, it is possible that a quadrant is called once or more as an orphan and eventually becomes part of a family. With coarsen\\_recursive false and callback\\_orphans true, it is guaranteed that every quadrant is passed exactly once into the coarsen\\_fn callback.
* `coarsen_fn`:\\[in\\] Callback function that returns true if a family of quadrants shall be coarsened.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p8est_coarsen_ext (p8est_t * p8est, int coarsen_recursive, int callback_orphans, p8est_coarsen_t coarsen_fn, p8est_init_t init_fn, p8est_replace_t replace_fn);
```
"""
function p8est_coarsen_ext(p8est_, coarsen_recursive, callback_orphans, coarsen_fn, init_fn, replace_fn)
    @ccall libp4est.p8est_coarsen_ext(p8est_::Ptr{p8est_t}, coarsen_recursive::Cint, callback_orphans::Cint, coarsen_fn::p8est_coarsen_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

"""
    p8est_balance_ext(p8est_, btype, init_fn, replace_fn)

2:1 balance the size differences of neighboring elements in a forest.

### Parameters
* `p8est`:\\[in,out\\] The [`p8est`](@ref) to be worked on.
* `btype`:\\[in\\] Balance type (face, edge, or corner/full). Corner balance is almost never required when discretizing a PDE; just causes smoother mesh grading.
* `init_fn`:\\[in\\] Callback function to initialize the user\\_data which is already allocated automatically.
* `replace_fn`:\\[in\\] Callback function that allows the user to change incoming quadrants based on the quadrants they replace.
### Prototype
```c
void p8est_balance_ext (p8est_t * p8est, p8est_connect_type_t btype, p8est_init_t init_fn, p8est_replace_t replace_fn);
```
"""
function p8est_balance_ext(p8est_, btype, init_fn, replace_fn)
    @ccall libp4est.p8est_balance_ext(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

"""
    p8est_balance_subtree_ext(p8est_, btype, which_tree, init_fn, replace_fn)

### Prototype
```c
void p8est_balance_subtree_ext (p8est_t * p8est, p8est_connect_type_t btype, p4est_topidx_t which_tree, p8est_init_t init_fn, p8est_replace_t replace_fn);
```
"""
function p8est_balance_subtree_ext(p8est_, btype, which_tree, init_fn, replace_fn)
    @ccall libp4est.p8est_balance_subtree_ext(p8est_::Ptr{p8est_t}, btype::p8est_connect_type_t, which_tree::p4est_topidx_t, init_fn::p8est_init_t, replace_fn::p8est_replace_t)::Cvoid
end

"""
    p8est_partition_ext(p8est_, partition_for_coarsening, weight_fn)

Repartition the forest.

The forest is partitioned between processors such that each processor has an approximately equal number of quadrants (or weight).

### Parameters
* `p8est`:\\[in,out\\] The forest that will be partitioned.
* `partition_for_coarsening`:\\[in\\] If true, the partition is modified to allow one level of coarsening.
* `weight_fn`:\\[in\\] A weighting function or NULL for uniform partitioning. A weighting function with constant weight 1 on each quadrant is equivalent to weight\\_fn == NULL but other constant weightings may result in different uniform partitionings.
### Returns
The global number of shipped quadrants
### Prototype
```c
p4est_gloidx_t p8est_partition_ext (p8est_t * p8est, int partition_for_coarsening, p8est_weight_t weight_fn);
```
"""
function p8est_partition_ext(p8est_, partition_for_coarsening, weight_fn)
    @ccall libp4est.p8est_partition_ext(p8est_::Ptr{p8est_t}, partition_for_coarsening::Cint, weight_fn::p8est_weight_t)::p4est_gloidx_t
end

"""
    p8est_partition_for_coarsening(p8est_, num_quadrants_in_proc)

Correct partition to allow one level of coarsening.

### Parameters
* `p8est`:\\[in\\] forest whose partition is corrected
* `num_quadrants_in_proc`:\\[in,out\\] partition that will be corrected
### Returns
absolute number of moved quadrants
### Prototype
```c
p4est_gloidx_t p8est_partition_for_coarsening (p8est_t * p8est, p4est_locidx_t * num_quadrants_in_proc);
```
"""
function p8est_partition_for_coarsening(p8est_, num_quadrants_in_proc)
    @ccall libp4est.p8est_partition_for_coarsening(p8est_::Ptr{p8est_t}, num_quadrants_in_proc::Ptr{p4est_locidx_t})::p4est_gloidx_t
end

"""
    p8est_iterate_ext(p8est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner, remote)

[`p8est_iterate_ext`](@ref) adds the option *remote*: if this is false, then it is the same as [`p8est_iterate`](@ref); if this is true, then corner/edge callbacks are also called on corners/edges for hanging faces/edges touched by local quadrants.

### Prototype
```c
void p8est_iterate_ext (p8est_t * p8est, p8est_ghost_t * ghost_layer, void *user_data, p8est_iter_volume_t iter_volume, p8est_iter_face_t iter_face, p8est_iter_edge_t iter_edge, p8est_iter_corner_t iter_corner, int remote);
```
"""
function p8est_iterate_ext(p8est_, ghost_layer, user_data, iter_volume, iter_face, iter_edge, iter_corner, remote)
    @ccall libp4est.p8est_iterate_ext(p8est_::Ptr{p8est_t}, ghost_layer::Ptr{p8est_ghost_t}, user_data::Ptr{Cvoid}, iter_volume::p8est_iter_volume_t, iter_face::p8est_iter_face_t, iter_edge::p8est_iter_edge_t, iter_corner::p8est_iter_corner_t, remote::Cint)::Cvoid
end

"""
    p8est_save_ext(filename, p8est_, save_data, save_partition)

Save the complete connectivity/[`p8est`](@ref) data to disk. This is a collective operation that all MPI processes need to call. All processes write into the same file, so the filename given needs to be identical over all parallel invocations. See [`p8est_load_ext`](@ref) for information on the autopartition parameter.

!!! note

    Aborts on file errors.

### Parameters
* `filename`:\\[in\\] Name of the file to write.
* `p8est`:\\[in\\] Valid forest structure.
* `save_data`:\\[in\\] If true, the element data is saved. Otherwise, a data size of 0 is saved.
* `save_partition`:\\[in\\] If false, save file as if 1 core was used. If true, save core count and partition. Advantage: Partition can be recovered on loading with same mpisize and autopartition false. Disadvantage: Makes the file depend on mpisize. Either way the file can be loaded with autopartition true.
### Prototype
```c
void p8est_save_ext (const char *filename, p8est_t * p8est, int save_data, int save_partition);
```
"""
function p8est_save_ext(filename, p8est_, save_data, save_partition)
    @ccall libp4est.p8est_save_ext(filename::Cstring, p8est_::Ptr{p8est_t}, save_data::Cint, save_partition::Cint)::Cvoid
end

"""
    p8est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)

### Prototype
```c
p8est_t *p8est_load_ext (const char *filename, sc_MPI_Comm mpicomm, size_t data_size, int load_data, int autopartition, int broadcasthead, void *user_pointer, p8est_connectivity_t ** connectivity);
```
"""
function p8est_load_ext(filename, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p8est_load_ext(filename::Cstring, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

"""
    p8est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)

### Prototype
```c
p8est_t *p8est_source_ext (sc_io_source_t * src, sc_MPI_Comm mpicomm, size_t data_size, int load_data, int autopartition, int broadcasthead, void *user_pointer, p8est_connectivity_t ** connectivity);
```
"""
function p8est_source_ext(src, mpicomm, data_size, load_data, autopartition, broadcasthead, user_pointer, connectivity)
    @ccall libp4est.p8est_source_ext(src::Ptr{sc_io_source_t}, mpicomm::MPI_Comm, data_size::Csize_t, load_data::Cint, autopartition::Cint, broadcasthead::Cint, user_pointer::Ptr{Cvoid}, connectivity::Ptr{Ptr{p8est_connectivity_t}})::Ptr{p8est_t}
end

"""
    p8est_get_plex_data_ext(p8est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)

Create the data necessary to create a PETsc DMPLEX representation of a forest, as well as the accompanying lnodes and ghost layer. The forest must be at least face balanced (see [`p4est_balance`](@ref)()). See test/test\\_plex2.c for example usage.

All arrays should be initialized to hold sizeof ([`p4est_locidx_t`](@ref)), except for *out_remotes*, which should be initialized to hold (2 * sizeof ([`p4est_locidx_t`](@ref))).

### Parameters
* `p8est`:\\[in\\] the forest
* `ghost`:\\[out\\] the ghost layer
* `lnodes`:\\[out\\] the lnodes
* `ctype`:\\[in\\] the type of adjacency for the overlap
* `overlap`:\\[in\\] the number of layers of overlap (zero is acceptable)
* `first_local_quad`:\\[out\\] the local quadrants are assigned contiguous plex indices, starting with this index
* `out_points_per_dim`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cone_sizes`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cones`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_cone_orientations`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_vertex_coords`:\\[in,out\\] filled with argument for DMPlexCreateFromDAG()
* `out_children`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_parents`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_childids`:\\[in,out\\] filled with argument for DMPlexSetTree()
* `out_leaves`:\\[in,out\\] filled with argument for PetscSFSetGraph()
* `out_remotes`:\\[in,out\\] filled with argument for PetscSFSetGraph()
* `custom_numbering`:\\[in\\] Whether or use the default numbering (0) of DMPlex child ids or the custom (1).
### Prototype
```c
void p8est_get_plex_data_ext (p8est_t * p8est, p8est_ghost_t ** ghost, p8est_lnodes_t ** lnodes, p8est_connect_type_t ctype, int overlap, p4est_locidx_t * first_local_quad, sc_array_t * out_points_per_dim, sc_array_t * out_cone_sizes, sc_array_t * out_cones, sc_array_t * out_cone_orientations, sc_array_t * out_vertex_coords, sc_array_t * out_children, sc_array_t * out_parents, sc_array_t * out_childids, sc_array_t * out_leaves, sc_array_t * out_remotes, int custom_numbering);
```
"""
function p8est_get_plex_data_ext(p8est_, ghost, lnodes, ctype, overlap, first_local_quad, out_points_per_dim, out_cone_sizes, out_cones, out_cone_orientations, out_vertex_coords, out_children, out_parents, out_childids, out_leaves, out_remotes, custom_numbering)
    @ccall libp4est.p8est_get_plex_data_ext(p8est_::Ptr{p8est_t}, ghost::Ptr{Ptr{p8est_ghost_t}}, lnodes::Ptr{Ptr{p8est_lnodes_t}}, ctype::p8est_connect_type_t, overlap::Cint, first_local_quad::Ptr{p4est_locidx_t}, out_points_per_dim::Ptr{sc_array_t}, out_cone_sizes::Ptr{sc_array_t}, out_cones::Ptr{sc_array_t}, out_cone_orientations::Ptr{sc_array_t}, out_vertex_coords::Ptr{sc_array_t}, out_children::Ptr{sc_array_t}, out_parents::Ptr{sc_array_t}, out_childids::Ptr{sc_array_t}, out_leaves::Ptr{sc_array_t}, out_remotes::Ptr{sc_array_t}, custom_numbering::Cint)::Cvoid
end

"""
    p8est_find_partition(num_procs, search_in, my_begin, my_end, _begin, _end)

Binary search in partition array. Given two targets *my_begin* and *my_end*, find offsets such that `search\\_in[begin] >= my\\_begin`, `my\\_end <= search\\_in[end]`. If more than one index satisfies the conditions, then the minimal index is the result. If there is no index that satisfies the conditions, then *begin* and *end* are tried to set equal such that `search\\_in[begin] >= my\\_end`. If *my_begin* is less or equal than the smallest value of *search_in* *begin* is set to 0 and if *my_end* is bigger or equal than the largest value of *search_in* *end* is set to *num_procs* - 1. If none of the above conditions is satisfied, the output is not well defined. We require `my\\_begin <= my\\_begin'.

### Parameters
* `num_procs`:\\[in\\] Number of processes to get the length of *search_in*.
* `search_in`:\\[in\\] The sorted array (ascending) in that the function will search. If `k` indexes search\\_in, then `0 <= k < num\\_procs`.
* `my_begin`:\\[in\\] The first target that defines the start of the search window.
* `my_end`:\\[in\\] The second target that defines the end of the search window.
* `begin`:\\[in,out\\] The first offset such that `search\\_in[begin] >= my\\_begin`.
* `end`:\\[in,out\\] The second offset such that `my\\_end <= search\\_in[end]`.
### Prototype
```c
void p8est_find_partition (const int num_procs, p4est_gloidx_t * search_in, p4est_gloidx_t my_begin, p4est_gloidx_t my_end, p4est_gloidx_t * begin, p4est_gloidx_t * end);
```
"""
function p8est_find_partition(num_procs, search_in, my_begin, my_end, _begin, _end)
    @ccall libp4est.p8est_find_partition(num_procs::Cint, search_in::Ptr{p4est_gloidx_t}, my_begin::p4est_gloidx_t, my_end::p4est_gloidx_t, _begin::Ptr{p4est_gloidx_t}, _end::Ptr{p4est_gloidx_t})::Cvoid
end

"""
    p8est_find_lower_bound(array, q, guess)

Find the lowest position tq in a quadrant array such that tq >= q.

### Returns
Returns the id of the matching quadrant or -1 if array < q or the array is empty.
### Prototype
```c
ssize_t p8est_find_lower_bound (sc_array_t * array, const p8est_quadrant_t * q, size_t guess);
```
"""
function p8est_find_lower_bound(array, q, guess)
    @ccall libp4est.p8est_find_lower_bound(array::Ptr{sc_array_t}, q::Ptr{p8est_quadrant_t}, guess::Csize_t)::Cssize_t
end

"""
    p8est_find_higher_bound(array, q, guess)

Find the highest position tq in a quadrant array such that tq <= q.

### Returns
Returns the id of the matching quadrant or -1 if array > q or the array is empty.
### Prototype
```c
ssize_t p8est_find_higher_bound (sc_array_t * array, const p8est_quadrant_t * q, size_t guess);
```
"""
function p8est_find_higher_bound(array, q, guess)
    @ccall libp4est.p8est_find_higher_bound(array::Ptr{sc_array_t}, q::Ptr{p8est_quadrant_t}, guess::Csize_t)::Cssize_t
end

"""
    p8est_find_quadrant_cumulative(p8est_, cumulative_id, which_tree, quadrant_id)

Search a local quadrant by its cumulative number in the forest.

We perform a binary search over the processor-local trees, which means that it is advisable NOT to use this function if possible, and to try to maintain O(1) tree context information in the calling code.

### Parameters
* `p8est`:\\[in\\] Forest to be worked with.
* `cumulative_id`:\\[in\\] Cumulative index over all trees of quadrant.
* `which_tree`:\\[in,out\\] If not NULL, the input value can be -1 or an initial guess for the quadrant's tree. An initial guess must be the index of a nonempty local tree. Output is the tree of returned quadrant.
* `quadrant_id`:\\[out\\] If not NULL, the number of quadrant in tree.
### Returns
The identified quadrant.
### Prototype
```c
p8est_quadrant_t *p8est_find_quadrant_cumulative (p8est_t * p8est, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id);
```
"""
function p8est_find_quadrant_cumulative(p8est_, cumulative_id, which_tree, quadrant_id)
    @ccall libp4est.p8est_find_quadrant_cumulative(p8est_::Ptr{p8est_t}, cumulative_id::p4est_locidx_t, which_tree::Ptr{p4est_topidx_t}, quadrant_id::Ptr{p4est_locidx_t})::Ptr{p8est_quadrant_t}
end

"""
    p8est_split_array(array, level, indices)

Split an array of quadrants by the children of an ancestor.

Given a sorted **array** of quadrants that have a common ancestor at level **level**, compute the **indices** of the first quadrant in each of the common ancestor's children at level **level** + 1.

### Parameters
* `array`:\\[in\\] The sorted array of quadrants of level > **level**.
* `level`:\\[in\\] The level at which there is a common ancestor.
* `indices`:\\[in,out\\] The indices of the first quadrant in each of the ancestors's children, plus an additional index on the end. The quadrants of **array** that are descendants of child i have indices between indices[i] and indices[i + 1] - 1. If indices[i] = indices[i+1], this indicates that no quadrant in the array is contained in child i.
### Prototype
```c
void p8est_split_array (sc_array_t * array, int level, size_t indices[]);
```
"""
function p8est_split_array(array, level, indices)
    @ccall libp4est.p8est_split_array(array::Ptr{sc_array_t}, level::Cint, indices::Ptr{Csize_t})::Cvoid
end

"""
    p8est_find_range_boundaries(lq, uq, level, faces, edges, corners)

Find the boundary points touched by a range of quadrants.

Given two smallest quadrants, **lq** and **uq**, that mark the first and the last quadrant in a range of quadrants, determine which portions of the tree boundary the range touches.

### Parameters
* `lq`:\\[in\\] The smallest quadrant at the start of the range: if NULL, the tree's first quadrant is taken to be the start of the range.
* `uq`:\\[in\\] The smallest quadrant at the end of the range: if NULL, the tree's last quadrant is taken to be the end of the range.
* `level`:\\[in\\] The level of the containing quadrant whose boundaries are tested: 0 if we want to test the boundaries of the whole tree.
* `faces`:\\[in,out\\] An array of size 6 that is filled: faces[i] is true if the range touches that face.
* `edges`:\\[in,out\\] An array of size 12 that is filled: edges[i] is true if the range touches that edge.
* `corners`:\\[in,out\\] An array of size 8 that is filled: corners[i] is true if the range touches that corner. **faces**, **edges** or **corners** may be NULL.
### Returns
Returns an int32\\_t encoded with the same information in **faces**, **edges** and **corners**: the first (least) six bits represent the six faces, the next twelve bits represent the twelve edges, the next eight bits represent the eight corners.
### Prototype
```c
int32_t p8est_find_range_boundaries (p8est_quadrant_t * lq, p8est_quadrant_t * uq, int level, int faces[], int edges[], int corners[]);
```
"""
function p8est_find_range_boundaries(lq, uq, level, faces, edges, corners)
    @ccall libp4est.p8est_find_range_boundaries(lq::Ptr{p8est_quadrant_t}, uq::Ptr{p8est_quadrant_t}, level::Cint, faces::Ptr{Cint}, edges::Ptr{Cint}, corners::Ptr{Cint})::Int32
end

# typedef int ( * p8est_search_local_t ) ( p8est_t * p4est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant , p4est_locidx_t local_num , void * point )
"""
Callback function to query the match of a "point" with a quadrant.

This function can be called in two roles: Per-quadrant, in which case the parameter **point** is NULL, or per-point, possibly many times per quadrant.

### Parameters
* `p4est`:\\[in\\] The forest to be queried.
* `which_tree`:\\[in\\] The tree id under consideration.
* `quadrant`:\\[in\\] The quadrant under consideration. This quadrant may be coarser than the quadrants that are contained in the forest (an ancestor), in which case it is a temporary variable and not part of the forest storage. Otherwise, it is a leaf and points directly into the forest storage.
* `local_num`:\\[in\\] If the quadrant is not a leaf, this is < 0. Otherwise it is the (non-negative) index of the quadrant relative to the processor-local storage.
* `point`:\\[in\\] Representation of a "point"; user-defined. If **point** is NULL, the callback may be used to prepare quadrant-related search meta data.
### Returns
If **point** is NULL, true if the search confined to **quadrant** should be executed, false to skip it. Else, true if point may be contained in the quadrant and false otherwise; the return value has no effect on a leaf.
"""
const p8est_search_local_t = Ptr{Cvoid}

"""This typedef is provided for backwards compatibility."""
const p8est_search_query_t = p8est_search_local_t

"""
    p8est_search_local(p4est_, call_post, quadrant_fn, point_fn, points)

Search through the local part of a forest. The search is especially efficient if multiple targets, called "points" below, are searched for simultaneously.

The search runs over all local quadrants and proceeds recursively top-down. For each tree, it may start at the root of that tree, or further down at the root of the subtree that contains all of the tree's local quadrants. Likewise, some intermediate levels in the recursion may be skipped if the processor-local part is contained in a single deeper subtree. The outer loop is thus a depth-first, processor-local forest traversal. Each quadrant in that loop either is a leaf, or a (direct or indirect) strict ancestor of a leaf. On entering a new quadrant, a user-provided quadrant-callback is executed.

As a convenience, the user may provide anonymous "points" that are tracked down the forest. This way one search call may be used for multiple targets. The set of points that potentially matches a given quadrant diminishes from the root down to the leaves: For each quadrant, an inner loop over the potentially matching points executes a point-callback for each candidate that determines whether the point may be a match. If not, it is discarded in the current branch, otherwise it is passed to the next deeper level. The callback is allowed to return true for the same point and more than one quadrant; in this case more than one matching quadrant may be identified. The callback is also allowed to return false for all children of a quadrant that it returned true for earlier. If the point callback returns false for all points relevant to a quadrant, the recursion stops. The points can really be anything, [`p4est`](@ref) does not perform any interpretation, just passes the pointer along to the callback function.

If points are present and the first quadrant callback returned true, we execute it a second time after calling the point callback for all current points. This can be used to gather and postprocess information about the points more easily. If it returns false, the recursion stops.

If the points are a NULL array, they are ignored and the recursion proceeds by querying the per-quadrant callback. If the points are not NULL but an empty array, the recursion will stop immediately!

### Parameters
* `p4est`:\\[in\\] The forest to be searched.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] Executed once when a quadrant is entered, and once when it is left (the second time only if points are present and the first call returned true). This quadrant is always local, if not completely than at least one descendant of it. If the callback returns false, this quadrant and its descendants are excluded from the search recursion. Its **point** argument is always NULL. Callback may be NULL in which case it is ignored.
* `point_fn`:\\[in\\] If **points** is not NULL, must be not NULL. Shall return true for any possible matching point. If **points** is NULL, this callback is ignored.
* `points`:\\[in\\] User-defined array of "points". If NULL, only the **quadrant_fn** callback is executed. If that is NULL, this function noops. If not NULL, the **point_fn** is called on its members during the search.
### Prototype
```c
void p8est_search_local (p8est_t * p4est, int call_post, p8est_search_local_t quadrant_fn, p8est_search_local_t point_fn, sc_array_t * points);
```
"""
function p8est_search_local(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p8est_search_local(p4est_::Ptr{p8est_t}, call_post::Cint, quadrant_fn::p8est_search_local_t, point_fn::p8est_search_local_t, points::Ptr{sc_array_t})::Cvoid
end

"""
    p8est_search(p4est_, quadrant_fn, point_fn, points)

This function is provided for backwards compatibility. We call p8est_search_local with call\\_post = 0.

### Prototype
```c
void p8est_search (p8est_t * p4est, p8est_search_query_t quadrant_fn, p8est_search_query_t point_fn, sc_array_t * points);
```
"""
function p8est_search(p4est_, quadrant_fn, point_fn, points)
    @ccall libp4est.p8est_search(p4est_::Ptr{p8est_t}, quadrant_fn::p8est_search_query_t, point_fn::p8est_search_query_t, points::Ptr{sc_array_t})::Cvoid
end

# typedef int ( * p8est_search_partition_t ) ( p8est_t * p4est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant , int pfirst , int plast , void * point )
"""
Callback function for the partition recursion.

### Parameters
* `p4est`:\\[in\\] The forest to traverse. Its local quadrants are never accessed.
* `which_tree`:\\[in\\] The tree number under consideration.
* `quadrant`:\\[in\\] This quadrant is not from local forest storage, and its user data is undefined. It represents the branch of the forest in the top-down recursion.
* `pfirst`:\\[in\\] The lowest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `plast`:\\[in\\] The highest processor that owns part of **quadrant**. Guaranteed to be non-empty. If this is equal to **pfirst**, then the recursion will stop for **quadrant**'s branch after this function returns.
* `point`:\\[in,out\\] Pointer to a user-defined point object. If called per-quadrant, this is NULL.
### Returns
If false, the recursion at quadrant is terminated. If true, it continues if **pfirst** < **plast**.
"""
const p8est_search_partition_t = Ptr{Cvoid}

"""
    p8est_search_partition(p4est_, call_post, quadrant_fn, point_fn, points)

Traverse the global partition top-down. We proceed top-down through the partition, identically on all processors except for the results of two user-provided callbacks. The recursion will only go down branches that are split between multiple processors. The callback functions can be used to stop a branch recursion even for split branches. This function offers the option to search for arbitrary user-defined points analogously to p4est_search_local.

!!! note

    Traversing the whole processor partition will be at least O(P), so sensible use of the callback function is advised to cut it short.

### Parameters
* `p4est`:\\[in\\] The forest to traverse. Its local quadrants are never accessed.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] This function controls the recursion, which only continues deeper if this callback returns true for a branch quadrant. It is allowed to set this to NULL.
* `point_fn`:\\[in\\] This function decides per-point whether it is followed down the recursion. Must be non-NULL if **points** are not NULL.
* `points`:\\[in\\] User-provided array of **points** that are passed to the callback **point_fn**. See p8est_search_local for details.
### Prototype
```c
void p8est_search_partition (p8est_t * p4est, int call_post, p8est_search_partition_t quadrant_fn, p8est_search_partition_t point_fn, sc_array_t * points);
```
"""
function p8est_search_partition(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p8est_search_partition(p4est_::Ptr{p8est_t}, call_post::Cint, quadrant_fn::p8est_search_partition_t, point_fn::p8est_search_partition_t, points::Ptr{sc_array_t})::Cvoid
end

# typedef int ( * p8est_search_all_t ) ( p8est_t * p8est , p4est_topidx_t which_tree , p8est_quadrant_t * quadrant , int pfirst , int plast , p4est_locidx_t local_num , void * point )
"""
Callback function for the top-down search through the whole forest.

### Parameters
* `p4est`:\\[in\\] The forest to search. We recurse through the trees one after another.
* `which_tree`:\\[in\\] The current tree number.
* `quadrant`:\\[in\\] The current quadrant in the recursion. This quadrant is either a non-leaf tree branch or a leaf. If the quadrant is contained in the local partition, we know which, otherwise we don't. Let us first consider the situation when **quadrant** is local, which is indicated by both **pfirst** and **plast** being equal to [`p4est`](@ref)->mpirank. Then the parameter **local_num** is negative for non-leaves and the number of the quadrant as a leaf in local storage otherwise. Only if the quadrant is a local leaf, it points to the actual local storage and can be used to access user data etc., and the recursion terminates. The other possibility is that **pfirst** < **plast**, in which case we proceed with the recursion, or both are equal to the same remote rank, in which case the recursion terminates. Either way, the quadrant is not from local forest storage.
* `pfirst`:\\[in\\] The lowest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `plast`:\\[in\\] The highest processor that owns part of **quadrant**. Guaranteed to be non-empty.
* `local_num`:\\[in\\] If **quadrant** is a local leaf, this number is the index of the leaf in local quadrant storage. Else, this is a negative value.
* `point`:\\[in,out\\] User-defined representation of a point. This parameter distinguishes two uses of the callback. For each quadrant, the callback is first called with a NULL point, and if this callback returns true, once for each point tracked in this branch. The return value for a point determines whether it shall be tracked further down the branch or not, and has no effect on a local leaf. The call with a NULL point is intended to prepare quadrant-related search meta data that is common to all points, and/or to efficiently terminate the recursion for all points in the branch in one call.
### Returns
If false, the recursion at **quadrant** terminates. If true, it continues if **pfirst** < **plast** or if they are both equal to [`p4est`](@ref)->mpirank and the recursion has not reached a leaf yet.
"""
const p8est_search_all_t = Ptr{Cvoid}

"""
    p8est_search_all(p4est_, call_post, quadrant_fn, point_fn, points)

Perform a top-down search on the whole forest.

This function combines the functionality of p4est_search_local and p4est_search_partition; their documentation applies for the most part.

The recursion proceeds from the root quadrant of each tree until (a) we encounter a remote quadrant that covers only one processor, or (b) we encounter a local leaf quadrant. In other words, we proceed with the recursion into a quadrant's children if (a) the quadrant is split between two or more processors, no matter whether one of them is the calling processor or not, or (b) if the quadrant is on the local processor but we have not reached a leaf yet.

The search can track one or more points, which are abstract placeholders. They are matched against the quadrants traversed using a callback function. The result of the callback function can be used to stop a recursion early. The user determines how a point is interpreted, we only pass it around.

Note that in the remote case (a), we may terminate the recursion even if the quadrant is not a leaf, which we have no means of knowing. Still, this case is sufficient to determine the processor ownership of a point.

!!! note

    This is a very powerful function that can become slow if not used carefully.

!!! note

    As with the two other search functions in this file, calling it once with many points is generally much faster than calling it once for each point. Using multiple points also allows for a per-quadrant termination of the recursion in addition to a more costly per-point termination.

!!! note

    This function works fine when used for the special cases that either the partition or the local quadrants are not of interest. However, in the case of querying only local information we expect that p4est_search_local will be faster since it employs specific local optimizations.

### Parameters
* `p4est`:\\[in\\] The forest to be searched.
* `call_post`:\\[in\\] If true, call quadrant callback both pre and post.
* `quadrant_fn`:\\[in\\] Executed once for each quadrant that is entered. If the callback returns false, this quadrant and its descendants are excluded from the search, and the points in this branch are not queried further. Its **point** argument is always NULL. Callback may be NULL in which case it is ignored.
* `point_fn`:\\[in\\] Executed once for each point that is relevant for a quadrant of the search. If it returns true, the point is tracked further down that branch, else it is discarded from the queries for the children. If **points** is not NULL, this callback must be not NULL. If **points** is NULL, it is not called.
* `points`:\\[in\\] User-defined array of points. We do not interpret a point, just pass it into the callbacks. If NULL, only the **quadrant_fn** callback is executed. If that is NULL, the whole function noops. If not NULL, the **point_fn** is called on its members during the search.
### Prototype
```c
void p8est_search_all (p8est_t * p4est, int call_post, p8est_search_all_t quadrant_fn, p8est_search_all_t point_fn, sc_array_t * points);
```
"""
function p8est_search_all(p4est_, call_post, quadrant_fn, point_fn, points)
    @ccall libp4est.p8est_search_all(p4est_::Ptr{p8est_t}, call_post::Cint, quadrant_fn::p8est_search_all_t, point_fn::p8est_search_all_t, points::Ptr{sc_array_t})::Cvoid
end

struct __JL_Ctag_314
    which_tree::p4est_topidx_t
    owner_rank::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_314}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_314, f::Symbol)
    r = Ref{__JL_Ctag_314}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_314}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_314}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_315
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_315}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_315, f::Symbol)
    r = Ref{__JL_Ctag_315}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_315}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_315}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_316
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_316}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_316, f::Symbol)
    r = Ref{__JL_Ctag_316}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_316}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_316}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_317
    which_tree::p4est_topidx_t
    owner_rank::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_317}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_317, f::Symbol)
    r = Ref{__JL_Ctag_317}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_317}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_317}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_318
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_318}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_318, f::Symbol)
    r = Ref{__JL_Ctag_318}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_318}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_318}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_319
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_319}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_319, f::Symbol)
    r = Ref{__JL_Ctag_319}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_319}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_319}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_320
    which_tree::p4est_topidx_t
    owner_rank::Cint
end
function Base.getproperty(x::Ptr{__JL_Ctag_320}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :owner_rank && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_320, f::Symbol)
    r = Ref{__JL_Ctag_320}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_320}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_320}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_321
    which_tree::p4est_topidx_t
    from_tree::p4est_topidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_321}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :from_tree && return Ptr{p4est_topidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_321, f::Symbol)
    r = Ref{__JL_Ctag_321}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_321}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_321}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_322
    which_tree::p4est_topidx_t
    local_num::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_322}, f::Symbol)
    f === :which_tree && return Ptr{p4est_topidx_t}(x + 0)
    f === :local_num && return Ptr{p4est_locidx_t}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_322, f::Symbol)
    r = Ref{__JL_Ctag_322}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_322}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_322}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_323

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_323
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_323}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p8est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_323, f::Symbol)
    r = Ref{__JL_Ctag_323}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_323}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_323}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_324

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_324
    is_ghost::NTuple{2, Int8}
    quad::NTuple{2, Ptr{p8est_quadrant_t}}
    quadid::NTuple{2, p4est_locidx_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_324}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{2, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{2, Ptr{p8est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{2, p4est_locidx_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_324, f::Symbol)
    r = Ref{__JL_Ctag_324}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_324}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_324}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_325

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_325
    is_ghost::Int8
    quad::Ptr{p8est_quadrant_t}
    quadid::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_325}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p8est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_325, f::Symbol)
    r = Ref{__JL_Ctag_325}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_325}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_325}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_326

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_326
    is_ghost::NTuple{4, Int8}
    quad::NTuple{4, Ptr{p8est_quadrant_t}}
    quadid::NTuple{4, p4est_locidx_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_326}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{4, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{4, Ptr{p8est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{4, p4est_locidx_t}}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_326, f::Symbol)
    r = Ref{__JL_Ctag_326}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_326}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_326}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_327

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_327
    is_ghost::Int8
    quad::Ptr{p4est_quadrant_t}
    quadid::p4est_locidx_t
end
function Base.getproperty(x::Ptr{__JL_Ctag_327}, f::Symbol)
    f === :is_ghost && return Ptr{Int8}(x + 0)
    f === :quad && return Ptr{Ptr{p4est_quadrant_t}}(x + 8)
    f === :quadid && return Ptr{p4est_locidx_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_327, f::Symbol)
    r = Ref{__JL_Ctag_327}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_327}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_327}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    __JL_Ctag_328

| Field      | Note                             |
| :--------- | :------------------------------- |
| is\\_ghost | boolean: local (0) or ghost (1)  |
| quad       | the actual quadrant              |
| quadid     | index in tree or ghost array     |
"""
struct __JL_Ctag_328
    is_ghost::NTuple{2, Int8}
    quad::NTuple{2, Ptr{p4est_quadrant_t}}
    quadid::NTuple{2, p4est_locidx_t}
end
function Base.getproperty(x::Ptr{__JL_Ctag_328}, f::Symbol)
    f === :is_ghost && return Ptr{NTuple{2, Int8}}(x + 0)
    f === :quad && return Ptr{NTuple{2, Ptr{p4est_quadrant_t}}}(x + 8)
    f === :quadid && return Ptr{NTuple{2, p4est_locidx_t}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_328, f::Symbol)
    r = Ref{__JL_Ctag_328}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_328}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_328}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const SC_CC = "mpicc"

const SC_CFLAGS = "-g -O2"

const SC_CPP = "mpicc -E"

const SC_CPPFLAGS = "-I/workspace/destdir/include"

const SC_ENABLE_MEMALIGN = 1

const SC_ENABLE_MPI = 1

const SC_ENABLE_MPICOMMSHARED = 1

const SC_ENABLE_MPIIO = 1

const SC_ENABLE_MPISHARED = 1

const SC_ENABLE_MPITHREAD = 1

const SC_ENABLE_MPIWINSHARED = 1

const SC_ENABLE_USE_COUNTERS = 1

const SC_ENABLE_USE_REALLOC = 1

const SC_ENABLE_V4L2 = 1

const SC_HAVE_BACKTRACE = 1

const SC_HAVE_BACKTRACE_SYMBOLS = 1

const SC_HAVE_FSYNC = 1

const SC_HAVE_GNU_QSORT_R = 1

const SC_HAVE_POSIX_MEMALIGN = 1

const SC_HAVE_QSORT_R = 1

const SC_HAVE_STRTOL = 1

const SC_HAVE_STRTOLL = 1

const SC_HAVE_ZLIB = 1

const SC_LDFLAGS = "-L/workspace/destdir/lib"

const SC_LIBS = "-lz -lm "

const SC_LT_OBJDIR = ".libs/"

const SC_MEMALIGN = 1

const SC_SIZEOF_VOID_P = 8

const SC_MEMALIGN_BYTES = SC_SIZEOF_VOID_P

const SC_MPI = 1

const SC_MPIIO = 1

const SC_PACKAGE = "libsc"

const SC_PACKAGE_BUGREPORT = "p4est@ins.uni-bonn.de"

const SC_PACKAGE_NAME = "libsc"

const SC_PACKAGE_STRING = "libsc 2.8.3"

const SC_PACKAGE_TARNAME = "libsc"

const SC_PACKAGE_URL = ""

const SC_PACKAGE_VERSION = "2.8.3"

const SC_SIZEOF_INT = 4

const SC_SIZEOF_LONG = 8

const SC_SIZEOF_LONG_LONG = 8

const SC_SIZEOF_UNSIGNED_LONG = 8

const SC_SIZEOF_UNSIGNED_LONG_LONG = 8

const SC_STDC_HEADERS = 1

const SC_USE_COUNTERS = 1

const SC_USE_REALLOC = 1

const SC_VERSION = "2.8.3"

const SC_VERSION_MAJOR = 2

const SC_VERSION_MINOR = 8

const SC_VERSION_POINT = 3

# Skipping MacroDefinition: _sc_const const

const sc_MPI_SUCCESS = MPI_SUCCESS

const sc_MPI_ERR_OTHER = MPI_ERR_OTHER

const sc_MPI_COMM_NULL = MPI_COMM_NULL

const sc_MPI_COMM_WORLD = MPI_COMM_WORLD

const sc_MPI_COMM_SELF = MPI_COMM_SELF

const sc_MPI_COMM_TYPE_SHARED = MPI_COMM_TYPE_SHARED

const sc_MPI_GROUP_NULL = MPI_GROUP_NULL

const sc_MPI_GROUP_EMPTY = MPI_GROUP_EMPTY

const sc_MPI_IDENT = MPI_IDENT

const sc_MPI_CONGRUENT = MPI_CONGRUENT

const sc_MPI_SIMILAR = MPI_SIMILAR

const sc_MPI_UNEQUAL = MPI_UNEQUAL

const sc_MPI_ANY_SOURCE = MPI_ANY_SOURCE

const sc_MPI_ANY_TAG = MPI_ANY_TAG

const sc_MPI_STATUS_IGNORE = MPI_STATUS_IGNORE

const sc_MPI_STATUSES_IGNORE = MPI_STATUSES_IGNORE

const sc_MPI_REQUEST_NULL = MPI_REQUEST_NULL

const sc_MPI_INFO_NULL = MPI_INFO_NULL

const sc_MPI_DATATYPE_NULL = MPI_DATATYPE_NULL

const sc_MPI_CHAR = MPI_CHAR

const sc_MPI_SIGNED_CHAR = MPI_SIGNED_CHAR

const sc_MPI_UNSIGNED_CHAR = MPI_UNSIGNED_CHAR

const sc_MPI_BYTE = MPI_BYTE

const sc_MPI_SHORT = MPI_SHORT

const sc_MPI_UNSIGNED_SHORT = MPI_UNSIGNED_SHORT

const sc_MPI_INT = MPI_INT

const sc_MPI_2INT = MPI_2INT

const sc_MPI_UNSIGNED = MPI_UNSIGNED

const sc_MPI_LONG = MPI_LONG

const sc_MPI_UNSIGNED_LONG = MPI_UNSIGNED_LONG

const sc_MPI_LONG_LONG_INT = MPI_LONG_LONG_INT

const sc_MPI_UNSIGNED_LONG_LONG = MPI_UNSIGNED_LONG_LONG

const sc_MPI_FLOAT = MPI_FLOAT

const sc_MPI_DOUBLE = MPI_DOUBLE

const sc_MPI_LONG_DOUBLE = MPI_LONG_DOUBLE

const sc_MPI_OP_NULL = MPI_OP_NULL

const sc_MPI_MAX = MPI_MAX

const sc_MPI_MIN = MPI_MIN

const sc_MPI_LAND = MPI_LAND

const sc_MPI_BAND = MPI_BAND

const sc_MPI_LOR = MPI_LOR

const sc_MPI_BOR = MPI_BOR

const sc_MPI_LXOR = MPI_LXOR

const sc_MPI_BXOR = MPI_BXOR

const sc_MPI_MINLOC = MPI_MINLOC

const sc_MPI_MAXLOC = MPI_MAXLOC

const sc_MPI_REPLACE = MPI_REPLACE

const sc_MPI_SUM = MPI_SUM

const sc_MPI_PROD = MPI_PROD

const sc_MPI_UNDEFINED = MPI_UNDEFINED

const sc_MPI_KEYVAL_INVALID = MPI_KEYVAL_INVALID

const sc_MPI_Comm = MPI_Comm

const sc_MPI_Group = MPI_Group

const sc_MPI_Datatype = MPI_Datatype

const sc_MPI_Op = MPI_Op

const sc_MPI_Request = MPI_Request

const sc_MPI_Status = MPI_Status

const sc_MPI_Init = MPI_Init

const sc_MPI_Finalize = MPI_Finalize

const sc_MPI_Abort = MPI_Abort

const sc_MPI_Alloc_mem = MPI_Alloc_mem

const sc_MPI_Free_mem = MPI_Free_mem

const sc_MPI_Comm_set_attr = MPI_Comm_set_attr

const sc_MPI_Comm_get_attr = MPI_Comm_get_attr

const sc_MPI_Comm_delete_attr = MPI_Comm_delete_attr

const sc_MPI_Comm_create_keyval = MPI_Comm_create_keyval

const sc_MPI_Comm_dup = MPI_Comm_dup

const sc_MPI_Comm_create = MPI_Comm_create

const sc_MPI_Comm_split = MPI_Comm_split

const sc_MPI_Comm_split_type = MPI_Comm_split_type

const sc_MPI_Comm_free = MPI_Comm_free

const sc_MPI_Comm_size = MPI_Comm_size

const sc_MPI_Comm_rank = MPI_Comm_rank

const sc_MPI_Comm_compare = MPI_Comm_compare

const sc_MPI_Comm_group = MPI_Comm_group

const sc_MPI_Group_free = MPI_Group_free

const sc_MPI_Group_size = MPI_Group_size

const sc_MPI_Group_rank = MPI_Group_rank

const sc_MPI_Group_translate_ranks = MPI_Group_translate_ranks

const sc_MPI_Group_compare = MPI_Group_compare

const sc_MPI_Group_union = MPI_Group_union

const sc_MPI_Group_intersection = MPI_Group_intersection

const sc_MPI_Group_difference = MPI_Group_difference

const sc_MPI_Group_incl = MPI_Group_incl

const sc_MPI_Group_excl = MPI_Group_excl

const sc_MPI_Group_range_incl = MPI_Group_range_incl

const sc_MPI_Group_range_excl = MPI_Group_range_excl

const sc_MPI_Barrier = MPI_Barrier

const sc_MPI_Bcast = MPI_Bcast

const sc_MPI_Gather = MPI_Gather

const sc_MPI_Gatherv = MPI_Gatherv

const sc_MPI_Allgather = MPI_Allgather

const sc_MPI_Allgatherv = MPI_Allgatherv

const sc_MPI_Alltoall = MPI_Alltoall

const sc_MPI_Reduce = MPI_Reduce

const sc_MPI_Reduce_scatter_block = MPI_Reduce_scatter_block

const sc_MPI_Allreduce = MPI_Allreduce

const sc_MPI_Scan = MPI_Scan

const sc_MPI_Exscan = MPI_Exscan

const sc_MPI_Recv = MPI_Recv

const sc_MPI_Irecv = MPI_Irecv

const sc_MPI_Send = MPI_Send

const sc_MPI_Isend = MPI_Isend

const sc_MPI_Probe = MPI_Probe

const sc_MPI_Iprobe = MPI_Iprobe

const sc_MPI_Get_count = MPI_Get_count

const sc_MPI_Wtime = MPI_Wtime

const sc_MPI_Wait = MPI_Wait

const sc_MPI_Waitsome = MPI_Waitsome

const sc_MPI_Waitall = MPI_Waitall

const sc_MPI_THREAD_SINGLE = MPI_THREAD_SINGLE

const sc_MPI_THREAD_FUNNELED = MPI_THREAD_FUNNELED

const sc_MPI_THREAD_SERIALIZED = MPI_THREAD_SERIALIZED

const sc_MPI_THREAD_MULTIPLE = MPI_THREAD_MULTIPLE

const sc_MPI_Init_thread = MPI_Init_thread

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

const P4EST_CC = "mpicc"

const P4EST_CFLAGS = "-g -O2"

const P4EST_CPP = "mpicc -E"

const P4EST_CPPFLAGS = "-I/workspace/destdir/include"

const P4EST_ENABLE_BUILD_2D = 1

const P4EST_ENABLE_BUILD_3D = 1

const P4EST_ENABLE_BUILD_P6EST = 1

const P4EST_ENABLE_MEMALIGN = 1

const P4EST_ENABLE_MPI = 1

const P4EST_ENABLE_MPICOMMSHARED = 1

const P4EST_ENABLE_MPIIO = 1

const P4EST_ENABLE_MPISHARED = 1

const P4EST_ENABLE_MPITHREAD = 1

const P4EST_ENABLE_MPIWINSHARED = 1

const P4EST_ENABLE_VTK_BINARY = 1

const P4EST_ENABLE_VTK_COMPRESSION = 1

const P4EST_HAVE_GNU_QSORT_R = 1

const P4EST_HAVE_POSIX_MEMALIGN = 1

const P4EST_HAVE_ZLIB = 1

const P4EST_LDFLAGS = "-L/workspace/destdir/lib"

const P4EST_LIBS = "-lz -lm "

const P4EST_LT_OBJDIR = ".libs/"

const P4EST_MEMALIGN = 1

const P4EST_SIZEOF_VOID_P = 8

const P4EST_MEMALIGN_BYTES = P4EST_SIZEOF_VOID_P

const P4EST_MPI = 1

const P4EST_MPIIO = 1

const P4EST_PACKAGE = "p4est"

const P4EST_PACKAGE_BUGREPORT = "p4est@ins.uni-bonn.de"

const P4EST_PACKAGE_NAME = "p4est"

const P4EST_PACKAGE_STRING = "p4est 2.8"

const P4EST_PACKAGE_TARNAME = "p4est"

const P4EST_PACKAGE_URL = ""

const P4EST_PACKAGE_VERSION = "2.8"

const P4EST_STDC_HEADERS = 1

const P4EST_VERSION = "2.8"

const P4EST_VERSION_MAJOR = 2

const P4EST_VERSION_MINOR = 8

const P4EST_VERSION_POINT = 0

const P4EST_VTK_BINARY = 1

const P4EST_VTK_COMPRESSION = 1

const p4est_qcoord_compare = sc_int32_compare

const P4EST_QCOORD_BITS = 32

const P4EST_MPI_QCOORD = sc_MPI_INT

const P4EST_VTK_QCOORD = "Int32"


const P4EST_QCOORD_MIN = INT32_MIN

const P4EST_QCOORD_MAX = INT32_MAX

const P4EST_QCOORD_1 = p4est_qcoord_t(1)

const p4est_topidx_compare = sc_int32_compare

const P4EST_TOPIDX_BITS = 32

const P4EST_MPI_TOPIDX = sc_MPI_INT

const P4EST_VTK_TOPIDX = "Int32"


const P4EST_TOPIDX_MIN = INT32_MIN

const P4EST_TOPIDX_MAX = INT32_MAX

const P4EST_TOPIDX_FITS_32 = 1

const P4EST_TOPIDX_1 = p4est_topidx_t(1)

const p4est_locidx_compare = sc_int32_compare

const P4EST_LOCIDX_BITS = 32

const P4EST_MPI_LOCIDX = sc_MPI_INT

const P4EST_VTK_LOCIDX = "Int32"


const P4EST_LOCIDX_MIN = INT32_MIN

const P4EST_LOCIDX_MAX = INT32_MAX

const P4EST_LOCIDX_1 = p4est_locidx_t(1)

const p4est_gloidx_compare = sc_int64_compare

const P4EST_GLOIDX_BITS = 64

const P4EST_MPI_GLOIDX = sc_MPI_LONG_LONG_INT

const P4EST_VTK_GLOIDX = "Int64"


const P4EST_GLOIDX_MIN = INT64_MIN

const P4EST_GLOIDX_MAX = INT64_MAX

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
const PREFIXES = ["p4est_", "p6est_", "p8est_", "sc_", "P4EST_", "P6EST_", "P8EST_", "SC_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module

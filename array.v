module blend2d

// ============================================================================
// Array - Definitions
// ============================================================================

struct C.BLArrayImpl {
	capacity size_t                 // Array capacity.

	refCount size_t                 // Reference count.
	implType byte                   // Impl type.
	implTraits byte                 // Impl traits.
	memPoolData u16                 // Memory pool data.

	itemSize byte                   // Item size in bytes.
	dispatchType byte               // Function dispatch used to handle arrays that don't store simple items.
	reserved []byte = []byte{len:2} // Reserved, must be set to 0.

	// These members are part of sub data structures that can't be represented in V.
	// Declaring them directly like this seems to be sufficient for access.
	// union {
	// struct {
	data voidptr	  // Array data (as `void`).
	size size_t		  // Array size.
	// }
	view C.BLDataView // Array data and size as a view.
	// }
}
struct C.BLArrayCore {
	impl &C.BLArrayImpl = 0
}
// Blend2D Array.
pub type Array = C.BLArrayCore

// ============================================================================
// Array - Init / Destroy
// ============================================================================

fn C.blArrayInit(self &C.BLArrayCore, arrayTypeId u32) BLResult
// Create a new Blend2D Array.
[inline]
pub fn new_array<T>() &Array {
	arr := &Array{}
	res := C.blArrayInit(arr, sizeof(T)) //
	if res != 0 {
		panic(IError(Result{
			msg: "Could not create array."
			result: ResultCode(res)
		}))
	}
	return arr
}

fn C.blArrayDestroy(self &C.BLArrayCore) BLResult
// Free the Array data from memory. (Called by V's autofree engine).
[inlne]
pub fn (arr &Array) free() {
	C.blArrayDestroy(arr)
}


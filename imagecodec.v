module blend2d

// ============================================================================
// Image Codec - Definitions
// ============================================================================

struct C.BLImageCodecCore {}
// Image Codec.
pub type ImageCodec = C.BLImageCodecCore

// ============================================================================
// Image Codec - Init / Destroy
// ============================================================================

fn C.blImageCodecInit(self &C.BLImageCodecCore) BLResult
fn C.blImageCodecFindByName(self &C.BLImageCodecCore, name charptr, size size_t, codecs &C.BLArrayCore) BLResult
// Create a new Image Codec with the specified name.
[inline]
pub fn new_codec_by_name(name string) ?&ImageCodec {
	codec := &ImageCodec{}
	C.blImageCodecInit(codec)
	res := C.blImageCodecFindByName(codec, name.str, name.len, 0)
	if res != 0 {
		return IError(Result{
			msg: "Could not find image codec."
			result: ResultCode(res)
		})
	}
	return codec
}

fn C.blImageCodecDestroy(self &C.BLImageCodecCore) BLResult
// Free the Image Codec data from memory. (Called by V's autofree engine).
[inline]
pub fn (codec &ImageCodec) free() {
	C.blImageCodecDestroy(codec)
}

module blend2d

// TODO: As per note in `blFontFaceCreateFromFile`, need to 
// add better handling for options - readFlags, getting multiple font faces from one file, etc

// ============================================================================
// Font Face - Definitions
// ============================================================================

struct C.BLFontFaceCore {
}
// Font face.
pub type FontFace = C.BLFontFaceCore

// ============================================================================
// Font Face - Init / Destroy
// ============================================================================

fn C.blFontFaceInit(/*mut*/ self &C.BLFontFaceCore) BLResult
fn C.blFontFaceCreateFromFile(/*mut*/ self &C.BLFontFaceCore, fileName &char, readFlags u32) BLResult
// Retrieve the first font in a font file.
[inline]
pub fn new_font_face(file_path string) ?&FontFace {
	mut face := &FontFace{}
	C.blFontFaceInit(/*mut*/ face)
	res := C.blFontFaceCreateFromFile(/*mut*/ face, file_path.str, 0)
	if res != 0 {
		return IError(Result{
			msg: "Could not create font face."
			result: ResultCode(res)
		})
	}
	return face
}

fn C.blFontFaceDestroy(/*mut*/ self &C.BLFontFaceCore) BLResult
// Free the FontFace data from memory. (Called by V's autofree engine).
[inline]
pub fn (face &FontFace) free() {
	C.blFontFaceDestroy(face)
}

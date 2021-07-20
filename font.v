module blend2d

// ============================================================================
// Font - Definitions
// ============================================================================

struct C.BLFontCore {
}
// Font.
pub type Font = C.BLFontCore

// ============================================================================
// Font - Init / Destroy
// ============================================================================

fn C.blFontInit(/*mut*/ self &C.BLFontCore) BLResult
fn C.blFontCreateFromFace(/*mut*/ self &C.BLFontCore, face &C.BLFontFaceCore, size f32) BLResult
// Retrieve the first font in a font file.
[inline]
pub fn new_font(font_face &FontFace, size f32) &Font {
	mut font := &Font{}
	C.blFontInit(/*mut*/ font)
	res := C.blFontCreateFromFace(/*mut*/ font, font_face, size)
	if res != 0 {
		panic(IError(Result{
			msg: "Could not create font."
			result: ResultCode(res)
		}))
	}
	return font
}

fn C.blFontDestroy(/*mut*/ self &C.BLFontCore) BLResult
// Free the Font data from memory. (Called by V's autofree engine).
[inline]
pub fn (font &Font) free() {
	C.blFontDestroy(font)
}

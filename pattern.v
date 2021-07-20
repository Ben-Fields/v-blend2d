module blend2d

// ============================================================================
// Pattern - Definitions
// ============================================================================

struct C.BLPatternCore {
}
// Pattern.
pub type Pattern = C.BLPatternCore

// Pattern creation optional arguments.
pub struct PatternCfg {
	extend ExtendMode = .repeat
	area &RectI       = voidptr(0)
	matrix &Matrix2D  = voidptr(0)
}

// ============================================================================
// Pattern - Init / Destroy
// ============================================================================

fn C.blPatternInitAs(/*mut*/ self &C.BLPatternCore, image &C.BLImageCore, area &C.BLRectI, extendMode u32, m &C.BLMatrix2D) BLResult
// Create a new Pattern with the specified dimensions in the premultiplied RGB 32-bit format.
[inline]
pub fn new_pattern(img &Image, cfg PatternCfg) ?&Pattern {
	mut pattern := &Pattern{}
	res := C.blPatternInitAs(/*mut*/ pattern, img, cfg.area, u32(cfg.extend), cfg.matrix)
	if res != 0 {
		return IError(Result{
			msg: "Could not create pattern."
			result: ResultCode(res)
		})
	}
	return pattern
}

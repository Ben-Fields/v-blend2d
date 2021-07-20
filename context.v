module blend2d

// TODO: Finish context API originating from the virtual function table (as opposed to public C API)

// ============================================================================
// Context - Definitions
// ============================================================================

struct C.BLContextCore {
	impl &C.BLContextImpl = 0
}
// Rendering Context.
type Context = C.BLContextCore

// Composition & blending operator.
pub enum CompOp {
	src_over		// Source-over [default].
	src_copy		// Source-copy.
	src_in			// Source-in.
	src_out			// Source-out.
	src_atop		// Source-atop.
	dst_over		// Destination-over.
	dst_copy		// Destination-copy [nop].
	dst_in			// Destination-in.
	dst_out			// Destination-out.
	dst_atop		// Destination-atop.
	xor				// Xor.
	clear			// Clear.
	plus			// Plus.
	minus			// Minus.
	modulate		// Modulate.
	multiply		// Multiply.
	screen			// Screen.
	overlay			// Overlay.
	darken			// Darken.
	lighten			// Lighten.
	color_dodge		// Color dodge.
	color_burn		// Color burn.
	linear_burn		// Linear burn.
	linear_light	// Linear light.
	pin_light		// Pin light.
	hard_light		// Hard-light.
	soft_light		// Soft-light.
	difference		// Difference.
	exclusion		// Exclusion.
	count			// Count of composition & blending operators. 
}

// ============================================================================
// Context - Init / Destroy
// ============================================================================

fn C.blContextInitAs(self &C.BLContextCore, image &C.BLImageCore, options &C.BLContextCreateInfo) BLResult
// Create a new rendering Context.
[inline]
pub fn new_context(target &Image) ?&Context {
	context := &Context{}
	res := C.blContextInitAs(context, target, 0)
	if res != 0 {
		return IError(Result{
			msg: "Could not create rendering context."
			result: ResultCode(res)
		})
	}
	return context
}

fn C.blContextDestroy(self &C.BLContextCore) BLResult
// Free the rendering Context data from memory. (Called by V's autofree engine).
[inline]
pub fn (ctx &Context) free() {
	C.blContextDestroy(ctx)
}

// ============================================================================
// Context - Begin / End
// ============================================================================

fn C.blContextEnd(self &C.BLContextCore) BLResult
// Waits for completion of all render commands and detaches the rendering 
// context from the rendering target. After end() completes, the rendering 
// context implementation would be released and replaced by a built-in null 
// instance (no context).
[inline]
pub fn (ctx &Context) end() {
	res := C.blContextEnd(ctx)
	if res != 0 {
		panic(IError(Result{
			msg: "Failed to detach/end rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Operational Behavior - Composition
// ============================================================================

// Sets the composition & blending operation type for the context.
[inline]
pub fn (ctx &Context) set_comp_op(comp_op CompOp) {
	res := ctx.impl.virt.setCompOp(ctx.impl, comp_op)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Comp Op' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Operational Behavior - Fill
// ============================================================================

// Set fill style - color (RGBA32).
[inline]
pub fn (ctx &Context) set_fill_color(rgba32 Rgba32) {
	func := ctx.impl.virt.setStyleRgba32[C_OpType.fill]
	res := func(ctx.impl, rgba32.value)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleRgba32[C_OpType.fill](ctx.impl, rgba32.value)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Color' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set fill style - gradient.
[inline]
pub fn (ctx &Context) set_fill_gradient(gradient &Gradient) {
	func := ctx.impl.virt.setStyleObject[C_OpType.fill]
	res := func(ctx.impl, gradient)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleObject[C_OpType.fill](ctx.impl, gradient)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Gradient' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set fill style - pattern.
[inline]
pub fn (ctx &Context) set_fill_pattern(pattern &Pattern) {
	func := ctx.impl.virt.setStyleObject[C_OpType.fill]
	res := func(ctx.impl, pattern)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleObject[C_OpType.fill](ctx.impl, pattern)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Pattern' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Operational Behavior - Stroke
// ============================================================================

// Set stroke style - color (RGBA32).
[inline]
pub fn (ctx &Context) set_stroke_color(rgba32 Rgba32) {
	func := ctx.impl.virt.setStyleRgba32[C_OpType.stroke]
	res := func(ctx.impl, rgba32.value)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleRgba32[C_OpType.stroke](ctx.impl, rgba32.value)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Color' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set stroke style - gradient.
[inline]
pub fn (ctx &Context) set_stroke_gradient(gradient &Gradient) {
	func := ctx.impl.virt.setStyleObject[C_OpType.stroke]
	res := func(ctx.impl, gradient)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleObject[C_OpType.stroke](ctx.impl, gradient)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Gradient' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set stroke style - pattern.
[inline]
pub fn (ctx &Context) set_stroke_pattern(pattern &Pattern) {
	func := ctx.impl.virt.setStyleObject[C_OpType.stroke]
	res := func(ctx.impl, pattern)
	// TODO: cgen checker bug
	// res := ctx.impl.virt.setStyleObject[C_OpType.stroke](ctx.impl, pattern)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Fill Pattern' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set stroke width.
pub fn (ctx &Context) set_stroke_width(width f64) {
	res := ctx.impl.virt.setStrokeWidth(ctx.impl, width)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Stroke Width' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set stroke cap - start.
pub fn (ctx &Context) set_stroke_cap_start(@type StrokeCap) {
	res := ctx.impl.virt.setStrokeCap(ctx.impl, C_BLStrokeCapPosition.start, @type)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Stroke Cap' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Set stroke cap - end.
pub fn (ctx &Context) set_stroke_cap_end(@type StrokeCap) {
	res := ctx.impl.virt.setStrokeCap(ctx.impl, C_BLStrokeCapPosition.end, @type)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Stroke Cap' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Fill Operations
// ============================================================================

// Fill everything.
[inline]
pub fn (ctx &Context) fill_all() {
	res := ctx.impl.virt.fillAll(ctx.impl)
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill All' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Fill path.
[inline]
pub fn (ctx &Context) fill_path(path &Path) {
	res := ctx.impl.virt.fillGeometry(ctx.impl, C_BLGeometryType.path, path)
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill Path' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Fill rectangle.
[inline]
pub fn (ctx &Context) fill_rect(x f64, y f64, w f64, h f64) {
	res := ctx.impl.virt.fillGeometry(ctx.impl, C_BLGeometryType.rectd, &RoundRect{x:x, y:y, w:w, h:h})
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill Rectangle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Fill rounded rectangle.
[inline]
pub fn (ctx &Context) fill_round_rect(x f64, y f64, w f64, h f64, r f64) {
	res := ctx.impl.virt.fillGeometry(ctx.impl, C_BLGeometryType.round_rect, &RoundRect{x:x, y:y, w:w, h:h, rx:r, ry:r})
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill Rounded Rectangle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Fill circle.
[inline]
pub fn (ctx &Context) fill_circle(cx f64, cy f64, r f64) {
	res := ctx.impl.virt.fillGeometry(ctx.impl, C_BLGeometryType.circle, &Circle{cx:cx, cy:cy, r:r})
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill Circle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Fill string.
pub fn (ctx &Context) fill_string(x f64, y f64, font &Font, str string) {
	res := ctx.impl.virt.fillTextD(ctx.impl, &Point{x:x, y:y}, font, str.str, str.len, C_BLTextEncoding.utf8)
	if res != 0 {
		panic(IError(Result{
			msg: "'Fill String' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Stroke Operations
// ============================================================================

// Stroke path.
[inline]
pub fn (ctx &Context) stroke_path(path &Path) {
	res := ctx.impl.virt.strokeGeometry(ctx.impl, C_BLGeometryType.path, path)
	if res != 0 {
		panic(IError(Result{
			msg: "'Stroke Path' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Stroke rectangle.
[inline]
pub fn (ctx &Context) stroke_rect(x f64, y f64, w f64, h f64) {
	res := ctx.impl.virt.strokeGeometry(ctx.impl, C_BLGeometryType.rectd, &RoundRect{x:x, y:y, w:w, h:h})
	if res != 0 {
		panic(IError(Result{
			msg: "'Stroke Rectangle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Stroke rounded rectangle.
[inline]
pub fn (ctx &Context) stroke_round_rect(x f64, y f64, w f64, h f64, r f64) {
	res := ctx.impl.virt.strokeGeometry(ctx.impl, C_BLGeometryType.round_rect, &RoundRect{x:x, y:y, w:w, h:h, rx:r, ry:r})
	if res != 0 {
		panic(IError(Result{
			msg: "'Stroke Rounded Rectangle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Stroke circle.
[inline]
pub fn (ctx &Context) stroke_circle(cx f64, cy f64, r f64) {
	res := ctx.impl.virt.strokeGeometry(ctx.impl, C_BLGeometryType.circle, &Circle{cx:cx, cy:cy, r:r})
	if res != 0 {
		panic(IError(Result{
			msg: "'Stroke Circle' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Stroke string.
pub fn (ctx &Context) stroke_string(x f64, y f64, font &Font, str string) {
	res := ctx.impl.virt.strokeTextD(ctx.impl, &Point{x:x, y:y}, font, str.str, str.len, C_BLTextEncoding.utf8)
	if res != 0 {
		panic(IError(Result{
			msg: "'Stroke String' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Matrix Operations
// ============================================================================

// Reset the transofmration matrix.
[inline]
pub fn (ctx &Context) reset_matrix() {
	res := ctx.impl.virt.matrixOp(ctx.impl, C_BLMatrix2DOp.reset, voidptr(0))
	if res != 0 {
		panic(IError(Result{
			msg: "'Reset' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Transfer the User transformation matrix to the Meta transofmration matrix, and 
// reset the user matrix.
[inline]
pub fn (ctx &Context) user_to_meta() {
	res := ctx.impl.virt.userToMeta(ctx.impl, C_BLMatrix2DOp.reset, voidptr(0))
	if res != 0 {
		panic(IError(Result{
			msg: "'Reset' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Rotate about a point.
[inline]
pub fn (ctx &Context) rotate(angle f64, x f64, y f64) {
	res := ctx.impl.virt.matrixOp(ctx.impl, C_BLMatrix2DOp.rotate_pt, [f64(angle), x, y].data)
	if res != 0 {
		panic(IError(Result{
			msg: "'Rotate' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Rotate about the origin, [0, 0].
[inline]
pub fn (ctx &Context) rotate_origin(angle f64) {
	res := ctx.impl.virt.matrixOp(ctx.impl, C_BLMatrix2DOp.rotate, [f64(angle)].data)
	if res != 0 {
		panic(IError(Result{
			msg: "'Rotate Origin' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Scale uniformly.
[inline]
pub fn (ctx &Context) scale(scale_factor f64) {
	res := ctx.impl.virt.matrixOp(ctx.impl, C_BLMatrix2DOp.scale, [f64(scale_factor), scale_factor].data)
	if res != 0 {
		panic(IError(Result{
			msg: "'Scale' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// Scale separately for horizontal and vetical axes.
[inline]
pub fn (ctx &Context) scale_xy(scale_x f64, scale_y f64) {
	res := ctx.impl.virt.matrixOp(ctx.impl, C_BLMatrix2DOp.scale, [f64(scale_x), scale_y].data)
	if res != 0 {
		panic(IError(Result{
			msg: "'Scale XY' operation failed for rendering context."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Context - Internal Definitions
// ============================================================================

// Rendering context [Impl].
struct C.BLContextImpl {
	virt 				&C.BLContextVirt = 0  // Virtual function table.

	refCount 			size_t                // Reference count.
	implType			byte                  // Impl type.
	implTraits		byte                  // Impl traits.
	memPoolData		u16                   // Memory pool data.
	contextType		u32                   // Type of the context, see `BLContextType`.

	state 			&C.BLContextState = 0 // Current state of the context.
}

// Rendering context state.
struct C.BLContextState {
}

// Rendering context [Virtual Function Table].
struct C.BLContextVirt {
	destroy						fn (/*mut*/ impl &C.BLContextImpl) BLResult
	flush						fn (/*mut*/ impl &C.BLContextImpl, flags u32) BLResult

	queryProperty				fn (impl &C.BLContextImpl, propertyId u32, /*mut*/ valueOut voidptr) BLResult

	save						fn (/*mut*/ impl &C.BLContextImpl, /*mut*/ cookie &C.BLContextCookie) BLResult
	restore						fn (/*mut*/ impl &C.BLContextImpl, cookie &C.BLContextCookie) BLResult

	matrixOp					fn (/*mut*/ impl &C.BLContextImpl, opType u32, opData voidptr) BLResult
	userToMeta					fn (/*mut*/ impl &C.BLContextImpl) BLResult

	setHint						fn (/*mut*/ impl &C.BLContextImpl, hintType u32, value u32) BLResult
	setHints					fn (/*mut*/ impl &C.BLContextImpl, hints &C.BLContextHints) BLResult
	setFlattenMode				fn (/*mut*/ impl &C.BLContextImpl, mode u32) BLResult
	setFlattenTolerance			fn (/*mut*/ impl &C.BLContextImpl, tolerance f64) BLResult
	setApproximationOptions		fn (/*mut*/ impl &C.BLContextImpl, options &C.BLApproximationOptions) BLResult
 
	setCompOp					fn (/*mut*/ impl &C.BLContextImpl, compOp u32) BLResult
	setGlobalAlpha				fn (/*mut*/ impl &C.BLContextImpl, alpha f64) BLResult
 
	setStyleAlpha[2]			fn (/*mut*/ impl &C.BLContextImpl, alpha f64) BLResult
	getStyle[2]					fn (impl &C.BLContextImpl, /*mut*/ out &C.BLStyleCore) BLResult
	setStyle[2]					fn (/*mut*/ impl &C.BLContextImpl, style &C.BLStyleCore) BLResult
	setStyleRgba[2]				fn (/*mut*/ impl &C.BLContextImpl, rgba &C.BLRgba) BLResult
	setStyleRgba32[2]			fn (/*mut*/ impl &C.BLContextImpl, rgba32 u32) BLResult
	setStyleRgba64[2]			fn (/*mut*/ impl &C.BLContextImpl, rgba64 u64) BLResult
	setStyleObject[2]			fn (/*mut*/ impl &C.BLContextImpl, object voidptr) BLResult
 
	setFillRule					fn (/*mut*/ impl &C.BLContextImpl, fillRule u32) BLResult
 
	setStrokeWidth				fn (/*mut*/ impl &C.BLContextImpl, width f64) BLResult
	setStrokeMiterLimit			fn (/*mut*/ impl &C.BLContextImpl, miterLimit f64) BLResult
	setStrokeCap		 		fn (/*mut*/ impl &C.BLContextImpl, position u32, strokeCap u32) BLResult
	setStrokeCaps				fn (/*mut*/ impl &C.BLContextImpl, strokeCap u32) BLResult
	setStrokeJoin				fn (/*mut*/ impl &C.BLContextImpl, strokeJoin u32) BLResult
	setStrokeDashOffset			fn (/*mut*/ impl &C.BLContextImpl, dashOffset f64) BLResult
	setStrokeDashArray			fn (/*mut*/ impl &C.BLContextImpl, dashArray &C.BLArrayCore) BLResult
	setStrokeTransformOrder		fn (/*mut*/ impl &C.BLContextImpl, transformOrder u32) BLResult
	setStrokeOptions	  		fn (/*mut*/ impl &C.BLContextImpl, options &C.BLStrokeOptionsCore) BLResult
 
	clipToRectI					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRectI) BLResult
	clipToRectD					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRect) BLResult
	restoreClipping				fn (/*mut*/ impl &C.BLContextImpl) BLResult
 
	clearAll					fn (/*mut*/ impl &C.BLContextImpl) BLResult
	clearRectI					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRectI) BLResult
	clearRectD					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRect) BLResult
 
	fillAll						fn (/*mut*/ impl &C.BLContextImpl) BLResult
	fillRectI					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRectI) BLResult
	fillRectD					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRect) BLResult
	fillPathD					fn (/*mut*/ impl &C.BLContextImpl, path &C.BLPathCore) BLResult
	fillGeometry				fn (/*mut*/ impl &C.BLContextImpl, geometryType u32, geometryData voidptr) BLResult
	fillTextI					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPointI, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
	fillTextD					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPoint, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
	fillGlyphRunI				fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPointI, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
	fillGlyphRunD				fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPoint, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult

	strokeRectI					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRectI) BLResult
	strokeRectD					fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRect) BLResult
	strokePathD					fn (/*mut*/ impl &C.BLContextImpl, path &C.BLPathCore) BLResult
	strokeGeometry				fn (/*mut*/ impl &C.BLContextImpl, geometryType u32, geometryData voidptr) BLResult
	strokeTextI					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPointI, font &C.BLFontCore,  text voidptr, size size_t, encoding u32) BLResult
	strokeTextD					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPoint, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
	strokeGlyphRunI				fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPointI, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
	strokeGlyphRunD				fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPoint, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult

	blitImageI					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPointI, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
	blitImageD					fn (/*mut*/ impl &C.BLContextImpl, pt &C.BLPoint, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
	blitScaledImageI			fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRectI, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
	blitScaledImageD			fn (/*mut*/ impl &C.BLContextImpl, rect &C.BLRect, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
}

// Used to select the correct function from the virtual function
// table when there are multiple. Used primarily in the various 
// set_fill_style() functions.
enum C_BLContextOpType {
	fill   = 0 // Fill operation type.
	stroke = 1 // Stroke operation type.
	count  = 2 // Count of rendering operations.
}
enum C_OpType {
	fill   = 0 // TODO: int(C_BLContextOpType.fill)   is error
	stroke = 1 // TODO: int(C_BLContextOpType.stroke) is error
}

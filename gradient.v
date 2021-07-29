module blend2d

// ============================================================================
// Gradient - Definitions
// ============================================================================

[noinit]
struct C.BLGradientImpl {
	capacity size_t // Stop capacity.

	refCount size_t // Reference count.
	implType byte  // Impl type.
	implTraits byte // Impl traits.
	memPoolData u16 // Memory pool data.

	gradientType byte	// Gradient type, see `BLGradientType`.
	extendMode byte	// Gradient extend mode, see `BLExtendMode`.
	matrixType byte	// Type of the transformation matrix.
	reserved /*[1]*/byte	// Reserved, must be zero.

	stops &C.BLGradientStop // Gradient stop data.
	size size_t // Gradient stop count.

	matrix Matrix2D // Gradient transformation matrix.

	//union {
	// TODO: Fix
	// values [int(C_BLGradientValue.count)]f64 // Gradient values (coordinates, radius, angle).
	values [6]f64 // Gradient values (coordinates, radius, angle).
	// BLLinearGradientValues linear // Linear parameters.
	// BLRadialGradientValues radial // Radial parameters.
	// BLConicalGradientValues conical // Conical parameters.
	//}
}
[noinit]
struct C.BLGradientCore {
	impl &C.BLGradientImpl = voidptr(0)
}
// Gradient.
pub type Gradient = C.BLGradientCore

// Gradient type.
pub enum GradientType {
  linear  = 0 // Linear gradient type.
  radial  = 1 // Radial gradient type.
  conical = 2 // Conical gradient type.

  count   = 3 // Count of gradient types.
}

// Defines an `offset` and `rgba` color that is used by `BLGradient` to define
// a linear transition between colors.
struct C.BLGradientStop {
pub mut:
	offset f64
	rgba Rgba64 // TODO: With the pure_v version of rgba.v, this should be `Rgba64`, but the C compiler tries to convert to uint64_t and fails.
	         //       This behavior only happens when there is an init function defined, like below.
	         //         (That is, any funciton that returns `GradientStop`).
}
pub type GradientStop = C.BLGradientStop

// Convenience function for `GradientStop`
[inline]
pub fn gradient_stop(offset f64, rgba Rgba64) GradientStop {
	return GradientStop{
		offset: offset
		rgba: rgba
	}
}

// Gradient creation optional arguments.
pub struct GradientCfg {
	extend ExtendMode     = .pad
	stops  []GradientStop = voidptr(0)
	matrix &Matrix2D      = voidptr(0)
}

// ============================================================================
// Gradient - Init / Destroy
// ============================================================================

fn C.blGradientInitAs(/*mut*/ self &C.BLGradientCore, @type u32, values voidptr, extendMode u32, stops &C.BLGradientStop, n size_t, m &C.BLMatrix2D) BLResult
// Create a new linear gradient.
[inline]
pub fn new_linear_gradient(x0 f64, y0 f64, x1 f64, y1 f64, cfg GradientCfg) &Gradient {
	grad := &Gradient{}
	res := C.blGradientInitAs(grad, u32(GradientType.linear), &C.BLLinearGradientValues{x0: x0, y0: y0, x1: x1, y1: y1}, u32(cfg.extend), cfg.stops.data, cfg.stops.len, cfg.matrix)
	if res != 0 {
		panic(IError(Result{
			msg: "Could not create linear gradient."
			result: ResultCode(res)
		}))
	}
	return grad
}

fn C.blGradientInitAs(/*mut*/ self &C.BLGradientCore, @type u32, values voidptr, extendMode u32, stops &C.BLGradientStop, n size_t, m &C.BLMatrix2D) BLResult
// Create a new radial gradient.
[inline]
pub fn new_radial_gradient(x0 f64, y0 f64, x1 f64, y1 f64, r0 f64, cfg GradientCfg) &Gradient {
	grad := &Gradient{}
	res := C.blGradientInitAs(grad, u32(GradientType.radial), &C.BLRadialGradientValues{x0: x0, y0: y0, x1: x1, y1: y1, r0: r0}, u32(cfg.extend), cfg.stops.data, cfg.stops.len, cfg.matrix)
	if res != 0 {
		panic(IError(Result{
			msg: "Could not create radial gradient."
			result: ResultCode(res)
		}))
	}
	return grad
}

fn C.blGradientInitAs(/*mut*/ self &C.BLGradientCore, @type u32, values voidptr, extendMode u32, stops &C.BLGradientStop, n size_t, m &C.BLMatrix2D) BLResult
// Create a new conical gradient.
[inline]
pub fn new_conical_gradient(x0 f64, y0 f64, angle f64, cfg GradientCfg) &Gradient {
	grad := &Gradient{}
	res := C.blGradientInitAs(grad, u32(GradientType.conical), &C.BLConicalGradientValues{x0: x0, y0: y0, angle: angle}, u32(cfg.extend), cfg.stops.data, cfg.stops.len, cfg.matrix)
	if res != 0 {
		panic(IError(Result{
			msg: "Could not create conical gradient."
			result: ResultCode(res)
		}))
	}
	return grad
}

fn C.blGradientDestroy(/*mut*/ self &C.BLGradientCore) BLResult
// Free the Gradient data from memory. (Called by V's autofree engine).
[inline]
pub fn (grad &Gradient) free() {
	C.blGradientDestroy(grad)
}

// ============================================================================
// Gradient - Get Information
// ============================================================================

// Get the type of the gradient (linear, radial, conical).
[inline]
pub fn (grad &Gradient) @type() GradientType {
	return GradientType(grad.impl.gradientType)
}

fn C.blGradientSetType(/*mut*/ self &C.BLGradientCore, @type u32) BLResult
// Set the type of the gradient (linear, radial, conical).
[inline]
pub fn (grad &Gradient) set_type(@type GradientType) {
	res := C.blGradientSetType(grad, u32(@type))
	if res != 0 {
		println(res)
		println(ResultCode(res))
		panic(IError(Result{
			msg: "'Set Type' failed for gradient."
			result: ResultCode(res)
		}))
	}
}

// Get the extend mode of the gradient (pad, repeat, reflect, or combination).
[inline]
pub fn (grad &Gradient) extend_mode() ExtendMode {
	return ExtendMode(grad.impl.extendMode)
}

fn C.blGradientSetExtendMode(/*mut*/ self &C.BLGradientCore, extendMode u32) BLResult
// Set the extend of the gradient (pad, repeat, reflect, or combination).
[inline]
pub fn (grad &Gradient) set_extend_mode(mode ExtendMode) {
	res := C.blGradientSetExtendMode(grad, u32(mode))
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Extend Mode' failed for gradient."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Gradient - Operations
// ============================================================================

fn C.blGradientAddStopRgba32(/*mut*/ self &C.BLGradientCore, offset f64, argb32 u32) BLResult
// Add color stop (keyframe) to the gradient (RGBA32).
[inline]
pub fn (grad &Gradient) add_stop(offset f64, color Rgba) {
	res := C.blGradientAddStopRgba32(grad, offset, color.value)
	if res != 0 {
		panic(IError(Result{
			msg: "'Add Stop' operation failed for gradient."
			result: ResultCode(res)
		}))
	}
}

fn C.blGradientResetStops(/*mut*/ self &C.BLGradientCore) BLResult
// Remove all stops from the gradient.
[inline]
pub fn (grad &Gradient) reset_stops() {
	res := C.blGradientResetStops(grad)
	if res != 0 {
		panic(IError(Result{
			msg: "'Reset Stops' operation failed for gradient."
			result: ResultCode(res)
		}))
	}
}


fn C.blGradientSetValues(/*mut*/ self &C.BLGradientCore, index size_t, values &C.double, n size_t) BLResult
// Set the shape attributes of the (first) linear gradient.
[inline]
pub fn (grad &Gradient) set_linear_values(x0 f64, y0 f64, x1 f64, y1 f64) {
	res := C.blGradientSetValues(grad, 0, [x0, y0, x1, y1].data, 4)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Linear Values' operation failed for gradient."
			result: ResultCode(res)
		}))
	}
}

fn C.blGradientSetValues(/*mut*/ self &C.BLGradientCore, index size_t, values &C.double, n size_t) BLResult
// Set the shape attributes of the (first) radial gradient.
[inline]
pub fn (grad &Gradient) set_radial_values(x0 f64, y0 f64, x1 f64, y1 f64, r0 f64) {
	res := C.blGradientSetValues(grad, 0, [x0, y0, x1, y1, r0].data, 5)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Radial Values' operation failed for gradient."
			result: ResultCode(res)
		}))
	}
}

fn C.blGradientSetValues(/*mut*/ self &C.BLGradientCore, index size_t, values &C.double, n size_t) BLResult
// Set the shape attributes of the (first) conical gradient.
[inline]
pub fn (grad &Gradient) set_conical_values(x0 f64, y0 f64, angle f64) {
	res := C.blGradientSetValues(grad, 0, [x0, y0, angle].data, 3)
	if res != 0 {
		panic(IError(Result{
			msg: "'Set Conical Values' operation failed for gradient."
			result: ResultCode(res)
		}))
	}
}

// ============================================================================
// Gradient - Internal Definitions
// ============================================================================

// Linear gradient values packed into a structure.
struct C.BLLinearGradientValues {
	x0 f64
	y0 f64
	x1 f64
	y1 f64
}

// Radial gradient values packed into a structure.
struct C.BLRadialGradientValues {
	x0 f64
	y0 f64
	x1 f64
	y1 f64
	r0 f64
}

// Conical gradient values packed into a structure.
struct C.BLConicalGradientValues {
	x0 f64
	y0 f64
	angle f64
}

//! Gradient data index.
enum C_BLGradientValue {
	common_x0 = 0  // x0 - start 'x' for Linear/Radial and center 'x' for Conical.
	common_y0 = 1  // y0 - start 'y' for Linear/Radial and center 'y' for Conical.
	common_x1 = 2  // x1 - end 'x' for Linear/Radial.
	common_y1 = 3 // y1 - end 'y' for Linear/Radial.
	radial_r0 = 4  // Radial gradient r0 radius.
	// TODO: Fix
	// conical_angle = 2 // Conical gradient angle.

	count = 6  //! Count of gradient values.
}

// struct C_GradientStops { // TODO
	
// }

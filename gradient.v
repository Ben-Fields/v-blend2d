module blend2d

// ============================================================================
// Gradient - Definitions
// ============================================================================

struct C_GradientStops {
	
}
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
	offset f64
	rgba Rgba64
}
pub type GradientStop = C.BLGradientStop

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

// ============================================================================
// Gradient - Get Information
// ============================================================================

// Create a new linear gradient.
[inline]
pub fn (grad &Gradient) get_type() GradientType {
	return GradientType(grad.impl.gradientType)
}

// ============================================================================
// Gradient - Operations
// ============================================================================

fn C.blGradientAddStopRgba32(/*mut*/ self &C.BLGradientCore, offset f64, argb32 u32) BLResult
// Add color stop (keyframe) to the gradient (RGBA32).
[inline]
pub fn (grad &Gradient) add_stop(offset f64, color Rgba32) {
	res := C.blGradientAddStopRgba32(grad, offset, color.value)
	if res != 0 {
		panic(IError(Result{
			msg: "Could not add stop to gradient."
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

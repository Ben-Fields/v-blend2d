module blend2d

// ============================================================================
// Path - Definitions
// ============================================================================

struct C.BLPathCore {
}
// Path.
type Path = C.BLPathCore

// Stroke cap.
pub enum StrokeCap {
  butt = 0 // Butt cap [default].
  square = 1 // Square cap.
  round = 2 // Round cap.
  round_rev = 3 // Round cap reversed.
  triangle = 4 // Triangle cap.
  triangle_rev = 5 // Triangle cap reversed.

  count = 6 // Used to catch invalid arguments.
}

// Stroke join type.
pub enum StrokeJoin {
  miter_clip = 0 // Miter-join possibly clipped at `miterLimit` [default].
  miter_bevel = 1 // Miter-join or bevel-join depending on miterLimit condition.
  miter_round = 2 // Miter-join or round-join depending on miterLimit condition.
  bevel = 3 // Bevel-join.
  round = 4 // Round-join.

  count = 5 // Count of stroke join types.
}

// Position of a stroke-cap.
enum C_BLStrokeCapPosition {
  start = 0 // Start of the path.
  end = 1 // End of the path.

  count = 2 // Count of stroke position options.
}

// ============================================================================
// Path - Init / Destroy
// ============================================================================

fn C.blPathInit(self &C.BLPathCore) BLResult
// Create a new Path.
[inline]
pub fn new_path() &Path {
	path := &Path{}
	C.blPathInit(path)
	return path
}

fn C.blPathDestroy(self &C.BLPathCore) BLResult
// Free the Path data from memory. (Called by V's autofree engine).
[inline]
pub fn (path &Path) free() {
	C.blPathDestroy(path)
}

// ============================================================================
// Path - Operations
// ============================================================================

fn C.blPathMoveTo(self &C.BLPathCore, x0 f64, y0 f64) BLResult
// Move to [x0, y0].
[inline]
pub fn (path &Path) move_to(x0 f64, y0 f64) {
	res := C.blPathMoveTo(path, x0, y0)
	if res != 0 {
		panic(IError(Result{
			msg: "'Move To' operation failed for path."
			result: ResultCode(res)
		}))
	}
}

fn C.blPathLineTo(self &C.BLPathCore, x1 f64, y1 f64) BLResult
// Add a line to [x1, y1].
[inline]
pub fn (path &Path) line_to(x1 f64, y1 f64) {
	res := C.blPathLineTo(path, x1, y1)
	if res != 0 {
		panic(IError(Result{
			msg: "'Line To' operation failed for path."
			result: ResultCode(res)
		}))
	}
}

fn C.blPathCubicTo(self &C.BLPathCore, x1 f64, y1 f64, x2 f64, y2 f64, x3 f64, y3 f64) BLResult
// Add a cubic curve to [x1, y1], [x2, y2], and [x3, y3].
[inline]
pub fn (path &Path) cubic_to(x1 f64, y1 f64, x2 f64, y2 f64, x3 f64, y3 f64) {
	res := C.blPathCubicTo(path, x1, y1, x2, y2, x3, y3)
	if res != 0 {
		panic(IError(Result{
			msg: "'Cubic To' operation failed for path."
			result: ResultCode(res)
		}))
	}
}




// Path properties.
pub struct PathCfg {
	dir    GeometryDirection = .cw
}

// Path properties.
pub struct PathGeometryCfg {
	dir    GeometryDirection = .cw
	matrix &Matrix2D         = voidptr(0)
}

fn C.blPathAddRectD(/*mut*/ self &C.BLPathCore, rect &C.BLRect, dir u32) BLResult
// Add a closed rectangle to the path.
[inline]
pub fn (path &Path) add_rect(x f64, y f64, w f64, h f64, cfg PathCfg) {
	res := C.blPathAddRectD(/*mut*/ path, &Rect{x:x, y:y, w:w, h:h}, u32(cfg.dir))
	if res != 0 {
		panic(IError(Result{
			msg: "'Add Rectangle' operation failed for path."
			result: ResultCode(res)
		}))
	}
}

fn C.blPathAddGeometry(/*mut*/ self &C.BLPathCore, geometryType u32, geometryData voidptr, m &C.BLMatrix2D, dir u32) BLResult
// Add a closed circle to the path.
[inline]
pub fn (path &Path) add_circle(cx f64, cy f64, r f64, cfg PathGeometryCfg) {
	res := C.blPathAddGeometry(/*mut*/ path, u32(C_BLGeometryType.circle), &Circle{cx:cx, cy:cy, r:r}, cfg.matrix, u32(cfg.dir))
	if res != 0 {
		panic(IError(Result{
			msg: "'Add Circle' operation failed for path."
			result: ResultCode(res)
		}))
	}
}

// // Need one with circle data structure. Perhaps a varargs one?: (but then no cfg trailing struct argument. Hmm...)
// fn C.blPathAddGeometry(/*mut*/ self &C.BLPathCore, geometryType u32, geometryData voidptr, m &C.BLMatrix2D, dir u32) BLResult
// // Add a closed circle to the path.
// [inline]
// pub fn (path &Path) add_circles(cfg PathCfg, circles ...&Circle) {
// 	// $for circle in circles {  // TODO: Why doesn't this work
// 	// for circle in circles {
// 	// 	res := C.blPathAddGeometry(/*mut*/ path, C_BLGeometryType.circle, circle, cfg.matrix, cfg.dir)
// 	// 	if res != 0 {
// 	// 		panic(IError(Result{
// 	// 			msg: "'Add Circles' operation failed for path."
// 	// 			result: ResultCode(res)
// 	// 		}))
// 	// 	}
// 	// }
// }

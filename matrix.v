module blend2d

// ============================================================================
// Matrix - Definitions
// ============================================================================

// 2D matrix represents an affine transformation matrix that can be used to
// transform geometry and images.
// [m00 m10 m20]  Translate/  [W 0 X]  Rotate:  [ cos(A) sin(A) 0]
// [m01 m11 m21]      Scale:  [0 H Y]           [-sin(A) cos(A) 0]
struct C.BLMatrix2D {
	// Matrix values, use `BL_MATRIX2D_VALUE` indexes to get a particular one.
	// m [C_BLMatrix2DValue.count]f64
	// Matrix values that map `m` to named values that can be used directly.
	// struct {
	m00 f64 = 1
	m01 f64 // = 0
	m10 f64 // = 0
	m11 f64 = 1
	m20 f64 // = 0
	m21 f64 // = 0
	// }
}
pub type Matrix2D = C.BLMatrix2D

// ============================================================================
// Matrix - Internal Definitions
// ============================================================================

// 2D matrix data index.
enum C_BLMatrix2DValue {
  _00 // = 0  // Value at index 0 - M00.
  _01 = 1  // Value at index 1 - M01.
  _10 = 2  // Value at index 2 - M10.
  _11 = 3  // Value at index 3 - M11.
  _20 = 4  // Value at index 4 - M20.
  _21 = 5  // Value at index 5 - M21.

  count = 6  // Count of `BLMatrix2D` values.
}

//! 2D matrix operation.
enum C_BLMatrix2DOp {
	reset // = 0  // Reset matrix to identity (argument ignored, should be nullptr).
	assign = 1  // Assign (copy) the other matrix.

	translate = 2  // Translate the matrix by [x, y].
	scale = 3  // Scale the matrix by [x, y].
	skew = 4  // Skew the matrix by [x, y].
	rotate = 5  // Rotate the matrix by the given angle about [0, 0].
	rotate_pt = 6  // Rotate the matrix by the given angle about [x, y].
	transform = 7  // Transform this matrix by other `BLMatrix2D`.

	post_translate = 8  // Post-translate the matrix by [x, y].
	post_scale = 9  // Post-scale the matrix by [x, y].
	post_skew = 10  // Post-skew the matrix by [x, y].
	post_rotate = 11  // Post-rotate the matrix about [0, 0].
	post_rotate_pt = 12  // Post-rotate the matrix about a reference BLPoint.
	post_transform = 13  // Post-transform this matrix by other `BLMatrix2D`.

	count = 14  // Count of matrix operations.
}
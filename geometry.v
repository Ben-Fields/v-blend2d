module blend2d

// ============================================================================
// Geometry - Type and Direction
// ============================================================================

// Used as parameter to ctx.impl.virt.fillGeometry() in ex. fill_path().     // TODO: expose this and one of each generaic funciton...?
enum C_BLGeometryType {
	@none = 0        // No geometry provided.
	boxi = 1        // BLBoxI struct.
	boxd = 2        // BLBox struct.
	recti = 3       // BLRectI struct.
	rectd = 4       // BLRect struct.
	circle = 5      // BLCircle struct.
	ellipse = 6     // BLEllipse struct.
	round_rect = 7  // BLRoundRect struct.
	arc = 8         // BLArc struct.
	chord = 9       // BLArc struct representing chord.
	pie = 10        // BLArc struct representing pie.
	line = 11       // BLLine struct.
	triangle = 12    // BLTriangle struct.
	polylinei = 13   // BLArrayView<BLPointI> representing a polyline.
	polylined = 14   // BLArrayView<BLPoint> representing a polyline.
	polygoni = 15    // BLArrayView<BLPointI> representing a polygon.
	polygond = 16    // BLArrayView<BLPoint> representing a polygon.
	array_view_boxi = 17  // BLArrayView<BLBoxI> struct.
	array_view_boxd = 18  // BLArrayView<BLBox> struct.
	array_view_recti = 19  // BLArrayView<BLRectI> struct.
	array_view_rectd = 20  // BLArrayView<BLRect> struct.
	path = 21             // BLPath (or BLPathCore).
	region = 22           // BLRegion (or BLRegionCore).

	count = 23  // Count of geometry types.

	// TODO: Fix
	// simple_last = triangle // The last simple type.
}

// Direction of a geometry used by geometric primitives and paths.
pub enum GeometryDirection {
	@none = 0 // No direction specified.
	cw = 1 // Clockwise direction.
	ccw = 2 // Counter-clockwise direction.
}

// ============================================================================
// Size
// ============================================================================

struct C.BLSizeI {
	w int
	h int
}
// Dimensions specified as [w, h] using `int` as a storage type.
pub type Size = C.BLSizeI

// ============================================================================
// Point
// ============================================================================

struct C.BLPoint {
	x f64
	y f64
}
// Point specified as [x, y] using `f64` as a storage type.
pub type Point = C.BLPoint

struct C.BLPointI {
	x int
	y int
}
// Point specified as [x, y] using `int` as a storage type.
pub type PointI = C.BLPointI

// ============================================================================
// Shapes
// ============================================================================

struct C.BLRectI {
	x int
	y int
	w int
	h int
}
// Rectangle specified as [x, y, w, h] using `int` as a storage type.
pub type RectI = C.BLRectI

struct C.BLRect {
	x f64
	y f64
	w f64
	h f64
}
// Rectangle specified as [x, y, w, h] using `f64` as a storage type.
pub type Rect = C.BLRect

struct C.BLRoundRect {
	x f64
	y f64
	w f64
	h f64
	rx f64
	ry f64
}
// Rounded rectangle specified as [x, y, w, h, rx, ry] using `f64` as a storage type.
pub type RoundRect = C.BLRoundRect

struct C.BLCircle {
	cx f64
	cy f64
	r f64
}
pub type Circle = C.BLCircle

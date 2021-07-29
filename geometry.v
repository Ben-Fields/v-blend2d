module blend2d

// The only geometry with integer versions are: Point, Size, Box, Rect

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
// Point
// ============================================================================

struct C.BLPoint {
pub mut:
	x f64
	y f64
}
// Point specified as [x, y] using `f64` as a storage type.
pub type Point = C.BLPoint

// Convenience function for `Point`
[inline]
pub fn point(x f64, y f64) Point {
	return Point{
		x: x
		y: y
	}
}

struct C.BLPointI {
pub mut:
	x int
	y int
}
// Point specified as [x, y] using `int` as a storage type.
pub type PointI = C.BLPointI

// Convenience function for `PointI`
[inline]
pub fn point_i(x int, y int) PointI {
	return PointI{
		x: x
		y: y
	}
}

// ============================================================================
// Size
// ============================================================================

struct C.BLSize {
pub mut:
	w f64
	h f64
}
// Dimensions specified as [w, h] using `f64` as a storage type.
pub type Size = C.BLSize

// Convenience function for `Size`
[inline]
pub fn size(w f64, h f64) Size {
	return Size{
		w: w
		h: h
	}
}

struct C.BLSizeI {
pub mut:
	w int
	h int
}
// Dimensions specified as [w, h] using `int` as a storage type.
pub type SizeI = C.BLSizeI

// Convenience function for `SizeI`
[inline]
pub fn size_i(w int, h int) SizeI {
	return SizeI{
		w: w
		h: h
	}
}

// ============================================================================
// Box
// ============================================================================

struct C.BLBox {
pub mut:
	x0 f64
	y0 f64
	x1 f64
	y1 f64
}
// Box specified as [x0, y0, x1, y1] using `f64` as a storage type.
pub type Box = C.BLBox

// Convenience function for `Box`
[inline]
pub fn box(x0 f64, y0 f64, x1 f64, y1 f64) Box {
	return Box{
		x0: x0
		y0: y0
		x1: x1
		y1: y1
	}
}

struct C.BLBoxI {
pub mut:
	x0 int
	y0 int
	x1 int
	y1 int
}
// Box specified as [x0, y0, x1, y1] using `int` as a storage type.
pub type BoxI = C.BLBoxI

// Convenience function for `BoxI`
[inline]
pub fn box_i(x0 int, y0 int, x1 int, y1 int) BoxI {
	return BoxI{
		x0: x0
		y0: y0
		x1: x1
		y1: y1
	}
}

// ============================================================================
// Rect
// ============================================================================

struct C.BLRect {
pub mut:
	x f64
	y f64
	w f64
	h f64
}
// Rectangle specified as [x, y, w, h] using `f64` as a storage type.
pub type Rect = C.BLRect

// Convenience function for `Rect`
[inline]
pub fn rect(x f64, y f64, w f64, h f64) Rect {
	return Rect{
		x: x
		y: y
		w: w
		h: h
	}
}

struct C.BLRectI {
pub mut:
	x int
	y int
	w int
	h int
}
// Rectangle specified as [x, y, w, h] using `int` as a storage type.
pub type RectI = C.BLRectI

// Convenience function for `RectI`
[inline]
pub fn rect_i(x int, y int, w int, h int) RectI {
	return RectI{
		x: x
		y: y
		w: w
		h: h
	}
}

// ============================================================================
// Round Rect
// ============================================================================

struct C.BLRoundRect {
pub mut:
	x f64
	y f64
	w f64
	h f64
	rx f64
	ry f64
}
// Rounded rectangle specified as [x, y, w, h, rx, ry] using `f64` as a storage type.
pub type RoundRect = C.BLRoundRect

// Convenience function for `Rect`
[inline]
pub fn round_rect(x f64, y f64, w f64, h f64, rx f64, ry f64) RoundRect {
	return RoundRect{
		x: x 
		y: y 
		w: w 
		h: h 
		rx: rx
		ry: ry
	}
}

// ============================================================================
// Circle
// ============================================================================

struct C.BLCircle {
pub mut:
	cx f64
	cy f64
	r f64
}
pub type Circle = C.BLCircle

// Convenience function for `Circle`
[inline]
pub fn circle(cx f64, cy f64, r f64) Circle {
	return Circle{
		cx: cx
		cy: cy
		r: r
	}
}

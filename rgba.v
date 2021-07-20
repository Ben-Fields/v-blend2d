module blend2d

// ============================================================================
// RGBA - Definitions
// ============================================================================

struct Rgba32_Components {
	b byte
	g byte
	r byte
	a byte
}
// 32-bit RGBA color (8-bits per component) stored as `0xAARRGGBB`.
pub union Rgba32 {
	Rgba32_Components
	value             u32
}

struct Rgba64_Components {
	b u16
	g u16
	r u16
	a u16
}
// 64-bit RGBA color (16-bit per component) stored as `0xAAAARRRRGGGGBBBB`.
pub union Rgba64 {
	Rgba64_Components
	value u64
}

// ============================================================================
// RGBA - Init
// ============================================================================

// Returns a new 32-bit RGBA color (Rgba32).
[inline]
pub fn new_rgba32(value u32) Rgba32 {
	return Rgba32 {
		value: value
	}
}

// Returns a new 64-bit RGBA color (Rgba64).
[inline]
pub fn new_rgba64(value u64) Rgba64 {
	return Rgba64 {
		value: value
	}
}
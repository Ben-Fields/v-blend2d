module blend2d

// There is an implementation in pure V in this same repository, but it does not compile due 
// to the note in `gradient.v`. Essentially, the library needs to convert the color type 
// somewhere to `uint64_t`, and the V-defined version causes a compiler error.

// This version, using Blend2D's own data structure, has the benefit of allowing one to 
// access components and such directly, since V thinks it's a normal struct. The below are 
// just declarations, so the original behavior and data orientation defined in the Blend2D
// library are conserved. 

// I attempted to avoid the divergence from conventional V behavior, causing potentially 
// unexpected results if one glosses over the details of these definitions, but it seems that 
// there are simply things you cannot do in V in the name of "safety".

// This is fine since the pure V version was getting overly verbose anyway, as compile-time 
// execution and data layout are two lacking areas of V, or they simply haven't been finished 
// yet.

// Note: As a result of the above, byte order is managed by the Bled2D library, and the below 
// initializers simply populate the data structure (unlike the pure V version).

// TODO: In the instances where you want to init the struct with `value`, you cannot because 
// V inits the other fields (which overlap in memory) to 0. 

// ============================================================================
// RGBA 32-bit
// ============================================================================

// ### Definition

struct C.BLRgba32 {
pub mut:
	// union {
		value u32
		// struct {
		// 	$if little_endian {
				b byte
				g byte
				r byte
				a byte
	// 		} $ else {
	// 			a byte
	// 			r byte
	// 			g byte
	// 			b byte
	// 		}
	// 	}
	// }
}
// 32-bit RGBA color (8-bits per component) stored as `0xAARRGGBB`.
// This is a composite struct defined outside of V, so behavior is not 
// strightforward. See definition.
pub type Rgba = C.BLRgba32

// ### Init

// Returns a new 32-bit color (Rgba32) from RGBA byte components.
[inline]
pub fn rgba(r byte, g byte, b byte, a byte) Rgba {
	return Rgba {
		b: b
		g: g
		r: r
		a: a
	}
}

// Returns a new 32-bit color (Rgba32) from RGBA byte components, with full alpha.
[inline]
pub fn rgb(r byte, g byte, b byte) Rgba {
	return Rgba {
		b: b
		g: g
		r: r
		a: 255
	}
}

// Returns a new 32-bit color (Rgba32) from a 32-bit RGBA hex value.
[inline]
pub fn rgba_hex(value u32) Rgba {
	return Rgba {
		b: byte(value >> 8)
		g: byte(value >> 16)
		r: byte(value >> 24)
		a: byte(value)
	}
}

// Returns a new 32-bit color (Rgba32) from a 32-bit RGBA hex value, with full alpha.
[inline]
pub fn rgb_hex(value u32) Rgba {
	return Rgba {
		b: byte(value)
		g: byte(value >> 8)
		r: byte(value >> 16)
		a: 255
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from a raw 32-bit value.
// Native for little-endian systems. Conversion for big-endian systems.
[inline]
pub fn bgra_raw(value u32) Rgba {
	$if little_endian {
		return Rgba {
			value: value // TODO: Does not work because V inits the other fields to 0.
		}
	} $else {
		return Rgba {
			b: byte(value >> 24)
			g: byte(value >> 16)
			r: byte(value >> 8)
			a: byte(value)
		}
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from a raw 32-bit value.
// Native for big-endian systems. Conversion for little-endian systems.
[inline]
pub fn argb_raw(value u32) Rgba {
	$if little_endian {
		return Rgba {
			b: byte(value)
			g: byte(value >> 8)
			r: byte(value >> 16)
			a: byte(value >> 24)
		}
	} $else {
		return Rgba {
			value: value // TODO: Does not work because V inits the other fields to 0.
		}
	}
}

// ### Modify

// Set the 32-bit color value.
[inline]
pub fn (mut rgba Rgba) set_hex(value u32) {
	rgba.b = byte(value >> 8)
	rgba.g = byte(value >> 16)
	rgba.r = byte(value >> 24)
	rgba.a = byte(value)
}

// ============================================================================
// RGBA 64-bit
// ============================================================================

// ### Definition

struct C.BLRgba64 {
pub mut:
	// union {
		value u64
		// struct {
		// 	$if little_endian {
				b u16
				g u16
				r u16
				a u16
	// 		} $ else {
	// 			a u16
	// 			r u16
	// 			g u16
	// 			b u16
	// 		}
	// 	}
	// }
}
// 64-bit RGBA color (16-bits per component) stored as `0xAAAARRRRGGGGBBBB`.
// This is a composite struct defined outside of V, so behavior is not 
// strightforward. See definition.
pub type Rgba64 = C.BLRgba64

// ### Init

// Returns a new 64-bit color (Rgba64) from RGBA components.
[inline]
pub fn rgba_64(r u16, g u16, b u16, a u16) Rgba64 {
	return Rgba64 {
		b: b
		g: g
		r: r
		a: a
	}
}

// Returns a new 64-bit color (Rgba64) from RGBA components, with full alpha.
[inline]
pub fn rgb_64(r u16, g u16, b u16) Rgba64 {
	return Rgba64 {
		b: b
		g: g
		r: r
		a: 0xFFFF
	}
}

// Returns a new 64-bit color (Rgba64) from a 64-bit RGBA hex value.
[inline]
pub fn rgba_hex_64(value u64) Rgba64 {
	return Rgba64 {
		b: u16(value >> 16)
		g: u16(value >> 32)
		r: u16(value >> 48)
		a: u16(value)
	}
}

// Returns a new 64-bit color (Rgba64) from a 64-bit RGBA hex value, with full alpha.
[inline]
pub fn rgb_hex_64(value u64) Rgba64 {
	return Rgba64 {
		b: u16(value)
		g: u16(value >> 16)
		r: u16(value >> 32)
		a: 0xFFFF
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from a raw 64-bit value.
// Native for little-endian systems. Conversion for big-endian systems.
[inline]
pub fn bgra_raw_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			value: value // TODO: Does not work because V inits the other fields to 0.
		}
	} $else {
		return Rgba64 {
			b: u16(value >> 48)
			g: u16(value >> 32)
			r: u16(value >> 16)
			a: u16(value)
		}
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from a raw 64-bit value.
// Native for big-endian systems. Conversion for little-endian systems.
[inline]
pub fn argb_raw_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			b: byte(value)
			g: byte(value >> 16)
			r: byte(value >> 32)
			a: byte(value >> 48)
		}
	} $else {
		return Rgba64 {
			value: value // TODO: Does not work because V inits the other fields to 0.
		}
	}
}

// ### Modify

// Set the 32-bit color value.
[inline]
pub fn (mut rgba Rgba64) set_hex(value u64) {
	rgba.b = u16(value >> 16)
	rgba.g = u16(value >> 32)
	rgba.r = u16(value >> 48)
	rgba.a = u16(value)
}

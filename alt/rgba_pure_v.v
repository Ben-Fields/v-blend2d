// module blend2d

// The structs ideally would be comptime-defined to be the native byte order (little/big endian).
// Since that is not possible, the getters / setters will be comptime defined to treat the fields 
//   as a, r, g, b, depending on the native byte order.
// The only downside is extra writing initially for the comptime conditionals and lack of default 
//   values. These unions couldn't be used alone anyway since V treats them as "unsafe", which 
//   would be annoying to use in practice unwrapped.

// ============================================================================
// RGBA 32-bit
// ============================================================================

// ### Definition

struct Rgba_Components {
mut: // Endian: Little Big
	b1 byte //   b      a
	b2 byte //   g      r
	b3 byte //   r      g
	b4 byte //   a      b
}
// 32-bit RGBA color (8-bits per component) stored as `0xAARRGGBB`.
pub union Rgba {
mut:
	components Rgba_Components
	value      u32
}

// ### Init

// Returns a new 32-bit color (Rgba32) from RGBA byte components.
[inline]
pub fn rgba(r byte, g byte, b byte, a byte) Rgba {
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: b
				b2: g
				b3: r
				b4: a
			}
		}
	} $else {
		return Rgba {
			components: Rgba_Components{
				b1: a
				b2: r
				b3: g
				b4: b
			}
		}
	}
}

// Returns a new 32-bit color (Rgba32) from RGBA byte components, with full alpha.
[inline]
pub fn rgb(r byte, g byte, b byte) Rgba {
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: b
				b2: g
				b3: r
				b4: 255
			}
		}
	} $else {
		return Rgba {
			components: Rgba_Components{
				b1: 255
				b2: r
				b3: g
				b4: b
			}
		}
	}
}

// Returns a new 32-bit color (Rgba32) from a 32-bit RGBA hex value.
[inline]
pub fn rgba_hex(value u32) Rgba {
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value >> 8) // b
				b2: byte(value >> 16) // g
				b3: byte(value >> 24) // r
				b4: byte(value) // a
			}
		}
	} $else {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value) // a
				b2: byte(value >> 24) // r
				b3: byte(value >> 16) // g
				b4: byte(value >> 8) // b
			}
		}
	}
}

// Returns a new 32-bit color (Rgba32) from a 32-bit RGBA hex value, with full alpha.
[inline]
pub fn rgb_hex(value u32) Rgba {
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value) // b
				b2: byte(value >> 8) // g
				b3: byte(value >> 16) // r
				b4: 255
			}
		}
	} $else {
		return Rgba {
			components: Rgba_Components{
				b1: 255
				b2: byte(value >> 16) // r
				b3: byte(value >> 8) // g
				b4: byte(value) // b
			}
		}
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from a raw 32-bit value.
// Native for little-endian systems. Conversion for big-endian systems.
[inline]
pub fn bgra_raw(value u32) Rgba {
	$if little_endian {
		return Rgba {
			value: value
		}
	} $else {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value) // a
				b2: byte(value >> 8) // r
				b3: byte(value >> 16) // g
				b4: byte(value >> 24) // b
			}
		}
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from a raw 32-bit value.
// Native for big-endian systems. Conversion for little-endian systems.
[inline]
pub fn argb_raw(value u32) Rgba {
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value >> 24) // b
				b2: byte(value >> 16) // g
				b3: byte(value >> 8) // r
				b4: byte(value) // a
			}
		}
	} $else {
		return Rgba {
			value: value
		}
	}
}

// ### Access

// Returns the r (red) component.
[inline]
pub fn (rgba Rgba) r() byte {
	unsafe {
		$if little_endian {
			return rgba.components.b3
		} $else {
			return rgba.components.b2
		}
	}
}

// Returns the g (green) component.
[inline]
pub fn (rgba Rgba) g() byte {
	unsafe {
		$if little_endian {
			return rgba.components.b2
		} $else {
			return rgba.components.b3
		}
	}
}

// Returns the b (blue) component.
[inline]
pub fn (rgba Rgba) b() byte {
	unsafe {
		$if little_endian {
			return rgba.components.b1
		} $else {
			return rgba.components.b4
		}
	}
}

// Returns the a (alpha) component.
[inline]
pub fn (rgba Rgba) a() byte {
	unsafe {
		$if little_endian {
			return rgba.components.b4
		} $else {
			return rgba.components.b1
		}
	}
}

// Returns the raw 32-bit value.
// Result depends whether system is big- or little-endian.
[inline]
pub fn (rgba Rgba) raw() u32 {
	unsafe {
		return rgba.value
	}
}

// ### Modify

// Set the 32-bit color value with RGBA components.
[inline]
pub fn (rgba Rgba) set(r byte, g byte, b byte, a byte) {
	unsafe {
		$if little_endian {
			rgba.components.b3 = r
			rgba.components.b2 = g
			rgba.components.b1 = b
			rgba.components.b4 = a
		} $else {
			rgba.components.b2 = r
			rgba.components.b3 = g
			rgba.components.b4 = b
			rgba.components.b1 = a
		}
	}
}

// Set the 32-bit color value.
[inline]
pub fn (rgba Rgba) set_hex(value u32) {
	unsafe {
		$if little_endian {
			rgba.components.b1 = byte(value >> 8) // b
			rgba.components.b2 = byte(value >> 16) // g
			rgba.components.b3 = byte(value >> 24) // r
			rgba.components.b4 = byte(value) // a
		} $else {
			rgba.components.b1 = byte(value) // a
			rgba.components.b2 = byte(value >> 24) // r
			rgba.components.b3 = byte(value >> 16) // g
			rgba.components.b4 = byte(value >> 8) // b
		}
	}
}

// Set the r (red) component.
[inline]
pub fn (rgba Rgba) set_r(r byte) {
	unsafe {
		$if little_endian {
			rgba.components.b3 = r
		} $else {
			rgba.components.b2 = r
		}
	}
}

// Set the g (green) component.
[inline]
pub fn (rgba Rgba) set_g(g byte) {
	unsafe {
		$if little_endian {
			rgba.components.b2 = g
		} $else {
			rgba.components.b3 = g
		}
	}
}

// Set the b (blue) component.
[inline]
pub fn (rgba Rgba) set_b(b byte) {
	unsafe {
		$if little_endian {
			rgba.components.b1 = b
		} $else {
			rgba.components.b4 = b
		}
	}
}

// Set the a (alpha) component.
[inline]
pub fn (rgba Rgba) set_a(a byte) {
	unsafe {
		$if little_endian {
			rgba.components.b4 = a
		} $else {
			rgba.components.b1 = a
		}
	}
}

// ============================================================================
// RGBA 64-bit
// ============================================================================

// ### Definition

struct Rgba64_Components {
mut: // Endian: Little Big
	b1 u16 //   b      a
	b2 u16 //   g      r
	b3 u16 //   r      g
	b4 u16 //   a      b
}
// 64-bit RGBA color (16-bits per component) stored as `0xAAAARRRRGGGGBBBB`.
pub union Rgba64 {
mut:
	components Rgba64_Components
	value      u64
}

// ### Init

// Returns a new 64-bit color (Rgba64) from RGBA components.
[inline]
pub fn rgba_64(r u16, g u16, b u16, a u16) Rgba64 {
	$if little_endian {
		return Rgba64 {
			components: Rgba64_Components{
				b1: b
				b2: g
				b3: r
				b4: a
			}
		}
	} $else {
		return Rgba64 {
			components: Rgba64_Components{
				b1: a
				b2: r
				b3: g
				b4: b
			}
		}
	}
}

// Returns a new 64-bit color (Rgba64) from RGBA components, with full alpha.
[inline]
pub fn rgb_64(r u16, g u16, b u16) Rgba64 {
	$if little_endian {
		return Rgba64 {
			components: Rgba64_Components{
				b1: b
				b2: g
				b3: r
				b4: 0xFFFF
			}
		}
	} $else {
		return Rgba64 {
			components: Rgba64_Components{
				b1: 0xFFFF
				b2: r
				b3: g
				b4: b
			}
		}
	}
}

// Returns a new 64-bit color (Rgba64) from a 64-bit RGBA hex value.
[inline]
pub fn rgba_hex_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			components: Rgba64_Components{
				b1: u16(value >> 16) // b
				b2: u16(value >> 32) // g
				b3: u16(value >> 48) // r
				b4: u16(value) // a
			}
		}
	} $else {
		return Rgba64 {
			components: Rgba64_Components{
				b1: u16(value) // a
				b2: u16(value >> 48) // r
				b3: u16(value >> 32) // g
				b4: u16(value >> 16) // b
			}
		}
	}
}

// Returns a new 64-bit color (Rgba64) from a 64-bit RGBA hex value, with full alpha.
[inline]
pub fn rgb_hex_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			components: Rgba64_Components{
				b1: u16(value) // b
				b2: u16(value >> 16) // g
				b3: u16(value >> 32) // r
				b4: 0xFFFF
			}
		}
	} $else {
		return Rgba64 {
			components: Rgba64_Components{
				b1: 0xFFFF
				b2: u16(value >> 32) // r
				b3: u16(value >> 16) // g
				b4: u16(value) // b
			}
		}
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from a raw 64-bit value.
// Native for little-endian systems. Conversion for big-endian systems.
[inline]
pub fn bgra_raw_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			value: value
		}
	} $else {
		return Rgba64 {
			components: Rgba64_Components{
				b1: u16(value) // a
				b2: u16(value >> 16) // r
				b3: u16(value >> 32) // g
				b4: u16(value >> 48) // b
			}
		}
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from a raw 64-bit value.
// Native for big-endian systems. Conversion for little-endian systems.
[inline]
pub fn argb_raw_64(value u64) Rgba64 {
	$if little_endian {
		return Rgba64 {
			components: Rgba64_Components{
				b1: u16(value >> 48) // b
				b2: u16(value >> 32) // g
				b3: u16(value >> 16) // r
				b4: u16(value) // a
			}
		}
	} $else {
		return Rgba64 {
			value: value
		}
	}
}

// ### Access

// Returns the r (red) component.
[inline]
pub fn (rgba Rgba64) r() u16 {
	unsafe {
		$if little_endian {
			return rgba.components.b3
		} $else {
			return rgba.components.b2
		}
	}
}

// Returns the g (green) component.
[inline]
pub fn (rgba Rgba64) g() u16 {
	unsafe {
		$if little_endian {
			return rgba.components.b2
		} $else {
			return rgba.components.b3
		}
	}
}

// Returns the b (blue) component.
[inline]
pub fn (rgba Rgba64) b() u16 {
	unsafe {
		$if little_endian {
			return rgba.components.b1
		} $else {
			return rgba.components.b4
		}
	}
}

// Returns the a (alpha) component.
[inline]
pub fn (rgba Rgba64) a() u16 {
	unsafe {
		$if little_endian {
			return rgba.components.b4
		} $else {
			return rgba.components.b1
		}
	}
}

// Returns the raw 64-bit value.
// Result depends whether system is big- or little-endian.
[inline]
pub fn (rgba Rgba64) raw() u64 {
	unsafe {
		return rgba.value
	}
}

// ### Modify

// Set the 64-bit color value with RGBA components.
[inline]
pub fn (rgba Rgba64) set(r u16, g u16, b u16, a u16) {
	unsafe {
		$if little_endian {
			rgba.components.b3 = r
			rgba.components.b2 = g
			rgba.components.b1 = b
			rgba.components.b4 = a
		} $else {
			rgba.components.b2 = r
			rgba.components.b3 = g
			rgba.components.b4 = b
			rgba.components.b1 = a
		}
	}
}

// Set the 64-bit color value with a 64-bit RGBA hex value.
[inline]
pub fn (rgba Rgba64) set_hex(value u64) {
	unsafe {
		$if little_endian {
			rgba.components.b1 = u16(value >> 16) // b
			rgba.components.b2 = u16(value >> 32) // g
			rgba.components.b3 = u16(value >> 48) // r
			rgba.components.b4 = u16(value) // a
		} $else {
			rgba.components.b1 = u16(value) // a
			rgba.components.b2 = u16(value >> 48) // r
			rgba.components.b3 = u16(value >> 32) // g
			rgba.components.b4 = u16(value >> 16) // b
		}
	}
}

// Set the r (red) component.
[inline]
pub fn (rgba Rgba64) set_r(r u16) {
	unsafe {
		$if little_endian {
			rgba.components.b3 = r
		} $else {
			rgba.components.b2 = r
		}
	}
}

// Set the g (green) component.
[inline]
pub fn (rgba Rgba64) set_g(g u16) {
	unsafe {
		$if little_endian {
			rgba.components.b2 = g
		} $else {
			rgba.components.b3 = g
		}
	}
}

// Set the b (blue) component.
[inline]
pub fn (rgba Rgba64) set_b(b u16) {
	unsafe {
		$if little_endian {
			rgba.components.b1 = b
		} $else {
			rgba.components.b4 = b
		}
	}
}

// Set the a (alpha) component.
[inline]
pub fn (rgba Rgba64) set_a(a u16) {
	unsafe {
		$if little_endian {
			rgba.components.b4 = a
		} $else {
			rgba.components.b1 = a
		}
	}
}

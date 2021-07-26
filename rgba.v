module blend2d

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

// Returns a new 32-bit RGBA color (Rgba32) from byte components.
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

// Returns a new 32-bit RGBA color (Rgba32) from byte components, with full alpha.
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

// Returns a new 32-bit RGBA color (Rgba32) from a 32-bit hex value.
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

// Returns a new 32-bit RGBA color (Rgba32) from a 32-bit hex value, with full alpha.
[inline]
pub fn rgb_hex(value u32) Rgba {
	// println("${value:x}")
	// println("${(value | 0xFF000000):x}")
	// return Rgba {
	// 	value: value | 0xFF000000
	// }
	// return Rgba {
	// 	value: () | () | () | 255
	// }
	$if little_endian {
		return Rgba {
			components: Rgba_Components{
				b1: byte(value & 0xFF) // b
				b2: byte(value >> 8 & 0xFF) // g
				b3: byte(value >> 16 & 0xFF) // r
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

// Set the 32-bit color value by components.
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

struct Rgba64_Components {
mut:
	b u16
	g u16
	r u16
	a u16
}
// 64-bit RGBA color (16-bit per component) stored as `0xAAAARRRRGGGGBBBB`.
pub union Rgba64 {
mut:
	components Rgba64_Components
	value      u64
}

// ### Init

// Returns a new 64-bit RGBA color (Rgba64) from a 64-bit value.
[inline]
pub fn rgba64_hex(value u64) Rgba64 {
	return Rgba64 {
		value: value
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from byte components.
[inline]
pub fn rgba64(r u16, g u16, b u16, a u16) Rgba64 {
	return Rgba64 {
		components: Rgba64_Components{
			b: b
			g: g
			r: r
			a: a
		}
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from byte components, with full alpha.
[inline]
pub fn rgb64(r byte, g byte, b byte) Rgba64 {
	return Rgba64 {
		components: Rgba64_Components{
			b: b
			g: g
			r: r
		}
	}
}

// ### Access

// Returns the r (red) component.
[inline]
pub fn (rgba Rgba64) r() u16 {
	unsafe {
		return rgba.components.r
	}
}

// Returns the g (green) component.
[inline]
pub fn (rgba Rgba64) g() u16 {
	unsafe {
		return rgba.components.g
	}
}

// Returns the b (blue) component.
[inline]
pub fn (rgba Rgba64) b() u16 {
	unsafe {
		return rgba.components.b
	}
}

// Returns the a (alpha) component.
[inline]
pub fn (rgba Rgba64) a() u16 {
	unsafe {
		return rgba.components.a
	}
}

// Returns the 32-bit value.
[inline]
pub fn (rgba Rgba64) value() u64 {
	unsafe {
		return rgba.value
	}
}

// ### Modify

// Set the 32-bit color value by components.
[inline]
pub fn (rgba Rgba64) set(r u16, g u16, b u16, a u16) {
	unsafe {
		rgba.components.r = r
		rgba.components.g = g
		rgba.components.b = b
		rgba.components.a = a
	}
}

// Set the 32-bit color value.
[inline]
pub fn (rgba Rgba64) set_hex(value u64) {
	unsafe {
		rgba.value = value
	}
}

// Set the r (red) component.
[inline]
pub fn (rgba Rgba64) set_r(r u16) {
	unsafe {
		rgba.components.r = r
	}
}

// Set the g (green) component.
[inline]
pub fn (rgba Rgba64) set_g(g u16) {
	unsafe {
		rgba.components.g = g
	}
}

// Set the b (blue) component.
[inline]
pub fn (rgba Rgba64) set_b(b u16) {
	unsafe {
		rgba.components.b = b
	}
}

// Set the a (alpha) component.
[inline]
pub fn (rgba Rgba64) set_a(a u16) {
	unsafe {
		rgba.components.a = a
	}
}















/* The old ways

// ============================================================================
// RGBA 32-bit
// ============================================================================

// ### Definition

struct Rgba_Components {
mut:
	// $if C.BL_BYTE_ORDER == 1234 { // LITTLE ENDIAN
		b byte
		g byte
		r byte
		a byte = 255
	// } $else {
	// 	a byte = 255
	// 	r byte
	// 	g byte
	// 	b byte
	// }
}
// 32-bit RGBA color (8-bits per component) stored as `0xAARRGGBB`.
pub union Rgba {
mut:
	components Rgba_Components
	value      u32
}

// ### Init

// Returns a new 32-bit RGBA color (Rgba32) from a 32-bit value.
[inline]
pub fn rgba_hex(value u32) Rgba {
	return Rgba {
		value: value
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from byte components.
[inline]
pub fn rgba(r byte, g byte, b byte, a byte) Rgba {
	return Rgba {
		components: Rgba_Components{
			b: b
			g: g
			r: r
			a: a
		}
	}
}

// Returns a new 32-bit RGBA color (Rgba32) from byte components, with full alpha.
[inline]
pub fn rgb(r byte, g byte, b byte) Rgba {
	return Rgba {
		components: Rgba_Components{
			b: b
			g: g
			r: r
		}
	}
}

// ### Access

// Returns the r (red) component.
[inline]
pub fn (rgba Rgba) r() byte {
	unsafe {
		return rgba.components.r
	}
}

// Returns the g (green) component.
[inline]
pub fn (rgba Rgba) g() byte {
	unsafe {
		return rgba.components.g
	}
}

// Returns the b (blue) component.
[inline]
pub fn (rgba Rgba) b() byte {
	unsafe {
		return rgba.components.b
	}
}

// Returns the a (alpha) component.
[inline]
pub fn (rgba Rgba) a() byte {
	unsafe {
		return rgba.components.a
	}
}

// Returns the 32-bit value.
[inline]
pub fn (rgba Rgba) value() u32 {
	unsafe {
		return rgba.value
	}
}

// ### Modify

// Set the 32-bit color value by components.
[inline]
pub fn (rgba Rgba) set(r byte, g byte, b byte, a byte) {
	unsafe {
		rgba.components.r = r
		rgba.components.g = g
		rgba.components.b = b
		rgba.components.a = a
	}
}

// Set the 32-bit color value.
[inline]
pub fn (rgba Rgba) set_hex(value u32) {
	unsafe {
		rgba.value = value
	}
}

// Set the r (red) component.
[inline]
pub fn (rgba Rgba) set_r(r byte) {
	unsafe {
		rgba.components.r = r
	}
}

// Set the g (green) component.
[inline]
pub fn (rgba Rgba) set_g(g byte) {
	unsafe {
		rgba.components.g = g
	}
}

// Set the b (blue) component.
[inline]
pub fn (rgba Rgba) set_b(b byte) {
	unsafe {
		rgba.components.b = b
	}
}

// Set the a (alpha) component.
[inline]
pub fn (rgba Rgba) set_a(a byte) {
	unsafe {
		rgba.components.a = a
	}
}

// ============================================================================
// RGBA 64-bit
// ============================================================================

struct Rgba64_Components {
mut:
	b u16
	g u16
	r u16
	a u16
}
// 64-bit RGBA color (16-bit per component) stored as `0xAAAARRRRGGGGBBBB`.
pub union Rgba64 {
mut:
	components Rgba64_Components
	value      u64
}

// ### Init

// Returns a new 64-bit RGBA color (Rgba64) from a 64-bit value.
[inline]
pub fn rgba64_hex(value u64) Rgba64 {
	return Rgba64 {
		value: value
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from byte components.
[inline]
pub fn rgba64(r u16, g u16, b u16, a u16) Rgba64 {
	return Rgba64 {
		components: Rgba64_Components{
			b: b
			g: g
			r: r
			a: a
		}
	}
}

// Returns a new 64-bit RGBA color (Rgba64) from byte components, with full alpha.
[inline]
pub fn rgb64(r byte, g byte, b byte) Rgba64 {
	return Rgba64 {
		components: Rgba64_Components{
			b: b
			g: g
			r: r
		}
	}
}

// ### Access

// Returns the r (red) component.
[inline]
pub fn (rgba Rgba64) r() u16 {
	unsafe {
		return rgba.components.r
	}
}

// Returns the g (green) component.
[inline]
pub fn (rgba Rgba64) g() u16 {
	unsafe {
		return rgba.components.g
	}
}

// Returns the b (blue) component.
[inline]
pub fn (rgba Rgba64) b() u16 {
	unsafe {
		return rgba.components.b
	}
}

// Returns the a (alpha) component.
[inline]
pub fn (rgba Rgba64) a() u16 {
	unsafe {
		return rgba.components.a
	}
}

// Returns the 32-bit value.
[inline]
pub fn (rgba Rgba64) value() u64 {
	unsafe {
		return rgba.value
	}
}

// ### Modify

// Set the 32-bit color value by components.
[inline]
pub fn (rgba Rgba64) set(r u16, g u16, b u16, a u16) {
	unsafe {
		rgba.components.r = r
		rgba.components.g = g
		rgba.components.b = b
		rgba.components.a = a
	}
}

// Set the 32-bit color value.
[inline]
pub fn (rgba Rgba64) set_hex(value u64) {
	unsafe {
		rgba.value = value
	}
}

// Set the r (red) component.
[inline]
pub fn (rgba Rgba64) set_r(r u16) {
	unsafe {
		rgba.components.r = r
	}
}

// Set the g (green) component.
[inline]
pub fn (rgba Rgba64) set_g(g u16) {
	unsafe {
		rgba.components.g = g
	}
}

// Set the b (blue) component.
[inline]
pub fn (rgba Rgba64) set_b(b u16) {
	unsafe {
		rgba.components.b = b
	}
}

// Set the a (alpha) component.
[inline]
pub fn (rgba Rgba64) set_a(a u16) {
	unsafe {
		rgba.components.a = a
	}
}
*/

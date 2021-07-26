module blend2d

// ============================================================================
// Format - Definitions
// ============================================================================

// Image Pixel Format.
// These are included formats that may be used to determine format of Blend2D internal data.
pub enum Format {
	@none   // None or invalid pixel format.
	prgb32  // 32-bit premultiplied ARGB pixel format (8-bit components).
	xrgb32  // 32-bit (X)RGB pixel format (8-bit components, alpha ignored).
	a8      // 8-bit alpha-only pixel format.
	count   // Count of pixel formats.
}

struct C.BLFormatInfo {
	depth u32
	flags FormatFlags // (u32)

	// union {
	// 	struct {
	sizes[4] byte
	shifts[4] byte
	// 	}

	// 	struct {
	// 		rSize byte
	// 		gSize byte
	// 		bSize byte
	// 		aSize byte

	// 		rShift byte
	// 		gShift byte
	// 		bShift byte
	// 		aShift byte
	// 	}

	// 	palette &C.BLRgba32
	// }
}
// Provides a detailed information about a pixel format. Use `blFormatInfo`
// array to get an information of Blend2D native pixel formats.
pub type FormatInfo = C.BLFormatInfo

// Pixel format flags.
[flag]
enum FormatFlags {
	rgb           // = 0x00000001      // Pixel format provides RGB components.
	alpha         // = 0x00000002      // Pixel format provides only alpha component.
	// rgba          = 0x00000003      // A combination of `.rgb | .alpha`.
	lum           // = 0x00000004      // Pixel format provides LUM component (and not RGB components).
	// luma          = 0x00000006      // A combination of `.lum | .alpha`.
	unused_8
	indexed       // = 0x00000010      // Indexed pixel format the requres a palette (I/O only).
	unused_20
	unused_40
	unused_80
	premultiplied // = 0x00000100      // RGB components are premultiplied by alpha component.
	byte_swap     // = 0x00000200      // Pixel format doesn't use native byte-order (I/O only).
	unused_400
	unused_800
	unused_1000
	unused_2000
	unused_4000
	unused_8000

	// The following flags are only informative. They are part of `blFormatInfo[]`,
	// but doesn't have to be passed to `BLPixelConverter` as they can be easily
	// calculated.

	// Pixel components are byte aligned (all 8bpp).
	byte_aligned // = 0x00010000 

	// Pixel has some undefined bits that represent no information.
	//
	// For example a 32-bit XRGB pixel has 8 undefined bits that are usually set
	// to all ones so the format can be interpreted as premultiplied RGB as well.
	// There are other formats like 16_0555 where the bit has no information and
	// is usually set to zero. Blend2D doesn't rely on the content of such bits.
	undefined_bits // = 0x00020000

	// Convenience flag that contains either zero or `BL_FORMAT_FLAG_BYTE_SWAP`
	// depending on host byte order. Little endian hosts have this flag set to
	// zero and big endian hosts to `BL_FORMAT_FLAG_BYTE_SWAP`.
	//
	// \note This is not a real flag that you can test, it's only provided for
	// convenience to define little endian pixel formats.
	// BL_FORMAT_FLAG_LE = (BL_BYTE_ORDER == 1234) ? (uint32_t)0 : (uint32_t)BL_FORMAT_FLAG_BYTE_SWAP,
	// * V does not allow const expressions in enums yet

	// Convenience flag that contains either zero or `BL_FORMAT_FLAG_BYTE_SWAP`
	// depending on host byte order. Big endian hosts have this flag set to
	// zero and little endian hosts to `BL_FORMAT_FLAG_BYTE_SWAP`.
	//
	// \note This is not a real flag that you can test, it's only provided for
	// convenience to define big endian pixel formats.
	// BL_FORMAT_FLAG_BE = (BL_BYTE_ORDER == 4321) ? (uint32_t)0 : (uint32_t)BL_FORMAT_FLAG_BYTE_SWAP
	// * V does not allow const expressions in enums yet
}
const rgba = FormatFlags(0x00000003) // A combination of `.rgb | .alpha`.
const luma = FormatFlags(0x00000006) // A combination of `.lum | .alpha`.

// Returns the format info for one of the included image pixel formats.
const format_info = [
	format_info_none
	format_info_prgb32
	format_info_xrgb32
	format_info_a8
]

// ============================================================================
// Format - Included Formats
// ============================================================================

const u = 0 // Used only to distinguish between zero and unused.

// Struct sizes/shifts definition is in order: r, g, b, a

const format_info_none = FormatInfo{
	depth: 0
	flags: FormatFlags(0)
	sizes: [byte(u), u, u, u]!
	shifts: [byte(u), u, u, u]!
}

const format_info_prgb32 = FormatInfo{
	depth: 32
	flags: rgba | .premultiplied | .byte_aligned
	sizes: [byte(8), 8, 8, 8]!
	shifts: [byte(16), 8, 0, 24]!
}
const format_info_argb8888 = format_info_prgb32

const format_info_xrgb32 = FormatInfo{
	depth: 32
	flags: .rgb | .byte_aligned | .undefined_bits
	sizes: [byte(8), 8, 8, u]!
	shifts: [byte(16), 8, 0, u]!
}
const format_info_xrgb8888 = format_info_xrgb32

const format_info_a8 = FormatInfo{
	depth: 8
	flags: .alpha | .byte_aligned
	sizes: [byte(u), u, u, 8]!
	shifts: [byte(u), u, u, 0]!
}

// ============================================================================
// Format - Additional Formats
// ============================================================================

const format_info_rgba8888 = FormatInfo{
	depth: 32
	flags: rgba | .premultiplied | .byte_aligned
	sizes: [byte(8), 8, 8, 8]!
	shifts: [byte(0), 8, 16, 24]!
}

// TODO - create definitions for other common formats

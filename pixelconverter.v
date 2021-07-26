// See also format.v

module blend2d

// ============================================================================
// Pixel Converter - Definition
// ============================================================================

struct C.BLPixelConverterCore {
	// union {
	// 	struct {
	// Converter function.
	convertFunc PixelConverterFunc
	// Internal flags used by the converter - non-zero value means initialized.
	internalFlags byte 
	// 	}

	// 	Internal data not exposed to users, aligned to sizeof(void*).
	// 	uint8_t data[80];
	// }
}
// Pixel format converter.
pub type PixelConverter = C.BLPixelConverterCore

// Flags used by `new_pixel_converter()` function.
[flag]
enum PixelConverterFlags {
	// Specifies that the source palette in `BLFormatInfo` doesn't have to by
	// copied by `BLPixelConverter`. The caller must ensure that the palette
	// would stay valid until the pixel converter is destroyed.
	dont_copy_palette // = 0x00000001

	// Specifies that the source palette in `BLFormatInfo` is alterable and
	// the pixel converter can modify it when preparing the conversion. The
	// modification can be irreversible so only use this flag when you are sure
	// that the palette passed to `BLPixelConverter::create()` won't be needed
	// outside of pixel conversion.
	//
	// \note The flag `BL_PIXEL_CONVERTER_CREATE_FLAG_DONT_COPY_PALETTE` must be
	// set as well, otherwise this flag would be ignored.
	alterable_palette // = 0x00000002

	// When there is no built-in conversion between the given pixel formats it's
	// possible to use an intermediate format that is used during conversion. In
	// such case the base pixel converter creates two more converters that are
	// then used internally.
	//
	// This option disables such feature - creating a pixel converter would fail
	// with `BL_ERROR_NOT_IMPLEMENTED` error if direct conversion is not possible.
	no_multi_step // = 0x00000004
}

struct PixelConverterCfg {
	flags PixelConverterFlags = PixelConverterFlags(0)
}

// ============================================================================
// Pixel Converter - Init
// ============================================================================

fn C.blPixelConverterInit(/*mut*/ self &C.BLPixelConverterCore) BLResult
fn C.blPixelConverterCreate(/*mut*/ self &C.BLPixelConverterCore, dstInfo &C.BLFormatInfo, srcInfo &C.BLFormatInfo, createFlags u32) BLResult
// Create a new PixelConverter for the specified source and destination formats.
[inline]
pub fn new_pixel_converter(dst_info &FormatInfo, src_info &FormatInfo, cfg PixelConverterCfg) &PixelConverter {
	mut conv := &PixelConverter{}
	C.blPixelConverterInit(/*mut*/ conv)
	res := C.blPixelConverterCreate(/*mut*/ conv, dst_info, src_info, u32(cfg.flags))
	if res != 0 {
		panic(Result{
			msg: "Could not create pixel converter."
			result: ResultCode(res)
		})
	}
	return conv
}

// ============================================================================
// Pixel Converter - Conversion
// ============================================================================

// Use the converter to convert the span of pixels using its source/destination pair.
[inline]
pub fn (conv &PixelConverter) convert_span(dst_data voidptr, src_data voidptr, w u32) {
	// TODO: Make (additional) safer version, with limit checks and/or with V arrays
	res := conv.convertFunc(conv, dst_data, 0, src_data, 0, w, 1, voidptr(0))
	if res != 0 {
		panic(Result{
			msg: "Could not convert pixels."
			result: ResultCode(res)
		})
	}
}

// ============================================================================
// Pixel Converter - Internal Definitions
// ============================================================================

type PixelConverterFunc = fn (self &C.BLPixelConverterCore, dst_data /* &u8 */ voidptr, dst_stride /* intptr_t */ int, src_data /* &u8 */ voidptr, src_stride /* intptr_t */ int, w u32, h u32, options &C.BLPixelConverterOptions) BLResult

// Pixel conversion options.
struct C.BLPixelConverterOptions {
  origin C.BLPointI
  gap size_t
}

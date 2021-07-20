module blend2d

// ============================================================================
// Image - Definitions
// ============================================================================

struct C.BLImageImpl {
	pub:
	pixelData voidptr  // Pixel data.

	refCount size_t  // Reference count.
	implType byte    // Impl type.
	implTraits byte  // Impl traits.
	memPoolData u16  // Memory pool data.

	format byte    // Image format.
	flags byte     // Image flags.
	depth u16      // Image depth (in bits).
	size C.BLSizeI // Image size.
	stride i64     // Image stride.
}
struct C.BLImageCore {
	pub:
	impl &C.BLImageImpl = voidptr(0)
}
// Image.
pub type Image = C.BLImageCore

// Image Pixel Format.
pub enum Format {
	@none   // None or invalid pixel format.
	prgb32  // 32-bit premultiplied ARGB pixel format (8-bit components).
	xrgb32  // 32-bit (X)RGB pixel format (8-bit components, alpha ignored).
	a8      // 8-bit alpha-only pixel format.
	count   // Count of pixel formats.
}

struct C.BLImageData {
	pixelData voidptr
	stride    /*inteptr_t*/int
	size      Size
	format    Format
	flags     u32
}
// Data describing a raster image.
pub type ImageData = C.BLImageData

//! Filter type used by `BLImage::scale()`.
enum ScaleFilter {
	@none    = 0  // No filter or uninitialized.
	nearest  = 1  // Nearest neighbor filter (radius 1.0).
	bilinear = 2  // Bilinear filter (radius 1.0).
	bicubic  = 3  // Bicubic filter (radius 2.0).
	bell     = 4  // Bell filter (radius 1.5).
	gauss    = 5  // Gauss filter (radius 2.0).
	hermite  = 6  // Hermite filter (radius 1.0).
	hanning  = 7  // Hanning filter (radius 1.0).
	catrom   = 8  // Catrom filter (radius 2.0).
	bessel   = 9  // Bessel filter (radius 3.2383).
	sinc     = 10  // Sinc filter (radius 2.0, adjustable through `BLImageScaleOptions`).
	lanczos  = 11  // Lanczos filter (radius 2.0, adjustable through `BLImageScaleOptions`).
	blackman = 12  // Blackman filter (radius 2.0, adjustable through `BLImageScaleOptions`).
	mitchell = 13  // Mitchell filter (radius 2.0, parameters 'b' and 'c' passed through `BLImageScaleOptions`).
	user     = 14  // Filter using a user-function, must be passed through `BLImageScaleOptions`.

	count    = 15  // Count of image-scale filters.
}

// Custom option for image scaling. TODO: scale_custom()
// struct BLImageScaleOptions {
//   BLImageScaleUserFunc userFunc;
//   void* userData;

//   double radius;
//   union {
//     double data[3];
//     struct {
//       double b, c;
//     } mitchell;
//   };
// }

// ============================================================================
// Image - Init / Destroy
// ============================================================================

fn C.blImageInitAs(/*mut*/ self &C.BLImageCore, w int, h int, format u32) BLResult
// Create a new Image with the specified dimensions in the premultiplied RGB 32-bit format.
[inline]
pub fn new_image(w int, h int) ?&Image {
	mut img := &Image{}
	res := C.blImageInitAs(/*mut*/ img, w, h, u32(Format.prgb32))
	if res != 0 {
		return IError(Result{
			msg: "Could not create image."
			result: ResultCode(res)
		})
	}
	return img
}

fn C.blImageInitAs(/*mut*/ self &C.BLImageCore, w int, h int, format u32) BLResult
// Create a new Image with the specified dimensions and pixel format.
[inline]
pub fn new_image_with_format(w int, h int, format Format) ?&Image {
	mut img := &Image{}
	res := C.blImageInitAs(/*mut*/ img, w, h, u32(format))
	if res != 0 {
		return IError(Result{
			msg: "Could not create image."
			result: ResultCode(res)
		})
	}
	return img
}

fn C.blImageInitAsFromData(/*mut*/ self &C.BLImageCore, w int, h int, format u32, pixelData voidptr, stride /*intptr_t*/int, destroyFunc DestroyCallback, /*mut*/ destroyData voidptr) BLResult
// Create an image from data (memory) according to dimensions, stride (valid line width in bytes), and pixel format. 
// Blend2D image updates will update the original data.
// For encoded data, use `read_from_memory()`.
[inline]
pub fn new_image_from_data(pixel_data voidptr, w int, h int, stride int, format Format) ?&Image {
	mut img := &Image{}
	res := C.blImageInitAsFromData(/*mut*/ img, w, h, u32(format), pixel_data, stride, voidptr(0), voidptr(0))
	if res != 0 {
		return IError(Result{
			msg: "Could not create image from data."
			result: ResultCode(res)
		})
	}
	return img
}

fn C.blImageDestroy(self &C.BLImageCore) BLResult
// Free the Image data from memory. (Called by V's autofree engine).
[inline]
pub fn (img &Image) free() {
	C.blImageDestroy(img)
}

// ============================================================================
// Image - I/O  (Encode/Decode)
// ============================================================================

fn C.blImageWriteToFile(self &C.BLImageCore, fileName charptr, codec &C.BLImageCodecCore) BLResult
// Write image to file using the specified codec.
[inline]
pub fn (img &Image) write_to_file(file_name string, codec &ImageCodec) ? {
	res := C.blImageWriteToFile(img, file_name.str, codec)
	if res != 0 {
		return IError(Result{
			msg: "Could not write image to file."
			result: ResultCode(res)
		})
	}
}

fn C.blImageInit(self &C.BLImageCore) BLResult
fn C.blImageReadFromFile(/*mut*/ self &C.BLImageCore, fileName &char, codecs &C.BLArrayCore) BLResult
// Read image from file. Codec determined from file contents.
[inline]
pub fn read_from_file(file_name string) ?&Image {
	mut img := &Image{}
	C.blImageInit(img)
	res := C.blImageReadFromFile(/*mut*/ img, file_name.str, voidptr(0))
	if res != 0 {
		return IError(Result{
			msg: "Could not read image from file."
			result: ResultCode(res)
		})
	}
	return img
}

fn C.blImageWriteToData(self &C.BLImageCore, /*mut*/ dst &C.BLArrayCore, codec &C.BLImageCodecCore) BLResult
// Write image to memory using the specified codec. Returns the written data.
[inlne]
pub fn (img &Image) write_to_memory(codec &ImageCodec) ?[]byte {
	mut out := new_array<byte>()
	res := C.blImageWriteToData(img, /*mut*/ out, codec)
	if res != 0 {
		return IError(Result{
			msg: "Could not write image to memory."
			result: ResultCode(res)
		})
	}
	unsafe {
		// fn (data voidptr) vbytes(len int) []byte
		// From the docs: "the data is reused, NOT copied!"
		// Must be called within `unsafe` block.
		return out.impl.data.vbytes(int(out.impl.size))
	}
}

fn C.blImageInit(self &C.BLImageCore) BLResult
fn C.blImageReadFromData(/*mut*/ self &C.BLImageCore, data voidptr, size size_t, codecs &C.BLArrayCore) BLResult
// Read image from memory. Codec determined from memory contents.
// For unencoded data, use `new_image_from_data()`.
[inlne]
pub fn read_from_memory(data []byte) ?&Image {
	mut img := &Image{}
	C.blImageInit(img)
	res := C.blImageReadFromData(/*mut*/ img, data.data, data.len, voidptr(0))
	if res != 0 {
		return IError(Result{
			msg: "Could not read image from memory."
			result: ResultCode(res)
		})
	}
	return img
}

// ============================================================================
// Image - UNCATEGORIZED
// ============================================================================

fn C.blImageInit(self &C.BLImageCore) BLResult
fn C.blImageAssignDeep(/*mut*/ self &C.BLImageCore, other &C.BLImageCore) BLResult
// Create a new Image identical to the specified Image.
[inline]
pub fn (img &Image) copy() ?&Image {
	mut img_copy := &Image{}
	C.blImageInit(img_copy)
	res := C.blImageAssignDeep(/*mut*/ img_copy, img)
	if res != 0 {
		return IError(Result{
			msg: "Could not create image copy."
			result: ResultCode(res)
		})
	}
	return img_copy
}

fn C.blImageGetData(self &C.BLImageCore, /*mut*/ dataOut &C.BLImageData) BLResult
// Returns complete image raster datan including formatting metadata.
[inline]
pub fn (img &Image) get_data() ImageData {
	img_data := ImageData{}
	C.blImageGetData(img, /*mut*/ &img_data)
	return img_data
}

fn C.blImageConvert(/*mut*/ self &C.BLImageCore, format u32) BLResult
// Convert the (raw) format of an image to a new format in-place.
[inline]
pub fn (img &Image) convert(format Format) {
	C.blImageConvert(/*mut*/ img, u32(format))
}

fn C.blImageEquals(a &C.BLImageCore, b &C.BLImageCore) bool
// Returns true if both images are the same size and contain the same data.
[inline]
pub fn (img &Image) equals(img2 &Image) bool {
	return C.blImageEquals(img, img2)
}

fn C.blImageInit(self &C.BLImageCore) BLResult
fn C.blImageScale(/*mut*/ dst &C.BLImageCore, src &C.BLImageCore, size &C.BLSizeI, filter u32, options &C.BLImageScaleOptions) BLResult
// Create a new scaled copy of the specified Image.
[inline]
pub fn (img &Image) scale(new_w int, new_h int, filter ScaleFilter) ?&Image {
	mut img_copy := &Image{}
	C.blImageInit(img_copy)
	res := C.blImageScale(/*mut*/ img_copy, img, &Size{w: new_w, h: new_h}, u32(filter), voidptr(0))
	if res != 0 {
		return IError(Result{
			msg: "Could not create scaled image copy."
			result: ResultCode(res)
		})
	}
	return img_copy
}

// ============================================================================
// Image - Unused
// ============================================================================

// Low-level management.
// fn C.blImageReset(mut self &C.BLImageCore) BLResult
// Low-level management.
// fn C.blImageAssignMove(mut self &C.BLImageCore, other &C.BLImageCore) BLResult
// Low-level management.
// fn C.blImageAssignWeak(mut self &C.BLImageCore, other &C.BLImageCore) BLResult
// Has InitAs equivalent.
// fn C.blImageCreate(mut self &C.BLImageCore, w int, h int, format u32) BLResult
// Has InitAs equivalent.
// fn C.blImageCreateFromData(mut self &C.BLImageCore, w int, h int, format u32, mut pixelData voidptr, int stride, DestroyCallback destroyFunc, mut destroyData voidptr) BLResult
// Low-level management.
// fn C.blImageMakeMutable(mut self &C.BLImageCore, dataOut &C.BLImageData) BLResult

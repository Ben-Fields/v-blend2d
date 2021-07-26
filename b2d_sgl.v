module blend2d

import sokol.gfx
import sokol.sgl
import gg

// TODO: `if you need to destroy resources before sg_shutdown(), call:  sg_destroy_image(sg_image img)`

// Wrap the specific Sokol Image config & render data in a struct to make drawing to window easier, similar to gg.

// Image Buffer. Create one for your image to render with `gg`.
struct ImageBuffer {
	bimg Image          // Blend2D image
	simg C.sg_image     // Sokol image
	// Formatted buffer
	rgba_buf []byte     // Image buffer in RGBA ordered format
	px u32              // RGBA image number of pixels
	sz u32              // RGBA image pixel data size in bytes
	conv PixelConverter // Blend2D converter to RGBA
pub mut:
	// Rendered dimensions
	x int 
	y int
	w int
	h int
}

// Create an Image Buffer for rendering the specified image. Default rendering dimensions are equal to the image dimensions.
pub fn new_image_buffer(img Image) ImageBuffer {
	// Init sokol image
	img_desc := C.sg_image_desc{
		// Dimensions
		width: img.impl.size.w
		height: img.impl.size.h
		// Image is for streaming/updating every frame (no intial content allowed)
		usage: .stream
		// Format info
		@type: ._2d
		pixel_format: .rgba8
		// Just a plain 2D image
		num_mipmaps: 0
		wrap_u: .clamp_to_edge
		wrap_v: .clamp_to_edge
		label: &byte(0)
		d3d11_texture: 0
		min_filter: .nearest
		mag_filter: .nearest
	}
	// Create the image buffer metadata structure with the sokol image
	px := u32(img.impl.size.w * img.impl.size.h)
	sz := u32(px * 4)
	img_buf := ImageBuffer{
		bimg: img
		simg: gfx.make_image(&img_desc)
		rgba_buf: []byte{len: int(sz), cap: int(sz)}
		px: px
		sz: sz
		conv: new_pixel_converter(format_info_rgba8888, format_info_prgb32)
		x: 0
		y: 0
		w: img.impl.size.w
		h: img.impl.size.h
	} // FIXME: check sg_error after make_iamge and return optional
	return img_buf
}

// Update and draw the image to the specified `gg` context.
pub fn (img_buf ImageBuffer) draw(ctx gg.Context) {
	// Convert the pixel format to 32-bit RGBA byte order, the only format that sokol will universally accept.
	// TODO: Need better/more efficient method other than comverting on CPU every frame, but this is the best for now.
	//   - As image size increases, performance approaches ~50% original.
	// TODO: Need to call the other version accounting for stride to really be correct. (probably supports A8 and whatnot).
	//   - Also need to convert based on format of the passed b2d image, not just assume prgb32.
	// TODO: Make a utility verison of this for []byte or &Image or something in pixelconverter.v.
	img_buf.conv.convert_span(img_buf.rgba_buf.data, img_buf.bimg.impl.pixelData, img_buf.px)
	// Update the sokol.gfx image with the blend2d one
	mut image_content := C.sg_image_data{
		// subimage [6][16]C.sg_range
	}
	image_content.subimage[0][0] = C.sg_range{
		ptr: img_buf.rgba_buf.data
		size: size_t(img_buf.sz)
	}
	gfx.update_image(img_buf.simg, &image_content)
	// Image rendering coordinates
	u0 := f32(0.0)
	v0 := f32(0.0)
	u1 := f32(1.0)
	v1 := f32(1.0)
	x0 := f32(img_buf.x)
	y0 := f32(img_buf.y)
	x1 := f32(img_buf.x + img_buf.w)
	y1 := f32(img_buf.y + img_buf.h)
	// Queue draw command using sokol.gl
	sgl.load_pipeline(ctx.timage_pip)
	sgl.enable_texture()
	sgl.texture(img_buf.simg)
	sgl.begin_quads()
	sgl.c4b(255, 255, 255, 255)
	sgl.v2f_t2f(x0, y0, u0, v0)
	sgl.v2f_t2f(x1, y0, u1, v0)
	sgl.v2f_t2f(x1, y1, u1, v1)
	sgl.v2f_t2f(x0, y1, u0, v1)
	sgl.end()
	sgl.disable_texture()
}

// Draw the currently stored image to the specified `gg` context.
pub fn (img_buf ImageBuffer) draw_cached(ctx gg.Context) {
	// Image rendering coordinates
	u0 := f32(0.0)
	v0 := f32(0.0)
	u1 := f32(1.0)
	v1 := f32(1.0)
	x0 := f32(img_buf.x)
	y0 := f32(img_buf.y)
	x1 := f32(img_buf.x + img_buf.w)
	y1 := f32(img_buf.y + img_buf.h)
	// Queue draw command using sokol.gl
	sgl.load_pipeline(ctx.timage_pip)
	sgl.enable_texture()
	sgl.texture(img_buf.simg)
	sgl.begin_quads()
	sgl.c4b(255, 255, 255, 255)
	sgl.v2f_t2f(x0, y0, u0, v0)
	sgl.v2f_t2f(x1, y0, u1, v0)
	sgl.v2f_t2f(x1, y1, u1, v1)
	sgl.v2f_t2f(x0, y1, u0, v1)
	sgl.end()
	sgl.disable_texture()
}

// Update and draw the image to the specified `gg` context.
// Unconverted pixel format, so components may be swapped.
pub fn (img_buf ImageBuffer) draw_raw(ctx gg.Context) {
	// Update the sokol.gfx image with the blend2d one
	mut image_content := C.sg_image_data{
		// subimage [6][16]C.sg_range
	}
	image_content.subimage[0][0] = C.sg_range{
		ptr: img_buf.bimg.impl.pixelData
		size: size_t(img_buf.bimg.impl.size.w*img_buf.bimg.impl.size.h*4)
	}
	gfx.update_image(img_buf.simg, &image_content)
	// Image rendering coordinates
	u0 := f32(0.0)
	v0 := f32(0.0)
	u1 := f32(1.0)
	v1 := f32(1.0)
	x0 := f32(img_buf.x)
	y0 := f32(img_buf.y)
	x1 := f32(img_buf.x + img_buf.w)
	y1 := f32(img_buf.y + img_buf.h)
	// Queue draw command using sokol.gl
	sgl.load_pipeline(ctx.timage_pip)
	sgl.enable_texture()
	sgl.texture(img_buf.simg)
	sgl.begin_quads()
	sgl.c4b(255, 255, 255, 255)
	sgl.v2f_t2f(x0, y0, u0, v0)
	sgl.v2f_t2f(x1, y0, u1, v0)
	sgl.v2f_t2f(x1, y1, u1, v1)
	sgl.v2f_t2f(x0, y1, u0, v1)
	sgl.end()
	sgl.disable_texture()
}

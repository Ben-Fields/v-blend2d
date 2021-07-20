module blend2d

import sokol.gfx
import sokol.sgl
import gg

// Wrap the specific Sokol Image config & render data in a struct to make drawing to window easier, similar to gg.

// Image Buffer. Create one for your image to render with `gg`.
struct ImageBuffer {
	bimg Image      // Blend2D image
	simg C.sg_image // Sokol image
pub mut:
	x int // Rendered dimensions
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
	img_buf := ImageBuffer{
		bimg: img
		simg: gfx.make_image(&img_desc)
		x: 0
		y: 0
		w: img.impl.size.w
		h: img.impl.size.h
	} // FIXME: check sg_error after make_iamge and return optional
	return img_buf
}

// Draw the image to the specified `gg` context.
pub fn (img_buf ImageBuffer) draw(ctx gg.Context) {
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
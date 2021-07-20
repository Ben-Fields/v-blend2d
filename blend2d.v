module blend2d

// ============================================================================
// General - Compilation & Import
// ============================================================================

#flag -D BL_STATIC

#flag -L @VROOT/build
#flag -L @VROOT/build/Release
#flag -lblend2d

#flag -I @VROOT/c/src
#include "blend2d.h"

// ============================================================================
// General - Definitions
// ============================================================================

type BLResult = u32
pub struct Result {
	msg string
	code int = 1
	result ResultCode
}

// Blend2D (error) result code.
pub enum ResultCode {
	success			= 0

	out_of_memory	= 0x00010000	// Out of memory					[ENOMEM].
	invalid_value					// Invalid value/argument			[EINVAL].
	invalid_state					// Invalid state					[EFAULT].
	invalid_handle					// Invalid handle or file.			[EBADF].
	value_too_large					// Value too large					[EOVERFLOW].
	not_initialized					// Object not initialized.
	not_implemented					// Not implemented					[ENOSYS].
	not_permitted					// Operation not permitted			[EPERM].
	
	io								// IO error							[EIO].
	busy							// Device or resource busy			[EBUSY].
	interrupted						// Operation interrupted			[EINTR].
	try_again						// Try again						[EAGAIN].
	timed_out						// Timed out						[ETIMEDOUT].
	broken_pipe						// Broken pipe						[EPIPE].
	invalid_seek					// File is not seekable				[ESPIPE].
	symlink_loop					// Too many levels of symlinks		[ELOOP].
	file_too_large					// File is too large				[EFBIG].
	already_exists					// File/directory already exists	[EEXIST].
	access_denied					// Access denied					[EACCES].
	media_changed					// Media changed					[Windows::ERROR_MEDIA_CHANGED].
	read_only_fs					// The file/FS is read-only			[EROFS].
	no_device						// Device doesn't exist				[ENXIO].
	no_entry						// Not found no entry (fs)			[ENOENT].
	no_media						// No media in drive/device			[ENOMEDIUM].
	no_more_data					// No more data / end of file		[ENODATA].
	no_more_files					// No more files					[ENMFILE].
	no_space_left					// No space left on device			[ENOSPC].
	not_empty						// Directory is not empty			[ENOTEMPTY].
	not_file						// Not a file						[EISDIR].
	not_directory					// Not a directory					[ENOTDIR].
	not_same_device					// Not same device					[EXDEV].
	not_block_device				// Not a block device				[ENOTBLK].
	
	invalid_file_name				// File/path name is invalid		[n/a].
	file_name_too_long				// File/path name is too long		[ENAMETOOLONG].
	
	too_many_open_files				// Too many open files				[EMFILE].
	too_many_open_files_by_os		// Too many open files by OS		[ENFILE].
	too_many_links					// Too many symbolic links on FS	[EMLINK].
	too_many_threads				// Too many threads					[EAGAIN].
	thread_pool_exhausted			// Thread pool is exhausted and couldn't acquire the requested thread count.
	
	file_empty						// File is empty (not specific to any OS error).
	open_failed						// File open failed					[Windows::ERROR_OPEN_FAILED].
	not_root_device					// Not a root device/directory		[Windows::ERROR_DIR_NOT_ROOT].
	
	unknown_system_error			// Unknown system error that failed to translate to Blend2D result code.
	
	invalid_alignment				// Invalid data alignment.
	invalid_signature				// Invalid data signature or header.
	invalid_data					// Invalid or corrupted data.
	invalid_string					// Invalid string (invalid data of either UTF8 UTF16 or UTF32).
	data_truncated					// Truncated data (more data required than memory/stream provides).
	data_too_large					// Input data too large to be processed.
	decompression_failed			// Decompression failed due to invalid data (RLE Huffman etc).
	
	invalid_geometry				// Invalid geometry (invalid path data or shape).
	no_matching_vertex				// Returned when there is no matching vertex in path data.
	
	no_matching_cookie				// No matching cookie (BLContext).
	no_states_to_restore			// No states to restore (BLContext).
	
	image_too_large					// The size of the image is too large.
	image_no_matching_codec			// Image codec for a required format doesn't exist.
	image_unknown_file_format		// Unknown or invalid file format that cannot be read.
	image_decoder_not_provided		// Image codec doesn't support reading the file format.
	image_encoder_not_provided		// Image codec doesn't support writing the file format.
	
	png_multiple_ihdr				// Multiple IHDR chunks are not allowed (PNG).
	png_invalid_idat				// Invalid IDAT chunk (PNG).
	png_invalid_iend				// Invalid IEND chunk (PNG).
	png_invalid_plte				// Invalid PLTE chunk (PNG).
	png_invalid_trns				// Invalid tRNS chunk (PNG).
	png_invalid_filter				// Invalid filter type (PNG).
	
	jpeg_unsupported_feature		// Unsupported feature (JPEG).
	jpeg_invalid_sos				// Invalid SOS marker or header (JPEG).
	jpeg_invalid_sof				// Invalid SOF marker (JPEG).
	jpeg_multiple_sof				// Multiple SOF markers (JPEG).
	jpeg_unsupported_sof			// Unsupported SOF marker (JPEG).
	
	font_not_initialized			// Font doesn't have any data as it's not initialized.
	font_no_match					// Font or font-face was not matched (BLFontManager).
	font_no_character_mapping		// Font has no character to glyph mapping data.
	font_missing_important_table	// Font has missing an important table.
	font_feature_not_available		// Font feature is not available.
	font_cff_invalid_data			// Font has an invalid CFF data.
	font_program_terminated			// Font program terminated because the execution reached the limit.

	invalid_glyph					// Invalid glyph identifier.
}

// Extend mode.
pub enum ExtendMode {
	pad = 0  // Pad extend [default].
	repeat = 1  // Repeat extend.
	reflect = 2  // Reflect extend.

	pad_x_repeat_y = 3  // Pad X and repeat Y.
	pad_x_reflect_y = 4  // Pad X and reflect Y.
	repeat_x_pad_y = 5  // Repeat X and pad Y.
	repeat_x_reflect_y = 6  // Repeat X and reflect Y.
	reflect_x_pad_y = 7  // Reflect X and pad Y.
	reflect_x_repeat_y = 8  // Reflect X and repeat Y.

	// TODO: Fix
	// simple_count = 3 // Count of simple extend modes (that use the same value for X and Y).
	// complex_count = 9 // Count of complex extend modes (that can use independent values for X and Y).
}

pub type DestroyCallback = fn (impl voidptr, destroy_data voidptr)

// Text encoding.
enum C_BLTextEncoding {
	utf8 = 0  // UTF-8 encoding.
	utf16 = 1  // UTF-16 encoding (native endian).
	utf32 = 2  // UTF-32 encoding (native endian).
	latin1 = 3  // LATIN1 encoding (one byte per character).

	// TODO: fix
	/*
	// Platform native `wchar_t` (or Windows `WCHAR`) encoding, alias to
	// either UTF-32, UTF-16, or UTF-8 depending on `sizeof(wchar_t)`.
	BL_TEXT_ENCODING_WCHAR
	  = sizeof(wchar_t) == 4 ? BL_TEXT_ENCODING_UTF32 :
	    sizeof(wchar_t) == 2 ? BL_TEXT_ENCODING_UTF16 : BL_TEXT_ENCODING_UTF8,
	*/

	count = 4	// Count of text supported text encodings.
}
# Notes on contributing

## Overview

The code is organized similarly to the Blend2D source code.

The goal is feature parity with the C++ API.

There are three primary sources for adding functions to the V API:
 - Functions directly from the public C API.
 - Functions form a struct's virtual function table.
 - Multiple functions derived from a single C function, where a parameter 
   significantly alters the function's behavior.

Functions are added from the above sources when the functions are not intermediate functions.

## Naming convention

The API is simplified where possible, and a slightly different naming convention 
is consequently followed to maintain conciseness. For instance, V does not allow 
overloaded functions or default parameters, which are used extensively in the C++ 
API. In other cases, an API without any of the intermediate functions allows 
for a simpler naming scheme. For example:
 - The overloaded `setFillStyle()` function of the blend2D API is fragmented into 
   `set_fill_color()`, `set_fill_gradient()`, and `set_fill_pattern()`.
   - Blend2D distinguishes gradients and patterns from solid fill, since they are handled 
     similarly, but we needn't complicate the user-facing API.
 - `addGeometry()` similarly has multiple variants based on BL_GEOMETRY_TYPE_*; separated 
   into multiple functions for the V API.

In both cases above, while the simplified API is provided, one multi-use funciton is provided
along with the original enumerator so the user can efiiciently switch funcitonalities if 
desired without re-creating the original code. Ex. `set_fill_style()` and `add_geometry()`. 

Other aspects of conversion are straightforward. Ex. convert to snake_case by V convention.
Remove redundant prefixes sicne V has proper scoping.

## Error handling

All funcitons in the Blend2D API return `BLResult`, the library's error enum. In some cases, 
as in the `bl***Init()` functions, the result may be ignored as stated explicitly in the 
Blend2D documentation. Where a function poses a reasonable threat in failing, such as in 
resource handling, an error option type is returned by the V function. Otherwise, to avoid 
a cumbersome API, the error is propogated with a `panic()`, with the understanding that such 
an error is unlikely, and may be cought in the future with the addition of `recover()` to V.

## Caveats

When redeclaraing C functions in V, the V compiler does not allow function 
parameters to be declared with "mut". Therefore, all such parameters (any C parameter 
which is not "const"), is marked with a comment: "/*mut*/". Variables passed into the function 
are treated accordingly.

## Building

Right now, since Blend2D is written in C++, either the binaries must be provided, or each user
must compile the library for the relevant platform (V can only compile C and V in its build 
steps). In the future, "c2v" could eliminate this dependency, and/or a build script could be 
provided since V does not have a sophisticated build system. In the "c2v" case, I am not sure 
if some of the library's optimizations could be successfully translated.

## Status

### Implemented

- Image
- ...

### Future Additions

- `(Context) set_fill_style()` (and other applicable functions) with a Style sum type
- Possible: Replace BLRgba32 with gx.rgba? (different byte order)
  - Add BLRgba64 equivalent to vlib's gx?
  - Either fix warnings somehow (from current union type) or do something else
- `BLFontData` and `BLFontManager`
  - Possible: Or see if vlib font handling is sufficient
- `BLGlyphBuffer` and `BLGlyphRun` implementations via `[]rune`
- `BLMatrix2D`
  - Possible: Unless a V matrix lib exists?
- `BLPixelConverter`
- `BLRegion` (undecided)
- Short doc

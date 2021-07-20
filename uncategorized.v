module blend2d

// Not planned. (Use V builtin).
// fn C.blArrayInit(/*mut*/ self &C.BLArrayCore, arrayTypeId u32) BLResult
// fn C.blArrayDestroy(/*mut*/ self &C.BLArrayCore) BLResult
// fn C.blArrayReset(/*mut*/ self &C.BLArrayCore) BLResult
// fn C.blArrayCreateFromData(/*mut*/ self &C.BLArrayCore, /*mut*/ data voidptr, size size_t, capacity size_t, dataAccessFlags u32, destroyFunc C.BLDestroyImplFunc, /*mut*/ destroyData voidptr) BLResult
// fn C.blArrayGetSize(self &C.BLArrayCore) size_t
// fn C.blArrayGetCapacity(self &C.BLArrayCore) size_t
// fn C.blArrayGetData(self &C.BLArrayCore) voidptr
// fn C.blArrayClear(/*mut*/ self &C.BLArrayCore) BLResult
// fn C.blArrayShrink(/*mut*/ self &C.BLArrayCore) BLResult
// fn C.blArrayReserve(/*mut*/ self &C.BLArrayCore, n size_t) BLResult
// fn C.blArrayResize(/*mut*/ self &C.BLArrayCore, n size_t, fill voidptr) BLResult
// fn C.blArrayMakeMutable(/*mut*/ self &C.BLArrayCore, /*mut*/ dataOut &voidptr) BLResult
// fn C.blArrayModifyOp(/*mut*/ self &C.BLArrayCore, op u32, n size_t, /*mut*/ dataOut &voidptr) BLResult
// fn C.blArrayInsertOp(/*mut*/ self &C.BLArrayCore, index size_t, n size_t, /*mut*/ dataOut &voidptr) BLResult
// fn C.blArrayAssignMove(/*mut*/ self &C.BLArrayCore, /*mut*/ other &C.BLArrayCore) BLResult
// fn C.blArrayAssignWeak(/*mut*/ self &C.BLArrayCore, other &C.BLArrayCore) BLResult
// fn C.blArrayAssignDeep(/*mut*/ self &C.BLArrayCore, other &C.BLArrayCore) BLResult
// fn C.blArrayAssignView(/*mut*/ self &C.BLArrayCore, items voidptr, n size_t) BLResult
// fn C.blArrayAppendU8(/*mut*/ self &C.BLArrayCore, value u8) BLResult
// fn C.blArrayAppendU16(/*mut*/ self &C.BLArrayCore, value u16) BLResult
// fn C.blArrayAppendU32(/*mut*/ self &C.BLArrayCore, value u32) BLResult
// fn C.blArrayAppendU64(/*mut*/ self &C.BLArrayCore, value u64) BLResult
// fn C.blArrayAppendF32(/*mut*/ self &C.BLArrayCore, value f32) BLResult
// fn C.blArrayAppendF64(/*mut*/ self &C.BLArrayCore, value f64) BLResult
// fn C.blArrayAppendItem(/*mut*/ self &C.BLArrayCore, item voidptr) BLResult
// fn C.blArrayAppendView(/*mut*/ self &C.BLArrayCore, items voidptr, n size_t) BLResult
// fn C.blArrayInsertU8(/*mut*/ self &C.BLArrayCore, index size_t, value u8) BLResult
// fn C.blArrayInsertU16(/*mut*/ self &C.BLArrayCore, index size_t, value u16) BLResult
// fn C.blArrayInsertU32(/*mut*/ self &C.BLArrayCore, index size_t, value u32) BLResult
// fn C.blArrayInsertU64(/*mut*/ self &C.BLArrayCore, index size_t, value u64) BLResult
// fn C.blArrayInsertF32(/*mut*/ self &C.BLArrayCore, index size_t, value f32) BLResult
// fn C.blArrayInsertF64(/*mut*/ self &C.BLArrayCore, index size_t, value f64) BLResult
// fn C.blArrayInsertItem(/*mut*/ self &C.BLArrayCore, index size_t, item voidptr) BLResult
// fn C.blArrayInsertView(/*mut*/ self &C.BLArrayCore, index size_t, items voidptr, n size_t) BLResult
// fn C.blArrayReplaceU8(/*mut*/ self &C.BLArrayCore, index size_t, value u8) BLResult
// fn C.blArrayReplaceU16(/*mut*/ self &C.BLArrayCore, index size_t, value u16) BLResult
// fn C.blArrayReplaceU32(/*mut*/ self &C.BLArrayCore, index size_t, value u32) BLResult
// fn C.blArrayReplaceU64(/*mut*/ self &C.BLArrayCore, index size_t, value u64) BLResult
// fn C.blArrayReplaceF32(/*mut*/ self &C.BLArrayCore, index size_t, value f32) BLResult
// fn C.blArrayReplaceF64(/*mut*/ self &C.BLArrayCore, index size_t, value f64) BLResult
// fn C.blArrayReplaceItem(/*mut*/ self &C.BLArrayCore, index size_t, item voidptr) BLResult
// fn C.blArrayReplaceView(/*mut*/ self &C.BLArrayCore, rStart size_t, rEnd size_t, items voidptr, n size_t) BLResult
// fn C.blArrayRemoveIndex(/*mut*/ self &C.BLArrayCore, index size_t) BLResult
// fn C.blArrayRemoveRange(/*mut*/ self &C.BLArrayCore, rStart size_t, rEnd size_t) BLResult
// fn C.blArrayEquals(a &C.BLArrayCore, b &C.BLArrayCore) bool


fn C.blContextInit(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextInitAs(/*mut*/ self &C.BLContextCore, /*mut*/ image &C.BLImageCore, options &C.BLContextCreateInfo) BLResult
fn C.blContextDestroy(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextReset(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextAssignMove(/*mut*/ self &C.BLContextCore, /*mut*/ other &C.BLContextCore) BLResult
fn C.blContextAssignWeak(/*mut*/ self &C.BLContextCore, other &C.BLContextCore) BLResult
fn C.blContextGetType(self &C.BLContextCore) u32
fn C.blContextGetTargetSize(self &C.BLContextCore, /*mut*/ targetSizeOut &C.BLSize) BLResult
fn C.blContextGetTargetImage(self &C.BLContextCore) &C.BLImageCore
fn C.blContextBegin(/*mut*/ self &C.BLContextCore, /*mut*/ image &C.BLImageCore, options &C.BLContextCreateInfo) BLResult
fn C.blContextEnd(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextFlush(/*mut*/ self &C.BLContextCore, flags u32) BLResult
fn C.blContextQueryProperty(self &C.BLContextCore, propertyId u32, /*mut*/ valueOut voidptr) BLResult
fn C.blContextSave(/*mut*/ self &C.BLContextCore, /*mut*/ cookie &C.BLContextCookie) BLResult
fn C.blContextRestore(/*mut*/ self &C.BLContextCore, cookie &C.BLContextCookie) BLResult
fn C.blContextGetMetaMatrix(self &C.BLContextCore, /*mut*/ m &C.BLMatrix2D) BLResult
fn C.blContextGetUserMatrix(self &C.BLContextCore, /*mut*/ m &C.BLMatrix2D) BLResult
fn C.blContextUserToMeta(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextMatrixOp(/*mut*/ self &C.BLContextCore, opType u32, opData voidptr) BLResult
fn C.blContextSetHint(/*mut*/ self &C.BLContextCore, hintType u32, value u32) BLResult
fn C.blContextSetHints(/*mut*/ self &C.BLContextCore, hints &C.BLContextHints) BLResult
fn C.blContextSetFlattenMode(/*mut*/ self &C.BLContextCore, mode u32) BLResult
fn C.blContextSetFlattenTolerance(/*mut*/ self &C.BLContextCore, tolerance f64) BLResult
fn C.blContextSetApproximationOptions(/*mut*/ self &C.BLContextCore, options &C.BLApproximationOptions) BLResult
fn C.blContextSetCompOp(/*mut*/ self &C.BLContextCore, compOp u32) BLResult
fn C.blContextSetGlobalAlpha(/*mut*/ self &C.BLContextCore, alpha f64) BLResult
fn C.blContextSetFillAlpha(/*mut*/ self &C.BLContextCore, alpha f64) BLResult
fn C.blContextGetFillStyle(self &C.BLContextCore, /*mut*/ styleOut &C.BLStyleCore) BLResult
fn C.blContextSetFillStyle(/*mut*/ self &C.BLContextCore, style &C.BLStyleCore) BLResult
fn C.blContextSetFillStyleRgba(/*mut*/ self &C.BLContextCore, rgba &C.BLRgba) BLResult
fn C.blContextSetFillStyleRgba32(/*mut*/ self &C.BLContextCore, rgba32 u32) BLResult
fn C.blContextSetFillStyleRgba64(/*mut*/ self &C.BLContextCore, rgba64 u64) BLResult
fn C.blContextSetFillStyleObject(/*mut*/ self &C.BLContextCore, object voidptr) BLResult
fn C.blContextSetFillRule(/*mut*/ self &C.BLContextCore, fillRule u32) BLResult
fn C.blContextSetStrokeAlpha(/*mut*/ self &C.BLContextCore, alpha f64) BLResult
fn C.blContextGetStrokeStyle(self &C.BLContextCore, /*mut*/ styleOut &C.BLStyleCore) BLResult
fn C.blContextSetStrokeStyle(/*mut*/ self &C.BLContextCore, style &C.BLStyleCore) BLResult
fn C.blContextSetStrokeStyleRgba(/*mut*/ self &C.BLContextCore, rgba &C.BLRgba) BLResult
fn C.blContextSetStrokeStyleRgba32(/*mut*/ self &C.BLContextCore, rgba32 u32) BLResult
fn C.blContextSetStrokeStyleRgba64(/*mut*/ self &C.BLContextCore, rgba64 u64) BLResult
fn C.blContextSetStrokeStyleObject(/*mut*/ self &C.BLContextCore, object voidptr) BLResult
fn C.blContextSetStrokeWidth(/*mut*/ self &C.BLContextCore, width f64) BLResult
fn C.blContextSetStrokeMiterLimit(/*mut*/ self &C.BLContextCore, miterLimit f64) BLResult
fn C.blContextSetStrokeCap(/*mut*/ self &C.BLContextCore, position u32, strokeCap u32) BLResult
fn C.blContextSetStrokeCaps(/*mut*/ self &C.BLContextCore, strokeCap u32) BLResult
fn C.blContextSetStrokeJoin(/*mut*/ self &C.BLContextCore, strokeJoin u32) BLResult
fn C.blContextSetStrokeDashOffset(/*mut*/ self &C.BLContextCore, dashOffset f64) BLResult
fn C.blContextSetStrokeDashArray(/*mut*/ self &C.BLContextCore, dashArray &C.BLArrayCore) BLResult
fn C.blContextSetStrokeTransformOrder(/*mut*/ self &C.BLContextCore, transformOrder u32) BLResult
fn C.blContextGetStrokeOptions(self &C.BLContextCore, /*mut*/ options &C.BLStrokeOptionsCore) BLResult
fn C.blContextSetStrokeOptions(/*mut*/ self &C.BLContextCore, options &C.BLStrokeOptionsCore) BLResult
fn C.blContextClipToRectI(/*mut*/ self &C.BLContextCore, rect &C.BLRectI) BLResult
fn C.blContextClipToRectD(/*mut*/ self &C.BLContextCore, rect &C.BLRect) BLResult
fn C.blContextRestoreClipping(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextClearAll(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextClearRectI(/*mut*/ self &C.BLContextCore, rect &C.BLRectI) BLResult
fn C.blContextClearRectD(/*mut*/ self &C.BLContextCore, rect &C.BLRect) BLResult
fn C.blContextFillAll(/*mut*/ self &C.BLContextCore) BLResult
fn C.blContextFillRectI(/*mut*/ self &C.BLContextCore, rect &C.BLRectI) BLResult
fn C.blContextFillRectD(/*mut*/ self &C.BLContextCore, rect &C.BLRect) BLResult
fn C.blContextFillPathD(/*mut*/ self &C.BLContextCore, path &C.BLPathCore) BLResult
fn C.blContextFillGeometry(/*mut*/ self &C.BLContextCore, geometryType u32, geometryData voidptr) BLResult
fn C.blContextFillTextI(/*mut*/ self &C.BLContextCore, pt &C.BLPointI, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
fn C.blContextFillTextD(/*mut*/ self &C.BLContextCore, pt &C.BLPoint, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
fn C.blContextFillGlyphRunI(/*mut*/ self &C.BLContextCore, pt &C.BLPointI, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
fn C.blContextFillGlyphRunD(/*mut*/ self &C.BLContextCore, pt &C.BLPoint, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
fn C.blContextStrokeRectI(/*mut*/ self &C.BLContextCore, rect &C.BLRectI) BLResult
fn C.blContextStrokeRectD(/*mut*/ self &C.BLContextCore, rect &C.BLRect) BLResult
fn C.blContextStrokePathD(/*mut*/ self &C.BLContextCore, path &C.BLPathCore) BLResult
fn C.blContextStrokeGeometry(/*mut*/ self &C.BLContextCore, geometryType u32, geometryData voidptr) BLResult
fn C.blContextStrokeTextI(/*mut*/ self &C.BLContextCore, pt &C.BLPointI, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
fn C.blContextStrokeTextD(/*mut*/ self &C.BLContextCore, pt &C.BLPoint, font &C.BLFontCore, text voidptr, size size_t, encoding u32) BLResult
fn C.blContextStrokeGlyphRunI(/*mut*/ self &C.BLContextCore, pt &C.BLPointI, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
fn C.blContextStrokeGlyphRunD(/*mut*/ self &C.BLContextCore, pt &C.BLPoint, font &C.BLFontCore, glyphRun &C.BLGlyphRun) BLResult
fn C.blContextBlitImageI(/*mut*/ self &C.BLContextCore, pt &C.BLPointI, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
fn C.blContextBlitImageD(/*mut*/ self &C.BLContextCore, pt &C.BLPoint, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
fn C.blContextBlitScaledImageI(/*mut*/ self &C.BLContextCore, rect &C.BLRectI, img &C.BLImageCore, imgArea &C.BLRectI) BLResult
fn C.blContextBlitScaledImageD(/*mut*/ self &C.BLContextCore, rect &C.BLRect, img &C.BLImageCore, imgArea &C.BLRectI) BLResult


// Not planned. (Use V's 'os' vlib)
// fn C.blFileInit(/*mut*/ self &C.BLFileCore) BLResult
// fn C.blFileReset(/*mut*/ self &C.BLFileCore) BLResult
// fn C.blFileOpen(/*mut*/ self &C.BLFileCore, fileName &char, openFlags u32) BLResult
// fn C.blFileClose(/*mut*/ self &C.BLFileCore) BLResult
// fn C.blFileSeek(/*mut*/ self &C.BLFileCore, int64_t offset, seekType u32, /*mut*/ positionOut &C.int64_t) BLResult
// fn C.blFileRead(/*mut*/ self &C.BLFileCore, /*mut*/ buffer voidptr, n size_t, /*mut*/ bytesReadOut &C.size_t) BLResult
// fn C.blFileWrite(/*mut*/ self &C.BLFileCore, buffer voidptr, n size_t, /*mut*/ bytesWrittenOut &C.size_t) BLResult
// fn C.blFileTruncate(/*mut*/ self &C.BLFileCore, int64_t maxSize) BLResult
// fn C.blFileGetSize(/*mut*/ self &C.BLFileCore, /*mut*/ fileSizeOut &u64) BLResult


// Not planned. (Use V's 'os' vlib).
// fn C.blFileSystemReadFile(fileName &char, /*mut*/ dst &C.BLArrayCore, maxSize size_t, readFlags u32) BLResult
// fn C.blFileSystemWriteFile(fileName &char, data voidptr, size size_t, /*mut*/ bytesWrittenOut &C.size_t) BLResult


// fn C.blFontInit(/*mut*/ self &C.BLFontCore) BLResult
// fn C.blFontDestroy(/*mut*/ self &C.BLFontCore) BLResult
// fn C.blFontReset(/*mut*/ self &C.BLFontCore) BLResult
// fn C.blFontAssignMove(/*mut*/ self &C.BLFontCore, /*mut*/ other &C.BLFontCore) BLResult
// fn C.blFontAssignWeak(/*mut*/ self &C.BLFontCore, other &C.BLFontCore) BLResult
fn C.blFontEquals(a &C.BLFontCore, b &C.BLFontCore) bool
// fn C.blFontCreateFromFace(/*mut*/ self &C.BLFontCore, face &C.BLFontFaceCore, size f32) BLResult
fn C.blFontShape(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore) BLResult
fn C.blFontMapTextToGlyphs(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore, /*mut*/ stateOut &C.BLGlyphMappingState) BLResult
fn C.blFontPositionGlyphs(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore, positioningFlags u32) BLResult
fn C.blFontApplyKerning(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore) BLResult
fn C.blFontApplyGSub(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore, index size_t, lookups C.BLBitWord) BLResult
fn C.blFontApplyGPos(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore, index size_t, lookups C.BLBitWord) BLResult
fn C.blFontGetMatrix(self &C.BLFontCore, /*mut*/ out &C.BLFontMatrix) BLResult
fn C.blFontGetMetrics(self &C.BLFontCore, /*mut*/ out &C.BLFontMetrics) BLResult
fn C.blFontGetDesignMetrics(self &C.BLFontCore, /*mut*/ out &C.BLFontDesignMetrics) BLResult
fn C.blFontGetTextMetrics(self &C.BLFontCore, /*mut*/ gb &C.BLGlyphBufferCore, /*mut*/ out &C.BLTextMetrics) BLResult
fn C.blFontGetGlyphBounds(self &C.BLFontCore, glyphData &u32, glyphAdvance /*intptr_t*/int, /*mut*/ out &C.BLBoxI, count size_t) BLResult
fn C.blFontGetGlyphAdvances(self &C.BLFontCore, glyphData &u32, glyphAdvance /*intptr_t*/int, /*mut*/ out &C.BLGlyphPlacement, count size_t) BLResult
fn C.blFontGetGlyphOutlines(self &C.BLFontCore, glyphId u32, userMatrix &C.BLMatrix2D, /*mut*/ out &C.BLPathCore, sink C.BLPathSinkFunc, /*mut*/ closure voidptr) BLResult
fn C.blFontGetGlyphRunOutlines(self &C.BLFontCore, glyphRun &C.BLGlyphRun, BLMatrix2userMatrix &C.D, /*mut*/ out &C.BLPathCore, sink C.BLPathSinkFunc, /*mut*/ closure voidptr) BLResult


// Planned.
// fn C.blFontDataInit(/*mut*/ self &C.BLFontDataCore) BLResult
// fn C.blFontDataDestroy(/*mut*/ self &C.BLFontDataCore) BLResult
// fn C.blFontDataReset(/*mut*/ self &C.BLFontDataCore) BLResult
// fn C.blFontDataAssignMove(/*mut*/ self &C.BLFontDataCore, /*mut*/ other &C.BLFontDataCore) BLResult
// fn C.blFontDataAssignWeak(/*mut*/ self &C.BLFontDataCore, other &C.BLFontDataCore) BLResult
// fn C.blFontDataCreateFromFile(/*mut*/ self &C.BLFontDataCore, fileName &char, readFlags u32) BLResult
// fn C.blFontDataCreateFromDataArray(/*mut*/ self &C.BLFontDataCore, dataArray &C.BLArrayCore) BLResult
// fn C.blFontDataCreateFromData(/*mut*/ self &C.BLFontDataCore, data voidptr, dataSize size_t, destroyFunc C.BLDestroyImplFunc, /*mut*/ destroyData voidptr) BLResult
// fn C.blFontDataEquals(a &C.BLFontDataCore, b &C.BLFontDataCore) bool
// fn C.blFontDataListTags(self &C.BLFontDataCore, faceIndex u32, /*mut*/ dst &C.BLArrayCore) BLResult
// fn C.blFontDataQueryTables(self &C.BLFontDataCore, faceIndex u32, /*mut*/ dst &C.BLFontTable, tags &C.BLTag, count size_t) size_t


// fn C.blFontFaceInit(/*mut*/ self &C.BLFontFaceCore) BLResult
// fn C.blFontFaceDestroy(/*mut*/ self &C.BLFontFaceCore) BLResult
// fn C.blFontFaceReset(/*mut*/ self &C.BLFontFaceCore) BLResult
// fn C.blFontFaceAssignMove(/*mut*/ self &C.BLFontFaceCore, /*mut*/ other &C.BLFontFaceCore) BLResult
// fn C.blFontFaceAssignWeak(/*mut*/ self &C.BLFontFaceCore, other &C.BLFontFaceCore) BLResult
fn C.blFontFaceEquals(a &C.BLFontFaceCore, b &C.BLFontFaceCore) bool
// fn C.blFontFaceCreateFromFile(/*mut*/ self &C.BLFontFaceCore, fileName &char, readFlags u32) BLResult
fn C.blFontFaceCreateFromData(/*mut*/ self &C.BLFontFaceCore, fontData &C.BLFontDataCore, faceIndex u32) BLResult
fn C.blFontFaceGetFaceInfo(self &C.BLFontFaceCore, /*mut*/ out &C.BLFontFaceInfo) BLResult
fn C.blFontFaceGetDesignMetrics(self &C.BLFontFaceCore, /*mut*/ out &C.BLFontDesignMetrics) BLResult
fn C.blFontFaceGetUnicodeCoverage(self &C.BLFontFaceCore, /*mut*/ out &C.BLFontUnicodeCoverage) BLResult


// Planned.
// fn C.blFontManagerInit(/*mut*/ self &C.BLFontManagerCore) BLResult
// fn C.blFontManagerInitNew(/*mut*/ self &C.BLFontManagerCore) BLResult
// fn C.blFontManagerDestroy(/*mut*/ self &C.BLFontManagerCore) BLResult
// fn C.blFontManagerReset(/*mut*/ self &C.BLFontManagerCore) BLResult
// fn C.blFontManagerAssignMove(/*mut*/ self &C.BLFontManagerCore, /*mut*/ other &C.BLFontManagerCore) BLResult
// fn C.blFontManagerAssignWeak(/*mut*/ self &C.BLFontManagerCore, other &C.BLFontManagerCore) BLResult
// fn C.blFontManagerCreate(/*mut*/ self &C.BLFontManagerCore) BLResult
// fn C.blFontManagerGetFaceCount(self &C.BLFontManagerCore) size_t
// fn C.blFontManagerGetFamilyCount(self &C.BLFontManagerCore) size_t
// fn C.blFontManagerHasFace(self &C.BLFontManagerCore, face &C.BLFontFaceCore) bool
// fn C.blFontManagerAddFace(/*mut*/ self &C.BLFontManagerCore, face &C.BLFontFaceCore) BLResult
// fn C.blFontManagerQueryFace(self &C.BLFontManagerCore, name &char, nameSize size_t, properties &C.BLFontQueryProperties, /*mut*/ out &C.BLFontFaceCore) BLResult
// fn C.blFontManagerQueryFacesByFamilyName(self &C.BLFontManagerCore, name &char, nameSize size_t, /*mut*/ out &C.BLArrayCore) BLResult
// fn C.blFontManagerEquals(a &C.BLFontManagerCore, b &C.BLFontManagerCore) bool


fn C.blFormatInfoQuery(/*mut*/ self &C.BLFormatInfo, format u32) BLResult
fn C.blFormatInfoSanitize(/*mut*/ self &C.BLFormatInfo) BLResult


// Not planned. (Use V's "[]rune").
// fn C.blGlyphBufferInit(/*mut*/ self &C.BLGlyphBufferCore) BLResult
// fn C.blGlyphBufferInitMove(/*mut*/ self &C.BLGlyphBufferCore, /*mut*/ other &C.BLGlyphBufferCore) BLResult
// fn C.blGlyphBufferDestroy(/*mut*/ self &C.BLGlyphBufferCore) BLResult
// fn C.blGlyphBufferReset(/*mut*/ self &C.BLGlyphBufferCore) BLResult
// fn C.blGlyphBufferClear(/*mut*/ self &C.BLGlyphBufferCore) BLResult
// fn C.blGlyphBufferGetSize(self &C.BLGlyphBufferCore) size_t
// fn C.blGlyphBufferGetFlags(self &C.BLGlyphBufferCore) u32
// fn C.blGlyphBufferGetGlyphRun(self &C.BLGlyphBufferCore) &C.BLGlyphRun
// fn C.blGlyphBufferGetContent(self &C.BLGlyphBufferCore) u32
// fn C.blGlyphBufferGetInfoData(self &C.BLGlyphBufferCore) &C.BLGlyphInfo
// fn C.blGlyphBufferGetPlacementData(self &C.BLGlyphBufferCore) &C.BLGlyphPlacement
// fn C.blGlyphBufferSetText(/*mut*/ self &C.BLGlyphBufferCore, textData voidptr, size size_t, encoding u32) BLResult
// fn C.blGlyphBufferSetGlyphs(/*mut*/ self &C.BLGlyphBufferCore, glyphData &u32, size size_t) BLResult
// fn C.blGlyphBufferSetGlyphsFromStruct(/*mut*/ self &C.BLGlyphBufferCore, glyphData voidptr, size size_t, glyphIdSize size_t, glyphIdAdvance /*intptr_t*/int) BLResult


fn C.blGradientInit(/*mut*/ self &C.BLGradientCore) BLResult
// fn C.blGradientInitAs(/*mut*/ self &C.BLGradientCore, @type u32, values voidptr, extendMode u32, stops &C.BLGradientStop, n size_t, m &C.BLMatrix2D) BLResult
fn C.blGradientDestroy(/*mut*/ self &C.BLGradientCore) BLResult
fn C.blGradientReset(/*mut*/ self &C.BLGradientCore) BLResult
fn C.blGradientAssignMove(/*mut*/ self &C.BLGradientCore, /*mut*/ other &C.BLGradientCore) BLResult
fn C.blGradientAssignWeak(/*mut*/ self &C.BLGradientCore, other &C.BLGradientCore) BLResult
fn C.blGradientCreate(/*mut*/ self &C.BLGradientCore, @type u32, values voidptr, extendMode u32, stops &C.BLGradientStop, n size_t, m &C.BLMatrix2D) BLResult
fn C.blGradientShrink(/*mut*/ self &C.BLGradientCore) BLResult
fn C.blGradientReserve(/*mut*/ self &C.BLGradientCore, n size_t) BLResult
fn C.blGradientGetType(self &C.BLGradientCore) u32
fn C.blGradientSetType(/*mut*/ self &C.BLGradientCore, @type u32) BLResult
fn C.blGradientGetValue(self &C.BLGradientCore, index size_t) f64
fn C.blGradientSetValue(/*mut*/ self &C.BLGradientCore, index size_t, value f64) BLResult
fn C.blGradientSetValues(/*mut*/ self &C.BLGradientCore, index size_t, values &C.double, n size_t) BLResult
fn C.blGradientGetExtendMode(/*mut*/ self &C.BLGradientCore) u32
fn C.blGradientSetExtendMode(/*mut*/ self &C.BLGradientCore, extendMode u32) BLResult
fn C.blGradientGetSize(self &C.BLGradientCore) size_t
fn C.blGradientGetCapacity(self &C.BLGradientCore) size_t
fn C.blGradientGetStops(self &C.BLGradientCore) &C.BLGradientStop
fn C.blGradientResetStops(/*mut*/ self &C.BLGradientCore) BLResult
fn C.blGradientAssignStops(/*mut*/ self &C.BLGradientCore, stops &C.BLGradientStop, n size_t) BLResult
// fn C.blGradientAddStopRgba32(/*mut*/ self &C.BLGradientCore, offset f64, argb32 u32) BLResult
fn C.blGradientAddStopRgba64(/*mut*/ self &C.BLGradientCore, offset f64, argb64 u64) BLResult
fn C.blGradientRemoveStop(/*mut*/ self &C.BLGradientCore, index size_t) BLResult
fn C.blGradientRemoveStopByOffset(/*mut*/ self &C.BLGradientCore, offset f64, all u32) BLResult
fn C.blGradientRemoveStops(/*mut*/ self &C.BLGradientCore, rStart size_t, rEnd size_t) BLResult
fn C.blGradientRemoveStopsFromTo(/*mut*/ self &C.BLGradientCore, offsetMin f64, offsetMax f64) BLResult
fn C.blGradientReplaceStopRgba32(/*mut*/ self &C.BLGradientCore, index size_t, offset f64, rgba32 u32) BLResult
fn C.blGradientReplaceStopRgba64(/*mut*/ self &C.BLGradientCore, index size_t, offset f64, rgba64 u64) BLResult
fn C.blGradientIndexOfStop(self &C.BLGradientCore, offset f64) size_t
fn C.blGradientApplyMatrixOp(/*mut*/ self &C.BLGradientCore, opType u32, opData voidptr) BLResult
fn C.blGradientEquals(a &C.BLGradientCore, b &C.BLGradientCore) bool


// Implemented.
// fn C.blImageInit(/*mut*/ self &C.BLImageCore) BLResult
// fn C.blImageInitAs(/*mut*/ self &C.BLImageCore, w int, h int, format u32) BLResult
// fn C.blImageInitAsFromData(/*mut*/ self &C.BLImageCore, w int, h int, format u32, /*mut*/ pixelData voidptr, stride /*intptr_t*/int, destroyFunc C.BLDestroyImplFunc, /*mut*/ destroyData voidptr) BLResult
// fn C.blImageDestroy(/*mut*/ self &C.BLImageCore) BLResult
// fn C.blImageReset(/*mut*/ self &C.BLImageCore) BLResult
// fn C.blImageAssignMove(/*mut*/ self &C.BLImageCore, /*mut*/ other &C.BLImageCore) BLResult
// fn C.blImageAssignWeak(/*mut*/ self &C.BLImageCore, other &C.BLImageCore) BLResult
// fn C.blImageAssignDeep(/*mut*/ self &C.BLImageCore, other &C.BLImageCore) BLResult
// fn C.blImageCreate(/*mut*/ self &C.BLImageCore, w int, h int, format u32) BLResult
// fn C.blImageCreateFromData(/*mut*/ self &C.BLImageCore, w int, h int, format u32, /*mut*/ pixelData voidptr, stride /*intptr_t*/int, destroyFunc C.BLDestroyImplFunc, /*mut*/ destroyData voidptr) BLResult
// fn C.blImageGetData(self &C.BLImageCore, /*mut*/ dataOut &C.BLImageData) BLResult
// fn C.blImageMakeMutable(/*mut*/ self &C.BLImageCore, /*mut*/ dataOut &C.BLImageData) BLResult
// fn C.blImageConvert(/*mut*/ self &C.BLImageCore, format u32) BLResult
// fn C.blImageEquals(a &C.BLImageCore, b &C.BLImageCore) bool
// fn C.blImageScale(/*mut*/ dst &C.BLImageCore, src &C.BLImageCore, size &C.BLSizeI, filter u32, options &C.BLImageScaleOptions) BLResult
// fn C.blImageReadFromFile(/*mut*/ self &C.BLImageCore, fileName &char, codecs &C.BLArrayCore) BLResult
// fn C.blImageReadFromData(/*mut*/ self &C.BLImageCore, data voidptr, size size_t, codecs &C.BLArrayCore) BLResult
// fn C.blImageWriteToFile(self &C.BLImageCore, fileName &char, codec &C.BLImageCodecCore) BLResult
// fn C.blImageWriteToData(self &C.BLImageCore, /*mut*/ dst &C.BLArrayCore, codec &C.BLImageCodecCore) BLResult


fn C.blImageCodecInit(/*mut*/ self &C.BLImageCodecCore) BLResult
fn C.blImageCodecDestroy(/*mut*/ self &C.BLImageCodecCore) BLResult
fn C.blImageCodecReset(/*mut*/ self &C.BLImageCodecCore) BLResult
fn C.blImageCodecAssignWeak(/*mut*/ self &C.BLImageCodecCore, other &C.BLImageCodecCore) BLResult
fn C.blImageCodecFindByName(/*mut*/ self &C.BLImageCodecCore, name &char, size size_t, codecs &C.BLArrayCore) BLResult
fn C.blImageCodecFindByExtension(/*mut*/ self &C.BLImageCodecCore, name &char, size size_t, codecs &C.BLArrayCore) BLResult
fn C.blImageCodecFindByData(/*mut*/ self &C.BLImageCodecCore, data voidptr, size size_t, codecs &C.BLArrayCore) BLResult
fn C.blImageCodecInspectData(self &C.BLImageCodecCore, data voidptr, size size_t) u32
fn C.blImageCodecCreateDecoder(self &C.BLImageCodecCore, /*mut*/ dst &C.BLImageDecoderCore) BLResult
fn C.blImageCodecCreateEncoder(self &C.BLImageCodecCore, /*mut*/ dst &C.BLImageEncoderCore) BLResult
fn C.blImageCodecArrayInitBuiltInCodecs(/*mut*/ self &C.BLArrayCore) BLResult
fn C.blImageCodecArrayAssignBuiltInCodecs(/*mut*/ self &C.BLArrayCore) BLResult
fn C.blImageCodecAddToBuiltIn(codec &C.BLImageCodecCore) BLResult
fn C.blImageCodecRemoveFromBuiltIn(codec &C.BLImageCodecCore) BLResult


// Not planned. (Internal API).
// fn C.blImageDecoderInit(/*mut*/ self &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderDestroy(/*mut*/ self &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderReset(/*mut*/ self &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderAssignMove(/*mut*/ self &C.BLImageDecoderCore, /*mut*/ other &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderAssignWeak(/*mut*/ self &C.BLImageDecoderCore, other &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderRestart(/*mut*/ self &C.BLImageDecoderCore) BLResult
// fn C.blImageDecoderReadInfo(/*mut*/ self &C.BLImageDecoderCore, /*mut*/ infoOut &C.BLImageInfo, data &byte, size size_t) BLResult
// fn C.blImageDecoderReadFrame(/*mut*/ self &C.BLImageDecoderCore, /*mut*/ imageOut &C.BLImageCore, data &byte, size size_t) BLResult


// Not planned. (Internal API).
// fn C.blImageEncoderInit(/*mut*/ self &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderDestroy(/*mut*/ self &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderReset(/*mut*/ self &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderAssignMove(/*mut*/ self &C.BLImageEncoderCore, /*mut*/ other &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderAssignWeak(/*mut*/ self &C.BLImageEncoderCore, other &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderRestart(/*mut*/ self &C.BLImageEncoderCore) BLResult
// fn C.blImageEncoderWriteFrame(/*mut*/ self &C.BLImageEncoderCore, /*mut*/ dst &C.BLArrayCore, image &C.BLImageCore) BLResult


// Planned. (Unless a common V matrix library exists).
// fn C.blMatrix2DSetIdentity(/*mut*/ self &C.BLMatrix2D) BLResult
// fn C.blMatrix2DSetTranslation(/*mut*/ self &C.BLMatrix2D, x f64, y f64) BLResult
// fn C.blMatrix2DSetScaling(/*mut*/ self &C.BLMatrix2D, x f64, y f64) BLResult
// fn C.blMatrix2DSetSkewing(/*mut*/ self &C.BLMatrix2D, x f64, y f64) BLResult
// fn C.blMatrix2DSetRotation(/*mut*/ self &C.BLMatrix2D, angle f64, cx f64, cy f64) BLResult
// fn C.blMatrix2DApplyOp(/*mut*/ self &C.BLMatrix2D, opType u32, opData voidptr) BLResult
// fn C.blMatrix2DInvert(/*mut*/ dst &C.BLMatrix2D, src &C.BLMatrix2D) BLResult
// fn C.blMatrix2DGetType(self &C.BLMatrix2D) u32
// fn C.blMatrix2DMapPointDArray(self &C.BLMatrix2D, /*mut*/ dst &C.BLPoint, src &C.BLPoint, count size_t) BLResult


fn C.blPathInit(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathDestroy(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathReset(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathGetSize(self &C.BLPathCore) size_t
fn C.blPathGetCapacity(self &C.BLPathCore) size_t
fn C.blPathGetCommandData(self &C.BLPathCore) &byte
fn C.blPathGetVertexData(self &C.BLPathCore) &C.BLPoint
fn C.blPathClear(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathShrink(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathReserve(/*mut*/ self &C.BLPathCore, n size_t) BLResult
fn C.blPathModifyOp(/*mut*/ self &C.BLPathCore, op u32, n size_t, cmdDataOut &&byte, vtxDataOut &&C.BLPoint) BLResult
fn C.blPathAssignMove(/*mut*/ self &C.BLPathCore, /*mut*/ other &C.BLPathCore) BLResult
fn C.blPathAssignWeak(/*mut*/ self &C.BLPathCore, other &C.BLPathCore) BLResult
fn C.blPathAssignDeep(/*mut*/ self &C.BLPathCore, other &C.BLPathCore) BLResult
fn C.blPathSetVertexAt(/*mut*/ self &C.BLPathCore, index size_t, cmd u32, x f64, y f64) BLResult
fn C.blPathMoveTo(/*mut*/ self &C.BLPathCore, x0 f64, y0 f64) BLResult
fn C.blPathLineTo(/*mut*/ self &C.BLPathCore, x1 f64, y1 f64) BLResult
fn C.blPathPolyTo(/*mut*/ self &C.BLPathCore, poly &C.BLPoint, count size_t) BLResult
fn C.blPathQuadTo(/*mut*/ self &C.BLPathCore, x1 f64, y1 f64, x2 f64, y2 f64) BLResult
fn C.blPathCubicTo(/*mut*/ self &C.BLPathCore, x1 f64, y1 f64, x2 f64, y2 f64, x3 f64, y3 f64) BLResult
fn C.blPathSmoothQuadTo(/*mut*/ self &C.BLPathCore, x2 f64, y2 f64) BLResult
fn C.blPathSmoothCubicTo(/*mut*/ self &C.BLPathCore, x2 f64, y2 f64, x3 f64, y3 f64) BLResult
fn C.blPathArcTo(/*mut*/ self &C.BLPathCore, x f64, y f64, rx f64, ry f64, start f64, sweep f64, forceMoveTo bool) BLResult
fn C.blPathArcQuadrantTo(/*mut*/ self &C.BLPathCore, x1 f64, y1 f64, x2 f64, y2 f64) BLResult
fn C.blPathEllipticArcTo(/*mut*/ self &C.BLPathCore, rx f64, ry f64, xAxisRotation f64, largeArcFlag bool, sweepFlag bool, x1 f64, y1 f64) BLResult
fn C.blPathClose(/*mut*/ self &C.BLPathCore) BLResult
fn C.blPathAddGeometry(/*mut*/ self &C.BLPathCore, geometryType u32, geometryData voidptr, m &C.BLMatrix2D, dir u32) BLResult
fn C.blPathAddBoxI(/*mut*/ self &C.BLPathCore, box &C.BLBoxI, dir u32) BLResult
fn C.blPathAddBoxD(/*mut*/ self &C.BLPathCore, box &C.BLBox, dir u32) BLResult
fn C.blPathAddRectI(/*mut*/ self &C.BLPathCore, rect &C.BLRectI, dir u32) BLResult
fn C.blPathAddRectD(/*mut*/ self &C.BLPathCore, rect &C.BLRect, dir u32) BLResult
fn C.blPathAddPath(/*mut*/ self &C.BLPathCore, other &C.BLPathCore, range &C.BLRange) BLResult
fn C.blPathAddTranslatedPath(/*mut*/ self &C.BLPathCore, other &C.BLPathCore, range &C.BLRange, p &C.BLPoint) BLResult
fn C.blPathAddTransformedPath(/*mut*/ self &C.BLPathCore, other &C.BLPathCore, range &C.BLRange, m &C.BLMatrix2D) BLResult
fn C.blPathAddReversedPath(/*mut*/ self &C.BLPathCore, other &C.BLPathCore, range &C.BLRange, reverseMode u32) BLResult
fn C.blPathAddStrokedPath(/*mut*/ self &C.BLPathCore, other &C.BLPathCore, range &C.BLRange, options &C.BLStrokeOptionsCore, approx &C.BLApproximationOptions) BLResult
fn C.blPathRemoveRange(/*mut*/ self &C.BLPathCore, range &C.BLRange) BLResult
fn C.blPathTranslate(/*mut*/ self &C.BLPathCore, range &C.BLRange, p &C.BLPoint) BLResult
fn C.blPathTransform(/*mut*/ self &C.BLPathCore, range &C.BLRange, m &C.BLMatrix2D) BLResult
fn C.blPathFitTo(/*mut*/ self &C.BLPathCore, range &C.BLRange, rect &C.BLRect, fitFlags u32) BLResult
fn C.blPathEquals(a &C.BLPathCore, b &C.BLPathCore) bool
fn C.blPathGetInfoFlags(self &C.BLPathCore, uint32_flagsOut &C.t) BLResult
fn C.blPathGetControlBox(self &C.BLPathCore, /*mut*/ boxOut &C.BLBox) BLResult
fn C.blPathGetBoundingBox(self &C.BLPathCore, /*mut*/ boxOut &C.BLBox) BLResult
fn C.blPathGetFigureRange(self &C.BLPathCore, index size_t, /*mut*/ rangeOut &C.BLRange) BLResult
fn C.blPathGetLastVertex(self &C.BLPathCore, /*mut*/ vtxOut &C.BLPoint) BLResult
fn C.blPathGetClosestVertex(self &C.BLPathCore, p &C.BLPoint, maxDistance f64, indexOut &C.size_t, /*mut*/ distanceOut &C.double) BLResult
fn C.blPathHitTest(self &C.BLPathCore, p &C.BLPoint, fillRule u32) u32


fn C.blPatternInit(/*mut*/ self &C.BLPatternCore) BLResult
fn C.blPatternInitAs(/*mut*/ self &C.BLPatternCore, image &C.BLImageCore, area &C.BLRectI, extendMode u32, m &C.BLMatrix2D) BLResult
fn C.blPatternDestroy(/*mut*/ self &C.BLPatternCore) BLResult
fn C.blPatternReset(/*mut*/ self &C.BLPatternCore) BLResult
fn C.blPatternAssignMove(/*mut*/ self &C.BLPatternCore, /*mut*/ other &C.BLPatternCore) BLResult
fn C.blPatternAssignWeak(/*mut*/ self &C.BLPatternCore, other &C.BLPatternCore) BLResult
fn C.blPatternAssignDeep(/*mut*/ self &C.BLPatternCore, other &C.BLPatternCore) BLResult
fn C.blPatternCreate(/*mut*/ self &C.BLPatternCore, image &C.BLImageCore, area &C.BLRectI, extendMode u32, m &C.BLMatrix2D) BLResult
fn C.blPatternSetImage(/*mut*/ self &C.BLPatternCore, image &C.BLImageCore, area &C.BLRectI) BLResult
fn C.blPatternSetArea(/*mut*/ self &C.BLPatternCore, area &C.BLRectI) BLResult
fn C.blPatternSetExtendMode(/*mut*/ self &C.BLPatternCore, extendMode u32) BLResult
fn C.blPatternApplyMatrixOp(/*mut*/ self &C.BLPatternCore, opType u32, opData voidptr) BLResult
fn C.blPatternEquals(a &C.BLPatternCore, b &C.BLPatternCore) bool


// Planned.
// fn C.blPixelConverterInit(/*mut*/ self &C.BLPixelConverterCore) BLResult
// fn C.blPixelConverterInitWeak(/*mut*/ self &C.BLPixelConverterCore, other &C.BLPixelConverterCore) BLResult
// fn C.blPixelConverterDestroy(/*mut*/ self &C.BLPixelConverterCore) BLResult
// fn C.blPixelConverterReset(/*mut*/ self &C.BLPixelConverterCore) BLResult
// fn C.blPixelConverterAssign(/*mut*/ self &C.BLPixelConverterCore, other &C.BLPixelConverterCore) BLResult
// fn C.blPixelConverterCreate(/*mut*/ self &C.BLPixelConverterCore, dstInfo &C.BLFormatInfo, srcInfo &C.BLFormatInfo, createFlags u32) BLResult
// fn C.blPixelConverterConvert(self &C.BLPixelConverterCore, /*mut*/ dstData voidptr, dstStride /*intptr_t*/int, srcData voidptr, srcStride /*intptr_t*/int, w u32, h u32, options &C.BLPixelConverterOptions) BLResult


// Not planned. (Use V builtin).
// fn C.blRandomReset(/*mut*/ self &C.BLRandom, seed u64) BLResult
// fn C.blRandomNextUInt32(/*mut*/ self &C.BLRandom) u32
// fn C.blRandomNextUInt64(/*mut*/ self &C.BLRandom) u64
// fn C.blRandomNextDouble(/*mut*/ self &C.BLRandom) f64


// Addition undecided.
// fn C.blRegionInit(/*mut*/ self &C.BLRegionCore) BLResult
// fn C.blRegionDestroy(/*mut*/ self &C.BLRegionCore) BLResult
// fn C.blRegionReset(/*mut*/ self &C.BLRegionCore) BLResult
// fn C.blRegionGetSize(self &C.BLRegionCore) size_t
// fn C.blRegionGetCapacity(self &C.BLRegionCore) size_t
// fn C.blRegionGetData(self &C.BLRegionCore) &C.BLBoxI
// fn C.blRegionClear(/*mut*/ self &C.BLRegionCore) BLResult
// fn C.blRegionShrink(/*mut*/ self &C.BLRegionCore) BLResult
// fn C.blRegionReserve(/*mut*/ self &C.BLRegionCore, n size_t) BLResult
// fn C.blRegionAssignMove(/*mut*/ self &C.BLRegionCore, /*mut*/ other &C.BLRegionCore) BLResult
// fn C.blRegionAssignWeak(/*mut*/ self &C.BLRegionCore, other &C.BLRegionCore) BLResult
// fn C.blRegionAssignDeep(/*mut*/ self &C.BLRegionCore, other &C.BLRegionCore) BLResult
// fn C.blRegionAssignBoxI(/*mut*/ self &C.BLRegionCore, src &C.BLBoxI) BLResult
// fn C.blRegionAssignBoxIArray(/*mut*/ self &C.BLRegionCore, data &C.BLBoxI, n size_t) BLResult
// fn C.blRegionAssignRectI(/*mut*/ self &C.BLRegionCore, rect &C.BLRectI) BLResult
// fn C.blRegionAssignRectIArray(/*mut*/ self &C.BLRegionCore, data &C.BLRectI, n size_t) BLResult
// fn C.blRegionCombine(/*mut*/ self &C.BLRegionCore, a &C.BLRegionCore, b &C.BLRegionCore, booleanOp u32) BLResult
// fn C.blRegionCombineRB(/*mut*/ self &C.BLRegionCore, a &C.BLRegionCore, b &C.BLBoxI, booleanOp u32) BLResult
// fn C.blRegionCombineBR(/*mut*/ self &C.BLRegionCore, a &C.BLBoxI, b &C.BLRegionCore, booleanOp u32) BLResult
// fn C.blRegionCombineBB(/*mut*/ self &C.BLRegionCore, a &C.BLBoxI, b &C.BLBoxI, booleanOp u32) BLResult
// fn C.blRegionTranslate(/*mut*/ self &C.BLRegionCore, r &C.BLRegionCore, pt &C.BLPointI) BLResult
// fn C.blRegionTranslateAndClip(/*mut*/ self &C.BLRegionCore, r &C.BLRegionCore, pt &C.BLPointI, clipBox &C.BLBoxI) BLResult
// fn C.blRegionIntersectAndClip(/*mut*/ self &C.BLRegionCore, a &C.BLRegionCore, b &C.BLRegionCore, clipBox &C.BLBoxI) BLResult
// fn C.blRegionEquals(a &C.BLRegionCore, b &C.BLRegionCore) bool
// fn C.blRegionGetType(self &C.BLRegionCore) u32
// fn C.blRegionHitTest(self &C.BLRegionCore, pt &C.BLPointI) u32
// fn C.blRegionHitTestBoxI(self &C.BLRegionCore, box &C.BLBoxI) u32


// Not planned. (Internal API).
// fn C.blRuntimeInit() BLResult
// fn C.blRuntimeShutdown() BLResult
// fn C.blRuntimeCleanup(cleanupFlags u32) BLResult
// fn C.blRuntimeQueryInfo(infoType u32, /*mut*/ infoOut voidptr) BLResult
// fn C.blRuntimeMessageOut(msg &char) BLResult
// fn C.blRuntimeMessageFmt(fmt &char, x ...any) BLResult
// fn C.blRuntimeMessageVFmt(fmt &char, ap C.va_list) BLResult
// fn C.blRuntimeAssertionFailure(file &char, line int, msg &char)
// fn C.blResultFromPosixError(e int) BLResult


// Not planned. (Use V builtin).
// fn C.blStringInit(/*mut*/ self &C.BLStringCore) BLResult
// fn C.blStringInitWithData(/*mut*/ self &C.BLStringCore, str &char, size size_t) BLResult
// fn C.blStringDestroy(/*mut*/ self &C.BLStringCore) BLResult
// fn C.blStringReset(/*mut*/ self &C.BLStringCore) BLResult
// fn C.blStringGetSize(self &C.BLStringCore) size_t
// fn C.blStringGetCapacity(self &C.BLStringCore) size_t
// fn C.blStringGetData(self &C.BLStringCore) &char
// fn C.blStringClear(/*mut*/ self &C.BLStringCore) BLResult
// fn C.blStringShrink(/*mut*/ self &C.BLStringCore) BLResult
// fn C.blStringReserve(/*mut*/ self &C.BLStringCore, n size_t) BLResult
// fn C.blStringResize(/*mut*/ self &C.BLStringCore, n size_t, fill char) BLResult
// fn C.blStringMakeMutable(/*mut*/ self &C.BLStringCore, dataOut &&char) BLResult
// fn C.blStringModifyOp(/*mut*/ self &C.BLStringCore, op u32, n size_t, dataOut &&char) BLResult
// fn C.blStringInsertOp(/*mut*/ self &C.BLStringCore, index size_t, n size_t, dataOut &&char) BLResult
// fn C.blStringAssignMove(/*mut*/ self &C.BLStringCore, /*mut*/ other &C.BLStringCore) BLResult
// fn C.blStringAssignWeak(/*mut*/ self &C.BLStringCore, other &C.BLStringCore) BLResult
// fn C.blStringAssignDeep(/*mut*/ self &C.BLStringCore, other &C.BLStringCore) BLResult
// fn C.blStringAssignData(/*mut*/ self &C.BLStringCore, str &char, n size_t) BLResult
// fn C.blStringApplyOpChar(/*mut*/ self &C.BLStringCore, op u32, c char, n size_t) BLResult
// fn C.blStringApplyOpData(/*mut*/ self &C.BLStringCore, op u32, str &char, n size_t) BLResult
// fn C.blStringApplyOpString(/*mut*/ self &C.BLStringCore, op u32, other &C.BLStringCore) BLResult
// fn C.blStringApplyOpFormat(/*mut*/ self &C.BLStringCore, op u32, fmt &char, x ...any) BLResult
// fn C.blStringApplyOpFormatV(/*mut*/ self &C.BLStringCore, op u32, fmt &char, va_list ap) BLResult
// fn C.blStringInsertChar(/*mut*/ self &C.BLStringCore, index size_t, c char, n size_t) BLResult
// fn C.blStringInsertData(/*mut*/ self &C.BLStringCore, index size_t, str &char, n size_t) BLResult
// fn C.blStringInsertString(/*mut*/ self &C.BLStringCore, index size_t, other &C.BLStringCore) BLResult
// fn C.blStringRemoveRange(/*mut*/ self &C.BLStringCore, rStart size_t, rEnd size_t) BLResult
// fn C.blStringEquals(self &C.BLStringCore, other &C.BLStringCore) bool
// fn C.blStringEqualsData(self &C.BLStringCore, str &char, n size_t) bool
// fn C.blStringCompare(self &C.BLStringCore, other &C.BLStringCore) int
// fn C.blStringCompareData(self &C.BLStringCore, str &char, n size_t) int


fn C.blStrokeOptionsInit(/*mut*/ self &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsInitMove(/*mut*/ self &C.BLStrokeOptionsCore, /*mut*/ other &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsInitWeak(/*mut*/ self &C.BLStrokeOptionsCore, other &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsDestroy(/*mut*/ self &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsReset(/*mut*/ self &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsAssignMove(/*mut*/ self &C.BLStrokeOptionsCore, /*mut*/ other &C.BLStrokeOptionsCore) BLResult
fn C.blStrokeOptionsAssignWeak(/*mut*/ self &C.BLStrokeOptionsCore, other &C.BLStrokeOptionsCore) BLResult


fn C.blStyleInit(/*mut*/ self &C.BLStyleCore) BLResult
fn C.blStyleInitMove(/*mut*/ self &C.BLStyleCore, /*mut*/ other &C.BLStyleCore) BLResult
fn C.blStyleInitWeak(/*mut*/ self &C.BLStyleCore, other &C.BLStyleCore) BLResult
fn C.blStyleInitRgba(/*mut*/ self &C.BLStyleCore, rgba &C.BLRgba) BLResult
fn C.blStyleInitRgba32(/*mut*/ self &C.BLStyleCore, rgba32 u32) BLResult
fn C.blStyleInitRgba64(/*mut*/ self &C.BLStyleCore, rgba64 u64) BLResult
fn C.blStyleInitObject(/*mut*/ self &C.BLStyleCore, object voidptr) BLResult
fn C.blStyleDestroy(/*mut*/ self &C.BLStyleCore) BLResult
fn C.blStyleReset(/*mut*/ self &C.BLStyleCore) BLResult
fn C.blStyleAssignMove(/*mut*/ self &C.BLStyleCore, /*mut*/ other &C.BLStyleCore) BLResult
fn C.blStyleAssignWeak(/*mut*/ self &C.BLStyleCore, other &C.BLStyleCore) BLResult
fn C.blStyleAssignRgba(/*mut*/ self &C.BLStyleCore, rgba &C.BLRgba) BLResult
fn C.blStyleAssignRgba32(/*mut*/ self &C.BLStyleCore, rgba32 u32) BLResult
fn C.blStyleAssignRgba64(/*mut*/ self &C.BLStyleCore, rgba64 u64) BLResult
fn C.blStyleAssignObject(/*mut*/ self &C.BLStyleCore, object voidptr) BLResult
fn C.blStyleGetType(self &C.BLStyleCore) u32
fn C.blStyleGetRgba(self &C.BLStyleCore, /*mut*/ rgbaOut &C.BLRgba) BLResult
fn C.blStyleGetRgba32(self &C.BLStyleCore, uint32_rgba &C.t32Out) BLResult
fn C.blStyleGetRgba64(self &C.BLStyleCore, uint64_rgba &C.t64Out) BLResult
fn C.blStyleGetObject(self &C.BLStyleCore, /*mut*/ object voidptr) BLResult
fn C.blStyleEquals(a &C.BLStyleCore, b &C.BLStyleCore) bool


// Not planned. (Use V syntax).
// fn C.blVariantInit(/*mut*/ self voidptr) BLResult
// fn C.blVariantInitMove(/*mut*/ self voidptr, /*mut*/ other voidptr) BLResult
// fn C.blVariantInitWeak(/*mut*/ self voidptr, other voidptr) BLResult
// fn C.blVariantDestroy(/*mut*/ self voidptr) BLResult
// fn C.blVariantReset(/*mut*/ self voidptr) BLResult
// fn C.blVariantGetImplType(self voidptr) u32
// fn C.blVariantAssignMove(/*mut*/ self voidptr, /*mut*/ other voidptr) BLResult
// fn C.blVariantAssignWeak(/*mut*/ self voidptr, other voidptr) BLResult
// fn C.blVariantEquals(a voidptr, b voidptr) bool
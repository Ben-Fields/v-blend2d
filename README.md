# v-blend2d

V wrapper for [Blend2D](https://github.com/blend2d/blend2d), a vector graphics library ([website](https://blend2d.com/)).

Provides a `blend2d` module; clone to `~.vmodules/blend2d` or install with [vpm](https://vpm.vlang.io/) (yet unpublished to vpm).

[There are plenty of examples to get started!](https://github.com/Ben-Fields/v-blend2d-examples)

## Building the Blend2D library manually

### Future

In the future, either:
 - a V or C version will be gnerated and provided to work with V's build steps (best)
 - a V build script to detect the platform and build automatically will be provided
 - binaries will be generated and provided (worst-case)

### Prerequisites
* [V](https://vlang.io/)
* C++ compiler
* [cmake](https://cmake.org/download/)

### Instructions
```
cd ./blend2d/build
cmake ../c -DCMAKE_BUILD_TYPE=Release -DASMJIT_DIR="../asmjit" -DCMAKE_C_STANDARD=99 -DCMAKE_C_FLAGS="-std=gnu99" -DBLEND2D_STATIC=ON
cmake --build . --config Release

cd ../..
v ./blend2d.v -show-c-output -showcc
```

If the above does not work, ensure both the library and your v program are compiled with the same compiler:
1. Make note of the exact compiler, compiler version, and target architecture when you run `v`.
2. Run `cmake --help`. Copy the full compiler name matching the details from (1.).
3. Navigate to the build directory, delete its contents, and run `cmake -G "[compiler name]" ../c -DCMAKE_BUILD_TYPE=Release -DASMJIT_DIR="../asmjit" -DCMAKE_C_STANDARD=99 -DCMAKE_C_FLAGS="-std=gnu99" -DBLEND2D_STATIC=ON`, replacing `[compiler name]` with the copied name from (2.), including the matching architecture.
4. Run the remaining commands as before, appending `-cc [compiler]` to the v command. `[compiler]` should match the compiler specified in (3.) - `tcc`, `gcc`, `msvc`, or a direct path to the compiler.

### Misc. Notes

IDEs such as Visual Studio or Xcode require `--config Release`. Other IDEs/compilers require `-DCMAKE_BUILD_TYPE=Release`.
GNU compilers prior to Cmake 3.1 require `-DCMAKE_C_FLAGS="-std=gnu99"`. All other compilers require `-DCMAKE_C_STANDARD=99`. (gnu99 is the C standard used by V).

## Contributing

Components are currently added as needed. See [CONTRIBUTING.md](https://github.com/Ben-Fields/v-blend2d/blob/master/CONTRIBUTING.md) to add something you're missing. It's easy!

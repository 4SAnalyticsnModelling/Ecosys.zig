# Ecosys.zig

`Ecosys.zig` is the Zig implementation of the **ECOSYS** model, which was originally developed by **Professor Dr. Robert Grant** at the **University of Alberta** in **Fortran77**. Compared to the original Fortran77 version, `Ecosys.zig` is significantly more modular. As a result, the design and structure of `Ecosys.zig` may differ substantially from the original ECOSYS implementation.

ℹ️ **Note:**  
- Zig uses **row-major** array ordering, whereas Fortran uses **column-major**. Therefore, all array dimensions in `Ecosys.zig` are reversed relative to those in the original **ECOSYS**.  
- Zig arrays are **zero-indexed**, while Fortran arrays typically start at **index 1**.

# Motivation

`Ecosys.zig` leverages the power of the Zig programming language to achieve:

- lower memory footprint

- higher speed

- cross-platform binaries (Windows, macOS, Linux)

- better error handling

- more accurate and faster convergence

- fewer oscillations

- parallelism (planned for future development)

⚠️  `Ecosys.zig` is currently under active development. The code is incomplete and not yet ready for production use.

# Compile Ecosys.zig 
**(with zig version 0.15.1)**

=> `zig build` (**default compilation**)

=> `zig build -Dewgridsmax=1 -Dnsgridsmax=1 -Dsoillayersmax=20 -Dsnowlayersmax=10  -Dpftmax=5 -Dcanopymax=10 -Dsubhrwtrcymax=60 -Doptimize=ReleaseFast --verbose` (**custom compilation**)

ℹ️  See `build.zig` file for detailed description of the custom compilation options.

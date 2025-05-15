# Ecosys.zig

```Ecosys.zig``` is the Zig implementation of the ECOSYS model, which was originally developed by Professor Dr. Robert Grant at the University of Alberta in Fortran77. Compared to the original Fortran77 version, ```Ecosys.zig``` is significantly more modular. As a result, the design and structure of ```Ecosys.zig``` may differ substantially from the original ECOSYS implementation.

```Ecosys.zig``` leverages the power of the Zig programming language to achieve:

- lower memory footprint

- higher speed

- cross-platform binaries (Windows, macOS, Linux)

- better error handling

- more accurate and faster convergence

- fewer oscillations

- parallelism (planned for future development)

⚠️  ```Ecosys.zig``` is currently under active development. The code is not yet ready for production use.

# Compile Ecosys.zig (default)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=1 -Dnsgridsmax=1 -Dsoillayersmax=20 -Dsnowlayersmax=10  -Dpftmax=5 -Dcanopymax=10 -Dsubhrwtrcymax=60 -Doptimize=ReleaseFast --verbose`

ℹ️  See build.zig file for detailed description of the options.

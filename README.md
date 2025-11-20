# Ecosys.zig

`Ecosys.zig` is the Zig-based modernization of the legacy **Fortran77** codebase of the **ECOSYS** model that was originally developed by **Professor Dr. Robert Grant** at the **University of Alberta**. Compared to the original **ECOSYS** model, `Ecosys.zig` is significantly more modular. The names of the variables and constants are also expanded to make them more instantly readable. As a result, the design, look, and structure of `Ecosys.zig` differ substantially from the original **ECOSYS** model. However, the core algorithms remains mostly the same.

ℹ️ **Note:**
- Zig uses **row-major** array ordering, whereas Fortran uses **column-major**. Therefore, all array dimensions in `Ecosys.zig` are reversed relative to those in the original **ECOSYS**.
- Zig arrays are **zero-indexed**, while Fortran arrays typically start at **index 1**. So, **index offsetting** is used wherever applicable.

# Motivation

`Ecosys.zig` leverages the power of the Zig programming language to achieve:

- lower memory footprint

- higher speed

- cross-platform binaries (Windows, macOS, Linux)

- better error handling

- faster convergence with fewer oscillations, using modern schemes

- better readability with expanded variable/constant names

- parallelism (planned for future development)

⚠️  `Ecosys.zig` is currently under active development. The code is incomplete and not yet ready for production use.

# Compile Ecosys.zig 
**(compile with zig version 0.15.2)**

=> `zig build` (**default compilation**)

=> `zig build -Dnwex=1 -Dnnsx=1 -Dnsoilx=10 -Dnresx=3, -Dnsnowx=5 -Dnplantx=5 -Dncanopyx=5 -Dnscenariox=2 -Dnscenex=6 -Doptimize=ReleaseFast --verbose` (**custom compilation - production**)

=> `zig build -Dnwex=1 -Dnnsx=1 -Dnsoilx=10 -Dnresx=3, -Dnsnowx=5 -Dnplantx=5 -Dncanopyx=5 -Dnscenariox=2 -Dnscenex=6 -Doptimize=ReleaseSafe --verbose` (**custom compilation - UAT**)

ℹ️  See `build.zig` file for detailed description of the custom compilation options.

# Ecosys.zig
Zig implementation of fortran77 ECOSYS model (developed by Professor Dr. Robert Grant, University of Alberta). Ecosys.zig is substantially modular compared to the fortran77 ECOSYS model. So the design and structuring of Ecosys.zig, in some cases, significatnly differ from the fortran77 ECOSYS.

Ecosys.zig leverages the power of the Zig programming language to achieve:
- Lower memory footprint
- Higher speed
- Cross-platform binaries (Windows, MacOs, Linux)
- Better error handling
- More accurate, and faster convergence
- Less oscillations
- Parellelism (future development)

**Warning: Ecosys.zig is currently under construction. The codes are not yet ready for use.

# Compile Ecosys.zig (default)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=1 -Dnsgridsmax=1 -Dsoillayersmax=20 -Dsnowlayersmax=10  -Dpftmax=5 -Dcanopymax=10 -Dsubhrwtrcymax=60 -Doptimize=ReleaseFast --verbose`

**see build.zig file for detailed description of the options.

# Ecosys.zig
Zig version of fortran77 ECOSYS model. The orginal developer of the fortran77 ECOSYS model is Professor Dr. Robert Grant (University of Alberta).

Ecosys.zig leverages the power of the Zig programming language to achieve:
- Lower memory footprint
- Higher speed
- Cross-platform binaries (Windows, MacOs, Linux)
- Better error handling
- More accurate, and faster convergence solutions
- Parellelism (future option)

**Warning: Ecosys.zig is currently under construction. The codes are not yet ready for use.

# Compile Ecosys.zig (default)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=1 -Dnsgridsmax=1 -Dsoillayersmax=20 -Dsnowlayersmax=10  -Dpftmax=5 -Dcanopymax=10 -Dsubhrwtrcymax=60 -Doptimize=ReleaseFast --verbose`

**see build.zig file for detailed description of the options.

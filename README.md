# Ecosys.zig
Zig version of fortran77 ECOSYS model. The orginal developer of the fortran77 ECOSYS model is Professor Dr. Robert Grant (University of Alberta).

# Compile Ecosys.zig (default)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=1 -Dnsgridsmax=1 -Dsoillayersmax=20 -Dsnowlayersmax=10  -Dpftmax=5 -Dcanopymax=10 -Dsubhrwtrcymax=60 -Doptimize=ReleaseFast --verbose`

**see build.zig file for detailed description of the options.

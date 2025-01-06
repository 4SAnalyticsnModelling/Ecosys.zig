# Ecosys.zig
Zig version of fortran77 ECOSYS model. The orginal developer of fortran77 ECOSYS model is Professor Dr. Robert Grant (University of Alberta).

# Compile Ecosys.zig (with default options)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=2 -Dnsgridsmax=2 -Dsoillayermax=10 -Dpftmax=2 -Dcanopymax=10 -Dsubhrwtrcymax=15`
*see build.zig file for detailed description of the options.

# Ecosys.zig
Zig version of the [ECOSYS](https://github.com/jinyun1tang/ECOSYS) model. The orginal developer of the ECOSYS model (written in Fortran77) is Professor Dr. Robert Grant (University of Alberta). [Symon Mezbahuddin](mailto:symon.mezbahuddin@4sanalyticsnmodelling.com) translated the Fortran77 ECOSYS to Ecosys.zig.

# Compile Ecosys.zig (default)
`zig build`

# Custom Compile Ecosys.zig
`zig build -Dewgridsmax=2 -Dnsgridsmax=2 -Dsoillayermax=10 -Dpftmax=2 -Dcanopymax=10 -Dsubhrwtrcymax=15`

**see build.zig file for detailed description of the options.

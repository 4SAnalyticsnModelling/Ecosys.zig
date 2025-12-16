# Ecosys.zig

`Ecosys.zig` is a modern re-implementation of the original ecosystem model **ECOSYS** developed by **Professor Dr. Robert Grant (University of Alberta)**, originally written in **Fortran-77**. The goal of this project is to preserve the scientific foundations and process-based structure of **ECOSYS** while modernizing its software architecture for contemporary large-scale, high-performance computing workflows.

This modernization focuses on improving **scalability, numerical robustness, and spatial representation**, while preserving the underlying biophysical formulations of the original **ECOSYS** model.

# Key modernizations

**Explicit spatial representation: **
Geographic structure is represented using explicit latitude–longitude grids with lateral connectivity between neighboring cells, enabling more realistic spatial interactions and landscape-scale simulations.

**Out-of-core tiling for large domains: **
Designed for very large spatial extents, the model supports tile-based, out-of-core execution, allowing simulations to scale beyond available memory on HPC systems.

**Robust nonlinear solvers: **
Sub-hourly solutions of heat, water, solute, and gas transport use damped Picard–Newton (modified Newton) methods, improving convergence stability under strongly coupled and highly nonlinear conditions.

**Parallel execution with Zig: **
Computational kernels are parallelized using Zig’s multithreading facilities, enabling efficient utilization of modern multi-core CPUs without external runtime dependencies.

**Improved error handling and safety: **
The Zig implementation emphasizes explicit error handling, and clearer control flow, making the model more maintainable and easier to debug than legacy Fortran implementations.

⚠️  `Ecosys.zig` is currently under active development. The code is incomplete and not yet ready for production use.

# Compile Ecosys.zig 
**(compile with zig version 0.15.2)**

=> `zig build` (**default compilation**: you will find the binary within `zig-out/ecosys` path within the Ecosys.zig directory)

=> `zig build -p --verbose --sumary all.` (**example custom compilation**: you will find the binary within the `./ecosys` directory)

=> `zig build test --verbose --summary all` (**example custom compilation with code testing during compilation - UAT**)

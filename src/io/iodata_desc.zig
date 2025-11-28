///This module contains structs and methods for input data description to help write the input check files
const std = @import("std");
///All I/O file (both parents and child) name description
pub const IoFileNameDesc = struct {
    global_params: []const u8 =
        \\[{d}] grid numbers for simulation -> west: {d}, north: {d}, east: {d}, south: {d}
        \\[{d}] site file name: {s}
        \\[{d}] simulation start year: {d}
        \\[{d}] number of scenarios: {d}, each repeats: {d} times
        \\
    ,
    scenario_params: []const u8 =
        \\----------------------------------------------------
        \\[{d}] number of scenes: {d}, each repeats: {d} times
        \\----------------------------------------------------
        \\
    ,
    scene_params: []const u8 =
        \\[{d}] weather network file name: {s}
        \\[{d}] option file name: {s}
        \\[{d}] soil management file name: {s}
        \\[{d}] plant management file name: {s}
        \\[{d}] hourly carbon outputs file name: {s}
        \\[{d}] hourly water outputs file name: {s}
        \\[{d}] hourly nitrogen outputs file name: {s}
        \\[{d}] hourly phosphorus outputs file name: {s}
        \\[{d}] hourly heat/energy outputs file name: {s}
        \\[{d}] daily carbon outputs file name: {s}
        \\[{d}] daily water outputs file name: {s}
        \\[{d}] daily nitrogen outputs file name: {s}
        \\[{d}] daily phosphorus outputs file name: {s}
        \\[{d}] daily heat/energy outputs file name: {s}
        \\
    ,
    site_params: []const u8 =
        \\grid position -> west: {d}, north: {d}, east: {d}, south: {d}
        \\landscape unit file name: {s}, soil file name: {s}
        \\
    ,
    wthr_net_params: []const u8 =
        \\grid position -> west: {d}, north: {d}, east: {d}, south: {d}
        \\weather file name: {s}
        \\
    ,
    soil_mgmt_params: []const u8 =
        \\grid position -> west: {d}, north: {d}, east: {d}, south: {d}
        \\tillage file name: {s}, fertilizer file name: {s}, irrigation file name: {s}
        \\
    ,
    plant_mgmt_params: []const u8 =
        \\grid position -> west: {d}, north: {d}, east: {d}, south: {d}; number of plant species {d}
        \\plant species/functional type file name: {s}, plant management operation file name: {s}
        \\
    ,
};
///Land unit data description
pub const LandUnitDataDesc = struct {
    loc_atm_gas_opts: []const u8 =
        \\[0] latitude: {d}⁰, altitude/elevation: {d} m, aspect: {d}⁰, ground surface slope: {d}⁰, initial snowpack depth: {d} m, Mean Annual Temperature: {d}⁰C, Water table (WT) simulation?: {s}
        \\[1] atmospheric gas concentrations in ppm; O₂: {d}, N₂: {d}, initial CO₂: {d}, CH₄: {d}, N₂O: {d}, NH₃: {d}
        \\[2] Koppen Climate Zone: {d}, salinity?: {s}, erosion?: {s}, lateral grid connection?: {s}, external WT depth (WTDx) (natural): {d} m, WTDx (artificial): {d} m, WTx slope: {d} m
        \\
    , //mutiline string literals, line split by \\ no "" is required
    bounds_grid_dims: []const u8 =
        \\[3] surface boundary conditions (unitless multipliers) -> west: {d}, north: {d}, east: {d}, south: {d}; sub-surface boundary conditions (unitless multipliers) -> west: {d}, north: {d}, east: {d}, south: {d}; distances to WTDx (m) to the -> west: {d}, north: {d}, east: {d}, south: {d}; bottom boundary condition for water movement (unitless multiplier): {d}
        \\[4] grid dimensions (m); west-east: {d}, north-south: {d}
        \\
    ,
};
///Soil data description
pub const SoilDataDesc = struct {};
///Weather data description
pub const WthrDataDesc = struct {};
///Options data description
pub const OptsDataDesc = struct {};
///Tillage data description
pub const TillDataDesc = struct {};
///Fertilizer data description
pub const FertDataDesc = struct {};
///Scheduled irrigation data description
pub const IrrigDataDesc = struct {};
///Automated irrigation data description
pub const AutoIrrigDataDesc = struct {};
///Plant species/functional type data description
pub const PlantDataDesc = struct {};
///Agriculture, silviculture, horticulture operations (e.g. planting, harvesting etc.) data description
pub const PlantOperationDataDesc = struct {};

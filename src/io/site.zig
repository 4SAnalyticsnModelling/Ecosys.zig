const std = @import("std");
const config = @import("config");
const nhx = config.nwe;
const nhy = config.nns;
///This struct defines site variables.
pub const Site = struct {
    loc: Location,
    atm_gas: AtmGas,
    opt: SiteOptions,
    bound: Boundary,
    grid_dim: GridDimension,

    pub fn init() Site {
        return std.mem.zeroInit(Site, .{});
    }
};
///This struct defines model site location.
const Location = struct {
    lat: [nhx][nhy]f32, // latitude (deg)
    alt_init: [nhx][nhy]f32, // altitude or elevation (m)
    matc_init: [nhx][nhy]f32, // Mean Annual Temperature (⁰C)
    wt_opt: [nhx][nhy]u32, // water table simulation option
    max_daylength: [nhx][nhy]f32, // max. day length (h)
};
///This struct defines various site options (e.g., koppen climate zone, salinity, erosion, grid connectivity, wtdx etc.).
const SiteOptions = struct {
    koppen_clim_zone: [nhx][nhy]u32, // Koppen climate zone
    salinity_opt: [nhx][nhy]u32, // slainity simulation option
    erosion_opt: [nhx][nhy]i32, // erosion simulation option
    grid_conn_opt: [nhx][nhy]u32, // grid lateral connectivity option
    nat_wtdx_init: [nhx][nhy]f32, // natural external water table depth (m) relative to grid surface
    art_wtdx_init: [nhx][nhy]f32, // depth of artificial drainage (m) relative to grid surface
    nat_wtx_slope: [nhx][nhy]f32, // natural external water table slope (m) relative to grid surface
};
///This struct defines model site atmospheric gas concentrations.
const AtmGas = struct {
    o2conc: [nhx][nhy]f32, // O₂ conc. (ppm)
    n2conc: [nhx][nhy]f32, // N₂ conc. (ppm)
    co2conc_init: [nhx][nhy]f32, // initial CO₂ conc. (ppm)
    co2conc: [nhx][nhy]f32, // ambient CO₂ conc. (ppm)
    ch4conc: [nhx][nhy]f32, // CH₄ conc. (ppm)
    n2oconc: [nhx][nhy]f32, // N₂O conc. (ppm)
    nh3conc: [nhx][nhy]f32, // NH₃ conc. (ppm)
    h2conc: [nhx][nhy]f32, // H₂ conc. (ppm)
};
///This struct defines model boundary conditions and grid size.
const Boundary = struct {
    surf_north: [nhx][nhy]f32, // N boundary condition for surface run-off/run-on
    surf_east: [nhx][nhy]f32, // E boundary condition for surface run-off/run-on
    surf_south: [nhx][nhy]f32, // S boundary condition for surface run-off/run-on
    surf_west: [nhx][nhy]f32, // W boundary condition for surface run-off/run-on
    sub_surf_north: [nhx][nhy]f32, // N boundary condition for sub-surface lateral discharge/recharge
    sub_surf_east: [nhx][nhy]f32, // E boundary condition for sub-surface lateral discharge/recharge
    sub_surf_south: [nhx][nhy]f32, // S boundary condition for sub-surface lateral discharge/recharge
    sub_surf_west: [nhx][nhy]f32, // W boundary condition for sub-surface lateral discharge/recharge
    dist_wtdx_north: [nhx][nhy]f32, // distance to external water table (m) to the N
    dist_wtdx_east: [nhx][nhy]f32, // distance to external water table (m) to the E
    dist_wtdx_south: [nhx][nhy]f32, // distance to external water table (m) to the S
    dist_wtdx_west: [nhx][nhy]f32, // distance to external water table (m) to the W
    bottom_drain: [nhx][nhy]f32, // lower boundary condition for water flow
};
///This struct defines model grid dimensions.
const GridDimension = struct {
    west_east: [nhx][nhy]f32, // west to east dimension (m)
    north_south: [nhx][nhy]f32, // north to south dimension (m)
};

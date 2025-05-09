const std = @import("std");

/// This function reads site data
pub fn readSiteFile(allocator: std.mem.Allocator) anyerror!void {

    // alatg, altig, atcag = latitude, altitude, mat(deg c)
    // idtblg = water table flag
    //   0 = none
    //   1,2 = natural stationary, mobile
    //   3,4 = artificial stationary, mobile
    // oxyeg, z2geg, co2eig, ch4eg, z2oeg, znh3eg = atm o2, n2, co2, ch4, n2o, nh3 (ppm)
    // ietypg, isaltg, iersng = koppen climate zone, salt, erosion options
    // ncng = 1: lateral connections between grid cells, 3: no connections
    // dtblig, dtbldig = depth of natural, artificial water table (idtblg)
    // dtblgg = slope of natural water table relative to landscape surface
    // rchqng, rchqeg, rchqsg, rchqwg = boundary condns for n, e, s, w surface runoff
    // rchgnug, rchgeug, rchgsug, rchgwug = boundary condns for n, e, s, w subsurface flow
    // rchgntg, rchgetg, rchgstg, rchgwtg = n, e, s, w distance to water table (m)
    // rchgdg = lower boundary conditions for water flow
    // dhi = width of each w-e landscape column
    // dvi = width of each n-s landscape row
    // iersng = erosion options
    //   0 = allow freeze-thaw to change elevation
    //   1 = allow freeze-thaw plus erosion to change elevation
    //   2 = allow freeze-thaw plus soc accumulation to change elevation
    //   3 = allow freeze-thaw plus soc accumulation plus erosion to change elevation
    //   -1 = no change in elevation

}

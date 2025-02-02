const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;

pub const Blkc = struct {
    isoil: [jx][jy][jz][4]i32,
    lsg: [jx][jy][jz]f32,
    iflgi: [jx][jy][jp]i32,
    iflgc: [jx][jy][jp]i32,
    zerop: [jx][jy][jp]f32,
    zeroq: [jx][jy][jp]f32,
    zerol: [jx][jy][jp]f32,
    tdiri: [jx][jy][12]f32,
    tdtpx: [jx][jy][12]f32,
    tdtpn: [jx][jy][12]f32,
    tdrad: [jx][jy][12]f32,
    tdhum: [jx][jy][12]f32,
    tdprc: [jx][jy][12]f32,
    tdwnd: [jx][jy][12]f32,
    tdco2: [jx][jy][12]f32,
    tdcn4: [jx][jy][12]f32,
    tdcno: [jx][jy][12]f32,
    zeros: [jx][jy]f32,
    zeros2: [jx][jy]f32,
    dylm: [jx][jy]f32,
    xcorp: [jx][jy]f32,
    alat: [jx][jy]f32,
    ncn: [jx][jy]i32,
    iflgv: [jx][jy]i32,
    iflgs: [jx][jy]i32,
    ifnhb: [jx][jy]i32,
    ifnob: [jx][jy]i32,
    ifpob: [jx][jy]i32,
    np: [jx][jy]i32,
    np0: [jx][jy]i32,
    ietyp: [jx][jy]i32,
    drad: [12]f32,
    dtmpx: [12]f32,
    dtmpn: [12]f32,
    dhum: [12]f32,
    dprec: [12]f32,
    dirri: [12]f32,
    dwind: [12]f32,
    dco2e: [12]f32,
    dcn4r: [12]f32,
    dcnor: [12]f32,
    iwthr: [2]i32,
    tarea: f32,
    zero: f32,
    zero2: f32,
    xnpx: f32,
    xnpa: f32,
    xnpb: f32,
    xnpc: f32,
    xnph: f32,
    xnpt: f32,
    xnpg: f32,
    xnpr: f32,
    xnpd: f32,
    xnps: f32,
    xnpy: f32,
    xnpz: f32,
    xnpq: f32,
    xnpv: f32,
    doy: i32,
    igo: i32,
    idayr: i32,
    iyrc: i32,
    iyrr: i32,
    nyr: i32,
    iterm: i32,
    ifin: i32,
    isaltg: i32,
    iersng: i32,
    npx: i32,
    npy: i32,
    nph: i32,
    npt: i32,
    npg: i32,
    iclm: i32,
    imng: i32,
    iflgw: i32,
    npr: i32,
    nps: i32,
    jout: i32,
    iout: i32,
    kout: i32,
    iold: i32,
    ilast: i32,
    irun: i32,
    ibegin: i32,
    istart: i32,
    iend: i32,
    lyrx: f32,
    lyrc: f32,

    pub fn init() Blkc {
        return std.mem.zeroInit(Blkc, .{});
    }
};

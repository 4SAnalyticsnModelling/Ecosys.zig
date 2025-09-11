const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;

pub const Blkc = struct {
    isoil: [jx][jy][jz][4]u32, // Fortran: ISOIL(4,JZ,JY,JX)
    lsg: [jx][jy][jz]u32, // Fortran: LSG(JZ,JY,JX)
    iflgi: [jx][jy][jp]u32, // Fortran: IFLGI(JP,JY,JX)
    iflgc: [jx][jy][jp]u32, // Fortran: IFLGC(JP,JY,JX)
    zerop: [jx][jy][jp]f32, // Fortran: ZEROP(JP,JY,JX)
    zeroq: [jx][jy][jp]f32, // Fortran: ZEROQ(JP,JY,JX)
    zerol: [jx][jy][jp]f32, // Fortran: ZEROL(JP,JY,JX)
    tdiri: [jx][jy][12]f32, // Fortran: TDIRI(JY,JX,12)
    tdtpx: [jx][jy][12]f32, // Fortran: TDTPX(JY,JX,12)
    tdtpn: [jx][jy][12]f32, // Fortran: TDTPN(JY,JX,12)
    tdrad: [jx][jy][12]f32, // Fortran: TDRAD(JY,JX,12)
    tdhum: [jx][jy][12]f32, // Fortran: TDHUM(JY,JX,12)
    tdprc: [jx][jy][12]f32, // Fortran: TDPRC(JY,JX,12)
    tdwnd: [jx][jy][12]f32, // Fortran: TDWND(JY,JX,12)
    tdco2: [jx][jy][12]f32, // Fortran: TDCO2(JY,JX,12)
    tdcn4: [jx][jy][12]f32, // Fortran: TDCN4(JY,JX,12)
    tdcno: [jx][jy][12]f32, // Fortran: TDCNO(JY,JX,12)
    zeros: [jx][jy]f32, // Fortran: ZEROS(JY,JX)
    zeros2: [jx][jy]f32, // Fortran: ZEROS2(JY,JX)
    dylm: [jx][jy]f32, // Fortran: DYLM(JY,JX)
    xcorp: [jx][jy]f32, // Fortran: XCORP(JY,JX)
    alat: [jx][jy]f32, // Fortran: ALAT(JY,JX)
    ncn: [jx][jy]u32, // Fortran: NCN(JY,JX)
    iflgv: [jx][jy]u32, // Fortran: IFLGV(JY,JX)
    iflgs: [jx][jy]u32, // Fortran: IFLGS(JY,JX)
    ifnhb: [jx][jy]u32, // Fortran: IFNHB(JY,JX)
    ifnob: [jx][jy]u32, // Fortran: IFNOB(JY,JX)
    ifpob: [jx][jy]u32, // Fortran: IFPOB(JY,JX)
    np: [jx][jy]u32, // Fortran: NP(JY,JX)
    np0: [jx][jy]u32, // Fortran: NP0(JY,JX)
    iersn: [jx][jy]i32, // Fortran: IERSNG
    ietyp: [jx][jy]u32, // Fortran: IETYP(JY,JX)
    isalt: [jx][jy]u32, // Fortran: ISALTG
    iflgw: [jx][jy]u32, // Fortran: IFLGW
    drad: [12]f32, // Fortran: DRAD(12)
    dtmpx: [12]f32, // Fortran: DTMPX(12)
    dtmpn: [12]f32, // Fortran: DTMPN(12)
    dhum: [12]f32, // Fortran: DHUM(12)
    dprec: [12]f32, // Fortran: DPREC(12)
    dirri: [12]f32, // Fortran: DIRRI(12)
    dwind: [12]f32, // Fortran: DWIND(12)
    dco2e: [12]f32, // Fortran: DCO2E(12)
    dcn4r: [12]f32, // Fortran: DCN4R(12)
    dcnor: [12]f32, // Fortran: DCNOR(12)
    iwthr: [2]u32, // Fortran: IWTHR(2)
    tarea: f32, // Fortran: TAREA
    zero: f32, // Fortran: ZERO
    zero2: f32, // Fortran: ZERO2
    xnpx: f32, // Fortran: XNPX
    xnpa: f32, // Fortran: XNPA
    xnpb: f32, // Fortran: XNPB
    xnpc: f32, // Fortran: XNPC
    xnph: f32, // Fortran: XNPH
    xnpt: f32, // Fortran: XNPT
    xnpg: f32, // Fortran: XNPG
    xnpr: f32, // Fortran: XNPR
    xnpd: f32, // Fortran: XNPD
    xnps: f32, // Fortran: XNPS
    xnpy: f32, // Fortran: XNPY
    xnpz: f32, // Fortran: XNPZ
    xnpq: f32, // Fortran: XNPQ
    xnpv: f32, // Fortran: XNPV
    doy: f32, // Fortran: DOY
    idayr: u32, // Fortran: IDAYR
    iyrc: u32, // Fortran: IYRC
    iyrr: u32, // Fortran: IYRR
    lpy: i32,
    nyr: u32, // Fortran: NYR
    iterm: u32, // Fortran: ITERM
    ifin: u32, // Fortran: IFIN
    npx: u32, // Fortran: NPX
    npy: u32, // Fortran: NPY
    nph: u32, // Fortran: NPH
    npt: u32, // Fortran: NPT
    npg: u32, // Fortran: NPG
    iclm: u32, // Fortran: ICLM
    imng: u32, // Fortran: IMNG
    npr: u32, // Fortran: NPR
    nps: u32, // Fortran: NPS
    jout: u32, // Fortran: JOUT
    iout: u32, // Fortran: IOUT
    kout: u32, // Fortran: KOUT
    iold: u32, // Fortran: IOLD
    ilast: u32, // Fortran: ILAST
    irun: u32, // Fortran: IRUN
    ibegin: u32, // Fortran: IBEGIN
    istart: u32, // Fortran: ISTART
    iend: u32, // Fortran: IEND
    lyrx: u32, // Fortran: LYRX
    lyrc: u32, // Fortran: LYRC

    pub fn init() Blkc {
        return std.mem.zeroInit(Blkc, .{});
    }
};

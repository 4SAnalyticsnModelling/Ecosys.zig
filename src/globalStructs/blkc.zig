const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;

pub const Blkc = struct {
    isoil: [jx][jy][jz][4]i32, // Fortran: ISOIL(4,JZ,JY,JX)
    lsg: [jx][jy][jz]i32, // Fortran: LSG(JZ,JY,JX)
    iflgi: [jx][jy][jp]i32, // Fortran: IFLGI(JP,JY,JX)
    iflgc: [jx][jy][jp]i32, // Fortran: IFLGC(JP,JY,JX)
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
    iflgv: [jx][jy]i32, // Fortran: IFLGV(JY,JX)
    iflgs: [jx][jy]i32, // Fortran: IFLGS(JY,JX)
    ifnhb: [jx][jy]i32, // Fortran: IFNHB(JY,JX)
    ifnob: [jx][jy]i32, // Fortran: IFNOB(JY,JX)
    ifpob: [jx][jy]i32, // Fortran: IFPOB(JY,JX)
    np: [jx][jy]i32, // Fortran: NP(JY,JX)
    np0: [jx][jy]i32, // Fortran: NP0(JY,JX)
    iersn: [jx][jy]i32, // Fortran: IERSNG
    ietyp: [jx][jy]u32, // Fortran: IETYP(JY,JX)
    isalt: [jx][jy]u32, // Fortran: ISALTG
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
    iwthr: [2]i32, // Fortran: IWTHR(2)
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
    idayr: i32, // Fortran: IDAYR
    iyrc: i32, // Fortran: IYRC
    iyrr: i32, // Fortran: IYRR
    nyr: i32, // Fortran: NYR
    iterm: i32, // Fortran: ITERM
    ifin: i32, // Fortran: IFIN
    npx: i32, // Fortran: NPX
    npy: i32, // Fortran: NPY
    nph: i32, // Fortran: NPH
    npt: i32, // Fortran: NPT
    npg: i32, // Fortran: NPG
    iclm: i32, // Fortran: ICLM
    imng: i32, // Fortran: IMNG
    iflgw: i32, // Fortran: IFLGW
    npr: i32, // Fortran: NPR
    nps: i32, // Fortran: NPS
    jout: i32, // Fortran: JOUT
    iout: i32, // Fortran: IOUT
    kout: i32, // Fortran: KOUT
    iold: i32, // Fortran: IOLD
    ilast: i32, // Fortran: ILAST
    irun: i32, // Fortran: IRUN
    ibegin: i32, // Fortran: IBEGIN
    istart: i32, // Fortran: ISTART
    iend: i32, // Fortran: IEND
    lyrx: i32, // Fortran: LYRX
    lyrc: i32, // Fortran: LYRC

    pub fn init() Blkc {
        return std.mem.zeroInit(Blkc, .{});
    }
};

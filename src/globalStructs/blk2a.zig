const std = @import("std");

pub const Blk2a = struct {
    tmpx: comptime [366]f32 = std.mem.zeroes([366]f32),
    tmpn: comptime [366]f32 = std.mem.zeroes([366]f32),
    srad: comptime [366]f32 = std.mem.zeroes([366]f32),
    rain: comptime [366]f32 = std.mem.zeroes([366]f32),
    wind: comptime [366]f32 = std.mem.zeroes([366]f32),
    dwpt: comptime [2][366]f32 = std.mem.zeroes([2][366]f32),
    tmph: comptime [366][24]f32 = std.mem.zeroes([366][24]f32),
    sradh: comptime [366][24]f32 = std.mem.zeroes([366][24]f32),
    rainh: comptime [366][24]f32 = std.mem.zeroes([366][24]f32),
    windh: comptime [366][24]f32 = std.mem.zeroes([366][24]f32),
    dwpht: comptime [366][24]f32 = std.mem.zeroes([366][24]f32),
    tca: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tka: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ua: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    vpa: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    vpk: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dyln: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dylx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    altz: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precw: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    preci: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    prec_a: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    gsin: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    gcos: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    gazi: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    omegag: comptime [4][jx][jy]f32 = std.mem.zeroes([4][jx][jy]f32),
    sl: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    asp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zs: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zm: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    z0: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    alt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dtbly: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rab: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rib: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ths: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dtbli: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    trad: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tamx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tamn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hudx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hudn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    twind: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    trai: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thsx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    offset: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dh: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    wdpthd: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    dv: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dtbldi: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    precb: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    fert: comptime [20][366][jx][jy]f32 = std.mem.zeroes([20][366][jx][jy]f32),
    fdepth: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    rrig: comptime [366][24][jx][jy]f32 = std.mem.zeroes([366][24][jx][jy]f32),
    wdpth: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    dcorp: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    co2ei: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cco2ei: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    oxye: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    coxye: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    z2oe: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cz2oe: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    z2ge: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cz2ge: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    znh3e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cnh3e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ch4e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cch4e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    h2ge: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ch2ge: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dptht: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    altig: comptime f32 = std.mem.zeroes(f32),
    alti: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    znoon: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    vap: comptime f32 = std.mem.zeroes(f32),
    vaps: comptime f32 = std.mem.zeroes(f32),
    dtblx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    co2e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cco2e: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rads: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rady: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    raps: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rapy: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ssin: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ssinn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    scos: comptime f32 = std.mem.zeroes(f32),
    sazi: comptime f32 = std.mem.zeroes(f32),
    tysin: comptime f32 = std.mem.zeroes(f32),
    rchgnu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgeu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgsu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgwu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgnt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchget: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgst: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgwt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchqn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchqe: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchqs: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchqw: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchgd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dtblg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dptha: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rown: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rowo: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rowp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rowi: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    firra: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cirra: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dirra: comptime [2][jx][jy]f32 = std.mem.zeroes([2][jx][jy]f32),
    xradh: comptime [24][366]f32 = std.mem.zeroes([24][366]f32),
    dtblz: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tlex: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tshx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tlec: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tshc: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dpthsk: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tksd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tcndg: comptime f32 = std.mem.zeroes(f32),
    dtbld: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    atcai: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rad: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rap: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    atca: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    atcs: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    atka: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    atks: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    engyp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    idtbl: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    itill: comptime [366][jx][jy]f32 = std.mem.zeroes([366][jx][jy]f32),
    iirra: comptime [4][jx][jy]f32 = std.mem.zeroes([4][jx][jy]f32),
    irchg: comptime [2][2][jx][jy]f32 = std.mem.zeroes([2][2][jx][jy]f32),
    iflbh: comptime [2][2][jx][jy]f32 = std.mem.zeroes([2][2][jx][jy]f32),
    
    pub fn init() Blk2a {
        return .{};
    }
};

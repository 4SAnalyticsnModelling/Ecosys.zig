/// Gas and solute fluxes at sub-hourly flux time step entered in site file.
pub inline fn siteGasSoluteFlux() void {
    // xnph=1/no. of cycles h-1 for water, heat and solute flux calculations
    // r*bls, r*fl0, r*fl1, r*fl2=solute flux to snowpack, surface litter, soil surface non-band, band
    // solute code:co=co2, ch=ch4, ox=o2, ng=n2, n2=n2o, hg=h2
    //             :oc=doc, on=don, op=dop, oa=acetate
    //             :nh4=nh4, nh3=nh3, no3=no3, no2=no2, p14=hpo4, po4=h2po4 in non-band
    //             :n4b=nh4, n3b=nh3, nob=no3, n2b=no2, p1b=hpo4, pob=h2po4 in band
    // gas code: *co*=co2, *ox*=o2, *ch*=ch4, *ng*=n2, *n2*=n2o, *nh*=nh3, *h2*=h2
    inline for (0..2) |k| {
        rocfl0[nx][ny][k] = xocfls[nx][ny][0][3][k] * xnph;
        ronfl0[nx][ny][k] = xonfls[nx][ny][0][3][k] * xnph;
        ropfl0[nx][ny][k] = xopfls[nx][ny][0][3][k] * xnph;
        roafl0[nx][ny][k] = xoafls[nx][ny][0][3][k] * xnph;
        rocfl1[nx][ny][k] = xocfls[nx][ny][nu[nx][ny]][3][k] * xnph;
        ronfl1[nx][ny][k] = xonfls[nx][ny][nu[nx][ny]][3][k] * xnph;
        ropfl1[nx][ny][k] = xopfls[nx][ny][nu[nx][ny]][3][k] * xnph;
        roafl1[nx][ny][k] = xoafls[nx][ny][nu[nx][ny]][3][k] * xnph;
    }
    rcobls[nx][ny][1] = xcobls[nx][ny][1] * xnph;
    rchbls[nx][ny][1] = xchbls[nx][ny][1] * xnph;
    roxbls[nx][ny][1] = xoxbls[nx][ny][1] * xnph;
    rngbls[nx][ny][1] = xngbls[nx][ny][1] * xnph;
    rn2bls[nx][ny][1] = xn2bls[nx][ny][1] * xnph;
    rn4blw[nx][ny][1] = xn4blw[nx][ny][1] * xnph;
    rn3blw[nx][ny][1] = xn3blw[nx][ny][1] * xnph;
    rnoblw[nx][ny][1] = xnoblw[nx][ny][1] * xnph;
    rh1pbs[nx][ny][1] = xh1pbs[nx][ny][1] * xnph;
    rh2pbs[nx][ny][1] = xh2pbs[nx][ny][1] * xnph;
    rcofl0[nx][ny] = xcofls[nx][ny][0][3] * xnph;
    rchfl0[nx][ny] = xchfls[nx][ny][0][3] * xnph;
    roxfl0[nx][ny] = xoxfls[nx][ny][0][3] * xnph;
    rngfl0[nx][ny] = xngfls[nx][ny][0][3] * xnph;
    rn2fl0[nx][ny] = xn2fls[nx][ny][0][3] * xnph;
    rhgfl0[nx][ny] = xhgfls[nx][ny][0][3] * xnph;
    rn4fl0[nx][ny] = xn4flw[nx][ny][0][3] * xnph;
    rn3fl0[nx][ny] = xn3flw[nx][ny][0][3] * xnph;
    rnofl0[nx][ny] = xnoflw[nx][ny][0][3] * xnph;
    rnxfl0[nx][ny] = xnxfls[nx][ny][0][3] * xnph;
    rh1pf0[nx][ny] = xh1pfs[nx][ny][0][3] * xnph;
    rh2pf0[nx][ny] = xh2pfs[nx][ny][0][3] * xnph;
    rcofl1[nx][ny] = xcofls[nx][ny][nu[nx][ny]][3] * xnph;
    rchfl1[nx][ny] = xchfls[nx][ny][nu[nx][ny]][3] * xnph;
    roxfl1[nx][ny] = xoxfls[nx][ny][nu[nx][ny]][3] * xnph;
    rngfl1[nx][ny] = xngfls[nx][ny][nu[nx][ny]][3] * xnph;
    rn2fl1[nx][ny] = xn2fls[nx][ny][nu[nx][ny]][3] * xnph;
    rhgfl1[nx][ny] = xhgfls[nx][ny][nu[nx][ny]][3] * xnph;
    rn4fl1[nx][ny] = xn4flw[nx][ny][nu[nx][ny]][3] * xnph;
    rn3fl1[nx][ny] = xn3flw[nx][ny][nu[nx][ny]][3] * xnph;
    rnofl1[nx][ny] = xnoflw[nx][ny][nu[nx][ny]][3] * xnph;
    rnxfl1[nx][ny] = xnxfls[nx][ny][nu[nx][ny]][3] * xnph;
    rh1pf1[nx][ny] = xh1pfs[nx][ny][nu[nx][ny]][3] * xnph;
    rh2pf1[nx][ny] = xh2pfs[nx][ny][nu[nx][ny]][3] * xnph;
    rn4fl2[nx][ny] = xn4flb[nx][ny][nu[nx][ny]][3] * xnph;
    rn3fl2[nx][ny] = xn3flb[nx][ny][nu[nx][ny]][3] * xnph;
    rnofl2[nx][ny] = xnoflb[nx][ny][nu[nx][ny]][3] * xnph;
    rnxfl2[nx][ny] = xnxflb[nx][ny][nu[nx][ny]][3] * xnph;
    rh1bf2[nx][ny] = xh1bfb[nx][ny][nu[nx][ny]][3] * xnph;
    rh2bf2[nx][ny] = xh2bfb[nx][ny][nu[nx][ny]][3] * xnph;
}

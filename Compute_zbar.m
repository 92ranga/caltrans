function zbar = Compute_zbar(zs,sigmaz)

    z1=sigmaz*sqrt(2/pi)*exp(-0.5*((zs/sigmaz)^2));
    
    z2=zs*erf(zs/(sqrt(2)*sigmaz));
    
    zbar=z1+z2;
    
end
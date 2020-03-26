function Conc = Compute_Conc_Inf(q,Xr,Yr,Xs,Ys,ustar,wstar,L,wdir,zs,zr,zo)
    
    c=polyfit(Xs,Ys,1);
    
    Xo=(Yr-c(2))/c(1);
    
    Xd=Xr-Xo;
    
    Xp=Xd*cosd(wdir);
    
    if Xd>0
        
        sigmav=Compute_sigmav(ustar,wstar);
    
        Ue=Iterate_Ue(zs,zo,Xd,ustar,L,sigmav);
    
        wspd=Ue*cosd(wdir);
    
        szXd = Compute_sigmaz(L,Xd,ustar,Ue);
        
        C1=sqrt(1/2*pi)*(q/(wspd*szXd));
    
        C2=0.5*exp(-(((zs-zr)/(sqrt(2)*szXd))^2))*exp(-(((zs+zr)/(sqrt(2)*szXd))^2));
    
        Conc1=C1*C2;
        
        szXp=Compute_sigmaz(L,Xp,ustar,Ue);
        
        [fr,thetas] = Meandering_Inf(Ue,sigmav);
        
        Conc2=sqrt(2/pi)*q*thetas/(Ue*szXp*2*pi);
        
        Conc=Conc1*(1-fr)+Conc2*fr;
        
    else
        
        Conc=0;
        
    end
    
end
    
    
        
        
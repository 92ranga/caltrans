function Conc = Compute_Conc(q,Xr,Yr,Xs,Ys,ustar,sigmav,L,wdir,zs,zr,zo,ho)
    
    if Ys(1)<Ys(end)
        
        Xe=Xs(end);
    
        Xb=Xs(1);
    
        Ye=Ys(end);
    
        Yb=Ys(1);
        
    else
        
        Xe=Xs(1);
    
        Xb=Xs(end);
    
        Ye=Ys(1);
    
        Yb=Ys(end);
        
    end

    Xu=Xr-Xe;
    
    Xl=Xr-Xb;
    
    c=polyfit(Xs,Ys,1);
    
    Xo=(Yr-c(2))/c(1);
    
    Xd=Xr-Xo;
    
    Xp=Xd*cosd(wdir);
    
    if Xu>0 && Xl>0 && Xd>0
    
        Ue=Iterate_Ue(zs,zo,Xd,ustar,L,sigmav,ho);
    
        wspd=Ue*cosd(wdir);
    
        szXd = Compute_sigmaz(L,Xd,ustar,Ue,ho);
    
        szXu = Compute_sigmaz(L,Xu,ustar,Ue,ho);
    
        szXl = Compute_sigmaz(L,Xl,ustar,Ue,ho);
    
        syXu = Compute_sigmay(L,ustar,sigmav,szXu);
    
        syXl = Compute_sigmay(L,ustar,sigmav,szXl);
    
        C1=sqrt(1/2*pi)*(q/(wspd*szXd));
    
        P2=erf((Ye-Yr)/(sqrt(2)*syXu));
    
        P1=erf((Yb-Yr)/(sqrt(2)*syXl));
        
        C2=0.5*[exp(-(((zs-zr)/(sqrt(2)*szXd))^2))+exp(-(((zs+zr)/(sqrt(2)*szXd))^2))];
    
        Conc1=C1*(P2-P1)*C2;
        
        szXp=Compute_sigmaz(L,Xp,ustar,Ue,ho);
        
        [fr,thetas] = Meandering(Ue,sigmav,Xe,Ye,Xb,Yb,Xr,Yr);
        
        Conc2=sqrt(2/pi)*q*thetas/(Ue*szXp*2*pi);
        
        Conc=Conc1*(1-fr)+Conc2*fr;
        
    elseif Xu>0 && Xl<0 && Xd>0
    
        Ue=Iterate_Ue(zs,zo,Xd,ustar,L,sigmav,ho);
    
        wspd=Ue*cosd(wdir);
        
        Xl=0;
        
        szXd = Compute_sigmaz(L,Xd,ustar,Ue,ho);
    
        szXu = Compute_sigmaz(L,Xu,ustar,Ue,ho);
    
        szXl = Compute_sigmaz(L,Xl,ustar,Ue,ho);
    
        syXu = Compute_sigmay(L,ustar,sigmav,szXu);
    
        syXl = Compute_sigmay(L,ustar,sigmav,szXl);
    
        C1=sqrt(1/2*pi)*(q/(wspd*szXd));
    
        P2=erf((Ye-Yr)/(sqrt(2)*syXu));
    
        P1=erf((Yb-Yr)/(sqrt(2)*syXl));
    
        C2=0.5*[exp(-(((zs-zr)/(sqrt(2)*szXd))^2))+exp(-(((zs+zr)/(sqrt(2)*szXd))^2))];
    
        Conc1=C1*(P2-P1)*C2;
        
        szXp=Compute_sigmaz(L,Xp,ustar,Ue,ho);
        
        [fr,thetas] = Meandering(Ue,sigmav,Xe,Ye,Xb,Yb,Xr,Yr);
        
        Conc2=sqrt(2/pi)*q*thetas/(Ue*szXp*2*pi);
        
        Conc=Conc1*(1-fr)+Conc2*fr;
        
    elseif Xu<0 && Xl>0 && Xd>0
    
        Ue=Iterate_Ue(zs,zo,Xd,ustar,L,sigmav,ho);
    
        wspd=abs(Ue*cosd(wdir));
        
        Xu=0;
        
        szXd = Compute_sigmaz(L,Xd,ustar,Ue,ho);
    
        szXu = Compute_sigmaz(L,Xu,ustar,Ue,ho);
    
        szXl = Compute_sigmaz(L,Xl,ustar,Ue,ho);
    
        syXu = Compute_sigmay(L,ustar,sigmav,szXu);
    
        syXl = Compute_sigmay(L,ustar,sigmav,szXl);
    
        C1=sqrt(1/2*pi)*(q/(wspd*szXd));
    
        P2=erf((Ye-Yr)/(sqrt(2)*syXu));
    
        P1=erf((Yb-Yr)/(sqrt(2)*syXl));
    
        C2=0.5*[exp(-(((zs-zr)/(sqrt(2)*szXd))^2))+exp(-(((zs+zr)/(sqrt(2)*szXd))^2))];
    
        Conc1=C1*(P2-P1)*C2;
        
        szXp=Compute_sigmaz(L,Xp,ustar,Ue,ho);
        
        [fr,thetas] = Meandering(Ue,sigmav,Xe,Ye,Xb,Yb,Xr,Yr);
        
        Conc2=sqrt(2/pi)*q*thetas/(Ue*szXp*2*pi);
        
        Conc=Conc1*(1-fr)+Conc2*fr;
        
    else
        
        Conc=0;
        
    end
    
end
    
    
        
        
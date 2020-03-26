function [Conc,fr] = Compute_Conc(q,Xr,Yr,Xs,Ys,ustar,sigmav,L,wdir,wspd,zs,zr,zref,zo,ho,m,dtheta)
    
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
    Yu=Yr-Ye;    
    Yl=Yr-Yb;   
    C=polyfit(Xs,Ys,1);    
    Xo=(Yr-C(2))/C(1);    
    Xd=Xr-Xo;    
    Xp=Xd*cosd(wdir);
    
    if Xu>0 && Xl>0 && Xd>0
        [Conc,fr] = Compute_Conc_Case(zs,zr,zref,zo,Xd,Xp,ustar,L,sigmav,ho,wdir,wspd,Xu,Xl,Yu,Yl,q,m,dtheta);        
    elseif Xu>0 && Xl<0 && Xd>0        
        Xl=0;        
        Yi=C(1)*Xr+C(2);        
        Yl=Yr-Yi;        
        [Conc,fr] = Compute_Conc_Case(zs,zr,zref,zo,Xd,Xp,ustar,L,sigmav,ho,wdir,wspd,Xu,Xl,Yu,Yl,q,m,dtheta);        
    elseif Xu<0 && Xl>0 && Xd>0    
        Xu=0;        
        Yi=C(1)*Xr+C(2);
        Yu=Yr-Yi;        
        [Conc,fr] = Compute_Conc_Case(zs,zr,zref,zo,Xd,Xp,ustar,L,sigmav,ho,wdir,wspd,Xu,Xl,Yu,Yl,q,m,dtheta);        
    else
        Conc=0;        
        fr=-9999;        
    end
    
end
    
    
        
        
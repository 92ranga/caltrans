function [Conc,fr] = Compute_Conc_Case(zs,zr,zref,zo,Xd,Xp,ustar,L,sigmav,ho,wdir,ws,Xu,Xl,Yu,Yl,q,m,dtheta)
        
        sigmavo=dtheta*ws;
        if dtheta>55*pi/180
%             a=0.35*sigmav^2/ustar^2;
%             a=0.018*sigmav^6/ustar^6;
            a=0;
        else
            a=0;
        end
        
        sigmav=sqrt(sigmav^2+a*sigmavo^2);
        
        fac=ws/Similarity_Wind(zref,zo,ustar,L);
        [Ue,~]=Iterate_Ue(zs,zo,Xd,ustar,L,sigmav,ho,fac);
        wspd=Ue*cosd(wdir);
        
        szXd = Compute_sigmaz(L,Xd,ustar,Ue,ho);
        szXu = Compute_sigmaz(L,Xu,ustar,Ue,ho);
        szXl = Compute_sigmaz(L,Xl,ustar,Ue,ho);
        syXu = Compute_sigmay(L,ustar,sigmav,szXu);
        syXl = Compute_sigmay(L,ustar,sigmav,szXl);   
        tu=erf(-Yu/(sqrt(2)*syXu));
        tl=erf(-Yl/(sqrt(2)*syXl));
        Concy=sqrt(2/pi)*(q/(wspd*szXd))*((tu-tl)/2);
        
        if m==1
            szXp=Compute_sigmaz(L,Xp,ustar,Ue,ho);
            [fr,thetas] = Meandering(Ue,sigmav,Xu,Xl,Yu,Yl);
%           fr=1;
            Concm=sqrt(2/pi)*(q/(Ue*szXp))*(thetas/(2*pi));
        else
            Concm=0;
            fr=0;
        end
        
        Concz1=0.5*exp(-(((zs-zr)/(sqrt(2)*szXd))^2));        
        Concz2=0.5*exp(-(((zs+zr)/(sqrt(2)*szXd))^2));        
        Concz=Concz1+Concz2;        
        Concp=Concy*Concz;        
        Conc=Concp*(1-fr)+Concm*fr;
        
end
        
        
        
        

    
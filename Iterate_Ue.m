function [Ue,U] = Iterate_Ue(zs,zo,Xd,ustar,L,sigmav,ho,fac)

    zbar=zs;
    
    err=1;

    while err>0.01
        
        U=Similarity_Wind(zbar,zo,ustar,L)*fac;
    
        Ue=Compute_Ue(U,sigmav);
    
        sigmaz=Compute_sigmaz(L,Xd,ustar,Ue,ho);
    
        zbar_=Compute_zbar(zs,sigmaz);
        
        err=abs(zbar_-zbar);
        
        zbar=zbar_;
        
    end
    
    U=Similarity_Wind(zbar,zo,ustar,L)*fac;
    
    Ue=Compute_Ue(U,sigmav);    
    
    
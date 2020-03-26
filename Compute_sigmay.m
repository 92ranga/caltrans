function sigmay = Compute_sigmay(L,ustar,sigmav,sigmaz)
             
    sigmavu=sigmav/ustar;
            
    sigmazl=sigmaz/L;
            
    if L>0
                
        c=1+2.5*sigmazl;
                
        sigmay=1.6*sigmavu*sigmaz*c;
                
    else
                
        c=1-sigmazl;
                
        sigmay=1.6*sigmavu*sigmaz*(c^-0.5);
                
    end
    
end
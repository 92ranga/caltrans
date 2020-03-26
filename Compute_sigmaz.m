function sigmaz = Compute_sigmaz(L,x,ustar,Ue,ho)
        
    uU=ustar/Ue;
        
    xl=x/L;
            
    if L<0
        
        sigmaz=0.57*uU*x*(1-1.5*(uU*xl));
                
    else
                
        c=1+3*uU*(xl^(2/3));
                
        sigmaz=0.57*uU*x/c;
                
    end
    
%     sigmaz=sqrt((sigmaz^2)+(ho^2));

    sigmaz=sigmaz+ho;
    
end
function sigmav = Compute_sigmav(ustar,wstar)

    sigmavs3=(1.9*ustar)^3;
        
    sigmavc3=(0.6*wstar)^3;
        
    sigmav=(sigmavs3+sigmavc3)^(1/3);
    
end
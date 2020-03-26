function U = Similarity_Wind(z,zo,ustar,MOL)

    shi = z/MOL;
    x = (1-15*shi)^0.25;
    
    if MOL<=0
    
        phi = 2*log((1+x)/2)+log((1+x*x)/2)-2*atan(x)+(pi/2);
    
    else
    
        phi = -4.7*shi;
    
    end

    U = ustar/0.35*(log(z/zo)-phi);
    
end

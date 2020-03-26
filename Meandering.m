function [fr,thetas] = Meandering(Ue,sigmav,Xu,Xl,Yu,Yl)

    fr=2*(sigmav^2)/(Ue^2);
    
    m1=Yu/Xu;
    
    m2=Yl/Xl;
    
    thetas=atan(abs((m1-m2)/(1+m1*m2)));
    
    if isinf(m1)==1
        
        theta=atan(m2);
        
        if theta<(pi/2)
            
            thetas=(pi/2)-theta;
            
        else
            
            thetas=theta-(pi/2);
            
        end
        
    elseif isinf(m2)==1
        
        theta=atan(m1);
        
        if theta<(pi/2)
            
            thetas=(pi/2)-theta;
            
        else
            
            thetas=theta-(pi/2);
            
        end
        
    end
    
end
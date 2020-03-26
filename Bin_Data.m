function [Cp,Cm,d] = Bin_Data(B,step,start,stop)

    B=rmmissing(B);

    [n,~]=size(B);
    
    dis=B(:,3);
    
    for b=start:step:stop
        
        k=0;
            
        ib=b/step;
        
        Sum_p=0;
        
        Sum_m=0;
        
        for ir=1:n
            
            if dis(ir)>=(b-step) && dis(ir)<=b
                
                k=k+1;
                
                Sum_p=Sum_p+B(ir,1);
                
                Sum_m=Sum_m+B(ir,2);
                
            end
            
        end
        
            Cp1(ib)=Sum_p/k;
                
            Cm1(ib)=Sum_m/k;
                
            d1(ib)=(b+(b-step))/2;
        
    end
    
    Bb=[Cp1',Cm1',d1'];
    
    [nb,~]=size(Bb);
    
    l=0;
    
    for ir=1:nb
        
        if isnan(Bb(ir,1))==0
            
            l=l+1;
            
            Cp(l,:)=Bb(ir,1);
            
            Cm(l,:)=Bb(ir,2);
            
            d(l,:)=Bb(ir,3);
            
        end
        
    end
   
end

                
                
        
        
        
        
        
        
        
        
    
    
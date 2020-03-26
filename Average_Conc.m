function [Conc_Avg,SF6_Avg,X,Y,d]=Average_Conc(Conc,Rcp_SF6,siteLP,siteC,Rcp_x,Rcp_y,dis)

    n=length(siteLP);
    
    m=length(siteC);
    
    for lp=1:n
        
        Conc_Sum=0;
        
        SF6_Sum=0;
        
        k=0;
        
        clear x
        
        for c=1:m
            
            if strcmp(siteLP(lp),siteC(c))==1
                
                Conc_Sum=Conc_Sum+Conc(c);
                
                SF6_Sum=SF6_Sum+Rcp_SF6(c);
                
                x=Rcp_x(c);
                
                y=Rcp_y(c);
                
                di=dis(c);
                
                k=k+1;
                
            end
            
        end
        
        Conc_Avg(lp,:)=Conc_Sum/k;
        
        SF6_Avg(lp,:)=SF6_Sum/k;
        
        if exist('x')==1
        
            X(lp,:)=x;
        
            Y(lp,:)=y;
            
        else
            
            X(lp,:)=NaN;
        
            Y(lp,:)=NaN;
            
        end
        
         if exist('di')==1
        
            d(lp,:)=di;
            
        else
            
            d(lp,:)=NaN;
            
        end
        
    end
    
end
                
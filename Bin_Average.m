function [Xb,Yb] = Bin_Average(X,Y,n)

%X is the binning variable (eg. Distance)
%Y is the dependent variable (eg. Concentration)

    N=length(X);
    s=ceil(N/n);
    
    [Xs,I]=sort(X);
    Ys=Y(I);
    
    k=0;
    for i=1:s:N+s
        sumX=0;
        sumY=0;
        k=k+1;
        l=0;
        for j=i:i+s-1
            if j<=N
                l=l+1;
                sumX=sumX+Xs(j);
                sumY=sumY+Ys(j);
            end
        end
        
        if l~=0
            Xb(k,:)=sumX/l;
            Yb(k,:)=sumY/l;
        end
        
    end
    
end
        
        
    
    
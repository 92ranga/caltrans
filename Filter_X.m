function [Conc,Rcp_SF6,Rcp_x,Rcp_y]=Filter_X(Conc,Rcp_SF6,Rcp_x,Rcp_y,x)

    D=[Conc,Rcp_SF6,Rcp_x,Rcp_y];
    n=length(D);
    
    k=0;
    for i=1:n
        if Rcp_x(i)<=x
            k=k+1;
            E(k,:)=D(i,:);
        end
    end
    
    Conc=E(:,1);
    Rcp_SF6=E(:,2);
    Rcp_x=E(:,3);
    Rcp_y=E(:,4);

end
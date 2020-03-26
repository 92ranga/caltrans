function [Conc,fraction,Src_x,Src_y,Rcp_x,Rcp_y] = Rline_Test(wdir,ho)
    
    load('Data_Test.mat')
    
    Nm=length(L);
    [Ns,~]=size(Src_x);
    
    zs=1;
    zo=0.05;
    wdir=270-wdir;
    Q=Emis;
    
    k=0;
    for is=1:Ns
    
        for ir=1:Nm
            
            k=k+1;
        
            [Xr,Yr]=Rotate(Rcp_x(ir),Rcp_y(ir),wdir(ir));
            
            [Xs,Ys]=Rotate(Src_x(is,:),Src_y(is,:),wdir(ir));
            
            [Conc1(is,ir),fraction(k)]=Compute_Conc(Q(ir),Xr,Yr,Xs,Ys,ustar(ir),sigmav(ir),L(ir),wdir(ir),zs,zr(ir),zo,ho);
            
        end
        
    end
    
    Conc(1:Nm,:)=0;
    for is=1:Ns
        
        for ir=1:Nm
            
            Conc(ir)=Conc(ir)+Conc1(is,ir);
            
        end
        
    end
    
    %Plots
    plot(1:Nm,Conc)
    
    figure;
    scatter(Rcp_x,Rcp_y)
    hold on
    plot(Src_x,Src_y)
    axis equal
   
end
    
    
    
    


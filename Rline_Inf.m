function [a,R2] = Rline_Inf()

    load('Data_Centre.mat')
    
    Nm=length(L);
    
    Nr=length(sf6_x);
    
    sf6_x=sf6_x.*6;
    
    sf6_y=sf6_y.*6;
    
    zs=1;
    
    zr=1.5;
    
    zo=0.053;
    
%     [Src_x,Src_y]=Rotate(Src_x,Src_y,-57);
%     
%     [sf6_x,sf6_y]=Rotate(sf6_x,sf6_y,-57);
    
    wdir=270-wdir-57;
    
    Emis=Emis.*0.01./54;
    
    Q=Emis(sf6_ntest);
    
    sf6_flat(sf6_flat<=0)=NaN;
    
    for im=1:Nm
        
        for ir=1:Nr
            
            [Xr,Yr]=Rotate(sf6_x(ir),sf6_y(ir),wdir(im));
            
            [Xs,Ys]=Rotate(Src_x,Src_y,wdir(im));
            
            Conc(im,ir)=Compute_Conc_Inf(Q(im),Xr,Yr,Xs,Ys,ustar(im),wstar(im),L(im),wdir(im),zs,zr,zo);
            
        end
        
    end
    
    confv=(1e9*8.314*300/1e5/146);
    
%     confv=1.0135*(10^5)*146/(8.314*300)/(10^6);
    
%     Conc(Conc==0)=NaN;
    
    Concp=[];
    flatp=[];
    
    for ir=1:Nr-2
        
        Concp=[Concp; Conc(:,ir)];
        
        flatp=[flatp; sf6_flat(:,ir)];
            
    end
    
    x=Concp.*confv;
    
    y=flatp;
    
    a=[x,y];
    
    [textr,textf,R2]=Compute_Stats(x,y);
    
    figure;
                        
    loglog(x,y,'.')
    
    text(0.06,700,textr)
        
    text(0.06,300,textf)
    
    xlim([0.05,1000])
    
    ylim([0.05,1000])
    
    Plot_Ref
    
    xlim([0.05,1000])
    
    ylim([0.05,1000])
    
    xlabel('Predicted Concentration, ppb')
    
    ylabel('Observed Concentration, ppb')
    
    title('Infinite Line Source, ppb')
    
end
    
    
    
    


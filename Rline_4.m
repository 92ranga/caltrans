function [Conc,fraction] = Rline_4(ho,day)

    if day==1
        
        load('Data_0730_Caltrans_6_St.mat')
        lim=1000;
        
    elseif day==2
        
        load('Data_0806_Caltrans_6_St.mat')
        lim=1200;
        
    elseif day==3
        
        load('Data_0813_Caltrans_6_St.mat')
        lim=1500;
        
    elseif day==4
        
        load('Data_0820_Caltrans_6_St.mat')
        lim=1300;
        
    end
    
    %Remove Bag 1
    Nm=length(L);
    D=[bag,Emis,Rcp_SF6,Rcp_x,Rcp_y,sigmav,ustar,wdir,L,zr,dis];
    k=0;
    for i=1:Nm
        
        if bag(i)==4
            
            k=k+1;
            
            Df(k,:)=D(i,:);
            
            siteCf(k,:)=siteC(i,:);
            
        end
        
    end
        
%     bag=Df(:,1);
%     Emis=Df(:,2);
%     Rcp_SF6=Df(:,3);
%     Rcp_x=Df(:,4);
%     Rcp_y=Df(:,5);
%     sigmav=Df(:,6);
%     ustar=Df(:,7);
%     wdir=Df(:,8);
%     L=Df(:,9);
%     zr=Df(:,10);
%     di=Df(:,11);
    
    Df1=Df;
    site=siteCf;
    
    
%     %Remove Upwind Receptor
%     Nm=length(L);
%     D1=[bag,Emis,Rcp_SF6,Rcp_x,Rcp_y,sigmav,ustar,wdir,L,zr,di];
%     
%     k=0;
%     for i=1:Nm
%         
%         if i~=118 && i~=119 && i~=120 && i~=121 && i~=122
%             
%             k=k+1;
%             
%             Df1(k,:)=D1(i,:);
%             
%             site(k,:)=siteCf(i,:);
%             
%         end
%         
%     end
        
    bag=Df1(:,1);
    Emis=Df1(:,2);
    Rcp_SF6=Df1(:,3);
    Rcp_x=Df1(:,4);
    Rcp_y=Df1(:,5);
    sigmav=Df1(:,6);
    ustar=Df1(:,7);
    wdir=Df1(:,8);
    L=Df1(:,9);
    zr=Df1(:,10);
    di=Df1(:,11);
    
    
    Nm=length(L);
    [Ns,~]=size(Src_x);
    
    zs=0.5;
    zo=0.05;
%     wdir=270-wdir;
%     wdir=wdir-90+39.2870;
    wdir=270-wdir-39.2870;
    Q=Emis/6;
    Rcp_SF6=Rcp_SF6-BG;
    
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
    
    Convf=(8.314*300)/(101325*146)*1e12;
    
    Conc=Conc.*Convf;
    
    %Plots
    Plot_Scatter(Conc,Rcp_SF6,'Bag 4')
   
end
    
    
    
    


%Angle of curve for source
function [Conc] = Rline(ho,day,LW,met)
% function [bag,Conc,Rcp_SF6,Rcp_x,Rcp_y,site,zr] = Rline(ho,day,LW,met)
% function [Conc,Rcp_SF6,Rcp_x,Rcp_y] = Rline(ho,day,LW,met)

    if day==1
        load('Data_0730_Caltrans_6_St.mat')
    elseif day==2
        load('Data_0806_Caltrans_6_St.mat')
    elseif day==3
        load('Data_0813_Caltrans_6_St.mat')
    elseif day==4
        load('Data_0820_Caltrans_6_St.mat')
    end

    wdirg=270-wdir;
    wdir1g=270-wdir1;
    wdir6g=270-wdir6;
    dtheta1=adiff(wdirg,wdir1g);
    dtheta6=adiff(wdirg,wdir6g);
    dtheta=dtheta1; %Works Best
%     dtheta=dtheta6; %Not as good as 1.
    
    zref=5;
    if met==1
        L=L1;
        ustar=ustar1;
        sigmav=sigmav1;
        wspd=wspd1;
        wdir=wdir1;
        zref=2;
        dtheta(1:size(L))=0;
    elseif met==6
        L=L6;
        ustar=ustar6;
        sigmav=sigmav6;
        wspd=wspd6;
        wdir=wdir6;
        zref=2;
        dtheta(1:size(L))=0;
    elseif met==0
        dtheta(1:size(L))=0;
    end
        
    
    %Remove Bag 1
    Nm=length(L);
    D=[bag,Emis,Rcp_SF6,Rcp_x,Rcp_y,sigmav,ustar,wdir,L,zr,dis,wspd,dtheta];
    k=0;
    for i=1:Nm
        if bag(i)~=1
            k=k+1;
            Df(k,:)=D(i,:);
            siteCf(k,:)=siteC(i,:); 
        end 
    end
        
    bag=Df(:,1);
    Emis=Df(:,2);
    Rcp_SF6=Df(:,3);
    Rcp_x=Df(:,4);
    Rcp_y=Df(:,5);
    sigmav=Df(:,6);
    ustar=Df(:,7);
    wdir=Df(:,8);
    L=Df(:,9);
    zr=Df(:,10);
    di=Df(:,11);
    wspd=Df(:,12);
    dtheta=Df(:,13);
        
    %Remove Upwind Receptor
    Nm=length(L);
    D1=[bag,Emis,Rcp_SF6,Rcp_x,Rcp_y,sigmav,ustar,wdir,L,zr,di,wspd,dtheta];
    
    k=0;
    for i=1:Nm
        if Rcp_x(i)>0
            k=k+1;
            Df1(k,:)=D1(i,:);
            site(k,:)=siteCf(i,:); 
        end  
    end
        
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
    wspd=Df1(:,12);
    dtheta=Df1(:,13);
    
    
    Nm=length(L);
    [Ns,~]=size(Src_x);
    
    zs=0.5;
    zo=0.05;
%     zref=5;
%     wdir=270-wdir;
%     wdir=wdir-90+39.2870;
    wdir=270-wdir-39.2870;
    Emis=Emis/1300/2.5/3600;
    Q=Emis/6;
    Rcp_SF6=Rcp_SF6-BG;
    
    %Low Wind Condition
    m=1;
    if LW==1
        sigmav(sigmav<0.5)=0.5;
        m=0;
    elseif LW==2
        sigmav(sigmav<0.3)=0.3;
        m=1;
    elseif LW==3
        sigmav(sigmav<0.5)=0.5;
        m=1;
    end
    
    tx=atan(272/68); %Angle of curve
    k=0;
    for is=1:Ns
        for ir=1:Nm
            k=k+1;
            if Rcp_y(ir)<=272
                dx(ir)=Rcp_y(ir)/tan(tx);
            else
                dx(ir)=0;
            end
            [Xr,Yr]=Rotate(Rcp_x(ir)+dx(ir),Rcp_y(ir),wdir(ir));
            [Xs,Ys]=Rotate(Src_x(is,:),Src_y(is,:),wdir(ir));
            [Conc1(is,ir),fraction(k)]=Compute_Conc(Q(ir),Xr,Yr,Xs,Ys,ustar(ir),sigmav(ir),L(ir),wdir(ir),wspd(ir),zs,zr(ir),zref,zo,ho,m,dtheta(ir)); 
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
    
%     %Bags
    [Conc2,Rcp_SF62,Rcp_x2,Rcp_y2]=Sort_Bags(bag,2,Conc,Rcp_SF6,Rcp_x,Rcp_y);
    [Conc3,Rcp_SF63,Rcp_x3,Rcp_y3]=Sort_Bags(bag,3,Conc,Rcp_SF6,Rcp_x,Rcp_y);
    [Conc4,Rcp_SF64,Rcp_x4,Rcp_y4]=Sort_Bags(bag,4,Conc,Rcp_SF6,Rcp_x,Rcp_y);
    [Conc5,Rcp_SF65,Rcp_x5,Rcp_y5]=Sort_Bags(bag,5,Conc,Rcp_SF6,Rcp_x,Rcp_y);
    [Conc6,Rcp_SF66,Rcp_x6,Rcp_y6]=Sort_Bags(bag,6,Conc,Rcp_SF6,Rcp_x,Rcp_y);
    
    Cpe=Conc; Cme=Rcp_SF6; Xe=Rcp_x; Ye=Rcp_y; % Edge Effects
    
    %Average
    [Conc_Avg,SF6_Avg,X,Y,d]=Average_Conc(Conc,Rcp_SF6,siteLP,site,Rcp_x,Rcp_y,di);
    
    Ca=[Conc_Avg,SF6_Avg,X,Y,d];
    
    q=0;
    for i=1:length(Conc_Avg)
        
        if Conc_Avg(i)~=0
            
            q=q+1;
            
            Ca1(q,:)=Ca(i,:);
            
        end
        
    end
    
    Conc_Avg=Ca1(:,1);
    SF6_Avg=Ca1(:,2);
    X=Ca1(:,3);
    Y=Ca1(:,4);
    d=Ca1(:,5);
    
    %Binning
    
    B=[Conc_Avg,SF6_Avg,X];
    B=sortrows(B,3);
    
    [Cp,Cm,db]=Bin_Data(B,20,20,200);
    
    %Quiver
    wd=unique(wdir);
    s=length(wd);
    for i=1:s
        u(i)=cosd(wd(i));
        v(i)=sind(wd(i));
    end
    
    %Plots
    da=num2str(day);
    d=strcat('Day',{' '},da);

%     Plot_Scatter(Conc2,Rcp_SF62,'Bag 2')
%     Plot_Scatter(Conc3,Rcp_SF63,'Bag 3')
%     Plot_Scatter(Conc4,Rcp_SF64,'Bag 4')
%     Plot_Scatter(Conc5,Rcp_SF65,'Bag 5')
%     Plot_Scatter(Conc6,Rcp_SF66,'Bag 6')
% 
    Plot_Contour(Conc2,Rcp_SF62,Rcp_x2,Rcp_y2,Src_x,Src_y,Bar_x,Bar_y,'Bag 2');
    Plot_Contour(Conc3,Rcp_SF63,Rcp_x3,Rcp_y3,Src_x,Src_y,Bar_x,Bar_y,'Bag 3');
    Plot_Contour(Conc4,Rcp_SF64,Rcp_x4,Rcp_y4,Src_x,Src_y,Bar_x,Bar_y,'Bag 4');
    Plot_Contour(Conc5,Rcp_SF65,Rcp_x5,Rcp_y5,Src_x,Src_y,Bar_x,Bar_y,'Bag 5');
    Plot_Contour(Conc6,Rcp_SF66,Rcp_x6,Rcp_y6,Src_x,Src_y,Bar_x,Bar_y,'Bag 6');
    
    
%     num=[1:length(Conc_Avg)];
%     numc=num2str(num);

%     figure;
%     m1=max(Conc);
%     m2=max(Rcp_SF6);
%     m=max(m1,m2);
% %     scatter(Conc,Rcp_SF6,'MarkerFaceColor','r')
%     hold on
%     s2=scatter(Conc2,Rcp_SF62,'MarkerFaceColor','r','MarkerEdgeColor','k');
%     s3=scatter(Conc3,Rcp_SF63,'MarkerFaceColor','b','MarkerEdgeColor','k');
%     s4=scatter(Conc4,Rcp_SF64,'MarkerFaceColor','g','MarkerEdgeColor','k');
%     s5=scatter(Conc5,Rcp_SF65,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     s6=scatter(Conc6,Rcp_SF66,'MarkerFaceColor','c','MarkerEdgeColor','k');
%     xlabel('Predicted SF_6, ppt')
%     ylabel('Measured SF_6, ppt')
%     title(d)
%     axis equal
%     xlim([0,m])
%     ylim([0,m])
%     Plot_Ref()
%     xlim([0,m])
%     ylim([0,m])
%     legend([s2,s3,s4,s5,s6],{'Bag 2','Bag 3','Bag 4','Bag 5','Bag 6'},'NumColumns',2,'Location','SouthEast')
%     [R2,fact2]=Compute_Stats(Conc,Rcp_SF6);
%     [mg,sg]=Compute_Stats_A(Conc,Rcp_SF6);
%     str=[R2,fact2,mg,sg];
%     dim=[.25 .8 .05 .1];
%     annotation('textbox',dim,'String',str,'FitBoxToText','on');
%     grid on
%     box on
    
    figure;
    m1=max(Conc_Avg);
    m2=max(SF6_Avg);
    m=max(m1,m2);
    Conc_Avg=rmmissing(Conc_Avg);
    SF6_Avg=rmmissing(SF6_Avg);
    scatter(Conc_Avg,SF6_Avg,'MarkerFaceColor','r','MarkerEdgeColor','k')
    xlabel('Predicted SF_6, ppt')
    ylabel('Measured SF_6, ppt')
    title(d)
    axis equal
    xlim([0,m])
    ylim([0,m])
    Plot_Ref()
    xlim([0,m])
    ylim([0,m])
    [R2,fact2]=Compute_Stats(Conc_Avg,SF6_Avg);
    [mg,sg]=Compute_Stats_A(Conc_Avg,SF6_Avg);
    str=[R2,fact2,mg,sg];
%     str=[mg,sg];
    dim=[.25 .8 .05 .1];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
%     text(Conc_Avg,SF6_Avg,num)
    grid on
    box on
    
%     figure;
%     Cna=rmmissing(Conc_Avg);
%     SF6na=rmmissing(SF6_Avg);
%     np=length(Cna);
%     plot(1:np,Cna,'-bo')
%     hold on
%     plot(1:np,SF6na,'-ro')
%     legend('Predicted Concentration','Observed Concentration')
%     title('2.5 hr Averaged Concentration')
%     xlabel('Receptors')
%     ylabel('SF_6, ppt')
%     grid on
    
    Plot_Contour_Obs(Conc_Avg,SF6_Avg,rmmissing(X),rmmissing(Y),Src_x,Src_y,Bar_x,Bar_y,'Average Concentration');
%     hold on
%     for i=1:s
%         
%         quiver(0,0,u(i),v(i),100)
%         
%         
%     end

%     figure;
%     plot(db,Cm)
%     hold on
%     plot(db,Cp)
%     xlabel('Distance, m')
%     ylabel('SF_6, ppt')
%     legend('Observed','Predicted')
%     grid on

    %Edge Effects
    figure
    [Conce,Rcp_SF6e,~,Rcp_ye]=Filter_X(Cpe,Cme,Xe,Ye,20);
    n=length(Conce);
    r=Conce./Rcp_SF6e;
    [Yb,Cb] = Bin_Average(Rcp_ye,r,10);
%     Cb=r;Yb=Rcp_y;
    scatter(Yb,Cb,'MarkerFaceColor','r')
    hold on
    plot(Rcp_ye,ones(n,1))
    xlabel('y')
    ylabel('C_p/C_o')
    grid on
    box on
    
end
    
    
    
    


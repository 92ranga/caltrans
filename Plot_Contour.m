function Plot_Contour(Pred,Obs,Xr,Yr,Xs,Ys,Xb,Yb,heading)
    
    r=Pred./Obs;
    
    [Ns,~]=size(Xs);

    figure;
    
    R=scatter(Xr,Yr,[],r,'filled');
    
    colorbar
    
    colormap(jet)
    
    hold on
    
    for is=1:Ns
        
        S(is)=plot(Xs(is,:),Ys(is,:),'r');
        
    end
    
    B=plot(Xb,Yb,'b');
    
    title(heading)
    
    title(colorbar,'Ratio of Modeled to Measured SF_6')
    
    legend([R,S(1),B],'Receptors','Line Source','Barrier')
    
    xlabel('X, m')
    
    ylabel('Y, m')
    
    caxis([0,2])
    
    grid on
    
    axis equal
    
    axis square
    
    xlim([-100,200])
    
end
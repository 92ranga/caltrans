function Plot_Scatter(Pred,Obs,heading)

    figure;
    
    Max=max(max(Pred),max(Obs));
    
%     Min=min(min(Pred),min(Obs));
    
    scatter(Pred,Obs,'r','filled');
    
    title(heading)
    
    xlabel('Predicted SF_6, ppb')
    
    ylabel('Observed SF_6, ppb')
    
    grid on
    
    axis equal
    
    xlim([0,Max])
    
    ylim([0,Max])
    
    Plot_Ref()
    
    xlim([0,Max])
    
    ylim([0,Max])
    
    [R2,fact2]=Compute_Stats(Pred,Obs);
    [mg,sg]=Compute_Stats_A(Pred,Obs);
    str=[R2,fact2,mg,sg];
    dim=[.25 .8 .05 .1];
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    
end
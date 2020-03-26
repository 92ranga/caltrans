function Rline_Plot_Bins(day)

    set(0,'DefaultFigureVisible','off')
    
    [~,~,Cp,~,db] = Rline(5,day,0,0);
    
    [~,~,Co,~,~] = Rline(0,day,0,0);
    
    set(0,'DefaultFigureVisible','on')
    
    figure;
    hold on
    plot(db,(Co-Cp)./Co.*100,'r')
    xlabel('Distance, m')
    ylabel('% Reduction')
    xlim([0,200])
    ylim([0,70])
    grid on
    box on
    d=num2str(day);
    tit=strcat('Day',{' '},d);
    title(tit)
    
end
    
    
    
    
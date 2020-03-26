function Test_Rline()
    
    wdir=(-89.99:10:89.99);
    wdir=270-wdir;
    
    set(0,'DefaultFigureVisible','off')
    
    [Conc0,~] = Rline_Test(270,0);
    
    for im=1:length(wdir)
    [Conc(im),~,Src_x,Src_y,Rcp_x,Rcp_y] = Rline_Test(wdir(im),0);
    end
    
    set(0,'DefaultFigureVisible','on')
    
    figure;
    plot(270-wdir,Conc./Conc0)
    
    figure
    plot(Src_x,Src_y)
    hold on
    scatter(Rcp_x,Rcp_y)
    
end
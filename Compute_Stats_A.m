function [textm,texts]=Compute_Stats_A(Pred,Obs)

    em=log(Pred)-log(Obs);
    
    em=rmmissing(em);
    
    m=exp(nanmean(em));
    
    s=exp(nanstd(em));
    
    mg=round(m,2);
    
    textm=strcat('m_g =',{' '}, num2str(mg));
 
    sg=round(s,2);
    
    texts=strcat('s_g =',{' '}, num2str(sg));
    
end
function [textr,textf,R2]=Compute_Stats(Pred,Obs)

    %Calculate R^2
    
    fit=fitlm(Pred,Obs);
    
    R2=fit.Rsquared.Ordinary;
    
    R2=round(R2,2);
    
    textr=strcat('R^2 =',{' '}, num2str(R2));
    
    %Calculate fact2
    
    nfact2=0;
    
    rt=Pred./Obs;
    
    Nr=length(Obs);
    
    for ir=1:Nr
        
        if rt(ir)<=2 && rt(ir)>=0.5
            
            nfact2=nfact2+1;
            
        end
        
    end
    
    fact2=nfact2/Nr*100;
    
    fact2=round(fact2,1);
    
    textf=strcat('fact2 =',{' '}, num2str(fact2),'%');
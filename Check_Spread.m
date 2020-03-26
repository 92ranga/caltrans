function [sigmaz,sigmay]=Check_Spread

load('Data.mat');

load('IF_Data_ME_255.mat')

    Nm=length(L);
    
    Nr=length(dwnd);

    for im=1:Nm
        
        for ir=1:Nr
            
            sigmaz(im,ir) = Compute_sigmaz(L(im),dwnd(ir),ustar(im),wspd(im));
            
            sigmay(im,ir) = Compute_sigmay(L(im),ustar(im),wstar(im),sigmaz(im,ir));
            
        end
        
    end
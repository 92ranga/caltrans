function Ue = Compute_Ue(U,sigmav)

    sigmav2=sigmav^2;
    
    U2=U^2;
    
    Ue=(2*sigmav2+U2)^0.5;
    
end
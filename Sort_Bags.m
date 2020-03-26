function [Vars1,Vars2,Vars3,Vars4]=Sort_Bags(bag,n,Var1,Var2,Var3,Var4)

    cn=length(bag);
    
    k=0;
    for c=1:cn
        
        if bag(c)==n
            
            k=k+1;
            
            Vars1(k)=Var1(c);
            
            Vars2(k)=Var2(c);
            
            Vars3(k)=Var3(c);
            
            Vars4(k)=Var4(c);
            
        end

    end
    
end
    

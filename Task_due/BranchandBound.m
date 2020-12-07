function [soluzioni_out,X_out] = BranchandBound(A,b,Aeq,beq,f,soluzioni, X_in)

soluzioni_out=soluzioni;

X_out=X_in;

% Trovo soluzione PL (Rilassamento lineare)

[X,fval]=linprog(f,A,b,Aeq,beq); 


% Se non ho soluzioni ammissibili fermo l'algoritmo

if isempty(X)
    return
end


% Se ho trovato una soluzione intera migliore dell'ultima trovata
% -> aggiorno la soluzione e fermo l'algoritmo    

if floor(X(1))==X(1) && floor(X(2))==X(2)
    
    if fval< soluzioni 
    
        soluzioni_out= fval;
    
        X_out=X;
    
        return
    end            
end

% Se la prima componente della soluzione trovata non è intera e la soluzione
% è migliore dell'ultima trovata -> procedo con i due sottoproblemi

if ~(floor(X(1))== X(1))
    
    if fval> soluzioni_out
        return
        
    else
        
        [soluzioni_out1,X_out1] = BranchandBound([A;1,0],[b floor(X(1))],Aeq,beq,f,soluzioni,X_in);
        
        if soluzioni_out1<soluzioni %se la soluzione è migliore di quella trovata fino ad ora
            
            soluzioni=soluzioni_out1; % aggiorno la soluzione
            
            
        end
        
        [soluzioni_out2,X_out2] = BranchandBound([A;-1,0],[b -ceil(X(1))],Aeq,beq,f,soluzioni,X_in);
        
        soluzioni_out= min(soluzioni_out2, soluzioni); % aggiorno la soluzione con la migliore tra le due
        
        % Salvo il risultato migliore tra i due sottoproblemi
        
        if soluzioni_out1==soluzioni_out
            
            X_out=X_out1;
       
        else
            
            X_out = X_out2;
            
        end
    end
    
else
    
    % Se la seconda componente della soluzione trovata non è intera e la soluzione
    % è migliore dell'ultima trovata -> procedo con i due sottoproblemi
    
    if  ~((floor(X(2))==X(2))) && (floor(X(1))==X(1))
        
        if fval> soluzioni_out
            return
            
        else
            
            [soluzioni_out1,X_out1] = BranchandBound([A;0,1],[b floor(X(2))],Aeq,beq,f,soluzioni,X_in) ;
            
            if soluzioni_out1 < soluzioni %se la soluzione è migliore di quella trovata fino ad ora
                
                soluzioni=soluzioni_out1; % aggiorno la soluzione
               
            end
            
            [soluzioni_out2,X_out2] = BranchandBound([A;0,-1],[b -ceil(X(2))],Aeq,beq,f,soluzioni,X_in);
            
            soluzioni_out= min(soluzioni_out2,soluzioni); % aggiorno la soluzione con la migliore tra le due
            
            % Salvo il risultato migliore tra i due sottoproblemi
            
            if soluzioni_out==soluzioni_out1
               
                X_out=X_out1;
            else
                
                X_out=X_out2;
            
            end
        end
    end
end
    
    
end


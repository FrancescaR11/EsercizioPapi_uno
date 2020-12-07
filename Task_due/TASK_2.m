%% Implementazione metodo Branch-Bound per un problema di PLI con 2 variabili

close all
clear all
clc

% Definisco la funzione obiettivo ed i vincoli

f=[-5 -17/4];

A=[1 1;
    10 6;
    -1 0;
    0 -1];

b=[5 45 0 0];

Aeq=[];

beq=[];

% Altro caso di Test
% f=[-3 -1];
% 
% A=[7 2;
%     -2 2;
%     -1 0;
%     0 -1;
%     -1 0;
%     0 -1];
% 
% b=[22 1 -1 0 4 3];

% calcolo i coefficenti angolari delle due rette che definiscono la regione
% di ammissibilità

if A(1,2)<0
    
    m1= A(1,1)/A(1,2);
   
end

if A(1,2)>0
    
    m1= -(A(1,1)/A(1,2));
    
    
else 
        m1= 0;
end

if A(2,2)<0
   
    m2= A(2,1)/A(2,2);
    
end

if A(2,2)>0
    
    m2= -(A(2,1)/A(2,2));
   
    
else
        m2= 0;
end
 

% Calcolo il punto di intersezione tra le rette 

syms x y

[xint yint]= solve( A(1,1)*x+A(1,2)*y-b(1), A(2,1)*x+A(2,2)*y-b(2), x,y);

Q= [xint yint]; % salvo il punto di intersezione nella variabile Q

% Definisco come soluzione di partenza il caso peggiore: infinito

soluzioni = inf;

% Prima di procedere con il calcolo della prima soluzione, verifico se la regione di ammisibilità è limitata

if ((det(A(1:2,:)) == 0) && (m1< 0) && (m2<0)) || ((det(A(1:2,:)) ~=0) && Q(1)>0 && Q(2)>0)
    
    [X,fval]= linprog(f,A,b,Aeq,beq);
    
    X_in=X;
    
else
    
    disp('Non è possibile calcolare la soluzione ottima del problema perchè la regione di ammissibilità non è limitata');
    
end


% Se la soluzione ottima trovata ha componenti intere e il valore della funzione
% è minore di quello in "soluzioni" ho trovato la soluzione ottima

if floor(X(1))==X(1) && floor(X(2))==X(2)
    
    if fval<soluzioni
       
        soluzioni= fval;
        
        X_out=X;
    end
end

% Se la prima componente della soluzione non è intera procedo con il metodo
% Branch & Bound

if  ~(floor(X(1))== X(1))
    
    [soluzioni_out1,X_out1] = BranchandBound([A;1,0],[b floor(X(1))],Aeq,beq,f,soluzioni,X_in); % primo sottoproblema
    
    if soluzioni_out1<soluzioni  % aggiorno "soluzioni" con la soluzione migliore che trovo in questo ramo
        
        soluzioni=soluzioni_out1;
       
        X_in=X_out1;
        
    end
    
    [soluzioni_out2,X_out2] = BranchandBound([A;-1,0],[b -ceil(X(1))],Aeq,beq,f,soluzioni,X_in); % secondo sottoproblema
    
    soluzioni= min(soluzioni_out2, soluzioni); % aggiorno 'soluzioni 'con la soluzione migliore
    
    % Salvo il risultato migliore tra i due sottoproblemi
    
    if soluzioni_out1==soluzioni
        
        X_out=X_out1;
    else
        
        X_out = X_out2;
        
    end
    
end

% Se la seconda componente della soluzione non è intera procedo come per
% la prima componente

if ~((floor(X(2))==X(2))) && (floor(X(1))==X(1))
    
    [soluzioni_out1,X_out1] = BranchandBound([A;0,1],[b floor(X(2))],Aeq,beq,f,soluzioni,X_in);
    
    if soluzioni_out1 < soluzioni
        
        soluzioni=soluzioni_out1;
        
        X_in=X1;
    end
    
    [soluzioni_out2,X_out2] = BranchandBound([A;0,-1],[b -ceil(X(2))],Aeq,beq,f,soluzioni,X_in);
    
    soluzioni= min(soluzioni_out2,soluzioni);
    
    if soluzioni==soluzioni_out1
        
        X_out=X1;
        
    else
        
        X_out=X2;
    end
    
end


% La solzuione otttima finale sarà -soluzioni e il punto di ottimo
% sarà contenuto nella variabile X_out









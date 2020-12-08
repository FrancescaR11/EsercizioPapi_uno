close all
clear all
clc

%IMPLEMENTO IL PROBLEMA DELLO ZAINO KP

n=3; % variabili

b=5; % capacità massima zaino

a=[1 2 3]; % spazio occupato dagli oggetti

c=[6 10 12]; % valore degli oggetti

d=[0:b]; 

% z rappresneta il massimo della funzione obiettivo per il problema KP

z=zeros(n,length(d)); %inizializzo z come una matrice vuota

% Calcolo la matrice z che conterrà sulla prima, seconda e terza riga z1,
% z2, e z3 rispettivamente

for i=1:length(d)
    
    if d(i)<a(1)
    
        z(1,(d(i)+1))= 0;
    else
        z(1,(d(i)+1))=c(1);
    end
    
end

for r=2:n
    
    for i=1:length(d)
        
        if d(i)<a(r)
            z(r,(d(i)+1))=z(r-1,(d(i)+1));
        else
            z(r,(d(i)+1))=max(z(r-1,(d(i)+1)),(z(r-1,(d(i)-a(r)+1))+c(r)));
        end
    end
    
end


% Calcolo la configurazione ottimale del problema

x=zeros(n,length(d)); %vettore di appoggio necessario per il calcolo ricorsivo

x_ott=zeros(1,length(d)); % inizializzazione vettore contenente configurazione ottimale

% Calcolo x_ott per r=1

for i=1:length(d)
    
    if d(i)<a(1)
    
        x_ott(1,(d(i)+1))= 0;
    else
        x_ott(1,(d(i)+1))=1;
    end
    
end  

% Calcolo x_ott per r=2,3

for r=2:n
    
    x=x_ott; % salvo la precedente x_ott in x
    
    x_ott=zeros(r,length(d)); % inizializzo nuovamente x_ott
    
    for i=1:length(d)
        
        if z(r,(d(i)+1))==z(r-1,(d(i)+1))
          
            x_ott(:,d(i)+1)= [x(1:r-1,d(i)+1); zeros(1,1)];
            
        else
            
            if z(r,(d(i)+1))==(z(r-1,(d(i)-a(r)+1))+c(r))
                
                x_ott(:,d(i)+1)=[x(1:r-1,d(i)-a(r)+1); ones(1,1)];
                
            end
        end
        
    end
    
end

% La configurazione ottima sarà contenuta in x_ott(:,length(d))

configurazione_ottima= x_ott(:,length(d));

% Il massimo della funzione obiettivo per il problema KP è in
% corrispondenza di z(n,length(d))

max_funzione=z(n,length(d));











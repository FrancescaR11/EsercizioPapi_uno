
close all
clear all
clc

%IMPLEMENTO IL PROBLEMA DELLO ZAINO K(n,b)

n=5;
b=5;
spazio=[2 3 7 5 9]; %coefficienti di vincolo
valore=[12 24 7 10 6]; %coefficienti della funzione obiettivo
d=[0:b]; %capacità dello zaino


%Inizializzo le variabili
z=zeros(1,length(d)); 
z1=zeros(1,length(d)); 
x=zeros(1,length(d)); 
x1=zeros(1,length(d));
%x1 e z1 servono per tenere conto dell'iterata successiva ad ogni passo,
%così da poter aggiornare la precedente, ovvero x e z

for j=1:length(spazio)
         %Aggiorno z e x al passo 1
         if j==1
             for i=1:length(d)
                 if d(i)<spazio(j)
                     z1(i)=z(i);
                 else
                     z1(i)=max(z(i),(z(i-spazio(j))+valore(j)));
                 if d(i)<spazio(j)
                     x(1,i)=0;
                 else
                     x(1,i)=1;
                 end
                 end
             
             end
         z=z1;
         %Aggiorno z e x ai passi successivi
         else 
             x1=[x1;zeros(1,6)];
             for i=1:length(d)
                 if d(i)<spazio(j)
                     z1(i)=z(i);
                 else
                     z1(i)=max(z(i),(z(i-spazio(j))+valore(j)));
                 end
                 if z1(i)==z(i)
                     x1(:,i)=[x(:,i);zeros(1,1)];
                 else
                     if z1(i)==(z(i-spazio(j))+valore(j))
                        x1(:,i)=[x(:,i-spazio(j));ones(1,1)];
                     end
                 end
             end
         z=z1;
         x=x1;
         end
end

configutazione_ottima=x1(:,length(d))
valore_totale=z1(:,length(d))





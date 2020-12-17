clear all
close all
clc

%% OTTIMIZZAZIONE CON INCERTEZZA: MODELLO DEL 'VENDITORE DI GIORNALI' SECONDO I TRE METODI VISTI

d=[30 40 50 60 100]; % variabile aleatoria 

p=[1/7 2/7 2/7 1/7 1/7]; % probabilità  associate

c=1.6; % costo di acquisto di un giornale dall'editore

s=1.8; % prezzo di vendita di un giornale da parte del venditore

r=0.8; % prezzo di rivendita del giornale all'editore

% Vogliamo stimare il numero di giornali (x) che il venditore deve acquistare
% dal'editore, stimando la domanda giornaliera di quotidiani.

%% METODO 1

% max f(x,D_media) su x

D_media=0;

for i=1:length(d)
    D_media=D_media+p(i)*d(i);
end

D=D_media;

fun=@(x) c*x-s*min(x,D)-r*max(0,x-D);

xmin1=[];

fott=[];

for i=1:length(d)-1
   
    if d(i)==d(1)
        x1=0;
        x2=d(i);
        xott = fminbnd(fun,x1,x2);
        xmin1=[xmin1,xott];
        x=[0:d(i)];
        hold on
        p1=plot(x,-fun(x),'b-','Linewidth',2)
    end
    
    x1=d(i);
    x2=d(i+1);
    xott = fminbnd(fun,x1,x2);
    xmin1=[xmin1,xott];
    hold on
    x=[d(i):d(i+1)];
    p1=plot(x,-fun(x),'b','Linewidth',2)
    
end


% Verifico dove la funzione assume valore minimo passandogli il vettore
% "xmin1" calcolato

fottimale1=inf;

for i=1:length(xmin1)-1
    
    fott=[fott,fun(xmin1(i))];
    
    if fott(i)<fottimale1
        fottimale1=min(fott);
        xottimale1=xmin1(i);
    end
    
end

fottimale1=-fottimale1;

%% METODO 2

%min su x(max -f(x,D) su D)  massimo del minimo profitto
         %min  f(x,D)

%Mi metto nella situazione peggiore: il venditore sceglie di acquistare il
%maggior numeor di giornali, nell'ipotesi di venderne il meno possibile

xmin2=[];

for i=1:length(d)-1
    for j=d(i):d(i+1) %faccio variare x negli intervalli di d per stimare D_ottimale
        x=j;
        fun=@(D) -c*x+s*min(x,D)+r*max(0,x-D);
        x1=d(i);
        x2=d(i+1);
        xott2 = fminbnd(fun,x1,x2);
        xmin2=[xmin2,xott2];
    end
end

D_ottimale=min(xmin2);

%Calcolo il minimo della perdita massima

D=D_ottimale;

fun=@(x) c*x-s*min(x,D)-r*max(0,x-D);

xmax3=[];

fott=[];

for i=1:length(d)-1
    if d(i)==d(1)
        x1=0;
        x2=d(i);
        xott = fminbnd(fun,x1,x2);
        xmax3=[xmax3,xott];
        x=[0:d(i)];
        hold on
        p2=plot(x,-fun(x),'r','Linewidth',2)
    end
    x1=d(i);
    x2=d(i+1)
    xott = fminbnd(fun,x1,x2);
    xmax3=[xmax3,xott];
    hold on
    x=[d(i):d(i+1)];
    p2=plot(x,-fun(x),'r','Linewidth',2)
    
end

% Verifico dove la funzione assume valore minimo passandogli il vettore
% "xmax3" calcolato

fottimale2=inf;

for i=1:length(xmax3)-1
    
    fott=[fott,fun(xmax3(i))];
    
    if fott(i)<fottimale2
        fottimale2=min(fott);
        xottimale2=xmax3(i);
        
    end
end

fottimale2=-fottimale2; 

%% METODO 3
% Programmazione stocastica

% Considero per ogni valore di x ammisibile, f(x,D) come v.a. e calcolo il
% suo valore atteso

sumf=@(x) 0;

for i=1:length(d)
    
    [fun]=calcolo_fun(c,s,r,d(i),p(i));
    
    sumf=@(x) fun(x)+sumf(x);
    
end

xmax4=[];

for i=1:length(d)-1
   
    if d(i)==d(1)
        x1=0;
        x2=d(i);
        xott = fminbnd(sumf,x1,x2);
        xmax4=[xmax4,xott];
        x=[0:d(i)];
        p3=plot(x,sumf(x),'g','Linewidth',2)
    end
    
    x1=d(i);
    x2=d(i+1);
    xott = fminbnd(sumf,x1,x2);
    xmax4=[xmax4,xott];
    hold on
    x=[d(i):d(i+1)];
    p3=plot(x,sumf(x),'g','Linewidth',2)
    
    
end

% Verifico dove la funzione assume valore minimo passandogli il vettore
% "xmax4" calcolato

fottimale3=inf;

fott=[];

for i=1:length(xmax4)-1
    
    fott=[fott,sumf(xmax4(i))];
    
    if fott(i)<fottimale3
        fottimale3=min(fott);
        xottimale3=xmax4(i);
    end
    
end

fottimale3=-fottimale3;

lgd=legend([p1 p2 p3],{'Metodo 1', 'Metodo 2', 'Metodo 3'});

title(lgd,'Legenda')

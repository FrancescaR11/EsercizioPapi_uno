clear all
close all
clc

%% IMPLEMENTAZIONE DEL MODELLO DEL 'VENDITORE DEI GIORNALI' SECONDO I TRE METODI VISTI

d=[30 40 50 60 100]; %variabile casuale
p=[1/7 2/7 2/7 1/7 1/7]; %probabilità associate
c=1; %costo acquisto di un giornale
s=2; %prezzo di vendita di un giornale
r=0.5; %prezzo di riacquisto del giornale non venduto
x=[1:100];
%x=numero giornali acquistati dall'editore

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
            plot(x,-fun(x))
        end
        x1=d(i);
        x2=d(i+1)
        xott = fminbnd(fun,x1,x2);
        xmin1=[xmin1,xott];
        hold on
        x=[d(i):d(i+1)];
        plot(x,-fun(x))

end
%Gli passo i valori di x e vedo dove la funzione assume valore minimo
fottimale1=inf;
for i=1:length(xmin1)-1
    
    fott=[fott,fun(xmin1(i))];
    if fott(i)<fottimale1
    fottimale1=min(fott);
    xottimale1=xmin1(i);
    end
end



%% METODO 2
%min su x(max -f(x,D) su D)  massimo del minimo profitto
         %min  f(x,D)
%Mi metto nella situazione peggiore
xmin2=[];
for i=1:length(d)-1
    for j=d(i):d(i+1) %fisso x facendolo variare negli intervalli e cerco D
        x=j;
        fun=@(D) -c*x+s*min(x,D)+r*max(0,x-D);
        x1=d(i);
        x2=d(i+1)
        xott2 = fminbnd(fun,x1,x2);
        xmin2=[xmin2,xott2];
    end
end
D_ottimale=min(xmin2);

%ora faccio il minimo della perdita massima
D=D_ottimale;
fun=@(x) c*x-s*min(x,D)-r*max(0,x-D);
xmax3=[];
fott=[];
for i=1:length(d)-1
    if d(i)==d(1)
        x1=0;
        x2=d(i);
        xott = fminbnd(fun,x1,x2);
        xmax3=[xmax3,xott]
        x=[0:d(i)];
        hold on
        plot(x,-fun(x))
    end
    x1=d(i);
    x2=d(i+1)
    xott = fminbnd(fun,x1,x2);
    xmax3=[xmax3,xott];
    hold on
    x=[d(i):d(i+1)];
    plot(x,-fun(x))
end
%Gli passo i valori di x e vedo dove la funzione assume valore minimo
fottimale2=inf;
for i=1:length(xmax3)-1
    
    fott=[fott,fun(xmax3(i))];
    if fott(i)<fottimale2
    fottimale2=min(fott);
    xottimale2=xmax3(i);
    end
end


%% METODO 3
%programmazione stocastica

sumf=@(x) 0;
for i=1:5
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
        plot(x,sumf(x))
    end
    x1=d(i);
    x2=d(i+1);
    xott = fminbnd(sumf,x1,x2);
    xmax4=[xmax4,xott];
    hold on
    x=[d(i):d(i+1)];
    plot(x,sumf(x))
end

%Gli passo i valori di x e vedo dove la funzione assume valore minimo
fottimale3=inf;
fott=[];
for i=1:length(xmax4)-1
    
    fott=[fott,fun(xmax4(i))];
    if fott(i)<fottimale3
    fottimale3=min(fott);
    xottimale3=xmax4(i);
    end
end







close all
clear all
clc
%DISCESA DEL GRADIENTE
%Inizializzo (x0,e,k=0)
%calcolo la direzione di discesa dk=-grad(f(xk))
%lungo tale direzione cerco lk>0 tale che f(xk+lk*dk)<f(xk)
%aggiorno xk+1=xk+lk*dk e k=k+1

x=linspace(-4, 4, 100);
y=linspace(-4, 4, 100);

[X,Y]=meshgrid(x,y);
Z= 2*X.^2+3*Y.^2;


mesh(X,Y,Z);

%inizializzo
X0=1;
Y0=1;
Z0 = f_task1 (X0,Y0);

%gradiente
dk=gradf(X0,Y0);

%lungo tale direzione cerco lk>0 tale che f(xk+lk*dk)<f(xk)
%calcolo passo di discesa lk

e=0.00001;
lk=0.005;
X=X0;
Y=Y0;
k=0;
exit=0; 
H=[4 , 0 ; 0 , 6];
iterazioni=0;

while not(exit)
    dk=gradf(X,Y);
    if norm(dk)<e
        disp('trovato minimo');
        exit=1;
    else
        iterazioni= iterazioni+1;
        X=X+lk*dk(1);  %-1
        Y=Y+lk*dk(2);  %-2
        dk=gradf(X,Y);
        lk= (gradf(X,Y)*dk')/(dk*H*dk');
        k=k+1;
        exit=0;
    end
end
Zmin = f_task1 (X,Y);
hold on
plot3(X,Y,Zmin,'b*','Markersize',20)




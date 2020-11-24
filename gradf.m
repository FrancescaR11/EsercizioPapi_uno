function [dk] = gradf(X,Y)
%calcolo la direzione di discesa dk=-grad(f(xk))
FX=4*X;
FY=6*Y;
dk=-[FX,FY];
end


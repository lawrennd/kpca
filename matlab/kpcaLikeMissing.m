function f = kpcaLikeMissing(X,W,sigma,kern, I,npts,Dim);

% KPCALIKEMISSING computes cross entropy between kernel and approximating matrix.

% KPCA


X=reshape(X,npts,Dim);

A=kernCompute(kern, X);
Kx =W*W'+sigma*eye(npts); 
f= +0.5*logdet(Kx)+0.5*trace(A*pdinv(Kx))-npts/2;


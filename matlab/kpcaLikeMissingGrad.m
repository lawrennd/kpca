function f = kpcaLikeMissingGrad(X,W,sigma,kern, I,npts,Dim);

% KPCALIKEMISSINGGRAD gradient of the cross entropy w.r.t. missing data.

% KPCA


X=reshape(X,npts,Dim);

npts = size(X,1);
Dim = size(X,2);
A = kernCompute(kern, X);
invA=pdinv(A);
Kx =W*W'+sigma*eye(npts); 
invKx=pdinv(Kx);
gX = zeros(npts,Dim);
for i=1:npts
    gX(i,:) = ((invKx(i,:))*kernGradX(kern, X(i,:), X)).*I(i,:);
end

f = reshape(gX, 1, npts*Dim);





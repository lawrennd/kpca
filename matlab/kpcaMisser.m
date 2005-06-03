function [newX, I] = kpcaMisser(X, p,seedling);

% KPCAMISSER randomly deletes a proportion p of entries from the data design matrix

% KPCA

% X.
rand('seed',seedling);
if p < 0
    error('p must be in [0,1]\n');
elseif p > 1
    error('p must be in [0,1]\n');
else 
end
Dim = size(X,2);
npts = size(X,1);
Y = rand(npts, Dim);
I = Y>(1-p);
neuX = zeros(npts,Dim);
for i=1:Dim
    neuX(:,i) = X(:,i).*(ones(npts,1)-I(:,i));
end
avgX = sum(neuX,1)./sum(ones(npts,Dim)-I,1);
Replace = zeros(npts,Dim);
for i=1:Dim
    Replace(:,i) = avgX(i)*I(:,i);
end
newX = neuX + Replace;
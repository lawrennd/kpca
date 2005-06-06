function W=kpca(kern,X, dims)

% KPCA performs kernel PCA

% KPCA 

A=kernCompute(kern,X);
[sigma, V, lambda]=ppca(A,dims);
W=V;

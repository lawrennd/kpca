function f = kpcaNumComp(A,options,dims);

% KPCANUMCOMP computes the number of principal components to be used in a

% KPCA

% KPCA missing data problem.

lambda = eig(A);
numComp = 0;
captVar=0;
while captVar < options.captVar
    numComp = numComp+1;
    captVar = sum(lambda((end-numComp):end)/sum(lambda));
end
f=numComp+1;
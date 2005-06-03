function [updatedX, var, PcEig, PcCoeff] = kpcaMissingData(X,options,W,sigma,kern,I,numComp)

% KPCAMISSING solves kpca missing data problem by iteratively minimising cross entropy.

% KPCA


npts=size(X,1);
Dim=size(X,2);
optionsScg=foptions;
%optionsScg(9)=1;
DiffKL=1;
Iter = 0;
while DiffKL > options.sensitivity & Iter < options.maxIter
    Iter = Iter + 1;
    X=reshape(X,1,npts*Dim);
    OldKL = kpcaLikeMissing(X,W,sigma,kern, I,npts,Dim);
    newX=scg('kpcaLikeMissing',X,optionsScg,'kpcaLikeMissingGrad',W,sigma,kern,I,npts,Dim);
    NewKL = kpcaLikeMissing(newX,W,sigma,kern, I,npts,Dim);
    DiffKL = OldKL - NewKL;
    if DiffKL < 0
        error('KL going up!\n')
    end
    newX=reshape(newX,npts,Dim);
    A=kernCompute(kern, newX);
    [sigma, V, lambda]=ppca(A,numComp);
    W=V*sqrt(diag(lambda));
   % fprintf('Iteration %d complete.\n', Iter);
    X=newX;
end
if Iter==options.maxIter
  fprintf('Maximum iterations exceeded.\n');
end
updatedX=newX;
var=sigma;
PcEig=V;
PcCoeff=lambda;
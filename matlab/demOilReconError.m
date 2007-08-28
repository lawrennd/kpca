% DEMOILRECONERROR performs  missing data KPCA on oil flow for different percentages of missing data and different seeds.

% KPCA

X=load('data/DataTrn.txt');
X=X(1:100,:);
Labels=load('data/DataTrnLbls.txt');
Labels=Labels(1:100,:); % loads oil flow dataset and subsamples to 100 datapoints.
kern=kernCreate(X,'rbf');
kern.inverseWidth = 0.075;
npts=size(X,1);
Dim=size(X,2);
options = kpcaOptions;
options.sensitivity=1e-4;
p=[0,0.05,0.1,0.25,0.5];
initialReconError=zeros(4,50);
initialSquaredError = zeros(4,50);
finalReconError = zeros(4,50);
finalSquaredError = zeros(4,50);
for i=1:4
    for j=1:50
        seedling = j*1e5;
        [newX, I] = kpcaMisser(X,p(i+1),seedling);
        initialReconError(i,j)=sum(sum((X-newX).^2))/npts;
        A=kernCompute(kern, newX);
        numComp=kpcaNumComp(A, options,Dim);
        Y=kernPca(kern,X,numComp);
        [sigma, oldV, lambda]=ppca(A,numComp);
        initialSquaredError(i,j)=sum(min(sum((oldV(1:2,:)-Y(1:2,:)).^2,1),sum((oldV(1:2,:)+Y(1:2,:)).^2,1)))/npts;
        W=oldV*sqrt(diag(lambda));
        [newX,sigma,V,lambda] = kpcaMissingData(newX,options,W,sigma,kern,I,numComp); % Invokes optimising routine.
        finalSquaredError(i,j)=sum(min(sum((V(1:2,:)-Y(1:2,:)).^2,1),sum((V(1:2,:)+Y(1:2,:)).^2,1)))/npts;
        finalReconError(i,j)=sum(sum((X-newX).^2))/npts;
    end
end

meanInitialReconError = [0;sum(initialReconError,2)/49];
meanInitialSquaredError = [0;sum(initialSquaredError,2)/49];
meanFinalReconError = [0;sum(finalReconError,2)/49];
meanFinalSquaredError = [0;sum(finalSquaredError,2)/49];
initialErrorError = [0;sqrt(sum((initialReconError-meanInitialReconError(2:end)*ones(1,50)).^2,2)/49)];
initialSquaredErrorError = [0;sqrt(sum((initialSquaredError-meanInitialSquaredError(2:end)*ones(1,50)).^2,2)/49)];
finalErrorError = [0;sqrt(sum((finalReconError-meanFinalReconError(2:end)*ones(1,50)).^2,2)/49)];
finalSquaredErrorError = [0;sqrt(sum((finalSquaredError-meanFinalSquaredError(2:end)*ones(1,50)).^2,2)/49)];
figure, lines = errorbar(p, meanInitialReconError, initialErrorError, 'r-')
set(lines, 'linewidth', 2);
hold on
lines = errorbar(p, meanFinalReconError, finalErrorError, 'b:')
set(lines, 'linewidth', 2);
set(gca, 'fontsize', 18)
set(gca, 'fontname', 'helvetica')
figure, lines = errorbar(p, meanInitialSquaredError, initialSquaredErrorError, 'r-')
set(lines, 'linewidth', 2);
hold on
lines = errorbar(p, meanFinalSquaredError, finalSquaredErrorError, 'b:')
set(lines, 'linewidth', 2);
set(gca, 'fontsize', 18)
set(gca, 'fontname', 'helvetica')
save oilErrorResults meanFinalReconError finalErroError meanInitialSquaredError initialSquaredErrorError meanInitialReconError initialErrorError meanFinalSquaredError finalSquaredErrorError
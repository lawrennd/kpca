% DEMTOBAMO demo of PCA with missing data on tobamovirus dataset

% KPCA

p = input('Enter probability of missing data\n');
X=load('data/virus3.txt');% Loads Tobamovirus dataset.

kern=kernel(X,'mlp'); % Produces structure vector of kernel specifics.

npts=size(X,1);
Dim=size(X,2);
options = kpcaOptions;
seed=24;
[newX, I] = kpcaMisser(X,p,seed); % Removes an average of p% data,replacing by mean.
initialReconError=sum(sum((X-newX).^2))/npts;
A=kernCompute(kern, newX); % Computes kernel matrix.
numComp=kpcaNumComp(A, options,Dim);
Y=kpca(kern,X,numComp);
[sigma, oldV, lambda]=ppca(A,numComp);
W=oldV*sqrt(diag(lambda));
initialSquaredError=sum(min(sum((oldV-Y).^2,1),sum((oldV+Y).^2,1)))/npts;


[newX,sigma,V,lambda] = kpcaMissingData(newX,options,W,sigma,kern,I,numComp); % Invokes optimising routine.

finalReconError=sum(sum((X-newX).^2))/npts;
finalSquaredError=sum(min(sum((V-Y).^2,1),sum((V+Y).^2,1)))/npts;
if options.display
    figure, kpcaPlotnum(Y(:,1),Y(:,2),14)
    set(gca, 'fontsize', 18)
    set(gca,'Xlim',[0.14,0.175])
    set(gca,'Ylim',[-0.4,0.45])
    %title('KPCA on the full dataset')
    figure, kpcaPlotnum(oldV(:,1),-oldV(:,2),14)
    set(gca, 'fontsize', 18)
    set(gca,'Xlim',[0.14,0.175])
    set(gca,'Ylim',[-0.4,0.45])
    %title('The initialised missing data problem')
    figure, kpcaPlotnum(V(:,1),V(:,2),14)
    %title('The reconstructed data')
    set(gca, 'fontsize', 18)
    set(gca,'Xlim',[0.14,0.175])
    set(gca,'Ylim',[-0.4,0.45])
end
save resultsTobamo Y oldV V finalReconError finalSquaredError initialReconError initialSquaredError
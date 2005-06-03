% DEMOILFLOW demo of KPCA with missing data on oil flow dataset

% KPCA

p = input('Enter percentage of missing data\n');
X=load('data/DataTrn.txt');
X=X(1:100,:);
Labels=load('data/DataTrnLbls.txt');
Labels=Labels(1:100,:); % loads oil flow dataset and subsamples to 100 datapoints.
kern=kernel(X,'rbf');
kern.inverseWidth = 0.075;
npts=size(X,1);
Dim=size(X,2);
options = kpcaOptions;
options.sensitivity=1e-4;
seed=24;
[newX, I] = kpcaMisser(X,p,seed);
initialReconError=sum(sum((X-newX).^2))/npts;
A=kernCompute(kern, newX);
numComp=kpcaNumComp(A, options,Dim);
[sigma, oldV, lambda]=ppca(A,numComp);
W=oldV*sqrt(diag(lambda));
Y=kpca(kern,X,numComp);

initialSquaredError=sum(min(sum((oldV-Y).^2,1),sum((oldV+Y).^2,1)))/npts;

[newX,sigma,V,lambda] = kpcaMissingData(newX,options,W,sigma,kern,I,numComp); % Invokes optimising routine.

finalReconError=sum(sum((X-newX).^2))/npts;
finalSquaredError=sum(min(sum((V-Y).^2,1),sum((V+Y).^2,1)))/npts;
if options.display
    figure, plot(Y(find(Labels(:,1)),1),Y(find(Labels(:,1)),2),'r+')
    hold on
    plot(Y(find(Labels(:,2)),1),Y(find(Labels(:,2)),2),'bo')
    hold on
    plot(Y(find(Labels(:,3)),1),Y(find(Labels(:,3)),2),'k>')
    set(gca,'Ylim',[-0.3,0.3])
    set(gca, 'fontsize', 18)
    %title('KPCA on the full data')

    figure, plot(oldV(find(Labels(:,1)),1),oldV(find(Labels(:,1)),2),'r+')
    hold on
    plot(oldV(find(Labels(:,2)),1),oldV(find(Labels(:,2)),2),'bo')
    hold on
    plot(oldV(find(Labels(:,3)),1),oldV(find(Labels(:,3)),2),'k>')
    set(gca,'Ylim',[-0.3,0.3])
    set(gca, 'fontsize', 18)
    %title('The initialised missing data problem')
    figure, plot(V(find(Labels(:,1)),1),V(find(Labels(:,1)),2),'r+')
    hold on
    plot(V(find(Labels(:,2)),1),V(find(Labels(:,2)),2),'bo')
    hold on
    plot(V(find(Labels(:,3)),1),V(find(Labels(:,3)),2),'k>')
    %title('The reconstructed data')
    set(gca,'Ylim',[-0.3,0.3])
    set(gca, 'fontsize', 18)
end
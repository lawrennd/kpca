function options=kpcaOptions;

% KPCAOPTIONS sets default options for KPCA missing data problem.

% KPCA

options.maxIter=500;
options.sensitivity=1e-4;
options.display=1; % Set to 1 to display visualisation of reconstruction.
options.captVar=0.95; % Selects the percentage of variance captured 
                     % in the  principal components
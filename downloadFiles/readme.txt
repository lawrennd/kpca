ReadMe file for the KPCA toolbox version 0.1 Monday, Jun 6, 2005 at 14:17:42
Written by Guido Sanguinetti and Neil D. Lawrence.

License Info
------------

This software is free for academic use. Please contact Neil Lawrence if you are interested in using the software for commercial purposes.

This software must not be distributed or modified without prior permission of the author.



File Listing
------------

demOilFlow.m: demo of KPCA with missing data on oil flow dataset
demOilReconError.m: performs  missing data KPCA on oil flow for different percentages of missing data and different seeds.
demTobamo.m: demo of PCA with missing data on tobamovirus dataset
kpca.m: performs kernel PCA
kpcaLikeMissing.m: computes cross entropy between kernel and approximating matrix.
kpcaLikeMissingGrad.m: gradient of the cross entropy w.r.t. missing data.
kpcaMisser.m: randomly deletes a proportion p of entries from the data design matrix
kpcaMissingData.m: solves kpca missing data problem by iteratively minimising cross entropy.
kpcaNumComp.m: computes the number of principal components to be used in a
kpcaOptions.m: sets default options for KPCA missing data problem.
kpcaPlotnum.m: A function to plot points as numbers rather than symbols.

format shortG

% Import raw data from excel file
Xshift = xlsread('SotTCombined2010.xlsx');

% Exclude rows with missing values
rows = any(isnan(Xshift),2);
Xshift(rows,:) = [];
Xshift

% Compute means and variance of each column
colmeans = mean(Xshift,1);
colvars = var(Xshift,1);

% Compute the X matrix from the raw data
X = (Xshift - repmat(colmeans, size(Xshift,1), 1)) ./ repmat(sqrt(colvars), size(Xshift,1), 1);
    
% Perform the SVD of the scaled matrix
[U,S,V] = svd(X);

% Grab the weights for PCA
weights = diag(S).^2;

% Compute the ratio of each component to the total sum of the weights
prop_weights = weights / sum(weights);
% Cumulative sum demonstrates how much of the space is represented by sums
% of 1st, 1st and 2nd, all components 
cumprop_weights = cumsum(prop_weights);

% Compute the reduced matrix from only first two components
reduced = U * S(:,1:2) * V(:,1:2)';
% Compute the residuals
residuals = sum((X_scaled - reduced).^2,2);

% Compute the score matrix
T = U*S;


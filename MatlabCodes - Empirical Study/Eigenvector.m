function [CrispWeights] = Eigenvector(InconsistentMatrix)

[V,D] = eig(InconsistentMatrix);
[~, Index] = max(diag(D));
CrispWeights = V(:,Index);

end
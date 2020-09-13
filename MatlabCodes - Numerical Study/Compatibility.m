function[CompatibilityIndex] = Compatibility(Amatrix, NormalizedCrispWeights)

[n,~] = size(Amatrix);

BMatrix = zeros(n,n);

for i = 1:n
    for j = 1:n
    BMatrix(i,j) = NormalizedCrispWeights(i)./NormalizedCrispWeights(j);       
    end
end

CompatibilityMatrix = Amatrix.*BMatrix';

CompatibilityIndex = sum(sum(CompatibilityMatrix))/n^2;

end

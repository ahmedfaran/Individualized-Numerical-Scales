function[NewScale] = WithOutPolarization(LPCM)

NumericScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
                
NPCM = LPCMtoCrispNPCM(LPCM, NumericScale);
[~, n] = size(NPCM);

Weights = Eigenvector(NPCM);
NormalizedWeights  = Weights/sum(Weights);

Matrix = zeros(n,n);
for i = 1:n
    for j = 1:n
    Matrix(i,j) = NormalizedWeights(i)./NormalizedWeights(j);       
    end
end

Scale = zeros(17,17);
l = 1;
for i = 1:n
    for j = 1:n
    element = LPCM(i,j);
        for k = 1:17
            if element == k
                Scale(k,l) = Matrix(i,j);
                l = l+1;
            end
        end
    end
end

NewScale = zeros(n,1);
for i = 1:17
NewScale(i,1) = mean(nonzeros(Scale(i,:)));
end
NewScale(9,1) = 1;

end


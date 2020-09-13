function[TwoNineMatrix] = Heuristic(NPCM, cut)

[~, n] = size(NPCM);
TwoNineMatrix = ones(n,n);

for i = 1:n
    for j = 1:n
        if NPCM(i,j) > 1 && NPCM(i,j) <=cut
            TwoNineMatrix(i,j) = 2;
        elseif NPCM(i,j) > cut && NPCM(i,j) <=9
            TwoNineMatrix(i,j) = 9;
        end
    end
end

for i = 2:n
    for j = 1:i-1
    TwoNineMatrix(i,j) = 1/TwoNineMatrix(j,i);
    end
end

for i = 1:n
TwoNineMatrix(i,i) = 1;
end

end
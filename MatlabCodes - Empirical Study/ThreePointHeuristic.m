function[ThreePointMatrix] = ThreePointHeuristic(NPCM)

[~, n] = size(NPCM);
ThreePointMatrix = ones(n,n);

for i = 1:n
    for j = 1:n
        if NPCM(i,j) > 1 && NPCM(i,j) <=3
            ThreePointMatrix(i,j) = 2;
        elseif NPCM(i,j) > 3 && NPCM(i,j) <=6
            ThreePointMatrix(i,j) = 3;
        elseif NPCM(i,j) > 6 && NPCM(i,j) <=9
            ThreePointMatrix(i,j) = 4;
        end
    end
end

for i = 2:n
    for j = 1:i-1
    ThreePointMatrix(i,j) = 1/ThreePointMatrix(j,i);
    end
end

for i = 1:n
ThreePointMatrix(i,i) = 1;
end

end
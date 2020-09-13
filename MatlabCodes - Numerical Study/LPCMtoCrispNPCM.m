function[NPCMmatrix] = LPCMtoCrispNPCM(LPCMmatrix, NumericScale)

[m, ~] = size(LPCMmatrix);
NPCMmatrix = zeros(m,m);

for i = 1:m
    for j = 1:m
        for s = 1:17
            if LPCMmatrix(i,j) == s
            NPCMmatrix(i,j) = NumericScale(s);
            end
        end
    end
end

end
function[LPCMmatrix] = NPCMtoLPCM(NPCMmatrix, S)

[m, ~] = size(NPCMmatrix);
LPCMmatrix = zeros(m,m);
                
for i = 1:m
    for j = 1:m
        if NPCMmatrix(i,j) < 2/(S(16)+S(17))
         LPCMmatrix(i,j) = 1;
        elseif NPCMmatrix(i,j) > 2/(S(16)+S(17)) && NPCMmatrix(i,j) <= 2/(S(15)+S(16))
         LPCMmatrix(i,j) = 2;
        elseif NPCMmatrix(i,j) > 2/(S(15)+S(16)) && NPCMmatrix(i,j) <= 2/(S(14)+S(15))
         LPCMmatrix(i,j) = 3;
        elseif NPCMmatrix(i,j) > 2/(S(14)+S(15)) && NPCMmatrix(i,j) <= 2/(S(13)+S(14))
         LPCMmatrix(i,j) = 4;
        elseif NPCMmatrix(i,j) > 2/(S(13)+S(14)) && NPCMmatrix(i,j) <= 2/(S(12)+S(13))
         LPCMmatrix(i,j) = 5;
        elseif NPCMmatrix(i,j) > 2/(S(12)+S(13)) && NPCMmatrix(i,j) <= 2/(S(11)+S(12))
         LPCMmatrix(i,j) = 6;
        elseif NPCMmatrix(i,j) > 2/(S(11)+S(12)) && NPCMmatrix(i,j) <= 2/(S(10)+S(11))
         LPCMmatrix(i,j) = 7;
        elseif NPCMmatrix(i,j) > 2/(S(10)+S(11)) && NPCMmatrix(i,j) <= 2/(S(9)+S(10))
         LPCMmatrix(i,j) = 8; 
        elseif NPCMmatrix(i,j) > 2/(S(9)+S(10)) && NPCMmatrix(i,j) <= (S(9) + S(10))/2
         LPCMmatrix(i,j) = 9;       
        elseif NPCMmatrix(i,j) > (S(9) + S(10))/2 && NPCMmatrix(i,j) <= (S(10) + S(11))/2
         LPCMmatrix(i,j) = 10;
        elseif NPCMmatrix(i,j) > (S(10) + S(11))/2 && NPCMmatrix(i,j) <= (S(11) + S(12))/2
         LPCMmatrix(i,j) = 11;
        elseif NPCMmatrix(i,j) > (S(11) + S(12))/2 && NPCMmatrix(i,j) <= (S(12) + S(13))/2
         LPCMmatrix(i,j) = 12;
        elseif NPCMmatrix(i,j) > (S(12) + S(13))/2 && NPCMmatrix(i,j) <= (S(13) + S(14))/2
         LPCMmatrix(i,j) = 13;
        elseif NPCMmatrix(i,j) > (S(13) + S(14))/2 && NPCMmatrix(i,j) <= (S(14) + S(15))/2
         LPCMmatrix(i,j) = 14;
        elseif NPCMmatrix(i,j) > (S(14) + S(15))/2 && NPCMmatrix(i,j) <= (S(15) + S(16))/2
         LPCMmatrix(i,j) = 15;
        elseif NPCMmatrix(i,j) > (S(15) + S(16))/2 && NPCMmatrix(i,j) <= (S(16) + S(17))/2
         LPCMmatrix(i,j) = 16;
        elseif NPCMmatrix(i,j) > (S(16) + S(17))/2
         LPCMmatrix(i,j) = 17;
         end
    end
end

for i = 1:m      
    LPCMmatrix(i,i) = 9; 
end
end
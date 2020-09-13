clc
OriginalNPCM = zeros(9,9);
Weights =[0.2000 0.1778 0.1556 0.1333 0.1111...
               0.0889 0.0667 0.0444 0.0222];
for i = 1:9
    for j = 1:9
    OriginalNPCM(i,j) = Weights(i)./Weights(j);       
    end
end

C2 = 0;
C3 = 0;
C4 = 0;
C5 = 0;
C6 = 0;
C7 = 0;
C8 = 0;
C9 = 0;

for l = 1:9
    for m = 1:9
    if OriginalNPCM(l,m) <= 2.1 && OriginalNPCM(l,m) > 1
        C2 = C2 + 1;
    elseif OriginalNPCM(l,m) <= 3.1 && OriginalNPCM(l,m) > 2.1
        C3 = C3 + 1;
    elseif OriginalNPCM(l,m) <= 4.1 && OriginalNPCM(l,m) > 3.1
        C4 = C4 + 1;
    elseif OriginalNPCM(l,m) <= 5.1 && OriginalNPCM(l,m) > 4.1
        C5 = C5 + 1;
    elseif OriginalNPCM(l,m) <= 6.1 && OriginalNPCM(l,m) > 5.1
        C6 = C6 + 1;
    elseif OriginalNPCM(l,m) <= 7.1 && OriginalNPCM(l,m) > 6.1
        C7 = C7 + 1;
    elseif OriginalNPCM(l,m) <= 8.1 && OriginalNPCM(l,m) > 7.1
        C8 = C8 + 1;
    elseif OriginalNPCM(l,m) <= 9.1 && OriginalNPCM(l,m) > 8.1
        C9 = C9 + 1;
    end
    end
end

Output = [C2 C3 C4 C5 C6 C7 C8 C9];
function[CorrectedErtMatrix]=IndividualCharacteristic(n, Matrix)

ertMatrix     = cell(17,17);
ertMatrixInfo = zeros();

for i = 1:17
    for j = 1:17
    ertMatrix{i,j} = 'null';
    end
end

u = 1;

for NumberOfMatrices = 1:n

LPCM = Matrix{1,NumberOfMatrices};

for i = length(LPCM)-1:-1:1
    for i1 = i:-1:1
        for i2 = 1:length(LPCM)
               
            ertMatrixInfo(u,1)  = LPCM(length(LPCM)-i, length(LPCM)-i1+1);
            ertMatrixInfo(u,2)  = LPCM(length(LPCM)-i1+1,i2);
            ertMatrixInfo(u,3)  = LPCM(length(LPCM)-i, i2);
        
        u = u+1;
        end
    end
end

LPCMtranspose = LPCM';

for j = length(LPCMtranspose)-1:-1:1
    for i1 = j:-1:1
        for i2 = 1:length(LPCMtranspose)
               
            ertMatrixInfo(u,2)  = LPCMtranspose(length(LPCMtranspose)-j, length(LPCMtranspose)-i1+1);
            ertMatrixInfo(u,1)  = LPCMtranspose(length(LPCMtranspose)-i1+1,i2);
            ertMatrixInfo(u,3)  = LPCMtranspose(length(LPCMtranspose)-j, i2);
        
        u = u+1;
        end
    end
end

for i = length(LPCM)-1:-1:1
    for i1 = i:-1:1
        for i2 = i:-1:1
               
            ertMatrixInfo(u,2)  = LPCM ( length(LPCM)-i   , length(LPCM)-i1+1);
            ertMatrixInfo(u,1)  = LPCM ( length(LPCM)-i2+1  , length(LPCM)-i);
            ertMatrixInfo(u,3)  = LPCM ( length(LPCM)-i2+1  , length(LPCM)-i1+1);
        
        u = u+1;
        end
    end
end

for i = 2:length(LPCM)
    for j = 2:i
            ertMatrixInfo(u,1)  = LPCM ( i    ,  i);
            ertMatrixInfo(u,2)  = LPCM ( j-1  ,  i);
            ertMatrixInfo(u,3)  = LPCM ( j-1  ,  i) ;
        
        u = u+1;
    end
end

for i = 2:length(LPCM)
    for j = 2:i
            ertMatrixInfo(u,2)  = LPCM ( i   ,  i);
            ertMatrixInfo(u,1)  = LPCM ( i ,  j-1);
            ertMatrixInfo(u,3)  = LPCM ( i ,  j-1);        
        u = u+1;
    end
end

end

for q = 1:length(ertMatrixInfo)
    if strcmp(ertMatrix{ertMatrixInfo(q,1),ertMatrixInfo(q,2)}, 'null')
    ertMatrix{ertMatrixInfo(q,1),ertMatrixInfo(q,2)} = ertMatrixInfo(q,3);
    else
    ertMatrix{ertMatrixInfo(q,1),ertMatrixInfo(q,2)} ...
    = [ertMatrix{ertMatrixInfo(q,1),ertMatrixInfo(q,2)} ertMatrixInfo(q,3)];
    end
    
end

CorrectedErtMatrix = cell(17);

for i = 1:17
    for j = 1:17
        if strcmp(ertMatrix{i,j}, 'null')
        CorrectedErtMatrix{i,j} = ertMatrix{i,j};
        else
        CorrectedErtMatrix{i,j} = ertMatrix{i,j}-1;
        end
    end
end

for i = 1:17
    for j = 1:17
        if strcmp(ertMatrix{i,j}, 'null')
            CorrectedErtMatrix{i,j} = 'null';
        else
        elements = CorrectedErtMatrix{i,j};
        size = length(CorrectedErtMatrix{i,j});
            if size > 1
            maximum = max(elements);
            minimum = min(elements);
                if maximum - minimum < 0.1
                CorrectedErtMatrix{i,j} = minimum;  
                else
                CorrectedErtMatrix{i,j} = [minimum maximum];
                end
            end
        end
    end
end

end
function[LPCMmatrix] = ProcessExcelData(RawExcelData)

[n, ~] = size(RawExcelData);

LPCMmatrix = cell(n,1);

for k = 1:n
    cellstorage = zeros(9,9);
    LPCM = RawExcelData(k,:);
    head = 1; toe  = 8; counter = 7; j = 2;
    for i = 1:8    
        cellstorage(i,j:9) = LPCM(head:toe);
        head    = toe + 1;
        toe     = toe + counter;
        counter = counter - 1;
        j = j + 1;
    end

    for i = 1:9
        for j = i:9
            if cellstorage(i,j) < 10 && cellstorage(i,j) > 0
            cellstorage(i,j) = cellstorage(i,j) + 8;
            cellstorage(j,i) = 18 - cellstorage(i,j);
            end
        end
    end

    for i = 1:9
        cellstorage(i,i) = 9;
    end
    LPCMmatrix{k} = cellstorage;
end

end
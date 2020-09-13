function[LPCMmatrix] = ProcessExcelData2(RawExcelData)

[n, ~] = size(RawExcelData);
n = n/9;

LPCMmatrix = cell(n,1);
first = 1;
second = 9;

for k = 1:n
    
Transition = RawExcelData(first:second,:);

    for i = 1:9
        for j = i:9
            if Transition(i,j) < 10 && Transition(i,j) > 0.9
            Transition(i,j) = Transition(i,j) + 8;
            Transition(j,i) = 18 - Transition(i,j);
            elseif Transition(i,j) < 1
            Transition(j,i) = Transition(j,i) + 8;   
            Transition(i,j) = 18 - Transition(j,i);
            end
        end
    end

    for i = 1:9
        Transition(i,i) = 9;
    end
    
    LPCMmatrix{k,1} = Transition;
    
first = first + 9;
second = second + 9;

end

end
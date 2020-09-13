function[ertEstimated] = EstimatedErts(S)
 
ertNumeric = zeros(17,17);

for i = 1:17
    for j = 1:17
    
    ertNumeric(i,j) = S(i)*S(j);
        
    end
end

ertEstimated = cell(17,17);

for i = 1:17
    for j = 1:17
         x = ertNumeric(i,j);
         ertNumeric(i,j) = fix(x*1e3)/1e3;
            
        if ertNumeric(i,j) < S(1)  || ertNumeric(i,j) > S(17);
        ertEstimated{i,j} = 'null';
        
        elseif ertNumeric(i,j) >= 1
               
        for iter = 9:16
            if ertNumeric(i,j) >= S(iter) && ertNumeric(i,j)<= S(iter+1)
            first = S(iter);
            fiplusone = S(iter +1);
            end
        end
   
        condition1 = first;
        condition2 = (first + fiplusone)/2;
        condition3 = fiplusone;
    
            if ertNumeric(i,j) >= condition1 && ertNumeric(i,j) <= condition2
                   ertEstimated{i,j} = find(S == first,1) - 1;                      
            elseif ertNumeric(i,j) >= condition2 && ertNumeric(i,j) <= condition3
                   ertEstimated{i,j} = find(S == fiplusone,1) - 1;        
            end
                              
        elseif ertNumeric(i,j) < 1
           
            y = 1/ertNumeric(i,j);
            
            for iter = 9:16
                if y >= S(iter) && y <= S(iter+1)
                first = S(iter);
                fiplusone = S(iter +1);
                end
            end

            condition1 = first;
            condition2 = (first + fiplusone)/2;
            condition3 = fiplusone;

            if y >= condition1 && y <= condition2
                     ertEstimated{i,j} = 18 - find(S == first,1)-1 ;                      
            elseif y >= condition2 && y <= condition3
                       ertEstimated{i,j} = 18 - find(S == fiplusone,1)-1 ;        
            end
                
        end        
    end
end

end

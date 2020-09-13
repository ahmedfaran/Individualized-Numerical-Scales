function[PersonalizedScale] = IndividualizeScale(LPCM)
    
Matrix = {LPCM};
n = length(Matrix);   

% Individual Characteristic Matrix provided by Decision Maker
DMErtMatrix  = IndividualCharacteristic(n, Matrix);

% Upper and Lower Bounds for Scale Individualization
fScaleLimits = [1.00  1.00;
                1.13  2.00; 
                1.29  3.00;   
                1.50  4.00;  
                1.80  5.00; 
                2.25  6.00;
                3.00  8.00; 
                4.50  11.31; 
                9.00  16.00];

%Initialize Parameters
f = zeros(1,9);
NewScale = ones(1,8);
DeviationMatrix = zeros();
dIndex = 1; 
Storage = cell(1,9);

 for i  = 1:9
 f(1,i) = fScaleLimits(i,1); 
 end
 
% Calculate Deviation
for i = 2:length(f)
    
    x = f(1,i-1);
    y = fScaleLimits(i,2);
    
    a = min( x, y ) + 0.2;
    c = fScaleLimits(i,2);
    
    while a <= c + 0.01
    
    f(1,i) = a;
    SL     = f(1,2:9);
    SU     = fliplr(1./SL);
    S      = [SU 1 SL];
    
    ertEstimated = EstimatedErts(S);
    DeviationValue = 0;
    
    for m = 1:17
        for n = 1:17
        
        DM = DMErtMatrix{m, n};
        ES = ertEstimated{m, n};
        SizeDM = length(DM);
        SizeES = length(ES);        
        
            if SizeDM == 4
                deviation = 0;
            elseif SizeDM <= 2 && SizeES == 4
                deviation = 16;
            elseif SizeDM == 1
                deviation = abs(DM-ES);
            elseif SizeDM == 2
                minimum = DM(1);
                maximum = DM(2);
                if ES <= minimum
                    deviation = abs(ES-minimum);
                elseif ES >= maximum
                    deviation = abs(ES-maximum);
                elseif ES >= minimum && ES <= maximum 
                    deviation = 0;
                end
            end
            DeviationValue = deviation + DeviationValue;
        end  
    end
    
    DeviationMatrix(1, dIndex) = DeviationValue;
    DeviationMatrix(2, dIndex) = a;
    dIndex = dIndex + 1;
    
    a = a + 0.2;
    end
    
    [~, index] =  min(DeviationMatrix(1,:));
    
    NewScale(1,i) = DeviationMatrix(2, index);
    f(1,i) = NewScale(1,i);
    dIndex = 1;
    
    Storage{i} = DeviationMatrix;
    DeviationMatrix = zeros(); 
end

InverseNewScale = fliplr(NewScale(2:9));
InverseNewScale = 1./InverseNewScale;
PersonalizedScale = [InverseNewScale NewScale];

end
function[FinalDataSet] = GenerateDataSet(Parameters)

% Experimental Conditions
MatrixSizes = Parameters.MatrixSizes; 
BetaParameters = Parameters.BetaParameters;
iter = Parameters.iter;

% Preallocations
NumberOfMatrices = iter*length(MatrixSizes)*length(BetaParameters);
% = iter * n * alpha * beta

CR                  = cell(NumberOfMatrices,1);
NPCMDataSet         = cell(NumberOfMatrices,1);
TrueWeights         = cell(NumberOfMatrices,1);
z = 1;

for n = MatrixSizes
    for iterations = 1:iter        
    % Generate Perfectly Consistent Crisp Matrix
    [CompMatrix, Weights] = GenerateConsistentMatrix(n);
        % Add Inconsistency in a Comparison Matrix     
        for beta = BetaParameters    
        NPCM =  AddInconsistency(n, beta, CompMatrix);            
          %Calculate inconsistency of crisp NPCM
          CR{z,1} = CalculateConsistency(NPCM);
          
          if CR{z,1} <0.00001
          CR{z,1} = 0;
          end
          
          NPCMDataSet{z,1} = NPCM;
          TrueWeights{z,1} = Weights;
          z = z + 1;             
        end
    end
end

CompleteData = OrganizeData(Parameters, CR, NPCMDataSet, TrueWeights);

FinalDataSet = CleanData(CompleteData);

end
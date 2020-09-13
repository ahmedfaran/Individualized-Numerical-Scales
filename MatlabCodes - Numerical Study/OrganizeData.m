function [CompleteData] = OrganizeData(Parameters, CR, NPCMDataSet, TrueWeightsData)

MatrixSizes = Parameters.MatrixSizes; 
BetaParameters = Parameters.BetaParameters;
iter = Parameters.iter;
   
k = 1;
EC = 1;

for n = MatrixSizes
    for iterations = 1:iter
        for beta = BetaParameters   
               if CR{EC} <= 0.1
               ConsRat     = CR{EC}; 
               NPCM        = NPCMDataSet{EC};
               TrueWeights = TrueWeightsData{EC};
               
               CompleteData{k,1} = n;
               CompleteData{k,2} = beta;
               CompleteData{k,3} = ConsRat;
                    
               if ConsRat >= 0 && ConsRat <= 0.03
               CompleteData{k,4} = 1;
               elseif ConsRat > 0.03 && ConsRat <= 0.06
               CompleteData{k,4} = 2;
               elseif ConsRat > 0.06 && ConsRat <= 0.1
               CompleteData{k,4} = 3;
               end
                   
               CompleteData{k,5} = NPCM;
               CompleteData{k,6} = TrueWeights;
               k = k + 1;
               
               end   
               EC = EC + 1;
        end
    end
end

end
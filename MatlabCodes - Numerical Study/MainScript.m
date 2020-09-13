clc

rng('default');
rng(1);

% Define Experimental Conditions to Generate Numerical DataSet
MatrixSizes = [3 7 11 15];
BetaParameters = [0 0.2 0.4 0.6 0.8 1.00];
iter = 200;

% Parameterize the Experimental Conditions
Parameters.MatrixSizes = MatrixSizes;
Parameters.BetaParameters = BetaParameters;
Parameters.iter = iter;

FinalDataSet = GenerateDataSet(Parameters);

[m, ~] = size(FinalDataSet);
CompatibilityIndex = cell(m,1);

SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
cut = 6;
ExcelFile = cell(m,15);
                
for i = 1:m

NPCM        = FinalDataSet{i,5};
LPCM        = NPCMtoLPCM(NPCM, SaatyScale);
TrueWeights = FinalDataSet{i,6};

[K, ~] = size(NPCM);
TrueWeightMatrix = zeros(K,K);
for p = 1:K
    for q = 1:K
    TrueWeightMatrix(p,q) = TrueWeights(p)./TrueWeights(q);       
    end
end

% Based on Heurisitc Proposed by Kemal Hoca 
[KilicScale, ~] = KilicHeuristicScale(LPCM, cut);
KilicHeuristicNPCM = LPCMtoCrispNPCM(LPCM,KilicScale);

% Based on Saaty Scale of 1 - 9
OriginalNPCM = LPCMtoCrispNPCM(LPCM,SaatyScale);

% Based on LP Model Scale
LPModelScale = IndividualizeScale(LPCM);
LPModelNPCM = LPCMtoCrispNPCM(LPCM, LPModelScale);

% Based on Without Polarization   
[NonPolarizedScale] = WithOutPolarization(LPCM);
NonPolarizedNPCM = LPCMtoCrispNPCM(LPCM,NonPolarizedScale);

ExcelFile{i,1}          = CalculateConsistency(KilicHeuristicNPCM);
CrispWeights            = Eigenvector(KilicHeuristicNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,2}          = Compatibility(KilicHeuristicNPCM, NormalizedCrispWeights);
ExcelFile{i,3}          = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,5}          = CalculateConsistency(NonPolarizedNPCM);
CrispWeights            = Eigenvector(NonPolarizedNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,6}          = Compatibility(NonPolarizedNPCM, NormalizedCrispWeights);
ExcelFile{i,7}          = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,9}          = CalculateConsistency(OriginalNPCM);
CrispWeights            = Eigenvector(OriginalNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,10}         = Compatibility(OriginalNPCM, NormalizedCrispWeights);
ExcelFile{i,11}         = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,13}         = CalculateConsistency(LPModelNPCM);
CrispWeights            = Eigenvector(LPModelNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,14}         = Compatibility(LPModelNPCM, NormalizedCrispWeights);
ExcelFile{i,15}         = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

i

end
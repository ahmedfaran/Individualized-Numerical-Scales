clc
clear all

% RawExcelData = xlsread('Group1.xlsx','Visual');
% RawExcelData = xlsread('Group1.xlsx','Weight');
% RawExcelData = xlsread('Group2.xlsx','Visual');
% RawExcelData = xlsread('Group2.xlsx','Weight');
%Generate LPCM Matrices from Empirical Data from Group 1 and 2
% LPCMmatrixData = ProcessExcelData(RawExcelData);

% RawExcelData = xlsread('Group3.xlsx','Visual');
RawExcelData = xlsread('Group4.xlsx','Weight');
%Generate LPCM Matrices from Empirical Data from Group 3 and 4
LPCMmatrixData = ProcessExcelData2(RawExcelData);

SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
                
TrueWeights = [0.2000 0.1778 0.1556 0.1333 0.1111...
               0.0889 0.0667 0.0444 0.0222];          

TrueWeightMatrix = zeros(9,9);
for i = 1:9
    for j = 1:9
    TrueWeightMatrix(i,j) = TrueWeights(i)./TrueWeights(j);       
    end
end

[n, ~] = size(LPCMmatrixData);
cut = 6;

% Preallocatiions
ExcelFile = cell(n,15);

for i = 1:n
LPCM = LPCMmatrixData{i,1};

% Based on Heurisitc Proposed by Kemal Hoca 
[KilicScale, ~] = KilicHeuristicScale(LPCM, cut);
KilicHeuristicNPCM = LPCMtoCrispNPCM(LPCM,KilicScale);

% Based on Saaty Scale of 1 - 9
OriginalNPCM = LPCMtoCrispNPCM(LPCM,SaatyScale);

% Based on LP Model Scale
LPModelScale = IndividualizeScale(LPCM);
LPModelNPCM = LPCMtoCrispNPCM(LPCM, LPModelScale);

% Based on Heurisitc Proposed by Faran  
[FaranScale, ~] = FaranHeuristicScale(LPCM);
FaranHeuristicNPCM = LPCMtoCrispNPCM(LPCM,FaranScale);

% Based on Without Polarization   
[NonPolarizedScale] = WithOutPolarization(LPCM);
NonPolarizedNPCM = LPCMtoCrispNPCM(LPCM,NonPolarizedScale);

ExcelFile{i,1} = CalculateConsistency(KilicHeuristicNPCM);
CrispWeights = Eigenvector(KilicHeuristicNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,2} = Compatibility(KilicHeuristicNPCM, NormalizedCrispWeights);
ExcelFile{i,3} = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,5} = CalculateConsistency(NonPolarizedNPCM);
CrispWeights = Eigenvector(NonPolarizedNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,6} = Compatibility(NonPolarizedNPCM, NormalizedCrispWeights);
ExcelFile{i,7} = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,9} = CalculateConsistency(OriginalNPCM);
CrispWeights = Eigenvector(OriginalNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,10} = Compatibility(OriginalNPCM, NormalizedCrispWeights);
ExcelFile{i,11} = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

ExcelFile{i,13} = CalculateConsistency(LPModelNPCM);
CrispWeights = Eigenvector(LPModelNPCM);
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,14} = Compatibility(LPModelNPCM, NormalizedCrispWeights);
ExcelFile{i,15} = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

end
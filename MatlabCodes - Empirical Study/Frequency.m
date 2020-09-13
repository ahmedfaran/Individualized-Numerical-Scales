clc
clear all

% RawExcelData = xlsread('Group2.xlsx','Weight');
% RawExcelData = xlsread('Group3.xlsx','Visual');
RawExcelData = xlsread('Group4.xlsx','Weight');

%Generate LPCM Matrices from Empirical Data from Group 1 and 2
% LPCMmatrixData = ProcessExcelData(RawExcelData);
%Generate LPCM Matrices from Empirical Data from Group 3 and 4
LPCMmatrixData = ProcessExcelData2(RawExcelData);

SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
                
[n, ~] = size(LPCMmatrixData);
OriginalNPCM = cell(n,1);
C2 = 0;
C3 = 0;
C4 = 0;
C5 = 0;
C6 = 0;
C7 = 0;
C8 = 0;
C9 = 0;

for i = 1:n
LPCM = LPCMmatrixData{i,1};
OriginalNPCM = LPCMtoCrispNPCM(LPCM,SaatyScale);

for l = 1:9
    for m = 1:9
    if OriginalNPCM(l,m) == 2
        C2 = C2 + 1;
    elseif OriginalNPCM(l,m) == 3
        C3 = C3 + 1;
    elseif OriginalNPCM(l,m) == 4
        C4 = C4 + 1;
    elseif OriginalNPCM(l,m) == 5
        C5 = C5 + 1;
    elseif OriginalNPCM(l,m) == 6
        C6 = C6 + 1;
    elseif OriginalNPCM(l,m) == 7
        C7 = C7 + 1;
    elseif OriginalNPCM(l,m) == 8
        C8 = C8 + 1;
    elseif OriginalNPCM(l,m) == 9
        C9 = C9 + 1;
    end
    end
end
end

Output = [C2 C3 C4 C5 C6 C7 C8 C9];

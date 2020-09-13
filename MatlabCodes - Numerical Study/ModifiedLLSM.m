function[FuzzyWeights] = ModifiedLLSM(FuzzyMatrix)

[n, ~] = size(FuzzyMatrix);
FuzzyWeights    = cell(1,n);
X =  rand(1,n*3);

[A, b, Aeq, beq] = Constraints(FuzzyMatrix);

Weights = fmincon(@(X)objFunc(X,FuzzyMatrix),X ,A, b, Aeq, beq);

WeightMatrix = vec2mat(Weights,3);

for i = 1:n
    
FuzzyWeights{1,i} = sort(WeightMatrix(i,:));
end

end

function[OBF] = objFunc(X, FuzzyMatrix) 
        
XM = vec2mat(X,3);

[~, n] = size(FuzzyMatrix);

OBF = 0;
for i = 1:n
   for j = 1:n
   
   A = cell2mat(FuzzyMatrix(i,j));
   if i~=j
    B = (log(XM(i,1)) - log(XM(j,3)) - log(A(1)))^2;
    C = (log(XM(i,2)) - log(XM(j,2)) - log(A(2)))^2;
    D = (log(XM(i,3)) - log(XM(j,1)) - log(A(3)))^2;
   Objective = B + C + D ;
   OBF = OBF + Objective;
   end
   end
end

end

function[A, b, Aeq, beq] = Constraints(FuzzyMatrix)

[~, n] = size(FuzzyMatrix);

% For First Set of Inequality Constraints
Amatrix1 = zeros(n, n*3); 
k = 1;
c = 3;
for i = 1:n
     for j = 1:n*3     
         Amatrix1(i, k) = -1;
         if j == c
         Amatrix1(1:n, j) = -1;
         Amatrix1(i, j) = 0;
         end
     end
     k = k + 3;
     c = c + 3;   
end
b1 = -ones(n,1);

% For Second Set of Inequality Constraints
Amatrix2 = ones(n, n*3); 
k = 1;
c = 3;
d = 2;
for i = 1:n
     for j = 1:n*3     
         Amatrix2(i, k) = 0;
         if j == c
         Amatrix2(1:n, j) = 0;
         Amatrix2(i, j) = 1;
         end
         if j == d
         Amatrix2(1:n, j) = 0;
         end
     end
     k = k + 3;
     c = c + 3;
     d = d + 3;
end
b2 = ones(n,1);

% Connstraints related to fuzzy rules i.e., l<m<u
Amatrix3 = zeros(n*3, n*3);
e = 1;
for i = 1:n
Amatrix3(e:e+2,e:e+2) = [0 1 -1;1 -1 0;-1 0 0];
e = e + 3;
end
b3 = -1e-3 * ones(n*3, 1);

%Complete A Matrix and b Vector for Ax < b
A = vertcat(Amatrix1, Amatrix2, Amatrix3);
b = vertcat(b1, b2, b3);

%Equality constraints
Aeq1 = zeros(1, n*3);
t = 1;
for i = 1:n
Aeq1(1,t:t+2) = [0 1 0];
t = t+3;
end
beq1 = 1;

Aeq2 = zeros(1, n*3);
t = 1;
for i = 1:n
Aeq2(1,t:t+2) = [1 0 1];
t = t+3;
end
beq2 = 2;

%Complete Aeq Matrix a beq vector for Aeq.X = b
Aeq = vertcat(Aeq1, Aeq2);
beq = vertcat(beq1, beq2);

end


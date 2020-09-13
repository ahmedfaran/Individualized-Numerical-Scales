clc

INSbar = cell(1,5);

TwoTupple = [3 -0.4];
scale = TwoTupple(1);
alpha = TwoTupple(2);

S = [0 1 2 3 4];

INSbar{1} = [0.00 0.25];
INSbar{2} = [0.20 0.25];
INSbar{3} = [0.50 0.50];
INSbar{4} = [0.75 0.80];
INSbar{5} = [0.751 1.0];

INSbarElementi         = INSbar{scale + 1};
INSbarElementiplusone  = INSbar{scale + 2};
INSbarElementiminusone = INSbar{scale};

if alpha >= 0
AL = INSbarElementi(1) + alpha*(INSbarElementiplusone(1) - INSbarElementi(1));
AR = INSbarElementi(2) + alpha*(INSbarElementiplusone(2) - INSbarElementi(2));
end

if alpha < 0
AL = INSbarElementi(1) + alpha*(INSbarElementi(1) - INSbarElementiminusone(1));
AR = INSbarElementi(2) + alpha*(INSbarElementi(2) - INSbarElementiminusone(2));
end


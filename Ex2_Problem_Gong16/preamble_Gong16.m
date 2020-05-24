function [ x1, x2, x3, u, t, ...
    x10, x20, x30, x1f, x2f, x3f ] = preamble_Gong16( primal )
%---------------------------------
% Preamble for the problem discussed in Gong et al, JOTA 2016:
%   Gong, Q., Ross, I. M. and Fahroo, F., "Spectral and Pseudospectral
%   Optimal Control Over Arbitrary Grids," Journal of Optimization Theory
%   and Applications, Vol 169, No 3, 2016, pp 759-783.
% See Section 8
%====================================

x1  = primal.states(1,:);
x2  = primal.states(2,:);
x3  = primal.states(3,:);

u   = primal.controls; 

t   = primal.time;

x10 = primal.initial.states(1);
x20 = primal.initial.states(2);
x30 = primal.initial.states(3);

x1f = primal.final.states(1);
x2f = primal.final.states(2);
x3f = primal.final.states(3);

end


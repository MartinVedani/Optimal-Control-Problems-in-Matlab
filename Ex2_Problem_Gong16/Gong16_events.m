function [ efun ] = Gong16_events( primal )
%-------------------------------------------
% Events for the problem discussed in Gong et al, JOTA 2016:
%   Gong, Q., Ross, I. M. and Fahroo, F., "Spectral and Pseudospectral
%   Optimal Control Over Arbitrary Grids," Journal of Optimization Theory
%   and Applications, Vol 169, No 3, 2016, pp 759-783.
% See Section 8
%===========================================

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------


[ x1, x2, x3, u, t, ...
    x10, x20, x30, x1f, x2f, x3f ] = preamble_Gong16( primal );

% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.

% preallocate for good MATLAB computing

efun = zeros(3,1);

% efun:

efun(1) = x10;
efun(2) = x20;
efun(3) = x30;

end


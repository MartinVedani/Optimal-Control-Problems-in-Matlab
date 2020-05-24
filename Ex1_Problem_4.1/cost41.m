function [E, F] = cost41(primal)
% Cost function for Problem 4.1 from Ross' book, "A Primer on Pontryagin's
% Principle in Optimal Control."  
% Page 248
%
% The complete problem description is also discussed in The DIDO Tutorial.

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ x, u, t, ...
            x0, xf, t0, tf ] = preamble41(primal);
        
% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.

E = xf^2/2;                 % Endpoint cost
F = u.^2/2;                 % Running cost

% eof




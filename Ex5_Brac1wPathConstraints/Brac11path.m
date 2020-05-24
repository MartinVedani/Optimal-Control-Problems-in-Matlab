function h = Brac11path(primal)
% Path function file file for "Brac1" with a path constraint.
%   References:  
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 137-138 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%=======================================

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ x, y, v, theta, t, ...                        % state, controls and time
            x0, y0, v0, t0, xf, yf, vf, tf, ... % endpoints  
            g ] ...                             % constants
            = Brac11Preamble(primal);
        
% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.
		

%=======================================================
% path constraint function:
%=======================================================
h = y - x;  
%---------
% If you have more than one path constraint, simply code your path file as 
% follows:
%   h(1,:) = your first path constraint
%   h(2,:) = your second path constraint
%   h(3,:) = etc
% up to the number of path constraints you have.
%=========

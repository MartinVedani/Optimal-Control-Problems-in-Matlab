function h = LanderPath(primal)
%====================================%        
% Path file for the Moon Landing Problem
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Ross, I.M., "A Primer on Pontryagin's Principle in Optimal 
%           Control," Second Edition, Collegiate Publishers, San Francisco,
%           CA, 2015, Chapter 4, Section 8, pp. 290-292.
%====================================%

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ h, v, m, T, t, ...                             % states, controls & time
            h0, v0, m0, t0, hf, vf, mf, tf, ...  % endpoints   
            g, ve ] ...                          % constants
            = LanderPreamble(primal);


% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.

%======================================================================
% Path constraint is control constraint.  IT IS BINDING!
%======================================================================
h = T;
%=======================================================================
% If you have more constraints, they must be coded as,
% h(1,:) = ...;
% h(2,:) = ...; etc.
% For faster run time, don't forget to preallocate!
%===============================================
% all done! 
function [EndpointCost, RunningCost] = Brac1Cost(primal)
% Cost file for Problem Brac:1
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 88 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%====================================

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ x, y, v, theta, t, ...                        % state, controls and time
            x0, y0, v0, t0, xf, yf, vf, tf, ... % endpoints  
            g ] ...                             % constants
            = Brac1Preamble(primal);
        
% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.


EndpointCost    = tf;
RunningCost     = 0;

% That's it! Now, wasn't that easy? Hmm? Hmmm??
% Remember to fill the first output first!
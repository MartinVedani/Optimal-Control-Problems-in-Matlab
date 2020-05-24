function endpointFunction = Brac1Events(primal)
% Events file for Problem Brac:1
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

%% preallocate the endpointFunction evaluation for good MATLAB computing

endpointFunction = zeros(5,1);      % t0 is specified in the problem file

%=========================
endpointFunction(1) = x0;
endpointFunction(2) = y0;
endpointFunction(3) = v0;

%------------------------
endpointFunction(4) = xf;
endpointFunction(5) = yf; 
%------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% To better understand the differences between a function, an equation and
% constraints specified by functions, see Section 1.3, page 37 of Ross.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%
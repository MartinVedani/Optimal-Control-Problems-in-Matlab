function endpointFunction = BadBrac1Events(primal)
% Endpoint file for the Bad Brachistochrone Problem Brac:1
%   References: 
%       1. DIDO Best Practices
%       2. Study Problem 1.5 from Ross, page 23:
%          I. M. Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%====================================

%-------------------------------%
% Call the preamble file first: %
%-------------------------------%

[xBar, yBar, vBar, thetaBar, tBar,...
    x0Bar, y0Bar, v0Bar, t0Bar, xfBar, yfBar, vfBar, tfBar, ...
    UNITS, SCALES, ...
    x, y, v, theta, t, x0, y0, v0, t0, xf, yf, vf, tf, g] = ...
    BadBrac1Preamble(primal);

% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.

% preallocate the endpointFunction evaluation for good MATLAB computing

endpointFunction = zeros(5,1); % t0 is specified in the main file

%===========================
endpointFunction(1) = x0Bar;
endpointFunction(2) = y0Bar;
endpointFunction(3) = v0Bar;

%---------------------------
endpointFunction(4) = xfBar;
endpointFunction(5) = yfBar;  
%---------------------------

% eof
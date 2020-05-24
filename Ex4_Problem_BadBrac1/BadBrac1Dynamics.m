function dxdtBar = BadBrac1Dynamics(primal)
% Dynamics file for the Bad Brachistochrone Problem Brac:1
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

%============================
% Scaled Equations of Motion:
%============================
xdotBar = SCALES.xdot*vBar.*sin(theta);
ydotBar = SCALES.ydot*vBar.*cos(theta);							 
vdotBar = SCALES.vdot*g*cos(theta);
%----------------------------
dxdtBar = [ xdotBar; 
            ydotBar; 
            vdotBar];
%============================
% eof
%====
function [UNITS,SCALES] = BadBrac1Constants
% Units and Scales file for the Bad Brachistochrone Problem Brac:1
%   References: 
%       1. DIDO Best Practices
%       2. Section 1.1.4 from Ross, page 20:
%          I. M. Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%       3. See also Study Problem 1.4, page 23 of Ross
%====================================%

%=======%
% UNITS %
%=======%
% The following units are Designer Units.  See page 23 of Ross
%--------------------------------------------------------------------------
UNITS.x = 100;      % x unit is based on xFinal = 1000 meters
UNITS.y = 20;       % y unit is based on DIDO runs for good values of xFinal
UNITS.v = 10;       % ditto
UNITS.theta = 1;    % theta is not scaled
UNITS.t = 10;       % time unit is 10 secs
%-------------------------------------------------------------------------%
% %--------------------------------------------%
% % Good data for testing:
% xFinal = 10;        % See Brac 1 Problem File
% yFinal = 10;
% UNITS.x = 1;      
% UNITS.y = 1;       
% UNITS.v = sqrt(9.81);       
% UNITS.theta = 1;
% UNITS.t = sqrt(1/9.81);
% %--------------------------------------------%

%========%
% SCALES %
%========%

SCALES.xdot = UNITS.t*UNITS.v/UNITS.x;
SCALES.ydot = UNITS.t*UNITS.v/UNITS.y;
SCALES.vdot = UNITS.t/UNITS.v;
%------------------------------------------
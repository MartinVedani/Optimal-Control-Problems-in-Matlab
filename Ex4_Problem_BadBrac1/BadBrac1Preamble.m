function [xBar, yBar, vBar, thetaBar, tBar,...
    x0Bar, y0Bar, v0Bar, t0Bar, xfBar, yfBar, vfBar, tfBar, ...
    UNITS, SCALES, ...
    x, y, v, theta, t, x0, y0, v0, t0, xf, yf, vf, tf, g] = ...
    BadBrac1Preamble(primal)
% Preamble file for the Bad Brachistochrone Problem Brac:1
%   References: 
%       1. DIDO Best Practices
%       2. Study Problem 1.5 from Ross, page 23:
%          I. M. Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%====================================%

%=========================================%
% Scaled variables are "barred" variables %
%=========================================%

xBar = primal.states(1,:);	    
yBar = primal.states(2,:);		
vBar = primal.states(3,:);		

thetaBar  = primal.controls;

tBar = primal.time;

x0Bar = primal.initial.states(1);
y0Bar = primal.initial.states(2);
v0Bar = primal.initial.states(3);

t0Bar = primal.initial.time;

xfBar = primal.final.states(1);
yfBar = primal.final.states(2);
vfBar = primal.final.states(3);

tfBar = primal.final.time;

%===========================%
% Designer Units and Scales %
%===========================%

UNITS   = primal.constants.UNITS;
SCALES  = primal.constants.SCALES;

%=========================%
% The Unscaled Variables: %
%=========================%

x = xBar*UNITS.x;         
y = yBar*UNITS.y;
v = vBar*UNITS.v;

theta = thetaBar*UNITS.theta;    

t = tBar*UNITS.t;

x0 = x0Bar*UNITS.x;
y0 = y0Bar*UNITS.y;
v0 = v0Bar*UNITS.y;

t0 = t0Bar*UNITS.t;

xf = xfBar*UNITS.x;
yf = yfBar*UNITS.y;
vf = vfBar*UNITS.v;

tf = tfBar*UNITS.t;

%======
% NOTE:
%==========================================================%
% All quantities above are optimization variables.
%
% This file is called repeatedly.
% 
% DO NOT put in this file quantites that need to be computed
% only once.
%
% Only include constants that require NO COMPUTATION.
%==========================================================%

%==================================%
% DATA THAT REQUIRE NO COMPUTATION %
%==================================%

%------------------%
% Problem Constants
%------------------%
g = 9.81;          % Earth g in m/s^2
%------------------%

% eof
function [ h, v, m, T, t, ...
            h0, v0, m0, t0, hf, vf, mf, tf, ...
            g, ve ] ...
            = LanderPreamble(primal)
%======================================        
% Preamble for the Moon Landing Problem
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Ross, I.M., "A Primer on Pontryagin's Principle in Optimal 
%           Control," Second Edition, Collegiate Publishers, San Francisco,
%           CA, 2015, Chapter 4, Section 8, pp. 290-292.
%====================================

h = primal.states(1,:);                 %   States
v = primal.states(2,:);
m = primal.states(3,:);

T = primal.controls;                    %   Controls

t = primal.time;                        %   time

h0 = primal.initial.states(1);          %   initial states
v0 = primal.initial.states(2);
m0 = primal.initial.states(3);

t0 = primal.initial.time;               %   initial time

hf = primal.final.states(1);            %   final states
vf = primal.final.states(2);
mf = primal.final.states(3);

tf = primal.final.time;                 %   final time

g  = primal.constants.g;                %   constants (data)
ve = primal.constants.ve;

% eof
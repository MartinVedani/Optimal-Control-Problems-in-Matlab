function [ x, y, v, theta, t, ...
            x0, y0, v0, t0, xf, yf, vf, tf, ...
            g ] ...
            = Brac1Preamble(primal)
%===================================        
% Preamble for Problem Brac:1
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 88 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%====================================

x = primal.states(1,:);                 %   States
y = primal.states(2,:);
v = primal.states(3,:);

theta = primal.controls;                %   Controls

t = primal.time;                        %   time

x0 = primal.initial.states(1);          %   initial states
y0 = primal.initial.states(2);
v0 = primal.initial.states(3);

t0 = primal.initial.time;               %   initial time

xf = primal.final.states(1);            %   final states
yf = primal.final.states(2);
vf = primal.final.states(3);

tf = primal.final.time;                 %   final time

g = primal.constants.g;                 %   constants (data)

% eof
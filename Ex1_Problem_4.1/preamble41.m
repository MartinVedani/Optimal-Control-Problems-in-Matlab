function [ x, u, t, ...
            x0, xf, t0, tf ] = preamble41(primal)
% Preamble for Problem 4.1
% See Page 248, Section 4.1.1 in Ross: A Primer On Pontryagin's Principle
% in Optimal Control, Second Edition
%====================================
%
% The complete problem description is also discussed in The DIDO Tutorial.

x = primal.states;
u = primal.controls;
t = primal.time;

x0 = primal.initial.states;
xf = primal.final.states;

t0 = primal.initial.time;
tf = primal.final.time;

% End of file
%============

function Bellman5Preamble(primal)
% Preamble file for Problem Bellman5

%     NO EJECUTAR, ESTE ES UNA FUNCION DE SOPORTE NADA MAS


%--------------%
% Reference:
%     1. Problem Set 3, Final Metodos Numericos I, Julio 2016, 
%        Prof. German Fermo, Univ Totcuato Ditella.
%     2. Elements of Dynamic Optimization - Chiang (1999) page 54
%     3. Ross, I. M., A Primer on Pontryagin's Principle in Optinal
%        Control, Second Edition, Collegiate Publishers, San Francisco,
%        2015.
%     4. DIDO Matlab Toolbox, Flight Tested by NASA.
%        http://www.elissarglobal.com/industry/products/software-3/
%====================================

%%%%%%%%%%%%
% CAUTION: %
%%%%%%%%%%%%
% The use of a preamble file makes it easy to code and debug your problem;
%
% *** HOWEVER,*** 
%
% the preamble style used here of saving variables and loading it in other
% DIDO files slows down your computation significantly. This is a
% MATLAB problem, not a DIDO issue. If you want your DIDO code to run
% faster, DO NOT USE save and load commands.  See the preamble method in:
%
%           BadBrac1Preamble 
%
% for the fastest option.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inflacionEsp = primal.states(1,:);

y = primal.controls(1,:);

t = primal.time;

inflacionEsp0 = primal.initial.states(1);

t0 = primal.initial.time;

inflacionEspF = primal.final.states(1);

tf = primal.final.time;

plenoEmp = primal.constants.plenoEmp;
theta = primal.constants.theta;
a = primal.constants.a;
g = primal.constants.g;

save -v6 Bellman5Primal
% NOTE: The default save operation in MATLAB is very slow.
% Use save -v6 for a faster run time.

% eof
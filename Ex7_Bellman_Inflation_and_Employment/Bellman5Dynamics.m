function dinflacionEspdt = Bellman5Dynamics(primal)
% Dynamics file for Problem Bellman5

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
%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

Bellman5Preamble(primal);
load Bellman5Primal


%=====================
% Equations of Motion:
%=====================
inflacionDot = inflacionEsp + (g .* (-theta .* (plenoEmp - y)));
%---------------------
dinflacionEspdt = [inflacionDot];
%=====================
% eof
%====
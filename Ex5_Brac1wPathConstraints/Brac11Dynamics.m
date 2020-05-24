function dxdt = Brac11Dynamics(primal)
% Dynamics file file for "Brac1" with a path constraint.
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 137-138 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%====================================

%**************************************************************************
% Although this file is identical to the file Brac1Dynamics, it usually not
% a good idea to "reuse" a file -- especially if you are a Beginner --
% because it can create significant problems and confusion when DIDO
% provides the (correct) results to the coded problem but you might think 
% you have defined the problem differently. By giving different file names
% to these different problems, you are ensuring that there are no coding
% errors and that the problem you think you are solving is indeed the
% problem DIDO is solving.
%**************************************************************************
% NOTE:
%------
% The recommended style also prevents MATLAB from executing the wrong file
% on the path!
%==========================================================================

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ x, y, v, theta, t, ...                        % state, controls and time
            x0, y0, v0, t0, xf, yf, vf, tf, ... % endpoints  
            g ] ...                             % constants
            = Brac11Preamble(primal);
        
% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.


%=====================
% Equations of Motion:
%=====================
xdot = v.*sin(theta);
ydot = v.*cos(theta);							 
vdot = g*cos(theta);  
%---------------------
dxdt = [ xdot;
         ydot; 
         vdot];
%=====================
% eof
%====
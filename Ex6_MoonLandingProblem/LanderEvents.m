function efun = LanderEvents(primal)
%======================================        
% Events file for the Moon Landing Problem
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Ross, I.M., "A Primer on Pontryagin's Principle in Optimal 
%           Control," Second Edition, Collegiate Publishers, San Francisco,
%           CA, 2015, Chapter 4, Section 8, pp. 290-292.
%====================================%

%-----------------------------------------
% Call preamble and load primal variables:
%-----------------------------------------

[ h, v, m, T, t, ...                             % states, controls & time
            h0, v0, m0, t0, hf, vf, mf, tf, ...  % endpoints   
            g, ve ] ...                          % constants
            = LanderPreamble(primal);


% Ignore MATLAB's suggestion to replace the unused variables by a ~ (tilde).
% Keeping the unused variables makes the code easier to read.

% preallocate boundary conditions (i.e. event conditions) for good MATLAB computing

efun = zeros(5, 1); 

%===========================================================
efun(1) = h0;
efun(2) = v0;
efun(3) = m0;
%-----------------------------------------------------------
efun(4) = hf;
efun(5) = vf;
%===========================================================
% all done!

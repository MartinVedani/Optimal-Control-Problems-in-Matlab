%----------------%
% Brac11_ProbDef %
%----------------%
% Problem (script) file for "Brac1" with a path constraint.  
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 137-138 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%--------------------------------------------------------------------------

%==========================================================================
% The main purpose of this file is to populate the computational line:
% 
% [cost, primal, dual] = dido(Brac1, algorithm)
%
%==========================================================================%

%---------
% Step 1:       % Always a good idea to begin with this!
clear all;      % Ignore MATLAB's suggestion to not do this!
%---------

%-------------------%
% DEFINE THE PROBLEM
%   - Do NOT code unless you have written down the problem
%   - Ref: The DIDO Tutorial and Page 12 of Ross
%-------------------%

%===================
% Problem variables:
%-------------------
% states = (x, y, v)
% controls = theta
%===================

%--------
% Step 2:       % Provide a search space for DIDO
%--------

search.states     = [0, 20;         % search space for x
                     0, 20;         % search space for y
                     0, 20];        % search space for v
search.controls   = [0, pi];        % search space for theta


%--------
% Step 3:       % Supply the boundary conditions using event boiunds
%--------

bounds.events     = [0, 0;      % x0 = 0
                     0, 0;      % y0 = 0
                     0, 0;      % v0 = 0
                     10, 10;    % xf = 10
                     10, 10];   % yf = 10


%--------
% Step 4:       % Set up the initial- and final-time conditions. 
%--------
                

bounds.initial.time     = [0, 0];       % t0 = 0
bounds.final.time       = [0, 10];      % tf is being minimized; however,
                                        % you still need to bound time
                                        % somewhat "reasonably". This bound
                                        % simply says, 0 < tf < 10
                 
                 

%--------
% Step 5:       % Define the bounds for the path constraint
%--------

bounds.path = [-20, 1.5];   % Why -20? Please look up the problem definition!


%--------
% Step 6:       % Setup the problem-specific constants
%--------

constants.g = 9.8;          


%--------
% Step 7:       % Define the problem using DIDO expressions
%--------

Brac11.cost 		= 'Brac11Cost';
Brac11.dynamics	    = 'Brac11Dynamics';
Brac11.events		= 'Brac11Events';		
Brac11.path         = 'Brac11path';
Brac11.bounds       = bounds;
Brac11.search       = search;
Brac11.constants    = constants; 



%--------
% Step 8:       % Check your problem formulation (using the DIDO Doctor
%--------       % Toolkit)


check(Brac11);


% The following lines will not run if your problem fails the doctor's test!


%--------
% Step 9:       % Setup the number of nodes and call DIDO
%--------

algorithm.nodes		= 80;	% This is an "excessive" number of nodes for
                            % this problem. Frequently, such a "large" 
                            % number is unnecessary.  This number is chosen
                            % here for demonstration purposes only.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call dido
tic;    % start CPU clock 
[cost, primal, dual] = dido(Brac11, algorithm);
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         PROCESS OUTPUT             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Begin with the primals:

[ x, y, v, theta, t, ...                        % state, controls and time
            x0, y0, v0, t0, xf, yf, vf, tf, ... % endpoints  
            g ] ...                             % constants
            = Brac11Preamble(primal);

        
figure;
plot(x, y)
xlabel('x'); ylabel('y'); axis ij;
title('Brachistochrone problem with a path constraint');

figure;
plot(t, [x; y; v]);
xlabel('t');
legend('x', 'y', 'v');
title('Constrained states for Brac1 with a path constraint');

figure;
plot(t, theta)
xlabel('t');
ylabel('\theta');



% 2. V & V -- Energy conservation

figure;
E = v.^2/2 - 9.8*y;
plot(t, E)
xlabel('t');
ylabel('Energy');
title('Special V&V: Check on energy conservation')


% 3. V&V -- Duals
lx = dual.dynamics(1,:);
ly = dual.dynamics(2,:);
lv = dual.dynamics(3,:);
mu = dual.path;

%------------------------------------------------
figure;

H_u = lx.*v.*cos(theta) - ly.*v.*sin(theta) - 9.8*lv.*sin(theta);
plot(t, H_u)
xlabel('t');
ylabel('H_u');
%--------------------------------------------------

figure;
%HEE
plot(t, dual.Hamiltonian)
xlabel('t');
ylabel('H_{lower}');
legend('Hamiltonian Evolution');
axis([0 2 -1.1 -.9]);

%-------------------------------------------------


%----------------------------------------------
figure;
plot(t, [lx; ly; lv; mu]);
title('Compare with Ross Fig. 2.17, pg 138')
xlabel('t');
legend('\lambda_x', '\lambda_y', '\lambda_v', '\mu');
%-----------------------------------------------

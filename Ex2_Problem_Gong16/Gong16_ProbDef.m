%==========================================================================
% Problem Definition file for the problem discussed in Gong et al, JOTA 2016:
%   Gong, Q., Ross, I. M. and Fahroo, F., "Spectral and Pseudospectral
%   Optimal Control Over Arbitrary Grids," Journal of Optimization Theory
%   and Applications, Vol 169, No 3, 2016, pp 759-783.
% See Section 8
%==========================================================================
% Sample Problem file for learning how to use DIDO
%-------------------------------------------------

%==========================================================================
% The main purpose of this file is to populate the computational line:
% 
% [cost, primal, dual] = dido(Gong16, algorithm)
%
%==========================================================================

%---------
% Step 1:       % Always a good idea to begin with this!
clear all;      % Ignore MATLAB's suggestion to not do this!
%---------

%-------------------%
% DEFINE THE PROBLEM
%   - Do NOT code unless you have written down the problem
%   - Ref: The DIDO Tutorial and Page 12 of Ross
%-------------------%

%--------
% Step 2:       % Provide a search space for DIDO
%--------

search.states     = [-10, 10;       % Because the problem has 0's and 1's
                     -10, 10;       % we are assuming (-10, 10) to be 
                     -10, 10];      % a "big enough" search space
search.controls   = [-10, 10];       
                                    
                                    
% After a DIDO run, check to see if any of state and control trajectories
% "hit" the extremes of the search space. If they do, then enlarge the
% search space. 


%--------
% Step 3:       % Supply the boundary conditions using bounds.events
%--------

bounds.events     = [0, 0;          % This goes hand-in-hand with the
                     1, 1;          % events function. It simply says
                     0, 0];         % x10 =0;
                                    % x20 = 1 
                                    % x30 = 0
                                                                       
%--------
% Step 4:       % Set up the initial and final time conditions
%--------

bounds.initial.time     = [0, 0];   % t0 = 0
bounds.final.time       = [2, 2];   % tf = 2



%--------
% Step 5:       % Define the problem using DIDO expressions
%--------

Gong16.cost     = 'Gong16_cost';
Gong16.dynamics = 'Gong16_dynamics';
Gong16.events   = 'Gong16_events';
Gong16.bounds   = bounds;   
Gong16.search   = search;   

%--------
% Step 6:       % Check your problem formulation (part of DIDO Doctor
                % Toolkit)
%--------

check(Gong16);

% If your code runs past this check point, the rest of your code will run.


%-------             
% Step 7:       % Setup the algorithm and call dido
%--------

algorithm.nodes = 30;       % 10 points is usually a very good idea to
                            % start up the algorithm. 

tic
[cost, primal, dual] = dido(Gong16, algorithm);
toc

%--------
% Step 8:       % Plot/process primal
%--------

[ x1, x2, x3, u, t, ...
    x10, x20, x30, x1f, x2f, x3f ] = preamble_Gong16( primal );


% Exact solution given in the paper:

x1E = -(64/5)*(2 + t).^(-5) + 0.4;
x2E = 4*(2 + t).^(-2);
x3E = -(128/5)*(2 + t).^(-5) +0.8;
uE  = -8*(2 + t).^(-3);

figure;
plot(t, x1, t, x1E, 'o', ...
     t, x2, t, x2E, '*', ...
     t, x3, t, x3E, '+');
legend('x_{DIDO} vs  x_{Exact}');

figure;
plot(t, u, t, uE, 'x');
legend('u_{DIDO} vs u_{Exact}');

%--------
% Step 9:       % Plot/process dual
%--------

% Exact solution given in the paper:

lam1E = 4;  lam1E = lam1E + t - t; % this will plot constants
lam2E = 64*(2 + t).^(-3);
lam3E = 2;  lam3E = lam3E + t - t; % for plotting


lam1   = dual.dynamics(1,:);
lam2   = dual.dynamics(2,:);
lam3   = dual.dynamics(3,:);

figure;
plot(t, lam1, t, lam1E, 'o', ...
     t, lam2, t, lam2E, '*', ...
     t, lam3, t, lam3E, '+');
legend('\lambda_{DIDO} vs  \lambda_{Exact}');

% Hamiltonian

% Exact H

HE = lam1E.*x2E.^3 + lam2E.*uE + 2*lam3E.*(uE.^2);
H  = dual.Hamiltonian;

figure;
plot(t, H, t, HE, 's');
legend('H_{DIDO} vs H_{Exact}');
ylim([-.1, .1]);

%= End =%




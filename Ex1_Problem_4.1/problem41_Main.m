%==========================================
% Sample Problem file for The DIDO Tutorial
%------------------------------------------
% The complete problem description is given in The DIDO Tutorial and Ross,
% page 248

%------------%
% problem41  %
%------------%
% Problem (script) file for Problem 4.1 from Ross, "A Primer on
% Pontryagin's Principle in Optimal Control,"  Page 248.  
%------------

%==========================================================================
% The main purpose of this file is to populate the computational line:
% 
% [cost, primal, dual] = dido(problem41, algorithm)
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

search.states     = [-10, 10];      % Because the problem has 0's and 1's
search.controls   = [-10, 10];      % we are assuming (-10, 10) to be a 
                                    % "big enough" search space.
                                    
% After a DIDO run, check to see if any of state and control trajectories
% "hit" the extremes of the search space. If they do, then enlarge the
% search space. 


%--------
% Step 3:       % Supply the boundary conditions using bounds.events
%--------

bounds.events     = [1, 1];         % This goes hand-in-hand with the 
                                    % events function. It simply says,
                                    % x0 = 1.
                                                                       
%--------
% Step 4:       % Set up the initial and final time conditions
%--------

bounds.initial.time     = [0, 0];   % t0 = 0
bounds.final.time       = [1, 1];   % tf = 1



%--------
% Step 5:       % Define the problem using DIDO expressions
%--------

problem41.cost     = 'cost41';
problem41.dynamics = 'dynamics41';
problem41.events   = 'events41';
problem41.bounds   = bounds;   
problem41.search   = search;   

%--------
% Step 6:       % Check your problem formulation (part of DIDO Doctor
                % Toolkit)
%--------

check(problem41);

% If your code runs past this check point, the rest of your code will run.


%-------             
% Step 7:       % Setup the algorithm and call dido
%--------

algorithm.nodes = 20;       % 10 points is usually a very good idea to
                            % start up the algorithm. 


[cost, primal, dual] = dido(problem41, algorithm);

%--------
% Step 8:       % Plot/process primal
%--------

[ x, u, t, ...
            x0, xf, t0, tf ] = preamble41(primal);

figure;
plot(t, [x; u]);
legend('x', 'u');

%--------
% Step 9:       % Plot/process dual
%--------

lam_x   = dual.dynamics;
H       = dual.Hamiltonian;

figure;
plot(t, [lam_x; H]);
legend('\lambda_x', 'H');

%---------
% Step 10:       % Perform V&V
%---------

% 1. u = - \lambda_x; see page 248 of Ross

figure;
plot(t, [u; -lam_x]);
legend('u', '-\lambda_x');

% 2. \lambda_x(t_f) = xf; see page 248 of Ross

tvCheck1 = lam_x(end) - x(end);

fprintf('Transversality check: %g should be near zero.\n', tvCheck1);

% eof 
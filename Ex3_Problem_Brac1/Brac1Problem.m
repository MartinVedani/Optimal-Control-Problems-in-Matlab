%--------------%
% Brac1Problem %
%--------------%
% Problem (script) file for Brac:1.  
%   References: 
%       1. Beginner's Guide to DIDO
%       2. The DIDO Tutorial
%       3. Page 88 of Chapter 2 of Ross (see documents folder)
%       4. Page 12 of Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%--------------------------------------------------------------------------

%==========================================================================
% The main purpose of this file is to populate the computational line:
% 
% [cost, primal, dual] = dido(Brac1, algorithm)
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
% Step 5:       % Define the problem using DIDO expressions
%--------

Brac1.cost     = 'Brac11Cost';           % Watch out for case-sensitive
Brac1.dynamics = 'Brac1Dynamics';       % errors
Brac1.events   = 'Brac1Events';
Brac1.bounds   = bounds;       
Brac1.search   = search;          



%--------
% Step 6:      % Set up problem-specific constants
%--------

Brac1.constants.g = 9.8;    % The DIDO field name is "constants"


%--------
% Step 7:       % Check your problem formulation (using the DIDO Doctor
                % Toolkit)
%--------

check(Brac1);

% The following lines will not run if your problem fails the doctor's test!


%-------             
% Step 8:       % Setup the algorithm
%--------

algorithm.nodes = 30;       % 10 points is usually a very good idea to
                            % start up the algorithm. 

%--------
% Step 9:       % call dido
%--------

tic    % start the clock 
[cost, primal, dual] = dido(Brac1, algorithm);
toc
 

%%%%%%%%%%%%%%%%%%%%%%
%  Process Output    %
%%%%%%%%%%%%%%%%%%%%%%

[ x, y, v, theta, t, ...                        % state, controls and time
            x0, y0, v0, t0, xf, yf, vf, tf, ... % endpoints  
            g ] ...                             % constants
            = Brac1Preamble(primal);
        
%---------
% Step 10:       % plot/process primal
%---------

% Sample processing.  See Section 3.2 of Ross for complete details.
figure; 
plot(x, -y);
title('Generation of Figure 3.4 in Ross');
xlabel('x'); ylabel('y');


%---------
% Step 11:       % Plot/process duals
%---------
% Sample processing.  See Section 3.2 of Ross for complete details.
%---------
lam_x   = dual.dynamics(1,:);
lam_y   = dual.dynamics(2,:);
lam_v   = dual.dynamics(3,:);

figure;
plot(t, [lam_x; lam_y; lam_v]);
title('Generation of Figure 3.5 in Ross');
legend('\lambda_x', '\lambda_y', '\lambda_v');
xlabel('t');

%--------
% Step 12:       % Perform V&V.  This is crtically important.  You should
                 % not trust any solution coming out of any code, including
                 % DIDO, without performing V&V.  See Sec 3.2.1 of Ross for
                 % complete details.  The V&V shows that 10 nodes for the
                 % choice of algorithm was sufficiently accurate.
%--------
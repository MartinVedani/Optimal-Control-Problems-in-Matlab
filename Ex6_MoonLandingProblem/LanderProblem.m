% LanderProblem: Problem File (Script) for the Moon-Landing Problem
%==================================================================
% This problem is dicussed in:
%   Ross, I.M., "A Primer on Pontryagin's Principle in Optimal Control,"
%   Second Edition, Collegiate Publishers, San Francisco, CA, 2015, Chapter
%   4, Section 8, pp. 290-292.
%------------------------------------------------------------------


%---------
% Step 1:       % Always a good idea to begin with this!
clear all;      % Ignore MATLAB's suggestion to not do this!
%---------

%-------------------%
% DEFINE THE PROBLEM
%   - Do NOT code unless you have written down the problem
%   - Ref: The DIDO Tutorial and Page 12 of Ross
%-------------------%
%   - See Ross, Sec 4.8.1, pg 290 for the problem definition.
%   - See Ross pg 291 for the chosen values of the constants
%-------------------%

Tmax    = 1.227;    % Eq 4.27, pg 291
tfMax   = 20;       % time-free problem but expect tf  < tfMax = 20

%   Problem states are (h, v, m); control is T

%--------
% Step 2:       % Provide a search space for DIDO
%--------

search.states     = [  0, 20;        % See the problem write up to 
                     -20, 20;        % better understand these limits.
                     0.01, 1 ];      % Why is m (left pt) = 0.01?
                 
search.controls   = [-Tmax, 2*Tmax]; % REMEMBER SEARCH IS NONBINDING       
                                    
bounds.path  = [0, Tmax];           % THIS IS BINDING!

%--------
% Step 3:       % Supply the boundary conditions using bounds.events
%--------
%   Ref Ross, Eqs 4.26, 4.27 on pg 291

h0 = 1.000;     v0 = -0.783;    m0 = 1.000;     % initial conditions
hf = 0.0;       vf =  0.0;                      % boundary condition

bounds.events     = [h0, h0;          % This goes hand-in-hand with the
                     v0, v0;          % events function. 
                     m0, m0;
                     hf, hf;
                     vf, vf];         
                                                  

%--------
% Step 4:       % Set up the initial and final time conditions
%--------

bounds.initial.time     = [0, 0];       % t0 = 0
bounds.final.time       = [0, tfMax];   % tf is free (expect tf < tfMax)

%--------
% Step 5:       % Set up the problem constants
%--------

constants.g     = 1.0;      % g of Moon, normalized
constants.ve    = 2.349;    % exhaust velocity (Eq. 4.27, Ross)


%--------
% Step 6:       % Define the problem using DIDO expressions
%--------

MoonLander.cost         = 'LanderCost';
MoonLander.dynamics     = 'LanderDynamics';
MoonLander.events       = 'LanderEvents';
MoonLander.path         = 'LanderPath';
MoonLander.bounds       = bounds;   
MoonLander.search       = search;
MoonLander.constants    = constants;
                 

%--------
% Step 7:       % Check your problem formulation (part of DIDO Doctor
%--------       % Toolkit)


check(MoonLander);

% If your code runs past this check point, the rest of your code will run.


%-------             
% Step 8:       % Setup the algorithm and call dido
%--------

algorithm.nodes = 150;    % somewhat arbitrary number; theoretically, the 
                         % larger the number of nodes, the more accurate 
                         % the solution (but, practically, this is not
                         % always true!)


tic
[cost, primal, dual] = dido(MoonLander, algorithm);
toc


%-------
% Step 9        % Process outputs
%-------

% 1. Begin with primal

[ h, v, m, T, t, ...                             % states, controls & time
            h0, v0, m0, t0, hf, vf, mf, tf, ...  % endpoints   
            g, ve ] ...                          % constants
            = LanderPreamble(primal);
        
        
        
figure;
plot(t, [h; v; m; T]);
legend('altitude', 'speed', 'mass', 'thrust');
xlabel('normalized time units');
ylabel('normalized units');
title('See Ross, Fig 4.17, pg 291');

% 2. V & V w/ dual

lam_h = dual.dynamics(1,:);
lam_v = dual.dynamics(2,:);
lam_m = dual.dynamics(3,:);
mu_T  = dual.path;
H     = dual.Hamiltonian;

figure;
plot(t, [lam_h; lam_v; lam_m]);
legend('\lambda_h', '\lambda_v', '\lambda_m');
xlabel('time')
ylabel('costates')
title('See Ross, Fig 4.18, pg 292');


figure;
plot(t, H);
legend('Hamiltonian Evolution');
xlabel('t')

% 3. V & V w Switching Func

S = 1+ lam_v./m - lam_m/ve;

Topt = t;   % initialize
Topt(S>=0) = 0;
Topt(S<0) = Tmax;

figure;
plot(t, Topt);
xlabel('t')
ylabel('T_{opt}')
legend('Optimal "Bang-Bang" Thrust');

% EOF
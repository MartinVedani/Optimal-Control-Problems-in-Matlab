%-----------------%
% BadBrac1Problem %
%-----------------%
% Problem (script) file for the Bad Brachistochrone Problem Brac:1.  
%   References: 
%       1. Beginner's Guide to DIDO.  See slides discussing scaling and
%          balancing
%       2. Section 1.1.4 from Ross, page 20:
%          I. M. Ross, "A Primer on Pontryagin's Principle in Optimal
%           Control, Second Edition, Collegiate Publishers, San Francisco,
%           2015.
%       3. See also Study Problem 1.4, page 23 of Ross
%       4. DIDO Best Practices
%-----------------%

%=========================================================================%
% Please study these files only after studying and reading the standard or
% the "good" Brachistochrone problem Brac:1.
% 
% This problem supports the material discussed in the DIDO Best Practices
% document.
%=========================================================================%

%---------
% Step 1:
clear all;      % Always a good idea to begin with this!
%---------

%-------------------%
% DEFINE THE PROBLEM
%   - Do NOT code unless you have written down the problem
%   - Ref: The DIDO Tutorial and Page 12 of Ross
%-------------------%

%--------
% Step 2:       % Set up the units and scales for the problem.
                % This is part of the pre-work that is needed for most
                % problems.  See the DIDO Beginner's Guide.
%--------

[UNITS, SCALES] = BadBrac1Constants;    % This file generates units & scales.

BadBrac1.constants.UNITS    = UNITS;    % BadBrac1 is the name of the problem.
BadBrac1.constants.SCALES   = SCALES;   % "constants" is a DIDO field name.
 


%--------
% Step 3:       % Set up the search space for the problem.
                % Remember all DIDO variables are scaled per the designer
                % units.  See DIDO Best Practices.
%--------

xLBar = 0;  xUBar = 10*UNITS.x;
yLBar = 0;  yUBar = 10*UNITS.y;
vLBar = 0;  vUBar = 100*UNITS.v;

search.states = [ xLBar, xUBar; 
                  yLBar, yUBar;             % search space for states
                  vLBar, vUBar];

search.controls = [0, pi/UNITS.theta];      % search space for controls



%--------
% Step 4:       % Set up the boundary conditions in the scaled variables
%--------

%---------------
% Bad Brac data:
%---------------
xFinal = 1000;     % in meters
yFinal = 1;        % in meters
%-------------------------------
x0Bar = 0; y0Bar = 0; v0Bar = 0;
xfBar = xFinal/UNITS.x;
yfBar = yFinal/UNITS.y;
%-------------------------------

bounds.events     = [x0Bar, x0Bar;      % x0Bar = x0Bar
                     y0Bar, y0Bar;      % y0Bar = y0Bar
                     v0Bar, v0Bar;      % v0Bar = v0Bar
                     xfBar, xfBar;      % xfBar = xfBar
                     yfBar, yfBar];     % yfBar = yfBar
                 
% See also Section 1.3, page 37 of Ross to get a better understanding of
% the differences between x_f and x^f. The preceding line of bounds.events
% is implementing the equation, x_f = x^f.


%--------
% Step 5:       % Set up the (scaled) initial and final-time conditions
%--------

t0	    = 0;
tUBar 	= 200/UNITS.t;                           % swag

bounds.initial.time     = [t0, t0];         % t0 = t0
bounds.final.time       = [t0, tUBar];      % See the "good" or standard 
                                            % Brac:1. Recall, tf is being
                                            % minimized; however, we need
                                            % to bound time "reasonably".

                                  
%--------
% Step 6:       % Define the problem using DIDO expressions
%--------

BadBrac1.cost     = 'BadBrac1Cost';           % Watch out for case-sensitive
BadBrac1.dynamics = 'BadBrac1Dynamics';       % errors
BadBrac1.events   = 'BadBrac1Events';
BadBrac1.search   = search;          
BadBrac1.bounds   = bounds;      

%--------
% Step 7:       % Check your problem formulation (using the DIDO Doctor
                % Toolkit)
%--------

check(BadBrac1);

% The rest of this code will not run if the problem fails the doctor's test!

%-------             
% Step 8:       % Setup the algorithm and run dido
%--------

% algorithm.nodes = 10;      % 10 points is usually a very good idea to
%                            % start up the algorithm. 

 algorithm.nodes = 30;      % After starting with 10 points and getting the
                            % the code working, run for a higher number of
                            % points.  See the DIDO Tutorial for more
                            % details on choosing this number.
                            
% Call dido
tic    % start the clock 
[cost, primal, dual] = dido(BadBrac1, algorithm);
toc


%%%%%%%%%%%%%%%%%%%%%%
%  Process Output    %
%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------%
% Call the preamble file first: %
%-------------------------------%

[xBar, yBar, vBar, thetaBar, tBar,...
    x0Bar, y0Bar, v0Bar, t0Bar, xfBar, yfBar, vfBar, tfBar, ...
    UNITS, SCALES, ...
    x, y, v, theta, t, x0, y0, v0, t0, xf, yf, vf, tf, g] = ...
    BadBrac1Preamble(primal);

%--------
% Step 9:       % plot/process primal
%--------


%---------------------------------------
figure;
plot(tBar, [xBar; yBar; vBar; thetaBar])
legend('Scaled States and Controls')
%----------------------------------------
figure;
plot(tBar, dual.dynamics);
legend('Scaled Costates');
%---------------------------------------
figure;
plot(tBar, dual.Hamiltonian);
legend('Scaled Hamiltonian');
%---------------------------------------

%===============
% Desired plots:
%===============



lamx = (UNITS.t/UNITS.x)*dual.dynamics(1,:);
lamy = (UNITS.t/UNITS.y)*dual.dynamics(2,:);
lamv = (UNITS.t/UNITS.v)*dual.dynamics(3,:);

OptimalCost = cost*UNITS.t


%----------------------------
% linear theoretical values:
%---------------------------
slopeAngle = atan(yFinal/xFinal);
LinearCost = sqrt(2*yFinal/(g*sin(slopeAngle)^2))

yLinear = yFinal/xFinal*x;
%============================================================================
figure;
plot(x, -y, '-o', x, -yLinear);
legend('DIDO Solution', 'Linear Solution');
title('Bad Brachistochrone Problem')
xlabel('x (m)');
ylabel('y (m)');

%--------------------------------------------------------------------------
figure;
plot(t, x, '-o', t, y, '-x', t, v, '-.');
title('"Bad" Brachistochrone States: Brac 1')
xlabel('time');
ylabel('states');
legend('x', 'y', 'v');

%----------------------------------------------
figure;
plot(t, dual.Hamiltonian);
title('"Bad" Brachistochrone Hamiltonian Evolution');
legend('H');
xlabel('time');
ylabel('Hamiltonian Value');

%----------------------------------------------
figure;
plot(t, [lamx; lamy; lamv]);
title('"Bad" Brachistochrone Costates: Brac 1')
xlabel('time');
ylabel('costates');
legend('\lambda_x', '\lambda_y', '\lambda_v');
%==============================================



%--------
% Step 10:       % Perform V&V.  This is crtically important.  You should
                 % not trust any solution coming out of any code, including
                 % DIDO, without performing V&V.  See Sec 3.2.1 of Ross for
                 % complete details.  The V&V shows that 20 nodes for the
                 % choice of algorithm was sufficiently accurate.
%--------

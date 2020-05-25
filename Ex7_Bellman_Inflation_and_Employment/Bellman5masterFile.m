%--------------%
% Bellman5 

%          ARCHIVO MAESTRO, CORRER ESTE ARCHIVO SOLAMENTE

% Si la TOOLBOX utilizada ("DIDO")no esta disponible en la maquina
% del profesor, las varibles estan incluidas y serán cargadas
% por este script.

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
%==========================================================================
% The main purpose of this file is to populate the computational line:
% 
% [cost, primal, dual] = dido(Bellman5, algorithm)
%
%==========================================================================

%---------
% Step 1:
clear all;      % Always a good idea to begin with this!
%---------

try
    %startupDIDO;

%--------
% Step 2:       % Provide a search space for DIDO
%--------

search.states     = [-1 , 1];   % search space for inflacionEsp
search.controls   = [-1 , 1];   % search space for y

%--------
% Step 3:       % Supply the boundary conditions using event bounds
%--------

bounds.events     = [0.25, 0.25;   % inflacionEsp0 = 25%                    
                     0.20, 0.20];  % inflacionEspF = 20%
                     
%--------
% Step 4:       % Set up the initial- and final-time conditions. 
%--------
                
bounds.initial.time     = [0 ,  0];  % t0 = 0
bounds.final.time       = [51, 51];  % tf = 51
                                    
%--------
% Step 5:       % Define the problem using DIDO expressions
%--------

Bellman5.cost     = 'Bellman5Cost';           % Watch out for case-sensitive
Bellman5.dynamics = 'Bellman5Dynamics';       % errors
Bellman5.events   = 'Bellman5Events';
Bellman5.bounds   = bounds;       
Bellman5.search   = search;          

%--------
% Step 6:      % Set up problem-specific constants
%--------

Bellman5.constants.plenoEmp = 0.40;
Bellman5.constants.theta = 0.5;
Bellman5.constants.a = 0.000001;
Bellman5.constants.g = 0.5;

%--------
% Step 7:       % Check your problem formulation (using the DIDO Doctor
                % Toolkit)
%--------

check(Bellman5);

% The following lines will not run if your problem fails the doctor's test!


%-------             
% Step 8:       % Setup the algorithm
%--------

algorithm.nodes = 10;       % 10 points is usually a very good idea to
                            % start up the algorithm. 

%--------
% Step 9:       % call dido
%--------

tStart= cputime;    % start CPU clock 
[cost, primal, dual] = dido(Bellman5, algorithm);
runTime = cputime-tStart
 

%%%%%%%%%%%%%%%%%%%%%%
%  Process Output    %
%%%%%%%%%%%%%%%%%%%%%%

Bellman5Preamble(primal);
load Bellman5Primal

%---------
% Step 10:       % plot/process primal
%---------

% Sample processing.

figure; 
plot(t, [inflacionEsp; y]);
title('Solucion');
legend('\pi_t', 'y', 'Location','South');
xlabel('t');

%---------
% Step 11:       % Plot/process duals
%---------
% Sample processing.  See Section 3.2 of Ross for complete details.
%---------

lam_pi   = dual.dynamics(1,:);

% --------
% Step 12:       % Perform V&V.  This is crtically important.  You should
%                  not trust any solution coming out of any code, including
%                  DIDO, without performing V&V.  See Sec 3.2.1 of Ross for
%                  complete details.  The V&V shows that 10 nodes for the
%                  choice of algorithm was sufficiently accurate.
% --------

figure; 
subplot(2,1,1);
mtit('Hamiltonian');
plot(t,dual.controls);
ylim([-20 20]);
subplot(2,1,2);
plot(t,dual.controls);
ylabel('Auto Zoom');
xlabel('t');

figure;
plot(t, dual.Hamiltonian);
title('lower Hamiltonian');
xlabel('t');

figure;
plot(t,dual.states(1,:));
title('-\lambda_y'' evolution');
xlabel('t');

% --------
% Step 13:       % Fit solution functions and evaluate at any t
% --------

%Fit: 'y(t)'.
[tData, yData] = prepareCurveData( t, y );
%Set up fittype and options.
ft_y_t = fittype( 'poly9' );
%Fit model to data.
[y_t, gof_y_t] = fit(tData, yData, ft_y_t,'Normalize','on');
%Plot fit with data.
figure;
plot(y_t, tData, yData,'o');
title('y(t), Control');
legend('y vs. t', 'y(t)', 'Location', 'South' );
xlabel('t');
ylabel('y');
grid on;

%Fit: '\pi(t)'.
[tData, inflacionEspData] = prepareCurveData( t, inflacionEsp );
%Set up fittype and options.
ft_inflacionEsp_t = fittype('poly9');
%Fit model to data.
[inflacionEsp_t, gof_u_t] = fit(tData, inflacionEspData,...
                        ft_inflacionEsp_t,'Normalize','on');
%Plot fit with data.
figure;
plot(inflacionEsp_t, tData, inflacionEspData,'o');
title('\pi(t), Estado');
legend('\pi_t vs. t', '\pi(t)', 'Location', 'North' );
xlabel('t');
ylabel('\pi_t');
grid on;

% Evaluate transversality conditions
y_t0 = sprintf('y(@t = %d) = %d \n',0,feval(y_t, 0));
inflacionEsp_t0 = sprintf('InfEsp(@t = %d) = %d \n',0,feval(inflacionEsp_t, 0));

fprintf(y_t0);
fprintf(inflacionEsp_t0);

y_tf = sprintf('y(@t = %d) = %d \n',t(end),feval(y_t, t(end)));
inflacionEsp_tf = sprintf('InfEsp(@t = %d) = %d \n',t(end),feval(inflacionEsp_t, t(end)));

fprintf(y_tf);
fprintf(inflacionEsp_tf);

% Evaluate result requested by profesor
infEsp_t23 = feval(inflacionEsp_t, 23);
infEsp_t51 = feval(inflacionEsp_t, 51);
y_t0 = feval(y_t, 0);
y_t47 = feval(y_t, 47);
y_t51 = feval(y_t, 51);

solucionBellman5=vertcat(infEsp_t23,infEsp_t51,...
                                y_t0, y_t47, y_t51);

solucionBellman5 = dataset({solucionBellman5...
    'x100'},'obsnames', {'pi(@t = 23)',...
            'pi(@t = 51)',...
            'y(@t = 0)',...
            'y(@t = 47)', 'y(@t = 51)'});
   
solucionBellman5 

catch

%%%%%%%%%%%%%%%%%%%%%%
%  Process Output    %
%%%%%%%%%%%%%%%%%%%%%%

load('dualBellman5.mat');
load('inflacionEspBellman5.mat');
load('tBellman5.mat');
load('yBellman5.mat');

%---------
% Step 10:       % plot/process primal
%---------

% Sample processing.

figure; 
plot(t, [inflacionEsp; y]);
title('Solucion');
legend('\pi_t', 'y', 'Location','South');
xlabel('t');

%---------
% Step 11:       % Plot/process duals
%---------

lam_pi   = dual.dynamics(1,:);

% --------
% Step 12:       % Perform V&V.  This is crtically important.  You should
%                  not trust any solution coming out of any code, including
%                  DIDO, without performing V&V.  See Sec 3.2.1 of Ross for
%                  complete details.  The V&V shows that 10 nodes for the
%                  choice of algorithm was sufficiently accurate.
% --------

figure; 
subplot(2,1,1);
mtit('Hamiltonian');
plot(t,dual.controls);
ylim([-20 20]);
subplot(2,1,2);
plot(t,dual.controls);
ylabel('Auto Zoom');
xlabel('t');

figure;
plot(t, dual.Hamiltonian);
title('lower Hamiltonian');
xlabel('t');

figure;
plot(t,dual.states(1,:));
title('-\lambda_y'' evolution');
xlabel('t');

% --------
% Step 13:       % Fit solution functions and evaluate at any t
% --------

%Fit: 'y(t)'.
[tData, yData] = prepareCurveData( t, y );
%Set up fittype and options.
ft_y_t = fittype( 'poly9' );
%Fit model to data.
[y_t, gof_y_t] = fit(tData, yData, ft_y_t,'Normalize','on');
%Plot fit with data.
figure;
plot(y_t, tData, yData,'o');
title('y(t), Control');
legend('y vs. t', 'y(t)', 'Location', 'South' );
xlabel('t');
ylabel('y');
grid on;

%Fit: '\pi(t)'.
[tData, inflacionEspData] = prepareCurveData( t, inflacionEsp );
%Set up fittype and options.
ft_inflacionEsp_t = fittype('poly9');
%Fit model to data.
[inflacionEsp_t, gof_u_t] = fit(tData, inflacionEspData,...
                        ft_inflacionEsp_t,'Normalize','on');
%Plot fit with data.
figure;
plot(inflacionEsp_t, tData, inflacionEspData,'o');
title('\pi(t), Estado');
legend('\pi_t vs. t', '\pi(t)', 'Location', 'North' );
xlabel('t');
ylabel('\pi_t');
grid on;

% Evaluate transversality conditions
y_t0 = sprintf('y(@t = %d) = %d \n',0,feval(y_t, 0));
inflacionEsp_t0 = sprintf('InfEsp(@t = %d) = %d \n',0,feval(inflacionEsp_t, 0));

fprintf(y_t0);
fprintf(inflacionEsp_t0);

y_tf = sprintf('y(@t = %d) = %d \n',t(end),feval(y_t, t(end)));
inflacionEsp_tf = sprintf('InfEsp(@t = %d) = %d \n',t(end),feval(inflacionEsp_t, t(end)));

fprintf(y_tf);
fprintf(inflacionEsp_tf);

% Evaluate result requested by profesor
infEsp_t23 = feval(inflacionEsp_t, 23);
infEsp_t51 = feval(inflacionEsp_t, 51);
y_t0 = feval(y_t, 0);
y_t47 = feval(y_t, 47);
y_t51 = feval(y_t, 51);

solucionBellman5=vertcat(infEsp_t23,infEsp_t51,...
                                y_t0, y_t47, y_t51);

solucionBellman5 = dataset({solucionBellman5...
    'x100'},'obsnames', {'pi(@t = 23)',...
            'pi(@t = 51)',...
            'y(@t = 0)',...
            'y(@t = 47)', 'y(@t = 51)'});
   
solucionBellman5 
    
end
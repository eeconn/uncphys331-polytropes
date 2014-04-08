% Homework #7b
% Driver for ode_fixedstep
clc
clear;
close all;
%===================================
% (7b)
%-----------------------------------
%For larger step numbers it is beneficial to change the marker on the plot
%for the analytical solution from stars to something thinner.
nstep = 10;   % number of steps
iinteg= 0;    % type of integrator
xs    = 0.0000001;  % starting x. Singularity
us    = [1.0,0]; % starting y.
xe    = ???;  % end x. Free Boundary.
f(x,u(1))  = u(2);
f(x,u(2))  =(-u(1)^n) - (2/x)*u(2);
%==========================================

[x,yrk4] = ode_stepper(nstep,f,xs,us,xe,1);

plot(x,yrk4)
fprintf(1,'Enter to continue...\n');
pause;

%==========================================



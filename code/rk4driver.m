clc
clear;
close all;
%===================================
%-----------------------------------
n     = ???;  % polytropic index
nstep = 10;   % number of steps
iinteg= 0;    % type of integrator; Not needed now, but I left it in there.
xs    = 0.0000001;  % starting x. Singularity
us    = [1.0,0]; % starting y.
xe    = ???;  % end x. Free Boundary.
f(x,u(1))  = u(2);
f(x,u(2))  =(-u(1)^n) - (2/x)*u(2);
%==========================================

[x,yrk4] = aode_stepper(nstep,f,xs,us,iter,1);

plot(x,yrk4)
fprintf(1,'Enter to continue...\n');
pause;

%==========================================



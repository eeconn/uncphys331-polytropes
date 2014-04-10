% Homework #7b
% Driver for ode_fixedstep
clc
clear;
close all;
%===================================
% (7b)
%-----------------------------------

iter = 10000;
h    = 0.001;
y0   = [1.0 0];
x0   = 0.0001;
f    = @Mfxy1;

%==========================================

[xs,ys] = newodesolverstep(iter,f,x0,y0,h,2);

plot(xs,ys(1,:))
fprintf(1,'Enter to continue...\n');
pause;

% Insert Mass-Radius Relationship and Plot


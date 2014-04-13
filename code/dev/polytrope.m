% polytrope.m
% Script to solve the Lane-Emden equation and find the dimensionless radius,
% then use this solution to find the mass & density profile of the star.
%
% 2014-04-13 13:34 eeconn: Renamed from newodesolver.m
%
%======================================================

clc
clear;
close all;

iter = 100000;
h    = 0.001;
y0   = [1.0 0];
x0   = 0.0001;
f1   = @rel;
f2   = @nonrel;

%==========================================

[x1s,y1s] = lesolve(iter,f1,x0,y0,h,2);
[x2s,y2s] = lesolve(iter,f2,x0,y0,h,2);

% Plot the solutions on the same graph
hold all
figure('Name','Comparison of non-relativistic and relativistic solutions','NumberTitle','off')
xlabel('\xi')
ylabel('\theta(\xi)')

plot(x1s,y1s(1,:))
plot(x2s,y2s(1,:))
legend('\theta_{nr}(\xi), n=1.5','\theta_{r}(\xi), n=3')
fprintf(1,'Enter to continue...\n');
pause;

% Insert Mass-Radius Relationship and Plot


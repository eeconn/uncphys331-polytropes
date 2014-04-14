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

iter = 10^5;
h    = 0.001;
y0   = [1.0 0];
x0   = 0.0001;
f1   = @nonrel;
f2   = @rel;

%==========================================

[x1s,y1s] = lesolve(iter,f1,x0,y0,h,2);
[x2s,y2s] = lesolve(iter,f2,x0,y0,h,2);

% write to .csv files for use with external applications
csvwrite('nonrel.csv',[x1s.',y1s(1,:).',y1s(2,:).']);
csvwrite('rel.csv',[x2s.',y2s(1,:).',y2s(2,:).']);

% Plot the solutions on the same graph
figure('Name','Comparison of non-relativistic and relativistic solutions','NumberTitle','off')
hold all
xlabel('\xi')
ylabel('\theta(\xi)')

plot(x1s,y1s(1,:))
plot(x2s,y2s(1,:))
legend('\theta_{nr}(\xi), n=1.5','\theta_{r}(\xi), n=3')
fprintf(1,'Enter to continue...\n');
pause;

% Insert Mass-Radius Relationship and Plot
m1 = zeros(1,size(x1s,2));
m2 = zeros(1,size(x2s,2));
% Central density in solar mass/solar radius
centdens1 = -1/(4*pi)/(1/x1s(end)*y1s(2,end));
centdens2 = -1/(4*pi)/(1/x2s(end)*y2s(2,end));

% still need to find alpha to get mass as a function of R.
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
f1   = @rel;
f2   = @nonrel;

%==========================================

[x1s,y1s] = lesolve(iter,f1,x0,y0,h,2);
[x2s,y2s] = lesolve(iter,f2,x0,y0,h,2);

% write to .csv files for use with external applications
csvwrite('nonrel.csv',[x1s,y1s]);
csvwrite('rel.csv',[x2s,y2s]);

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

% Take the definite integral of x^2 y^n dx from x0 to xfinal
%
% trapz - Matlab built-in function that uses trapezoidal quadrature to integrate
% a vector of data
%
nonrelint = trapz(x1s,y1s(1,:));
relint = trapz(x2s,y2s(1,:));

% This gives us the total mass of the star, but not a plot of mass vs. radius.
% Need to define alpha and centdens (central density)
%nonrelMass = 4*pi*alpha^3*centdens*nonrelint;
%relMass = 4*pi*alpha^3*centdens*relint;


% r1 - radius values for non-relativistic gas
% r2 - radius values for relativistic gas
% mr1 - M(r) (non-relativistic)
% mr2 - M(r) (relativistic)
%
% Plot mass/radius relationship in terms of solar masses & kilometers
% figure('Name','Mass - Radius Relation')
% hold all
% xlabel('R (km)')
% ylabel('M (M_{sun}')
%
% plot(r1,mr1)
% plot(r2,mr2)
% legend('M_{nr}','M_r')
% fprintf(1,'Enter to continue...\n');
% pause;

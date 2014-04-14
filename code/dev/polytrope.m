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

% Density profile
figure('Name','Density profiles for non-relativistic and relativistic polytropes','NumberTitle','off')
hold all
xlabel('\xi')
ylabel('\rho/\rho_c')

plot(x1s,y1s(1,:).^1.5)
plot(x2s,y2s(1,:).^3)
legend('n=1.5 (non-relativistic)','n=3 (relativistic)')
fprintf(1,'Enter to continue...\n');
pause;

% Insert Mass-Radius Relationship and Plot
m1 = zeros(1,size(x1s,2));
m2 = zeros(1,size(x2s,2));
% Central density in solar mass/solar radius
centdens1 = -1/(4*pi)/(1/x1s(end)*y1s(2,end));
centdens2 = -1/(4*pi)/(1/x2s(end)*y2s(2,end));
% Ratio of central density to average density (are we using this?)
rhorat1 = 1/3*x1s(end)/-y1s(2,end);
rhorat2 = 1/3*x2s(end)/-y2s(2,end);

% still need to find alpha to get mass as a function of R.
% Using pressure relation to find K
% SI units:
h = 6.6261*10^(-34);    %kg m^2/s
hc = 1.9864*10^(-25);   %kg m^3/s^2
Msun = 1.98855*10^(30); %kg
Rsun = 6.96340*10^8;    %m
Me = 9.1094*10^(-31);   %kg
Mh = 1.6726*10^(-27);   %kg
G = 6.67384*10^(-11);   %m^3/kgs^2

K1 = h^2/(20*Me)*(3/pi)^(2/3)*(1/(2*Mh))^(5/3);
K2 = hc/8*(3/pi)^(1/3)*(1/(2*Mh))^(4/3);

% Convert to solar units*
K1 = K1*Msun^(2/3)/Rsun^4;
K2 = K2*Msun^(1/3)/Rsun^3;
G = G*Msun/Rsun^3;

% Central pressure:
Pc1 = K1*centdens1^(5/3);
Pc2 = K2*centdens2^(4/3);

% Calculate alpha:
alpha1 = sqrt(2.5*Pc1/(4*pi*G*centdens1));
alpha2 = sqrt(4*Pc2/(4*pi*G*centdens2));

% Now we can do the mass/radius relation:
r1 = alpha1.*x1s;
r2 = alpha2.*x2s;
M1=-4*pi*alpha1^3*centdens1.*r1.^2./alpha1^2.*y1s(2,:);
M2=-4*pi*alpha1^3*centdens2.*r2.^2./alpha2^2.*y2s(2,:);

% real data:
Mreal = [0.46 0.50 0.501 0.53 0.59 0.59 0.604 0.70 0.74 1.000];
Rreal = [0.13 0.011 0.0136 0.12 0.011 0.015 0.0096 0.0149 0.01245 0.0084];
Merr  = [0.08 0.05 0.011 0.05 0.06 0.04 0.018 0.12 0.04 0.016];
Rerr  = [0.002 0.001 0.0002 0.0004 0.001 0.001 0.0004 0.001 0.0004 0.0002];

figure('Name','Mass/Radius Relation','NumberTitle','off')
hold all
xlabel ('M/M_{sun}')
ylabel ('r')

plot(M1,r1)
plot(M2,r2)
plot(Mreal,Rreal,'+')
% Something's definitely wrong here, our calculated masses aren't even
% approaching the masses in the provided data table
legend('n=1.5 (non-relativistic)','n=3 (relativistic)','Actual data')
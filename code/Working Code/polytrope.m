% polytrope.m
% Script to solve the Lane-Emden equation and find the dimensionless radius,
% then use this solution to find the mass radius relationship of white
% dwarf stars.
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
title('Solutions to Dimensionless Relativistic and Non-Relativistic Polytropes')
xlabel('\xi')
ylabel('\theta(\xi)')

plot(x1s,y1s(1,:))
plot(x2s,y2s(1,:))
legend('n = 1.5 polytrope: Non-Relativistic','n = 3 polytrope: Relativistic')
fprintf(1,'Enter to continue...\n');
pause;

%==========================================================================

% Mass-Radius Relationship

% All units converted to solar radii and solar masses

h  = (6.626*10^-34)/(((6.955*10^8)^2)*(1.9891*10^30));
n2 = 3;
n1 = 1.5;
mH = (1.672*10^-27)/(1.9891*10^30);
me = (9.109*10^-31)/(1.9891*10^30);
c  = (2.998*10^8)/(6.955*10^8);
G  = (6.67*10^-11)*((1.9891*10^30)/((6.955*10^8)^3));
x1e = x1s(end);
x2e = x2s(end);
y1e = y1s(2,end);
y2e = y2s(2,end);

Knon = ((h^2)/(20*me))*((3/pi)^(2/3))*((1/(mH*2))^(5/3));
Krel = ((h*c)/8)*((3/pi)^(1/3))*((1/(mH*2))^(4/3));

M1 = (0:0.01:2);

CR1 = (((4*pi)/((x1e^(n1+1))*((-y1e)^(n1-1))))^(1/n1)).*(G/(n1+1)).*(M1.^(1-(1/n1)));

R1 = (CR1./Knon).^(1/(1-(3/n1)));

figure(2)
plot(M1,R1);
title('Radius as a Function of Mass: Non-Relativistic Only');
xlabel('M/M_{solar}')
ylabel('R/R_{solar}')
legend('n = 1.5 polytrope')
fprintf(1,'Enter to continue...\n');
pause;

R2 = (0:0.001:2); 

% The term using R2 that 'should' be there is shown, but is not needed
% because it equals one everywhere for the n = 3 polytrope.

CM2 = (((4*pi)/((x2e^(n2+1))*((-y2e)^(n2-1))))^(1/n2))*(G/(n2+1));%.*(R2.^(-1+(3/n2))) 

% M2 is approximately equal to the Chandrasekhar mass of 1.44 solar masses

M2 = (CM2/Krel)^(1/(-1+(1/n2)));

fprintf('\n')
fprintf('Chandrasekhar mass M2 = %f\n',M2)
fprintf('\n')
fprintf(1,'Enter to continue...\n');
pause;

% Combining the pressures. A 'root-finder-like' for loop finds the
% value of the constant which needs to be included in the equation in order
% to make the radius go to zero at 1.44 solar masses (the Chandrasekhar
% limit). The constant here is given by w.
% The imaginary parts warned of in the command prompt come from the
% function after it crosses radius = 0 and also at the first value, which
% is NaN.

tol = 10^(-4);
a = 0;
b = 2;
w = 1;
M = 1.44;

for i = 1:1000
    
    R = sqrt(((w.*(1./((G^2).*(M.^4))) - (5.4707*10^12)./(M.^(8/3)))./(4.7338*10^16)).*M.^(10/3));
    tf = isreal(R);
    
    if R < tol && tf ~= 0
        break
    end
    if tf == 1
        b = w;
        w = (w+a)/2;
    end 
    if tf == 0
        a = w;
        w = (w+b)/2;
    end
end
 
M = (0:0.001:2);

R = sqrt(((w.*(1./((G^2).*(M.^4))) - (5.4707*10^12)./(M.^(8/3)))./(4.7338*10^16)).*M.^(10/3));

figure(3)
plot(M,R,M1,R1)
title('Radius as a Function of Mass');
xlabel('M/M_{solar}')
ylabel('R/R_{solar}')
legend('Combined Polytrope','Non-Relativistic')
fprintf(1,'Enter to continue...\n');
pause;

% real data:
Mreal = [0.46 0.50 0.501 0.53 0.59 0.59 0.604 0.70 0.74 1.000];
Rreal = [0.13 0.011 0.0136 0.12 0.011 0.015 0.0096 0.0149 0.01245 0.0084];
Merr  = [0.08 0.05 0.011 0.05 0.06 0.04 0.018 0.12 0.04 0.016];
Rerr  = [0.002 0.001 0.0002 0.0004 0.001 0.001 0.0004 0.001 0.0004 0.0002];

figure(4)
hold all
title('Mass/Radius Relation with Observed Data');
xlabel('M/M_{solar}')
ylabel('R/R_{solar}')
plot(M,R,M1,R1)
errorbar(Mreal, Rreal, Rerr, '+')
legend('Combined Polytrope','Non-Relativistic','Data')
%Matlab's ode solver
%-----------------------------------------------------------------
clc;
clear;
close all;
%-----------------------------------------------------------------

%n = [0 0.5 1 1.5 2 2.5 3]; % Attempting to make plots with multiple n, but
% this isn't going to work with how ode45 does function handles. -Erin

% I am going to look into Matlab's file I/O & make .csv files to plot in
% gnuplot.
h = 0.001;
y0 = 1;
w0 = 0;
x0 = 0.0001;
x1 = 15;
f = @Mfxy1;

%xarr = cell(size(n));
%yarr = cell(size(n));

%-----------------------------------------------------------------

Xspan = [x0 x1];

%for i=1:size(n,2)
[xs,ys] = ode45(f,Xspan,[y0 w0]);

%xarr(i) = {xs(:,1)};
%yarr(i) = {ys(:,1)};
%end

figure(2)
hold all
%for i=1:size(n)
%plot(xarr{i},yarr{i})
plot(xs,ys(:,1));
%end
% Insert root finder
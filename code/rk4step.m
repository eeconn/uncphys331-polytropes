% Homework #7
% function y = rk4step(y,f,x,h)
%
% Advancing solution by one single RK4 step.
%
% input:
%   y      : initial y value, scalar
%   f      : inline function (RHS of ODE)
%   x      : starting x.
%   h      : stepsize
% output:
%   y      : updated result
%---------------------------------------

function u = rk4step(u,f,x,h)
      
      K1 = h*f(x,u(1));
      K2 = h*f(x + h/2,u(1) + K1/2);
      K3 = h*f(x + h/2,u(1) + K2/2);
      K4 = h*f(x + h,u(1) + K3);
      
      u(1) = u(1) + (K1 + K4)/6 + (K2 + K3)/3;
      
      L1 = h*f(x,u(2));
      L2 = h*f(x + h/2,u(2) + L1/2);
      L3 = h*f(x + h/2,u(2) + L2/2);
      L4 = h*f(x + h,u(2) + L3);
      
      u(2) = u(2) + (L1 + L4)/6 + (L2 + L3)/3;

  return
end

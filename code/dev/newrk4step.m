% function y = newrk4step(y,f,x,h)
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

function y = newrk4step(y,f,x,h)
      
      K1 = h*f(x,y);
      K2 = h*f(x + h/2,y + K1/2);
      K3 = h*f(x + h/2,y + K2/2);
      K4 = h*f(x + h,y + K3);
      y = y + (K1 + K4)/6 + (K2 + K3)/3;

  return
end

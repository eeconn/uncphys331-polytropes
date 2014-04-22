% nonrel.m
% Defines a system of 1st order differential equations representing the
% Lane-Emden equation for a polytrope with index 1.5 (for a distribution of
% non-relativistic degenerate electrons)
% --------------------------------------
% 2014-04-13 13:47 eeconn: copied from Mfxy1.m

function [dy] = nonrel(x,y)

  n  = 1.5;
  dy = zeros(2,1);

  dy(1) = y(2);
  dy(2) = -y(1)^n - ((2/x)*y(2)); %w0 is initial guess
  
  return
end


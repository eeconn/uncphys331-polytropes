% lesolve.m
% Function to solve the Lane-Emden equation using a modified Runge-Kutta 4th
% degree "fixed-step" solver. To obtain arbitrary precision in the root
% (dimensionless radius of the stellar surface) of the solution, the function
% backs up a step and halves the step size when the solution becomes negative.
%
% Inputs:
% iter      integer number of iterations; iteration stops when this is reached
% f         function handle containing the system of differential equations
% x0        initial radius (=0)
% y0        initial theta (functon of density) = 1
% h         intial step size
% iinteg    indicates an integrator to use (left over from odesolverstep.m,
%           we're not using it)
% 
% Outputs:
% x         nx1 vector of xi values in the solution
% y         nx2 matrix - row 1 is the solution (theta), row 2 is its 1st
%           derivative
%---------------------------------------
% 2014-04-13 13:41 eeconn: Renamed from newodesolverstep.m

function [x,y] = newodesolverstep(iter,f,x0,y0,h,iinteg)
  
  y(:,1) = y0;
  x(1) = x0;
 
  switch iinteg
          
      case 2
          
          singlestep = @newrk4step;
          
  end
  
  r = 1;
  
  for i=1:iter
      
      x(r+1) = x(r) + h;
      y(:,r+1) = singlestep(y(:,r),f,x(r),h);
      
      if y(1,r+1) < 10^(-10) && y(1,r+1) > 0
                    
          break
      end
      
      if y(1,r+1) < 0
          
          h = h/2;
          r = r-1;
          
      end         
      
       r = r+1;
      
  end

  return
end

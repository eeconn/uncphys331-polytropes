% Homework #7a
% function [x,y] = ode_fixedstep(nstep,f,x0,y0,x1,iinteg)
%
% Solving an ordinary differential equation
% using fixed step size.
%
% input:
%   nstep  : number of steps
%   f      : inline function (RHS of ODE)
%   x0     : starting x.
%   y0     : starting y (scalar).
%   x1     : end x.
%   iinteg : integrator: 0: Euler
%                        1: Runge-Kutta 2nd order
%                        2: Runge-Kutta 4th order
% output:
%   x      : positions of n+1 steps (we'll need this for
%            consistency with adaptive step size integrators later)
%   y      : (nstep+1,1) vector of resulting y's
%
% comment  : Determine dx from the given stepsize and the integration
%            boundaries. Then use MatLab's switch statement to choose
%            between the integrators. The integrators you will have to
%            provide through functions eulerstep, rk2step, rk4step.
%            Each of them does just one single step.
%---------------------------------------

function [x,u] = ode_stepper(nstep,f,xs,us,x1,iinteg)

  x    = zeros(1,nstep+1);
  u    = zeros(nstep+1,nstep+1);
  h    = (x1 - xs)/nstep;%how do we determine this?
  u(1,1) = us;
  x(1) = xs;
 
  switch iinteg
          
      case 1
          
          singlestep = @rk4step;
          
  end
  
  for i=1:nstep
      
      x(i+1) = x(i) + h;
      u(i+1,i+1) = singlestep(u(i,i),f,x(i),h);
      
      if 
      
  end

  return
end

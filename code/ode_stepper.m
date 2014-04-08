% function [x,u] = ode_stepper(nstep,f,xs,us,x1,iinteg)
%
% xe will be the free boundary condition if we come up with it. Otherwise we
% will ignore it. Possibly use the switch case to include both the free
% boundary and tolerance methods in the same piece of code...
%---------------------------------------

function [x,u] = ode_stepper(nstep,f,xs,us,xe,iinteg)
  x    = zeros(1,nstep+1);
  u    = zeros(nstep+1,nstep+1);
  h    = (xe - xs)/nstep;         %how do we determine this?
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

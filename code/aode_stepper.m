% function [x,u] = ode_stepper(nstep,f,xs,us,x1,iinteg)
%
% nstep: I left this in just because
% f: function of x and u. f(x, u(1)) = first derivative. with u(2) it is
%                                      the second
% u: array, where u(1) = theta. u(2) = theta'
% xs: xstart
% us: vector for ustart
% iter is some max iteration. Have not implemented it yet
% iinteg:
% Possibly use the switch case to include both the free
% boundary and tolerance methods in the same piece of code...
%---------------------------------------

function [x,u] = aode_stepper(nstep,f,xs,us,iter,iinteg)

  x    = zeros(1,nstep+1);
  u    = zeros(nstep+1,nstep+1);
  u1    = zeros(nstep+1,nstep+1);
  u2    = zeros(nstep+1,nstep+1);
  h    = (xe - xs)/nstep;         %how do we determine this without having an xe?
  u(1,1) = us;                    %Adaptive step the whole thing?
  x(1) = xs;
 
  switch iinteg
          
      case 1
          
          singlestep = @rk4step;
          
  end
  
  r = 1;
  
  for i=1:iter
      for j=1:iter
          
         u1(r+1,r+1) = singlestep(u(r,r),f,x(r),h); 
         
         u2(r+1/2,r+1/2) = singlestep(u(r,r),f,x(r),h/2);
         
         x(r+1/2) = x(r) + h/2;
         u2(r+1,r+1) = singlestep(u(r+1/2,r+1/2),f,x(r+1/2),h/2);
         
         x(r+1) = x(r+1/2) + h/2;
         
         if abs(u2(r+1,r+1) - u1(r+1,r+1)) < 0.01
             
             h = 2*h;
         
         elseif abs(u2(r+1,r+1) - u1(r+1,r+1)) > 1
             
             h = h/2;
             
         else
             
             u(j+1,j+1) = u1(r+1,r+1);
             x(j+1) = x(r+1);
             
             break
         end
      end
      
      
      for k = 1:iter                     %Here is the "tolerance section. I
                                         %am not sure what the limits should be, 
          if u(1) < 0                    %but whatever.
          
              h = h/2;
              u(r+1,r+1) = singlestep(u(r,r),f,x(r),h);
          else
              break
          end
      end
      
      if u(1) < 10^-10
              break
      end
  end                  
      
  return
end

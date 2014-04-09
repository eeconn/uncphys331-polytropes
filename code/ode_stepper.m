% function [x,u] = ode_stepper(nstep,f,xs,us,x1,iinteg)
%
% xe will be the free boundary condition if we come up with it. Otherwise we
% will ignore it. Possibly use the switch case to include both the free
% boundary and tolerance methods in the same piece of code...
%---------------------------------------

function [x,u] = ode_stepper(nstep,f,xs,us,xe,iinteg)

  x    = zeros(1,nstep+1);
  u    = zeros(nstep+1,nstep+1);
  h    = (xe - xs)/nstep;         %how do we determine this without having an xe?
  u(1,1) = us;                    %Adaptive step the whole thing?
  x(1) = xs;
 
  switch iinteg
          
      case 1
          
          singlestep = @rk4step;
          
  end
  
  r = 1;
  
  for i=1:nstep
      for j=1:iter
          
         u1(r+1,r+1) = singlestep(u(r,r),f,x(r),h); 
         u2(r+1/2,r+1/2) = singlestep(u(r,r),f,x(r),h/2);
         u2(r+1,r+1) = singlestep(u(r+1/2,r+1/2),f,x(r+1/2),h/2);
         
         if abs(u2(r+1,r+1) - u1(r+1,r+1)) < 0.01
             
             h = 2*h;
         
         elseif abs(u2(r+1,r+1) - u1(r+1,r+1)) > 1
             
             h = h/2;
             
         else
             
             u(j,j) = u1(r+1,r+1);
             break
         end
      end
      
      x(i+1) = x(i) + h;
      u(i+1,i+1) = singlestep(u(i,i),f,x(i),h);  
            
      if u(1) < 10^-10
          break
      end
          
      if u(1) < 0
          
          h = h/2;
          
      end    
      
  end

  return
end

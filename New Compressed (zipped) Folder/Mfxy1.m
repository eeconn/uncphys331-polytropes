function [dy] = Mfxy1(x,y)

  n  = 3;%1,2,4,5
  dy = zeros(2,1);

  dy(1) = y(2);
  dy(2) = -y(1)^n - ((2/x)*y(2)); %w0 is initial guess
  
  return
end


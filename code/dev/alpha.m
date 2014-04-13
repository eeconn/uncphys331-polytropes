% alpha.m
% Function defining the proportionality constant for the polytropic
% dimensionless radius
% Inputs
% ======
% n     polytropic index
% centdens  central density (units?)
% centP     central pressure (units?)

function a = alpha(n,centdens,centP)

    G = 6.67*10^(-11);  % Newton's gravitational constant (Units? Currently Nm^2/kg^2)

    a = sqrt( ((n+1)*centP)/(4*pi*G*centdens^2));

    return
end

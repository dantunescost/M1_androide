function fmax = max_frequency(theta, T0 )
% theta is assume to be given in degrees (convert to radian before computing sin/cos)
  f0 = 1/T0;
  thetaRad = degtorad(theta);
  fmax= max(f0 * cos(thetaRad), f0 * sin(thetaRad));
end
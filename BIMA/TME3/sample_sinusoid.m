function [I,Ie] = sample_sinusoid(amplitude,taille,T0,theta,ratio)
 fn = max(2* (1/T0) * cos(degtorad(theta)), 2 * (1/T0) * sin(degtorad(theta)));

 I=sinusoid2d(amplitude, theta, taille, T0, 1); 

 Ie=sinusoid2d(amplitude, theta, taille, T0, 1 + floor(1/(ratio * fn)));
end
function [I, Ie, Ir] = sample_reconstruction(A,taille,T0,theta,ratio) 
  [I,Ie] = sample_sinusoid(A, taille, T0, theta, ratio);
  fn = max(2* (1/T0) * cos(degtorad(theta)), 2 * (1/T0) * sin(degtorad(theta)));
  Ir=shannon_interpolation(Ie,taille,1 + floor(1/(ratio * fn)));
end


function [I,Ie] = sample_sinusoid(amplitude,taille,T0,theta,ratio)
 fn = max(2* (1/T0) * cos(degtorad(theta)), 2 * (1/T0) * sin(degtorad(theta)));

 I=sinusoid2d(amplitude, theta, taille, T0, 1); 

 Ie=sinusoid2d(amplitude, theta, taille, T0, 1 + floor(1/(ratio * fn)));
end


function image = sinusoid2d(amplitude, theta,taille, TO,Te)

f0 = 1/TO; 
theta1 = theta/180*pi;

if(Te==1)
    image = zeros(taille,taille);
    for i=1:Te:taille;
        for j=1:Te:taille;
            in =  (i-1)*cos(theta1) - (j-1)*sin(theta1);
            image(i,j) = ( amplitude * cos(2*pi*(f0*in)));
        end
    end
else
    image = zeros(floor(taille/Te),floor(taille/Te));
    for i=1:Te:taille;
        for j=1:Te:taille;
            in =  (i-1)*cos(theta1) - (j-1)*sin(theta1);
            image(floor(i/Te)+1,floor(j/Te)+1) = ( amplitude * cos(2*pi*(f0*in)));
        end
    end
end
end


function [ imr ] = shannon_interpolation ( ime , taille , Te)

A = zeros(size(ime,1),taille);
for j=1:size(ime,1)
    for i=1:taille
        A(j,i) = cardinal_sine(pi*( (i-1)/Te - (j-1)) );
        %A(j,i) = sinc(( (i-1)/Te - (j-1)) );
    end
end


B = A';


imr = B * ime * A;


end



function [ val ] = cardinal_sine( x )
    val = 1;
    if(x~=0)
        val = sin(x)/x;
    end
end
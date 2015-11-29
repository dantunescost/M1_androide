function R = calculR(I,t)
  [Ix,Iy] = compute_gradient(I);
  Ix2 = Ix .^ 2;
  Iy2 = Iy .^ 2;
  Ixy = Ix .* Iy;
  h = gauss1d(t);
  Ix2 = convolution_separable(Ix2,h',h);
  Iy2 = convolution_separable(Iy2,h',h);
  Ixy = convolution_separable(Ixy,h',h);
  detM = Ix2 .* Iy2 - Ixy.^2;
  trM = Ix2 +  Iy2;
  R = detM - 0.04 * trM.^2 ;
end 

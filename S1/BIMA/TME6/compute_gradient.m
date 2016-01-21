function [Ix,Iy] = compute_gradient(I)
  h1x = [-1 0 1];
  h1y = [0;1;0];
  h2x = [0 1 0];
  h2y = [-1;0;1];
  Ix = convolution_separable(I,h1x,h1y);
  Iy = convolution_separable(I,h2x,h2y);
end
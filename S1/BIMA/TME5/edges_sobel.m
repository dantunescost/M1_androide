function [J] = edges_sobel(I,t)
  I = double(I);
  Gx = [-1 0 1;-2 0 2;-1 0 1];
  Gy = [-1 -2 -1;0 0 0; 1 2 1];
  Ix = convolution(I,Gx); 
  Iy = convolution(I,Gy);

  MG = sqrt(Ix.*Ix + Iy.*Iy);
  J = image_binarization(MG,t);
end
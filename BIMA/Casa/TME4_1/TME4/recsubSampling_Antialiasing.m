function [I1,I2,FT1,FT2] = recsubSampling_Antialiasing(I)
  I1=frequential_filtering(I, antiAliasingFilter(size(I,1), size(I,2)));
  I1= subSampling2(I1);
  I2= subSampling2(I1);
  FT1= log(1+abs(fftshift(fft2(I1))));
  FT2= log(1+abs(fftshift(fft2(I2))));
end
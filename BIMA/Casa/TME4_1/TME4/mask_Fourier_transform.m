function Hf = mask_Fourier_transform(h)
  Hf = zeros(512,512);
  for i = 1:size(h,1)
    for j = 1:size(h,2)
      Hf(i,j) = h(i,j);
    end
  end
  Hf = abs(fftshift(fft2(Hf)));
end

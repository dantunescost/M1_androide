function If = low_pass_filtering(I , fc)
  h = ideal_low_pass_Filter( size(I,1), size(I,2), fc);
  If=fftshift(fft2(I));
  If = If .* h;
  If = abs(ifft2(ifftshift(If)));
end

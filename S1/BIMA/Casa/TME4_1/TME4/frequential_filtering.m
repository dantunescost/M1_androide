function If = frequential_filtering(I,H)
 If= fftshift(fft2(I));
 If= If .* H;
 If= abs(ifft2(ifftshift(If)));
end
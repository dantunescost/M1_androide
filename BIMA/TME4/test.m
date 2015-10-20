I = imread('mandrill.png');
TF = fftshift(fft2(I));
TF = abs(TF);
TF = log(1+TF);

figure();
subplot(1,2,1);
imagesc(I);
subplot(1,2,2);
imagesc(TF);
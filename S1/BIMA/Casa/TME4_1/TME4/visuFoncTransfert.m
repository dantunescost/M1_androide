fm3 = (1/9) * ones(3,3);
fm5 = (1/25) * ones(5,5);
fm7 = (1/49) * ones(7,7);

foTr3 = mask_Fourier_transform(fm3);
foTr5 = mask_Fourier_transform(fm5);
foTr7 = mask_Fourier_transform(fm7);


figure();
subplot(1,3,1);
imagesc(foTr3);
colormap(gray);
subplot(1,3,2);
imagesc(foTr5);
colormap(gray);
subplot(1,3,3);
imagesc(foTr7);
colormap(gray);
I = imread('lena.jpg');

fm3 = (1/9) * ones(3,3);
fm5 = (1/25) * ones(5,5);
fm7 = (1/49) * ones(7,7);

Im3 = convolution(I, fm3);
Im5 = convolution(I, fm5);
Im7 = convolution(I, fm7);


figure();
subplot(1,4,1);
imagesc(I);
subplot(1,4,2);
imagesc(Im3);
colormap(gray);
subplot(1,4,3);
imagesc(Im5);
colormap(gray);
subplot(1,4,4);
imagesc(Im7);
colormap(gray);
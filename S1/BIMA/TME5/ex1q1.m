I = imread('lena.gif');
t = 70;
Ir = edges_sobel(I,t);

figure();
subplot(1,2,1), imagesc(I);
colormap(gray);
title('Image originale');
subplot(1,2,2), imagesc(Ir);
title('Notre résultat')
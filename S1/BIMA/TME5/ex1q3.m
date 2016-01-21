I = imread('lena.gif');
t = 65;
Is = edges_sobel(I,t);
Il = edges_laplacian(I,t);

figure();
subplot(1,3,1), imagesc(I);
colormap(gray);
title('Image originale');
subplot(1,3,2), imagesc(Is);
title('Détection Sobel');
subplot(1,3,3), imagesc(Il);
title('Détection Laplacien');


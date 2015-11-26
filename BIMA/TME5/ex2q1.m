I = imread('tools.gif');

Gx = [-1 0 1;-2 0 2;-1 0 1];
Gy = [-1 -2 -1;0 0 0; 1 2 1];
Ix = convolution(I,Gx); 
Iy = convolution(I,Gy);
IG = sqrt(Ix.*Ix + Iy.*Iy);

Io = orientation(Ix,Iy,IG);

figure();
subplot(1,3,1), imagesc(I);
colormap('gray');
title('Image originale');
subplot(1,3,2), imagesc(IG);
title('Image module gradient');
subplot(1,3,3), imagesc(Io);
title('Image orientation gradient');
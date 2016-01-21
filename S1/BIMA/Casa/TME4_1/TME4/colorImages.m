I1 = imread('clown.bmp');
I2 = imread('CLOWN_LUMI.BMP');

[ Ir,Iv, Ib ] = colormaps(I1);

I3 = swap_color_maps(I1, 2, 3);
I4 = swap_color_maps(I1, 1, 2);

R = chanel_in_color(I1(:,:,1),1);
V = chanel_in_color(I1(:,:,2),2);
B = chanel_in_color(I1(:,:,3),3);

figure();
subplot(2,5,1);
imagesc(uint8(I1));
subplot(2,5,2);
imagesc(I2);
colormap(gray);
subplot(2,5,3);
imagesc(Ir);
colormap(gray);
subplot(2,5,4);
imagesc(Iv);
colormap(gray);
subplot(2,5,5);
imagesc(Ib);
colormap(gray);
subplot(2,5,6);
imagesc(I3);
subplot(2,5,7);
imagesc(I4);
subplot(2,5,8);
imagesc(uint8(R));
subplot(2,5,9);
imagesc(uint8(V));
subplot(2,5,10);
imagesc(uint8(B));


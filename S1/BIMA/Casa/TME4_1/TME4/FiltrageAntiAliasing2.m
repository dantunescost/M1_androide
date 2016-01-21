I=imread('mandrill.png'); 

I1=frequential_filtering(I, antiAliasingFilter(size(I,1), size(I,2)));
I1= subSampling2(I1);
I2= subSampling2(I1);

I1br= subSampling2(I);
I2br= subSampling2(I1br);

FT0= log(1+abs(fftshift(fft2(I))));
FT1= log(1+abs(fftshift(fft2(I1))));
FT2= log(1+abs(fftshift(fft2(I2))));
FT3= log(1+abs(fftshift(fft2(I1br))));
FT4= log(1+abs(fftshift(fft2(I2br))));


figure();
subplot(2,5,1);
imagesc(I);
colormap(gray);
subplot(2,5,2);
imagesc(I1);
colormap(gray);
subplot(2,5,3);
imagesc(I2);
colormap(gray);
subplot(2,5,4);
imagesc(I1br);
colormap(gray);
subplot(2,5,5);
imagesc(I2br);
colormap(gray);
subplot(2,5,6);
imagesc(FT0);
colormap(gray); 
subplot(2,5,7);
imagesc(FT1);
colormap(gray); 
subplot(2,5,8);
imagesc(FT2);
colormap(gray);
subplot(2,5,9);
imagesc(FT3);
colormap(gray);
subplot(2,5,10);
imagesc(FT4);
colormap(gray);
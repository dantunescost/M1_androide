I = imread('mandrill.png');
J = imread('lena.jpg');

If1 = low_pass_filtering(I, size(I,1)/8) ;
Jf1 = low_pass_filtering(J, size(J,1)/8);

If2 = low_pass_filtering(I, size(I,1)/16);
Jf2 = low_pass_filtering(J, size(J,1)/16);


figure();
subplot(2,3,1);
imagesc(I);
colormap(gray);
subplot(2,3,2);
imagesc(If1);
colormap(gray);
subplot(2,3,3);
imagesc(If2);
colormap(gray);
subplot(2,3,4);
imagesc(J);
colormap(gray);
subplot(2,3,5);
imagesc(Jf1);
colormap(gray); 
subplot(2,3,6);
imagesc(Jf2);
colormap(gray);
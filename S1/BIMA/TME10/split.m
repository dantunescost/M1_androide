I1 = imread('cygnus.tif');
I2 = imread('house2.png');
I3 = imread('muscle.pgm');

I1 = expand(I1);
I2 = expand(I2);
I3 = expand(I3);

thresh = 22;
mindim = 2;

S1 = qtdecomp(I1,thresh,mindim); 
S2 = qtdecomp(I2,thresh,mindim);
S3 = qtdecomp(I3,thresh,mindim);

figure();
subplot(2,3,1);
imagesc(I1);
title('cygnus.tif original');
colormap(gray);

subplot(2,3,2);
imagesc(I2);
title('house2.png original');

subplot(2,3,3);
imagesc(I3);
title('muscle.pgm original');

subplot(2,3,4);
imagesc(quaddraw(I1,S1)/255);
title('');

subplot(2,3,5);
imagesc(quaddraw(I2,S2)/255);
title('');

subplot(2,3,6);
imagesc(quaddraw(I3,S3)/255);
title('');
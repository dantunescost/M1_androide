I1 = imread('cygnus.tif');
I2 = imread('house2.png');
I3 = imread('muscle.pgm');

I1 = expand(I1);
I2 = expand(I2);
I3 = expand(I3);

thresh = [5 3 4];
thresh2  = [10 35 42];
mindim = [2 4 2];

S1 = qtdecomp(I1,thresh(1),mindim(1)); 
S2 = qtdecomp(I2,thresh(2),mindim(2));
S3 = qtdecomp(I3,thresh(2),mindim(3));

F1 = fusiong(S1,I1,thresh2(1));
F2 = fusiong(S2,I2,thresh2(2));
F3 = fusiong(S3,I3,thresh2(3));


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
imagesc(label2rgb(F1));
title('');

subplot(2,3,5);
imagesc(label2rgb(F2));
title('');

subplot(2,3,6);
imagesc(label2rgb(F3));
title('');
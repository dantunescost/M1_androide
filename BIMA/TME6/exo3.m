load('toyHorse1.mat');
load('toyHorse2.mat');

Ri = calculR(I1,15);
Rj = calculR(I2,15);

Rfi = post_processing(Ri,100);
Rfj = post_processing(Rj,100);

figure();
subplot(2,3,1);
imagesc(I1);
subplot(2,3,2);
imagesc(Ri);
subplot(2,3,3);
imagesc(Rfi);
subplot(2,3,4);
imagesc(I2);
subplot(2,3,5);
imagesc(Rj);
subplot(2,3,6);
imagesc(Rfj);
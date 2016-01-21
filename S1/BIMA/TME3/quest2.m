I = sinusoid2d(10,10,512,64,1);


fm = max(2* (1/64) * cos((pi*10)/180), 2 * (1/64) * sin((pi*10)/180) );
Ie = sinusoid2d(10,10,512,64,1/(0.75 * fm));
Ieft = abs(fftshift(fft2(Ie)));
Ir=reconstruction(Ie,1/(0.75 * fm),512);

colormap('gray');
figure();
subplot(1,4,1);
imagesc(I);
subplot(1,4,2);
imagesc(Ie);
subplot(1,4,3);
mesh(Ieft);
subplot(1,4,4);
imagesc(Ir);


erreur(Ir, I)
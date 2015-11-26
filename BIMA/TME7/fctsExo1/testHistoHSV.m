clear all;
close all;


%%%%%%%%%% A Completer %%%%%%%%%% 
PathImage = '../Base/';
nom = 'Paysages67.png';


% Quantif HSV : Completer avec votre nombre de bins
nH = 34;
nS = 34;
nV = 34;

filename= nom;
I=imread([PathImage,filename]);
I=double(I);
I = I ./ 65535;

figure();
imagesc(I);

% conversion RGB->HSV
J = rgb2hsv(I);

[ palette,palette2 ] = calculPalette( nH, nS , nV );

%%%%%%%%%% COMPL�TER AVEC VOTRE FONCTION DE CALCUL D'HISTOGRAMME HSV %%%%%%%%%% 
[Iq , histo] = image_quantization(J,nH,nS,nV);

% Visualisation de l'image quantifi�e
visuQuantification( Iq , palette2);

% transformation de l'histogramme en 1 vecteur 1D
histo = histo(:);
% COMPL�TER AVEC VOTRE FONCTION DE NORMALISATION D'HISTOGRAMME
histo = normalise(histo);
 
figure();
plot(histo);

affiche5dominantes( histo , palette )
[Y,Ind] = sort(histo,'descend');




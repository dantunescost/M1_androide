pathBase = '../Base/';

[imaTab, imaTabTest] = chargeXTrainTest(pathBase);
X_moy=image_moy(imaTab);
imaTabCentre = visage_centre(imaTab, X_moy);

[u, Lambda] = eigenfaces(imaTabCentre);
% u = reshape(u,size(imaTab,1),size(imaTab,2),size(imaTab,3));
X = zeros(4096,1);
X = reshape(imaTab(:,:,50), [size(X,1) * size(X, 2),1]);
X_moy = reshape(X_moy, [size(X,1) * size(X, 2),1]);

affiche_Reconstruction(X,X_moy,u);

X = reshape(imaTab(:,:,55), [size(X,1) * size(X, 2),1]);

affiche_Reconstruction(X,X_moy,u);

X = reshape(imaTabTest(:,:,17), [size(X,1) * size(X, 2),1]);

affiche_Reconstruction(X,X_moy,u);

afficher_moy_err(reshape(imaTab,[4096,90]),X_moy,u);
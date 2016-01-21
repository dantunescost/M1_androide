function Er = affiche_Reconstruction(X, X_moy, W)
    K = [5,10,25,50,90];

    figure();
    
    subplot(2,3,1);
    imagesc(reshape(X,64,64));
    title('Depart');
    
    
    for i=1:5
        Z_proj = calculeProj(X, X_moy, K(i), W);
        Z_r = reconstruction(Z_proj, X_moy, W, K(i));
        Er = erreur_Reconstruction(Z_r, X);
        
        subplot(2,3,i+1);
        imagesc(reshape(Z_r,64,64));
        title(Er);
    end


end
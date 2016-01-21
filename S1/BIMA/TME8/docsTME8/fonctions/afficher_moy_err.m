function tab = afficher_moy_err(X, X_moy,W)
    tab = zeros(90,1);
    for i=1:size(W,2)
        Er = 0;
        for j=1:size(X,2)
            Z_proj = calculeProj(X(:,j),X_moy, i,W);
            Z_r = reconstruction(Z_proj,X_moy,W,i);
            Er = Er + erreur_Reconstruction(Z_r,X(:,j));
        end
        tab(i) = Er/90;
    end
    figure();
    plot(tab);
end
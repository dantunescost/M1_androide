function Zr = reconstruction(Z_proj, X_moy, W, K)
    Zr = X_moy + W(:,1:K) * Z_proj;
end
function eps = erreur(imager,imaged)
    eps = 0;
    for i=1 : size(imager,2)
        for j=1 : size(imager,1)
            eps = eps + abs(imager(i,j)-imaged(i,j));
        end
    end
    eps = eps/(2 * size(imager,1) * size(imager,1));
end
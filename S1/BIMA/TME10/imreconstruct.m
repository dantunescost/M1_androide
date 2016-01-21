function IM = myimreconstruct(Marker,Mask)
    %%% Réalise une reconstruction par ouverture
    B = ones(3,3);
    h1 = Marker;
    h2 = imdilate(h1,B) & Mask;
    while isequal(h1,h2) == 0,
        h1 = h2;
        h2 = imdilate(h1,B)& Mask;
    end
    IM = h2;   
end

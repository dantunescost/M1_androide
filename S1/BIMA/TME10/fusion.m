function B = fusion(S,I,thresh)
%%% Fusion locale
    B = zeros(size(I));
    % taille du plus grand bloc
    kmax = full(max(S(:)));
    for k=1:kmax,
        % liste des blocs de taille k
        [vals,i,j] = qtgetblk(I,S,k);
        if ~isempty(vals),
            for l=1:length(i),
                x=i(l); y = j(l);
                bloc=I(x:x+k-1,y:y+k-1);
		% prédicat
                if std2(bloc) < thresh,
                  B(x:x+k-1,y:y+k-1)=1;
                end
            end
        end
    end
    B = bwlabel(B);
end

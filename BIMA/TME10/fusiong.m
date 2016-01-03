function B = fusiong(S,I,thresh)
%%% Fusion globale
    B = zeros(size(I));
    % taille du plus grand bloc
    kmax = full(max(S(:)));
    % stats région fusionnée
    n1 = 0; mu1 = 0; var1 = 0;
    for k=1:kmax,
        % liste des blocs de taille k
        [vals,i,j] = qtgetblk(I,S,k);
        if ~isempty(vals),
            for l=1:length(i),
                x=i(l); y = j(l);
                bloc=I(x:x+k-1,y:y+k-1);
		% stats bloc en cours
		n2 = k*k;
		mu2 = mean2(bloc);
		var2 = std2(bloc)^2;	
		% stats région fusionnée
		n = n1+n2;
		mu = (n1*mu1+n2*mu2)/n;
		var = (n1*(var1+mu1^2) + n2*(var2+mu2^2))/n - mu^2;
		% prédicat
                if sqrt(var) < thresh,
                  B(x:x+k-1,y:y+k-1)=1;
		  % maj des stats
		  n1 = n;
		  mu1 = mu;
		  var1 = var;
                end
            end
        end
    end
    n 
    [mu1 sqrt(var)]
    B = bwlabel(B);
end

function Q = quaddraw(I,S)
    [n,m] = size(I);
    Q = zeros(n, m, 3);
    Q(:,:,1) = I;
    Q(:,:,2) = I;
    Q(:,:,3) = I;
    kmax = full(max(S(:)));
    for k=1:kmax,
        % liste des blocs de taille k
        [vals,i,j] = qtgetblk(I,S,k);
        if ~isempty(vals),
            for l=1:length(i),
                Q(i(l):i(l)+k-1,j(l),1) = 255;
                Q(i(l):i(l)+k-1,j(l),2) = 0;
                Q(i(l):i(l)+k-1,j(l),3) = 0;
                Q(i(l):i(l)+k-1,j(l)+k-1,1) = 255;
                Q(i(l):i(l)+k-1,j(l)+k-1,2) = 0;
                Q(i(l):i(l)+k-1,j(l)+k-1,3) = 0;
                Q(i(l),j(l):j(l)+k-1,1) = 255;
                Q(i(l),j(l):j(l)+k-1,2) = 0;
                Q(i(l),j(l):j(l)+k-1,3) = 0;
                Q(i(l)+k-1,j(l):j(l)+k-1,1) = 255;
                Q(i(l)+k-1,j(l):j(l)+k-1,2) = 0;
                Q(i(l)+k-1,j(l):j(l)+k-1,3) = 0;
            end
        end
    end            
end
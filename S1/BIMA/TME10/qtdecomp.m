function S = qtdecomp( I, thresh, mindim)
    [n,m]=size(I);
    if n ~= m,
       error( 'image must be squared');
    end
    if n>mindim & mod(n,2) == 0 & std2(I) > thresh,
        n2=n/2;        
        I11 = I(1:n2,1:n2);
        I12 = I(1:n2,n2+1:n);
        I21 = I(n2+1:n,1:n2);
        I22 = I(n2+1:n,n2+1:n);

        S11 = qtdecomp( I11, thresh, mindim);
        S12 = qtdecomp( I12, thresh, mindim);
        S21 = qtdecomp( I21, thresh, mindim);
        S22 = qtdecomp( I22, thresh, mindim);
        
        S = [S11,S12; S21, S22];
    else
        S = sparse(n,n);
        S(1,1) = n;
    end
end

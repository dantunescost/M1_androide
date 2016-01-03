function J = expand(I)
    s = ceil(log2(max(size(I))));
    J = zeros(2^s,2^s);
    J(1:size(I,1),1:size(I,2)) = I;
end
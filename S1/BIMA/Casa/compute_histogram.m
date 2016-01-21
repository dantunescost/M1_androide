function h = compute_histogram(I)
 % return a 256x1 matrix  
 h = zeros(256,1);
 for i = 1:size(I,1)
   for j = 1:size(I,2)
     h(I(i,j) + 1, 1) = h(I(i,j) + 1, 1) + 1;
   end
 end
end
function hc = cumulative_histogramme(I)
  hc= compute_histogram(I);
  for i=2:size(hc,1)
    hc(i,1)=hc(i-1,1) + hc(i,1)
  end
end

function h = compute_histogram(I)
 % return a 256x1 matrix  
 h = zeros(256,1);
 for i = 1:size(I,1)
   for j = 1:size(I,2)
     h(I(i,j) + 1, 1) = h(I(i,j) + 1, 1) + 1;
   end
 end
end
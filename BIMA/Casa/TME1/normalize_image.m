function In = normalize_image(I,k1,k2)
  n=(k2-k1)/(max(max(I))-min(min(I)))
  for i=1:size(I,1)
    for j=1:size(I,2)
      In(i,j)=n*(I(i,j) - min(min(I))) + k1;
    end
  end
end
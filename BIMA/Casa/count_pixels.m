function nb = count_pixels(I, k )
  nb= 0;
  for i=1:size(I,1)
    for j=1:size(I,2)
      if(I(i,j) == k)
        nb = nb + 1;
      end
    end
  end
end

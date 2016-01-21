function Iinv = image_inversion(I)
  Iinv=I;
  for i=1:size(I,1)
    for j=1:size(I,2)
      Iinv(i,j)=255-I(i,j);
    end 
  end
end
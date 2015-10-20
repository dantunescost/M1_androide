function Ib = image_binarization(I,S)
  Ib= I;
  Ib(find(I > S)) = 255;
  Ib(find(I <= S)) = 0;
end
function Rf = post_processing(R,s)
  Rf=image_binarization(R,s);
  for i = 2:size(R,1) - 1
    for j = 2:size(R,2) - 1
      voisins = R(i-1:i+1,j-1:j+1);
      for k = 1:size(voisins,1)
        for l = 1:size(voisins,2)
          if not((k == 2) && (l == 2)) && (R(i,j) <= voisins(k,l))
            Rf(i,j) = 0;
          end
        end
      end
    end
  end
end

function Ib = image_binarization(I,S)
  Ib= I;
  Ib(find(I <= S)) = 0;
  Ib(find(I > S)) = 100;
end
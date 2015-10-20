function [J] = convolution(I,h)
  J = zeros(size(I,1), size(I,2));
  h = rot90(rot90(h));
  n = (size(h,1) - 1) / 2;
  for i = n+1:size(J,1)-n
    for j = n+1:size(J,2)-n
      for k = 1:size(h,1)
        for l = 1:size(h,2)
          J(i,j) = J(i,j) + (I(i+k-n-1, j+l-n-1) * h(k,l));
        end
      end
    end
  end
end
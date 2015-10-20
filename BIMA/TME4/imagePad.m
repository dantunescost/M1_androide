function [J] = imagePad(I,h)
  n = (size(h,1) - 1) / 2;
  for i = 1:(size(I,1) + 2*n)
    for j = 1:(size(I,2) + 2*n)
      if (((i <= n) | (j <= n)) | (i > size(I,1) + n)) | (j > size(I,2) + n)
        J(i,j) = 0;
      else
        J(i,j) = I(i-n, j-n);
      end
    end
  end
end
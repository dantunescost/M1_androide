function J = edges_laplacian(I,t)
  L = [0 -1 0; -1 4 -1; 0 -1 0];
  Il = convolution(I,L);
  
  J = zeros(size(Il,1), size(Il,2));

  for i=2:size(I,1)-1
    for j=2:size(I,2)-1
      max = -1024;
      min = 1024;
      for k=1:3
        for l=1:3
          if( not((k == 2) && (l == 2)) )
            if(Il(i-2+k, j-2+l) > max)
              max = Il(i-2+k, j-2+l);
            else
              if(Il(i-2+k, j-2+l) < min)
                min = Il(i-2+k, j-2+l);
              end
            end
          end
        end
      end
      if( ((max > 0) && (min < 0)) && ((max - min) > t))
        J(i,j) = 1;
      else
        J(i,j) = 0;
      end
    end
  end 
end
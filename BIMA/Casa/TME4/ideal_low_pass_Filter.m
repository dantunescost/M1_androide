function [ F ] = ideal_low_pass_Filter( n, m, fc )
  cn = floor(n/2);
  cm = floor(m/2);
  for i = 1:n
     for j = 1:m
       if sqrt( (cn - i).^2 + (cm - j).^2 ) < fc
         F(i,j) = 1;
       else
         F(i,j) = 0;
       end
     end
  end
end
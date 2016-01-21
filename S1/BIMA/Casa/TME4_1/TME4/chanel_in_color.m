function J = chanel_in_color(I,k)
  J = zeros(size(I,1), size(I,2), 3);
  J(:,:,k)=I;
end
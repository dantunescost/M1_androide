function J = swap_color_maps(I,k1,k2)
  J = I;
  J(:,:,k1) = I(:,:,k2);
  J(:,:,k2) = I(:,:,k1);
end
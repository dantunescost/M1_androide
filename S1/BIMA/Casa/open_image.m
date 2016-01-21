function [n,m,I] = open_image(name)
  I =imread(name);
  n=size(I,1);
  m=size(I,2);

end

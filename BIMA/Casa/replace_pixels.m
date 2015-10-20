function Ir = replace_pixels(I,k1,k2)
  Ir=I;
  Ir(find(I==k1))=k2;
end
function iv = quantization(val,K)
  if (val == 1)
    iv=K;
  else
    iv=floor(val*K) + 1;
  end
end
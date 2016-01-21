function [Iq,hist]= image_quantization(I, nH,nS,nV)
  Iq=I;
  hist=zeros(nH,nS,nV);
  K = nH;

  for i=1:size(I,1)
    for j=1:size(I,2)
      for k=1:size(I,3)
        Iq(i,j,k) = quantization(I(i,j,k),K);
        if(k==1)
          K=nS;
        else
          if(k==2)
            K=nV;
          else
            K=nH;
          end
        end
      end
      hist(Iq(i,j,1),Iq(i,j,2),Iq(i,j,3))=hist(Iq(i,j,1),Iq(i,j,2),Iq(i,j,3))+1;
    end
  end
  
  
  
end
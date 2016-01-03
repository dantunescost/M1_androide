function [varargout] = qtgetblk(I, S, dim)
  if nargin ~= 3,
    usage('[vals,r,c]=qtgetblk(I,S,dim), [vals,idx]=qtgetblk(I,S,dim)');
  end
  if nargout>3,
    usage('[vals,r,c]=qtgetblk(I,S,dim), [vals,idx]=qtgetblk(I,S,dim)');
  end

  [i,j,v]=find(S);

  idx=find(v==dim);
  
  if length(idx)==0,
    for i=1:nargout
      varargout{i}=[];
    end
  else
    r=i(idx);
    c=j(idx);
    
    vals=zeros(dim,dim,length(idx));
    for i=1:length(idx)
      vals(:,:,i)=I(r(i):r(i)+dim-1,c(i):c(i)+dim-1);
    end
    
    varargout{1}=vals;
  
    if nargout==3,
      varargout{2}=r;
      varargout{3}=c;
    elseif nargout==2,
      varargout{2}=(c-1)*rows(I)+r;
    end
    end
 end
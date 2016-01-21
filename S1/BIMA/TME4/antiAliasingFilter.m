function [ F ] = antiAliasingFilter( n,m )

F = zeros(n,m);

fcn = floor(n/4)+1;
fcm = floor(m/4)+1;

nn = floor(n/2)+1;
mm = floor(m/2)+1;


for i=1:n
    for j=1:m
        d1 = abs(i-nn);
        d2 = abs(j-mm);
        
        if(d1<fcn && d2<fcm )
            F(i,j) = 1;
        end
        
    end
end


end


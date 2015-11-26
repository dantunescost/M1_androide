function h = gauss1d( N )

sigma = (N-1)/6;
h = zeros(N,1);

N2 = ceil(N/2);

for i=1:N
    h(i,1) = 1/(sqrt(2*pi)*sigma) * exp (-( (i-N2) * (i-N2) )/(2*sigma*sigma)  );
end

end
function [ J ] = convolution_separable( I, hx , hy )

padding=1; % 0 = zero-padding, 1= recopie

% convloution 1 d selon l'axe des x
d = size(hx,2);
if(size(hx,1)~=1)
    'erreur filtre x pas de bonne dimension'
end

if(mod(d,2)~=1)
    'erreur filtre x paqs de taille impaire'
end

d1 = size(hy,1);

if(size(hy,2)~=1)
    'erreur filtre y pas de bonne dimension'
end

if(mod(d,2)~=1)
    'erreur filtre y paqs de taille impaire'
end

if(d1~=d)
    'erreur'
end


[n,m] = size(I);

t = (d-1)/2;

% Matrice de Toeplitz Tx : taille m+2*t,m
Tx = zeros(m+2*t,m);
for j=1:m 
    Tx(j:j+d-1,j) = hx';
end

% Ip : padding sur les colonnes : taille n,m+2*t
Ip = zeros(n,m+2*t);
Ip(:,t+1:m+t) = I(:,:);

if(padding==1)
    for i=1:t
        Ip(:,i) = I(:,1);
        Ip(:,m+t+i) = I(:,m);
    end
end
% Calcul de la convolution selon le filtre hx
y = Ip * Tx;

% Padding de la réponse selon les lignes : yP taille n+2*t,m
yP = zeros(n+2*t,m);
yP(t+1:n+t,:)=y;

if(padding==1)
    for i=1:t
        yP(i,:) = y(1,:);
        yP(n+t+i,:) = y(n,:);
    end
end


% Matrice de Toeplitz Ty : taille n,n+2*t
Ty = zeros(n,n+2*t);

for i=1:n
    Ty(i,i:i+d-1) = hy';
end

J = Ty * yP;


end


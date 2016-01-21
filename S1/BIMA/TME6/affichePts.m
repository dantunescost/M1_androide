function [ JAff] = affichePts ( J, Bin ,taille_gauss)
     [l,c] = size(J);

     J = normaliseImage( J ,  0.0, 1.0 );

    JAff = zeros(l,c,3);
    JAff(:,:,1) = J(:,:);
    JAff(:,:,2) = J(:,:);
    JAff(:,:,3) = J(:,:);

    taille =floor(taille_gauss/2);
    val = 1;

    for i=1:l
        for j=1:c
            if(Bin(i,j)==100)
                for h=-taille:taille
                    if(and(i+h<=l,i+h>0))
                        JAff(i+h,j,1) = val;
                        JAff(i+h,j,2) = 0;
                        JAff(i+h,j,3) = 0;
                    end
                end
                for h=-taille:taille
                    if(and(j+h<=c,j+h>0))
                        JAff(i,j+h,1) = val;
                        JAff(i,j+h,2) = 0;
                        JAff(i,j+h,3) = 0;
                    end
                end
            end
        end
    end

    %JAff = uint8(JAff);


    function [ J ] = normaliseImage( I ,  k1, k2 )
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here

    I = double(I);
    m = min(min(I));
    M=max(max(I));

     J = zeros(size(I));
    for i=1:size(I,1)
        for j=1:size(I,2)
            J(i,j) = ( (k2-k1)/(M-m) * (I(i,j)-M) ) +k2  ;
        end    
    end


    m = min(min(J));
    M=max(max(J));


    end


end


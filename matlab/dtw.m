function [res] = dtw( reco, ref )

L = size(reco,1);
n = size(reco,2);
p = size(ref, 2);
%Construction de la matrice des distances locales

distLoca = zeros(n,p);
for i=1:n
   for j=1:p
       for k=1:L
           distLoca(i,j) = distLoca(i,j) + (reco(k,i) - ref(k,j))^2;
       end
       distLoca(i,j) = sqrt(distLoca(i,j));
   end
end

%Construction de la matrice des distances globales

distGlob = ones(n,p) * (+inf);
distGlob(1,1) = distLoca(1,1);
for i=1:n
    for j=1:p
        if i ~=1 && j ~= 1
            if i > 1 && j > 1
                minimum = min([distGlob(i-1,j-1) distGlob(i,j-1) distGlob(i-1,j)]);
            elseif i==1 && j>1
                minimum = distGlob(i,j-1);
            elseif i>1 && j==1
                minimum = distGlob(i-1,j);
            end
            distGlob(i,j) = distLoca(i,j) * minimum;
        end
    end
end

res = distGlob(n,p);


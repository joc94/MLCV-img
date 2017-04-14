function [nearest_index] = nearestNeighbour(A,B)

index = 1; 
for i = 1:size(A,1)  
    a = A(i,:);
    [b,j] = nearest(B, a); 
    [rec,~] = nearest(A, b);
    if (a == rec)
        
        nearest_index(index,1:2) = [i,j];
        index = index + 1;

    end 
end 

end

function [nearest,index] =  nearest(X, y)
 
        for j = 1:size(X,1)
            D(j) = sqrt(sum((y - X(j,:)) .^ 2));
        end 
  
        [~,index] = min(D);    
        nearest = X(index,:); 
        
end 


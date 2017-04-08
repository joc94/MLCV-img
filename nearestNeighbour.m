function [correspondences1,correspondences2] = nearestNeighbour(descriptors1,descriptors2);
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
correspondences1 = zeros(size(descriptors1,1),1);
correspondences2 = zeros(size(descriptors2,1),1); 


for i = 1:size(descriptors1,1)  
 D = zeros(size(descriptors2,1),1); 
 
    for j = 1:size(descriptors2,1)
          D(j) = sqrt(sum((descriptors1(i,:) - descriptors2(j,:)) .^ 2));
    end 
    
    [~,correspondences1(i)] = min(D);
    
end 


for i = 1:size(descriptors2,1)  
 D = zeros(size(descriptors1,1),1); 
 
    for j = 1:size(descriptors1,1)
          D(j) = sqrt(sum((descriptors2(i,:) - descriptors1(j,:)) .^ 2));
    end 
    
    [~,correspondences2(i)] = min(D);
    
end 

end


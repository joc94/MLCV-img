function descriptors = getDescriptors(img,interestPoints,radius)

%Intensity levels 
edges = [1:257]; 

descriptors = zeros(length(interestPoints),256);


for i = 1:length(interestPoints)
    
    %Finds the surrounding mask  
    mask = returnMask(img,interestPoints(i,1),interestPoints(i,2),radius);
    
    %Counts intensity levels 
    [count,edges] = histcounts(mask,edges);
    
    descriptors(i,:) = count;
    
end 

end


function descriptors = getDescriptors(img,interestPoints,maskSize,sample)

%Intensity levels 
edges = [1:sample+1]; 


if size(img,3) == 1
    Color = false; 
    descriptors = zeros(length(interestPoints),sample);

else 
    Color = true; 
    descriptors = zeros(length(interestPoints),3*sample);

end 

for i = 1:length(interestPoints)
    
    %Finds the surrounding mask  
    
     if Color
        
    mask1 = returnMask(img(:,:,1),interestPoints(i,1),interestPoints(i,2),maskSize);
    mask2 = returnMask(img(:,:,2),interestPoints(i,1),interestPoints(i,2),maskSize);
    mask3 = returnMask(img(:,:,3),interestPoints(i,1),interestPoints(i,2),maskSize);
    
    %Counts intensity levels 
    [count1,edges] = histcounts(mask1,edges);
    [count2,edges] = histcounts(mask2,edges);
    [count3,edges] = histcounts(mask3,edges);

    descriptors(i,:) = [count1,count2,count3];
    
    else 
        
    mask = returnMask(img,interestPoints(i,1),interestPoints(i,2),maskSize);
    
    %Counts intensity levels 
    [count,edges] = histcounts(mask,edges);
    
    descriptors(i,:) = count;

    end
    
end 

end


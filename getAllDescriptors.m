function descriptors = getAllDescriptors(img,maskSize,sample)

%Intensity levels 
edges = [1:sample+1]; 

if size(img,3) == 1
    Color = false; 
else 
    Color = true; 
end 

for i = 1:size(img,1)
    for j = 1:size(img,2)

    
    %Finds the surrounding mask  
    if Color
        
    mask1 = returnMask(img(:,:,1),i,j,maskSize);
    mask2 = returnMask(img(:,:,2),i,j,maskSize);
    mask3 = returnMask(img(:,:,3),i,j,maskSize);
    
    %Counts intensity levels 
    [count1,edges] = histcounts(mask1,edges);
    [count2,edges] = histcounts(mask2,edges);
    [count3,edges] = histcounts(mask3,edges);

    descriptors{i,j} = [count1,count2,count3];
    
    else 
        
    mask = returnMask(img,i,j,maskSize);
    
    %Counts intensity levels 
    [count,edges] = histcounts(mask,edges);
    
    descriptors{i,j} = count;
    end 
end 

end
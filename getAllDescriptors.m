function descriptors = getAllDescriptors(img,radius)

%Intensity levels 
edges = [1:257]; 



for i = 1:size(img,1)
    for j = 1:size(img,2)

    
    %Finds the surrounding mask  
    mask = returnMask(img,i,j,radius);
    
    %Counts intensity levels 
    [count,edges] = histcounts(mask,edges);
    
    descriptors{i,j} = count;
    end 
end 

end
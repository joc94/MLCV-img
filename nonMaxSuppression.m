function thresholdedImage = nonMaxSuppression(im, radius, considerBorders)

thresholdedImage = zeros(size(im));

if mod(radius,2) == 0
  error('Matrix Radius MUST be odd')
  %else there is not centroid 
else 
    
        %Should we consider border or not ? 
    if (considerBorders == false) 
        border = zeros(size(im));
        border(radius+1:end-radius, radius+1:end-radius) = 1; 
    else 
        border = ones(size(im));
    end 
    
       %Iterate Through pixels and check for local maxima defined by a mask
       %of size radius by radius

    for x = 1:size(im,1)
        for y = 1:size(im,2)
        
            mask = returnMask(im,x,y,2*radius);
       
            [~,ind] = max(mask(:));    
                        
%             S=regionprops(logical(mask),'Centroid');
      
            linearCenter = sub2ind(size(mask), ceil(size(mask,1)/2), ceil(size(mask,2)/2));
%             linearCenter =  ceil(linearCenter);

            
            if (border(x,y) && any(ind==linearCenter))
                thresholdedImage(x,y)=1; 
            end   
        end 
    end 
end 
        
end 


%handle boundaries : create variable mask size 

function [mask] = returnPaddedMask(im,x,y,radius)

ext = (radius-1)/2; 

if ((y <= ext && x <= ext)) 
    
    mask = im(1:x+ext,1:y+ext);

    
elseif (y >= size(im,2)-ext && x >= size(im,1)-ext)
    
    mask = im(size(im,1)-ext:size(im,1),size(im,2)-ext:size(im,2));

elseif (y <= ext && x >= (size(im,1)-ext)) 

    mask = im(size(im,1)-ext:size(im,1),1:y+ext);

elseif (y >= (size(im,2)-ext) && x <= ext) 
    
    mask = im(1:x+ext,size(im,2)-ext:size(im,2));

elseif (y >= size(im,2)-ext) 
    
    mask = im(x-ext:x+ext,size(im,2)-ext:size(im,2));

elseif (y <= ext) 
    
    mask = im(x-ext:x+ext,1:y+ext);

elseif (x <= ext) 
   
    mask = im(1:x+ext,y-ext:y+ext);

elseif (x >= size(im,1)-ext) 
    
    mask = im(size(im,1)-ext:size(im,1),y-ext:y+ext);
    
else

    mask = im(x-ext:x+ext,y-ext:y+ext);

end 

end 



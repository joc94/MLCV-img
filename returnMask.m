function [mask] = returnMask(im,x,y,radius)

ext = (radius-1)/2; 

if ((y==1 && x == 1)) 
    
    mask = im(1:1+ext,1:1+ext);
    
elseif (y==size(im,2) && x == size(im,1))
    
    mask = im(size(im,1)-ext:size(im,1),size(im,2)-ext:size(im,2));

elseif (y==1 && x == size(im,1)) 
    
    mask = im(size(im,1)-ext:size(im,1),1:1+ext);

elseif (y==size(im,2) && x == 1) 
    
    mask = im(1:1+ext,size(im,2)-ext:size(im,2));

elseif (y == size(im,2)) 
    
    mask = im(x-ext:x+ext,size(im,2)-ext:size(im,2));

elseif (y == 1) 
    
    mask = im(x-ext:x+ext,1:1+ext);

elseif (x==1) 
   
    mask = im(1:1+ext,y-ext:y+ext);

elseif (x == size(im,1)) 
    
    mask = im(size(im,1)-ext:size(im,1),y-ext:y+ext);
    
else

    mask = im(x-ext:x+ext,y-ext:y+ext);

end 

end 



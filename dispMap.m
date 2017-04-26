function map = dispMap(im,im2,maskWidth)

% map = zeros(size(im));

% intL = getAllDescriptors(im,maskWidth-1,50); 
% 
% intR = getAllDescriptors(im2,maskWidth-1,50); 

radius = (maskWidth-1)/2;
for x = radius+1:size(im,1)-radius-1
    for y = radius+1:size(im,2)-radius-1
        
        Il = returnMask(im,x,y,maskWidth-1);
        
        for d = 1:1:x-radius-1
            
            Ir = returnMask(im2,x-d,y,maskWidth-1);
            
            intL = int16(Il);
            intR = int16(Ir);
            
%             SSDmatrix = (intL-intR)
            
              NCCN = sum((Il(:).*Ir(:)));
              NCCD = sqrt(sum(Il(:).^2)*sum(Ir(:).^2));
              
              NCC = NCCN/NCCD;

%             SSDmatrix = (intL{x,y}-intR{x-d,y});

             
%             SSD = sumsqr(SSDmatrix); 
%             
% 
%             
%             SSD = 0 - SSD;
            
            if d == 1
                disparity = d;
                min = NCC;
            elseif(NCC<min) 
                disparity = d;
                min = NCC;
            end   
        end 
        if exist('disparity','var')
        map(x,y) = disparity;
        end 
    end 
end 
% map = smooth(map,100);$
for x = 1:size(map,1)
    for y = 1:size(map,2)

        sampledMap = returnMask(map,x,y,0);
        map(x,y) = mode(mode(sampledMap));
    end 
end 


%  h = (1/100)*ones(10);
% sigma = 2; % set sigma to the value you need
% sz = 2*ceil(2.6 * sigma) + 1; % See note below
% h = fspecial('gauss', sz, sigma);
% %  h = fspecial('gaussian');
% 
%  map = movmean(map,9,2);
% 
% map = imgaussfilt(map,2);

% map = reshape(map,size(im,1),size(im,2));

% map = single(map-1);



end 
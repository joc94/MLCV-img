function [l,e1,e2] = epLine(F,x1,y1,x2,y2,img1,img2, disp)
  	% Solve for epipoles
   [rows,~] = size(F);
   
   [U,~,V] = svd(F,0);

   %see 
   v3 = V(:,3);
   u3 = U(:,3);
  
  
   for j = 1:rows-1
    e1(j) = v3(j)./v3(rows);
    e2(j) = u3(j)./u3(rows);
   end
   
   subplot(2,1,1)
   imshow(img1)
   hold on 
   for i = 1:size(x1,1)
       if disp 
            plot([e1(1) x1(i)],[e1(2) y1(i)])
       end 
    l{i,1} = polyfit([e1(1) e1(2)],[x1(i) y1(i)],1);
   end 
   
   subplot(2,1,2)
   imshow(img2)
   
   hold on 

   for i = 1:size(x2,1)
        if disp
            plot([e2(1) x2(i)],[e2(2) y2(i)])
        end 
    l{i,2} = polyfit([e2(1) e2(2)],[x2(i) y2(i)],1);

   end 
    
end


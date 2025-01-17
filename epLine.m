function [l,e1,e2] = epLine(F,x1,y1,x2,y2,img1,img2, disp)
  	% Solve for epipoles
   [rows,~] = size(F);
   LT = 2;
   [U,~,V] = svd(F,0);

   %see 
   v3 = V(:,3);
   u3 = U(:,3);
  
  
   for j = 1:rows-1
    e1(j) = v3(j)./v3(rows);
    e2(j) = u3(j)./u3(rows);
   end
   
   subplot(1,2,1)
   imshow(imresize(img1,2))
   hold on 
   for i = 1:size(x1,1)
       if (disp && ~rem(i,7))
            plot([e1(1) x1(i)].*2,[e1(2) y1(i)].*2,'LineWidth', LT)
       end 
    l{i,1} = polyfit([e1(1) e1(2)],[x1(i) y1(i)],1);
   end 
   
   subplot(1,2,2)
   imshow(imresize(img2,2))
   hold on 

   for i = 1:size(x2,1)
        if (disp && ~rem(i,7))
            plot([e2(1) x2(i)].*2,[e2(2) y2(i)].*2,'LineWidth', LT)
        end 
    l{i,2} = polyfit([e2(1) e2(2)],[x2(i) y2(i)],1);

   end 
    
end


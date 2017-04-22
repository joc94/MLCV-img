function [x,y] = getInterestPoints(img)
imshow(img);
title('Click mouse to select interest points, press ENTER when finished')
xlabel('X')
ylabel('Y')
hold on
[x, y] = ginput;
scatter(x, y, 'mx')
n = length(x);
l = cellstr(num2str([1:n]'));
t = text(x + 2, y + 2, l);
set(t,'Color','m')
axis([0 size(img, 2) 0 size(img, 1)])
title('Interest Points')

end


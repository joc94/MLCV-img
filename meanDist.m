function HA = meanDist(x1, y1, px1, py1)
xd = px1 - x1;
yd = py1 - y1;
ed = sqrt(xd.^2 + yd.^2);
HA = mean(ed);
scatter(px1, py1, 'go')
n = length(x1);
l = cellstr(num2str([1:n]'));
t = text(px1 - 6, py1 + 2, l);
set(t,'Color','g')
end


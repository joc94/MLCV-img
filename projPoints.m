function [px1, py1] = projPoints(H, x2, y2)
n = length(x2);
px1 = zeros(n,1);
py1 = zeros(n,1);
for i = 1:n
    X2 = [x2(i); y2(i); 1];
    pX1 = H*X2;
    pX1 = pX1./pX1(3);
    px1(i) = pX1(1);
    py1(i) = pX1(2);
end
end


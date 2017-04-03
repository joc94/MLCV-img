function F = getFmMat(x2, y2, x1, y1)
% Consider normalising the points to avg 0 and std 1
% Then denormalise F at the end
if length(x2) ~= length(x1)
    error('Different numbers of input points.')
end
n = length(x2);
A = zeros(n,9);
for i = 1:n
    a = [x1(i)*x2(i);
         x1(i)*y2(i);
         x1(i);
         y1(i)*x2(i);
         y1(i)*y2(i);
         y1(i);
         x2(i);
         y2(i);
         1];
    A(i,:) = a;
end
[~, ~, V] = svd(A);
% Entries of f are the column of V with the least squared value
% The matlab function svd places these in the last column by default
f = V(:,9);
F_f = [f(1:3) f(4:6) f(7:9)];
% Enforce rank 2
[U_f, D_f, V_f] = svd(F_f);
D_f(end, end) = 0;
F = U_f*D_f*V_f;
end


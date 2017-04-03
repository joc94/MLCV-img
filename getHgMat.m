function H = getHgMat(x2, y2, x1, y1)
if length(x2) ~= length(x1)
    error('Different numbers of input points.')
end
n = length(x2);
A = zeros(2*n,9);
for i = 1:n
    a_x = [-x2(i), -y2(i), -1, 0, 0, 0, x1(i)*x2(i), x1(i)*y2(i), x1(i)];
    a_y = [0, 0, 0, -x2(i), -y2(i), -1, y1(i)*x2(i), y1(i)*y2(i), y1(i)];
    A(2*i - 1,:) = a_x;
    A(2*i,:) = a_y;
end
[~, ~, V] = svd(A);
% Entries of h are the column of V with the least squared value
% The matlab function svd places these in the last column by default
h = V(:,9);
H = ([h(1:3) h(4:6) h(7:9)]./h(9))';
end


function out = harrisDetection(im,k,radius,considerEdges)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
GradientX = [-1 0 1];
GradientY = transpose(GradientX);

BlurringX = [0.03 0.105 0.222 0.286 0.222 0.105 0.03];
BlurringY = transpose(BlurringX);

Ix = conv2(double(im), GradientX, 'same');    % Image derivatives
Iy = conv2(double(im), GradientY, 'same');

 Ix2 = conv2(Ix.^2, BlurringX, 'same'); % Smoothed squared image derivatives
 Ix2 = conv2(Ix2, BlurringY, 'same'); % Smoothed squared image derivatives

 Iy2 = conv2(Iy.^2, BlurringX, 'same');
 Iy2 = conv2(Iy2, BlurringY, 'same');
 
 Ixy = conv2(Ix.*Iy, BlurringX, 'same');
 Ixy = conv2(Ixy, BlurringY, 'same');

 
%  har = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps); % Harris corner measure
 har = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2; 
 
 % IN our lecture notes actually 
% Suggested that  k=0.04 
% Many researchers find this a bit arbitrary and unsatisfactory.
%   har = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2; 

% We should perform nonmaximal suppression and threshold

har = nonMaxSuppression(har,radius,considerEdges); 

[r,c] = find(har); % Find row,col coords.

out = [r,c];
	

end



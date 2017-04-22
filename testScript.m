close all
clearvars
FD = {imread('scene1.row3.col1.ppm');
      imread('scene1.row3.col2.ppm');
      imread('scene1.row3.col3.ppm');
      imread('scene1.row3.col4.ppm');
      imread('scene1.row3.col5.ppm')};
HG = {imread('img1.pgm');
      imread('img2.pgm');
      imread('img3.pgm');
      imread('img4.pgm');
      imread('img5.pgm');
      imread('img6.pgm')};
%% Q1.1 Manual
% a)
% Get interest points manually
figure
subplot(1,2,1)
[x1, y1] = getInterestPoints(FD{1});
subplot(1,2,2)
[x2, y2] = getInterestPoints(FD{5});

%% Q1.2 Automatic 

% a)

k = 0.04;
radius = 3;
considerEdges = true; 

interestPoints1 = harrisDetection(rgb2gray(FD{1}),k,radius,considerEdges);
interestPoints2 = harrisDetection(rgb2gray(FD{5}),k,radius,considerEdges);


% b)

descriptors1 = getDescriptors(rgb2gray(FD{1}),interestPoints1,33);
descriptors2 = getDescriptors(rgb2gray(FD{5}),interestPoints2,33);


% c)

[correspondences] = nearestNeighbour(descriptors1,descriptors2); 


%% Q1.3 Transformation estimation
% a)
% Estimate homography matrix
H = getHgMat(x2, y2, x1, y1);
% b)
% Estimate fundamental matrix
F = getFmMat(x2, y2, x1, y1);
% c)
% Project point coordinates from image 1 to image 2
[px1, py1] = projPoints(H, x2, y2);
% Calculate average pixel distance between original and projected points
subplot(1,2,1)
HA = meanDist(x1, y1, px1, py1);
% d)
% Calculate epipolar lines
l = epLine(F, x1, y1, x2, y2, FD{1},FD{5},true);

%% Q2.1 Homography
% a)
% Find interest points
figure
subplot(1,2,1)
[x1, y1] = getInterestPoints(FD{1});
subplot(1,2,2)
[x2, y2] = getInterestPoints(FD{5});
H = getHgMat(x2, y2, x1, y1);
[px1, py1] = projPoints(H, x2, y2);
subplot(1,2,1)
HA = meanDist(x1, y1, px1, py1);
% Reduce image size by 2 and run again
figure
subplot(1,2,1)
[rx1, ry1] = getInterestPoints(imresize(FD{1},0.5));
subplot(1,2,2)
[rx2, ry2] = getInterestPoints(imresize(FD{5},0.5));
rH = getHgMat(rx2, ry2, rx1, ry1);
[rpx1, rpy1] = projPoints(rH, rx2, ry2);
subplot(1,2,1)
rHA = meanDist(rx1, ry1, rpx1, rpy1);
% b)
xa1 = interestPoints1(correspondences(:,1),2);
ya1 = interestPoints1(correspondences(:,1),1);
xa2 = interestPoints2(correspondences(:,2),2);
ya2 = interestPoints2(correspondences(:,2),1);
Hauto = getHgMat(xa2, ya2, xa1, ya1);
[pxa1, pya1] = projPoints(Hauto, xa2, ya2);
HAauto = meanDist(xa1, ya1, pxa1, pya1);
% c)
% Estimate from different numbers of pairs
HAa = zeros(1,length(xa1));
for i = 1:length(xa1)
    Ha_i = getHgMat(xa2(1:i), ya2(1:i), xa1(1:i), ya1(1:i));
    [pxa1_i, pya1_i] = projPoints(Ha_i, xa2(1:i), ya2(1:i));
    HAa(i) = meanDist(xa1(1:i), ya1(1:i), pxa1_i, pya1_i);
    i
end
    
% Find number of outliers
alpha = 0.5;
Ni = length(xa1);
diff = abs(xa1-xa2);
idx=find(diff>mean(diff)+alpha*std(diff));
xa1(idx) = [];
ya1(idx) = [];
xa2(idx) = [];
ya2(idx) = [];
diff = abs(ya1-ya2);
idx=find(diff>mean(diff)+alpha*std(diff));
xa1(idx) = [];
ya1(idx) = [];
xa2(idx) = [];
ya2(idx) = [];
Nf = length(xa1);
numOutliers = Ni - Nf; 

Hauto2 = getHgMat(xa2, ya2, xa1, ya1);
[pxa1, pya1] = projPoints(Hauto2, xa2, ya2);
HAauto2 = meanDist(xa1, ya1, pxa1, pya1);
%% Q2.2 Stereo Vision

% Get interest points manually
figure
subplot(1,2,1)

% a)fundamental matrix 
[x1, y1] = getInterestPoints(FD{1});
subplot(1,2,2)
[x2, y2] = getInterestPoints(FD{5});

F = getFmMat(x2, y2, x1, y1);

% b )epipoles

l = epLine(F, x1, y1, x2, y2, FD{1},FD{5},true);

H = getHgMat(x2, y2, x1, y1);

% c) Disparity map
disparityRange = [0 64];

disparityMap = disparity(rgb2gray(J1),rgb2gray(J2),'BlockSize',...
    15,'DisparityRange',disparityRange);
 %need to search along epipolar lines for a corresponding point... or
 %something like that, there really isn't much on this 
 
imshow(disparityMap,disparityRange)

colormap jet
colorbar

% d) Depth map

%assuming the 2 cameras' optic axes are parallel 
focal_length = 0.1; 
baseline = 0.1; 

z = focal_length.*baseline./disparityMap;

surf(z)

close all
clearvars
FD = {imread('tsukuba\scene1.row3.col1.ppm');
      imread('tsukuba\scene1.row3.col2.ppm');
      imread('tsukuba\scene1.row3.col3.ppm');
      imread('tsukuba\scene1.row3.col4.ppm');
      imread('tsukuba\scene1.row3.col5.ppm')};
HG = {imread('boat\img1.pgm');
      imread('boat\img2.pgm');
      imread('boat\img3.pgm');
      imread('boat\img4.pgm');
      imread('boat\img5.pgm');
      imread('boat\img6.pgm')};
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
out = harrisDetection(rgb2gray(FD{1}),k,radius);

% b)


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
l = epLine(F, x1(1), y1(1));
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
%% Q2.2 Stereo Vision
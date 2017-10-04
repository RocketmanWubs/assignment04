clc; clear all; close all;

k = 3;
img1 = imread(['envelopes/envelope',sprintf('%1.1d',k),'.jpg']);

Imed = medfilt2(img1,[100 100]);
Ifinal = Imed - img1;
BW = Ifinal > 50;
[H,theta,rho] = hough(BW);

P = houghpeaks(H,10,'threshold',100);
lines = houghlines(BW,theta,rho,P);
tempangle = lines.theta;
angle = 90 + tempangle;

Irot = imrotate(BW,angle,'crop');

[m,n] = size(BW);
zoom = Irot((2/3*m):m,0:(1/2)*n);
imshow(zoom)

SE = strel('disk',4,0);
Iopen1 = imopen(zoom,SE);
Iclose1 = imclose(Iopen1,SE);
imshow(Iclose1);

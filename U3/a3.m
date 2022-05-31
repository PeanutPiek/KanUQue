clear;
home;
close all;
% Load Image
img = imread('Laboruebung 1/s2201.ppm');
gray = rgb2gray(img);
% Show Input Image
figure('Name', 'Raw');
imshow(gray);
% RLE Encoding of Image
R_ = rlencode(gray, 's2201.encoded');
% Read RLE encoded File
fid = fopen('s2201.encoded', 'rb');
dat = fread(fid, 'integer*4');
fclose(fid);
% RLE Decoding of Image
imgn = rledecode(dat, size(gray));
% Show decoded Image
figure('Name', 'Decoded');
imshow(uint8(imgn));
assert(isequal(gray, imgn));

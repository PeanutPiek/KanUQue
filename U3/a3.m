clear;
home;
close all;

filename = 'sample.ppm';

% Load Image
img = imread(filename);
gray = rgb2gray(img);
% Show Input Image
figure('Name', 'Raw');
imshow(gray);
% RLE Encoding of Image
encodedFilename = strcat(filename(1:strfind(filename, '.')-1), '.encoded');
R_ = rlencode(gray, encodedFilename);
% Read RLE encoded File
fid = fopen(encodedFilename, 'rb');
dat = fread(fid, 'integer*2');
fclose(fid);
% RLE Decoding of Image
imgn = rledecode(dat, size(gray));
% Show decoded Image
figure('Name', 'Decoded');
imshow(uint8(imgn));
assert(isequal(gray, imgn));

% Amount of Values in Data
rn = length(dat);
% Indices of '0' in Data
zi = find(R_ == 0);
% Amount of Trash in Data
zn = length(zi) - size(R_, 2)*2;
% Amount of Encoded Data
bn = rn - zn;

kn = bn / rn;

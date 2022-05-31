clear;
home;
close all;

filename = 'sample.ppm';
format = 'integer*2';

% Load Image
img = imread(filename);
gray = rgb2gray(img);
% Show Input Image
figure('Name', 'Raw');
imshow(gray);
% Build encoded Filename
start = strfind(filename, '/');
if isempty(start)
    start = 0;
end
encodedFilename = strcat(filename(start+1:strfind(filename, '.')-1), '.encoded');
% RLE Encoding of Image
R_ = rlencode(gray, encodedFilename, format);
% Read RLE encoded File
fid = fopen(encodedFilename, 'rb');
dat = fread(fid, format);
fclose(fid);
% RLE Decoding of Image
imgn = rledecode(dat, size(gray));
% Show decoded Image
figure('Name', 'Decoded');
imshow(uint8(imgn));
assert(isequal(gray, imgn));

% Amount of Values in Data
en = length(dat);
% Amount of Bits in Image
rn = size(R_, 1) * size(R_, 2);
% Indices of '0' in Data
zi = find(R_ == 0);
% Amount of Trash in Data reduced by control zeros (2 per Bitplane)
zn = length(zi) - size(R_, 2)*2;
% Amount of Encoded Data
bn = rn - zn;

kn = en / rn;

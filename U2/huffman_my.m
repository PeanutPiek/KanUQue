clear
home
close all

% Load Dictionary 
dict = readtable('huff_s2202.dict', 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');
% Load Image
img = imread('Laboruebung 1/s2202.ppm');
% Convert to Gray
gray = rgb2gray(img);
[h,w] = size(gray);
m = w*h;

figure('Name', 'Raw');
imshow(img);

% Schritt 1
x = reshape(gray, [m 1]);

% Schritt 2
huff=cell(height(dict), 1);
for i=1:m
    % Transition from [0..255] to [1..256]
    huff(i) = cellstr(dict{x(i)+1, 2});
end

l = 0;

% Schritt 3
j=1;
y=zeros(height(dict), 1);
for i = 1:length(huff)
    l = l + strlength(huff(i));
    f = find(strcmp([dict{:,2}], huff(i)));
    y(i) = str2double(dict{f+1, 1});
end

assert(length(x)==length(y));
assert(uint16(sum(x))==uint16(sum(y)));

komp = l / (m*8);

imgy = reshape (y, [h w]);
figure('Name', 'Decoded');
imshow(uint8(imgy));

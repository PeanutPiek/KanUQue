clear
home
close all

% Load Dictionary 
dict = readtable('huff_s2202.dict', 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');
% Load Image
img = imread('Laboruebung 1/s2201.ppm');
% Convert to Gray
gray = rgb2gray(img);
[h,w] = size(gray);
m = w*h;

figure('Name', 'Raw');
imshow(img);

% Schritt 1
x = reshape(gray, [m 1]);
% Read List of Codes
c_ = cell(height(dict), 1);
for i = 1:height(dict)
    c_(i) = dict{i, 2};
end

% Schritt 2
huff=cell(height(dict), 1);
for i=1:m
    v = x(i);
    huff(i) = cellstr(dict{v+1, 2});
end

l = 0;

% Schritt 3
j=1;
y=zeros(1, height(dict));
for i = 1:length(huff)
    l = l + strlength(huff(i));
    for j = 1:height(dict)
        if strcmp(dict{j, 2}, huff(i))
            y(i) = str2double(dict{j, 1});
            break
        end
    end
end

assert(length(x)==length(y));
assert(sum(x)==sum(y));

komp = l / (m*8);

imgy = reshape (y, [h w]);
figure('Name', 'Decoded');
imshow(imgy);

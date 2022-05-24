dict = readtable('huff_s2201.dict', 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');

c = cell(height(dict), 1);
for i = 1:height(dict)
    c(i) = dict{i, 2};
end

% Schritt 1
m=1000;                  
x=zeros(1, m);
for i=1:m
  x(i)= uint8(rand * 255);
end

% img = imread('Laboruebung 1/s2201.ppm');
% m = size(img, 1) * size(img, 2);
% gray = rgb2gray(img);
% x = reshape(gray, m, 1);

% Schritt 2
huff=cell(length(c), 1);
for i=1:m
    v = x(i);
    huff(i) = cellstr(c{v+1});
end

l = 0;

% Schritt 3
j=1;
y=zeros(1, length(c));
for i = 1:length(huff)
    l = l + strlength(huff(i));
    for j = 1:height(dict)
        if strcmp(c(j), huff(i))
            y(i) = j-1;
            break
        end
    end
end

assert(length(x)==length(y));
assert(sum(x)==sum(y));

komp = l / (m*8);



clear
home
close all

image = imread('Laboruebung 1/s2201.ppm');
gray = rgb2gray(image);

result = zeros(size(gray));
quant = zeros(size(gray));

N = 8;
qf = 64;
n = 32;

W = size(gray, 1) / N;
H = size(gray, 2) / N;

for i = 1:W
    for j = 1:H
        data = gray(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        dct = dct2D(N, data);
        result(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = dct;
    end
end

for i = 1:W
    for j = 1:H
        data = result(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        q = quantize(qf, data, n);
        quant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = q;
    end
end

figure
imshow(gray);

figure
imshow(result);

figure
imshow(quant);


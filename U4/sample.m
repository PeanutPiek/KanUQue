clear
home
close all

image = imread('Laboruebung 1/s2201.ppm');
gray = rgb2gray(image);

basis = zeros(size(gray));
result = zeros(size(gray));
quant = zeros(size(gray));
dequant = zeros(size(gray));
decoded = zeros(size(gray));

N = 4;
qf = 64;
n = 64;

assert(mod(size(gray, 1), N) == 0);
assert(mod(size(gray, 2), N) == 0);

W = size(gray, 1) / N;
H = size(gray, 2) / N;

for i = 1:W
    for j = 1:H
        dct = dct2D(N);
        basis(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = dct;
    end
end

figure
imshow(basis);

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
imshow(result);

figure
imshow(quant);

for i = 1:W
    for j = 1:H
        data = quant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        dq = dequantize(qf, data);
        dequant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = q;
    end
end


for i = 1:W
    for j = 1:H
        data = dequant(((i-1)*N)+1:i*N, ((j-1)*N)+1:j*N);
        id = idct2D(N, data);
        decoded(((i-1)*N)+1:i*N, ((j-1)*N)+1:j*N) = id;
    end
end

figure
imshow(dequant);

figure
imshow(decoded);
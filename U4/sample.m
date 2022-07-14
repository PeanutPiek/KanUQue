clear
home
close all

image = imread('Laboruebung 1/s2201.ppm');
gray = rgb2gray(image);

base = zeros(size(gray));
result = zeros(size(gray));
quant = zeros(size(gray));
dequant = zeros(size(gray));
decoded = uint8(zeros(size(gray)));

% Blockgröße NxN
N = 4;
% Quantisierungsfaktor
qf = 16;
% Reduktion auf die höchsten n Werte
n = 8;

assert(mod(size(gray, 1), N) == 0);
assert(mod(size(gray, 2), N) == 0);

W = size(gray, 1) / N;
H = size(gray, 2) / N;

for i = 1:W
    for j = 1:H
        data = gray(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        dct = dct2D(N, data);
        result(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = dct;
    end
end

%minResult = min(min(result))
%result = result + abs(minResult);

for i = 1:W
    for j = 1:H
        data = result(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        q = quantize(qf, data, n);
        quant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = q;
    end
end

quantOnly = uint8(zeros(size(gray)));
for i = 1:W
    for j = 1:H
        data = gray(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        q = quantize(qf, data, n);
        quantOnly(((i-1)*N)+1:i*N, ((j-1)*N)+1:j*N) = q;
    end
end

figure
imshow(quantOnly);
title("w/o Transformation");

figure('Name', 'DCT')
imshow(result);
title("DCT");

figure('Name', 'Quantisiert')
imshow(quant);
title(sprintf("Quantisiert, qf = %d, n = %d", qf, n));

for i = 1:W
    for j = 1:H
        data = quant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N);
        dq = dequantize(qf, data);
        dequant(((i-1)*N)+1:i*N,((j-1)*N)+1:j*N) = dq;
    end
end


for i = 1:W
    for j = 1:H
        data = result(((i-1)*N)+1:i*N, ((j-1)*N)+1:j*N);
        id = idct2D(N, data);
        decoded(((i-1)*N)+1:i*N, ((j-1)*N)+1:j*N) = id;
    end
end

figure('Name', 'Dequantisiert')
imshow(dequant);
title("Dequantisiert");

figure('Name', 'Decodiert')
imshow(decoded);
title("Decodiert");
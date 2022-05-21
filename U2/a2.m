clear;
home;
close all;

img = imread('Laboruebung 1/s2201.ppm');
M = 256;

gray = rgb2gray(img);
imgsize = (size(img, 1)*size(img, 2));

hist = histogram(gray, M);
p_ = hist.Values / imgsize;
c_ = 0:M-1;

[H0, H1, LM] = hufftr(c_, p_, 'huff_s2201.dict');

img = imread('Laboruebung 1/s2202.ppm');
gray = rgb2gray(img);
imgsize = size(img, 1) * size(img, 2);

hist = histogram(gray, M);
p_ = hist.Values / imgsize;

[H0_, H1_, LM_] = hufftr(c_, p_, 'huff_s2202.dict');
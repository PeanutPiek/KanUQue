clear;
home;
close all;

M = 256;
c_ = 0:M-1;

[H0, H1, LM] = hufftr(c_, p_image('Laboruebung 1/s2201.ppm'), 'huff_s2201.dict');
[dict1, d1_min, d1_max] = read_dict('huff_s2201.dict');

[H0_, H1_, LM_] = hufftr(c_, p_image('Laboruebung 1/s2202.ppm'), 'huff_s2202.dict');
[dict2, d2_min, d2_max] = read_dict('huff_s2202.dict');


function p_ = p_image(filename)
    img = imread(filename);
    gray = rgb2gray(img);
    imgsize = size(img, 1) * size(img, 2);

    figure('Name', strcat('Histogram:', filename));
    hist = histogram(gray, 256);
    p_ = hist.Values / imgsize;
end

function [dict, d_min, d_max] = read_dict(filename)
    dict = readtable(filename, 'Format', '%s%s', 'FileType', 'Text', 'delimiter', ';');
    codes = table2array(dict(:, 2));
    l_codes = strlength(codes);
    d_min = min(l_codes);
    d_max = max(l_codes);
end
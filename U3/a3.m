clear;
home;
close all;

img = imread('Laboruebung 1/s2201.ppm');
gray = rgb2gray(img);

R_ = rlencode(gray);

fid = fopen('s2201.encoded', 'wb');
for i = 1:8
    ei = find(R_(i,:) == 0, 1);
    if isempty(ei)
        fwrite(fid, R_(i, :));
    else
        fwrite(fid, R_(i, 1:ei(1)));
    end
end
fclose(fid);

fid = fopen('s2201.encoded', 'rb');
dat = fread(fid);
fclose(fid);

ind = find(dat == 0);

imgn = rledecode(dat, ind, size(img, 1)*size(img, 2));


clear
home
close all


image = imread('s2201.ppm');
gray = rgb2gray(image);

N = 8;
data = int16(gray);

M = length(data) / N;

for j = 0:M-1
    x0 = j*N+1;
    x1 = N*(j+1);
    y0 = j*N+1;
    y1 = N*(j+1);
    d = data(x0:x1,y0:y1);
    
    dct = dct2D(N, d);
    
end


x = 0:N-1;
y_ = dct;

figure
for i = 1:N
    y = y_(:,i);
    subplot(N/4, N/2, i);
    plot(x, y); 
    title(strcat('k = ', string(i)));
end
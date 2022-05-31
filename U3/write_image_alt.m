w = 480;
h = 480;
N = w*h;

data = zeros(N, 1);
for i = 1:N
    if mod(i, 2) == 0
        data(i) = 1;
    end
end

M = zeros(h, w);
for i = 1:h
    M(i,:) = circshift(data(1+(i-1)*w:i*w), mod(i,2));
end

gray = M * 255;
imwrite(gray, 'sample.ppm');
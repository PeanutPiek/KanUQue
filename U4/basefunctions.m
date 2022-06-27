clear
home
close all

%
%   Calculation of DCT Basefunctions and save as File
%


filename = 's2201.ppm';
resultfile = 'base.ppm';
N = 8;
dct_ = zeros(N,N);

for k = 0:N-1
    for i = 0:N-1
        dct_(k+1, i+1) = cos(((k*pi)/(2*N))*(2*i+1)); 
    end
end

figure('Name', sprintf('Basisfunktionen N=%d', N));
for j = 0:N-1
    subplot(2, 4, j+1);
    plot(0:N-1, dct_(j+1, :));
    title(sprintf('k = %d', j));
end

image = imread(filename);
gray = rgb2gray(image);

[H,W] = size(gray);
assert(H==W);

M = W / N;

base = zeros(N,N,N,N);
dct = zeros(N, N);
for k = 0:(M-1)*(M-1)
    x0 = mod(k, M-1)*N+1;
    x1 = (mod(k, M-1)+1)*N;
    y0 = ceil(k/(M-1))*N+1;
    y1 = (ceil(k/(M-1))+1)*N;
    
    data = gray(x0:x1,y0:y1);
    
    for k1 = 0:N-1
        for k2 = 0:N-1
            sum = 0;
            for i1 = 0:N-1
                for i2 = 0:N-1
                    coeff = cos(((k1*pi) / (2*N)) * (2*i1+1)) * cos(((k2*pi) / (2*N)) * (2*i2+1));
                    sum = sum + coeff;
                    base(k1+1,k2+1,i1+1,i2+1) = coeff;
                end
            end
            dct(k1+1,k2+1) = sum;
        end
    end
    
    for k1 = 0:N-1
        for k2 = 0:N-1
            sum = 0;
            for i1 = 0:N-1
                for i2 = 0:N-1
                    coeff = double(data(i1+1,i2+1)) * cos(((k1*pi) / (2*N)) * (2*i1+1)) * cos(((k2*pi) / (2*N)) * (2*i2+1));
                    sum = sum + coeff;
                end
            end
            dct(k1+1,k2+1) = sum;
        end
    end
end

base_image = zeros(N*N, N*N);

for y = 1:N
    for x = 1:N
        base_image((x-1)*N+1:x*N,(y-1)*N+1:y*N) = base(x, y, :, :);
    end
end
figure('Name', sprintf('Basisfunktionen %dx%d', N, N));
imshow(base_image);

imwrite(base_image, resultfile);

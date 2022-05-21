clear
close all
home

img = imread('Laboruebung 1/s2201.ppm');

gray = rgb2gray(img);

hist = histogram(gray, 256);
p_ = hist.Values / (size(img, 1)*size(img, 2));
assert(uint8(sum(p_))==1)

c_ = 0:255;
% Sort p_ in descending order
[p_sorted, sortIdx] = sort(p_, 'descend');
% Sort c_ with sortIndex of p_sorted
c_sorted = c_(sortIdx);
% Build Data Map
data_ = [string(c_sorted); double(p_sorted)];

huff = {};
huff.data = data_;
huff.code = cell(256, 2);
huff.code(:,1) = cellstr(string(c_sorted));
huff.tree_c = cell(256,256);
huff.tree_p = [];

huff.tree_c(256,:) = cellstr(string(c_sorted));
huff.tree_p(256,:) = double(p_sorted);

for i = 255:-1:1
    c_ = huff.tree_c(i+1,:);
    p_ = huff.tree_p(i+1,:);

    k = strcat(c_(i), strcat('_', c_(i+1)));
    v = double(p_(i)) + double(p_(i+1));

    cnext_ = cell(1,256);
    cnext_(1:i) = c_(1:i);
    cnext_(i) = k;

    pnext_ = zeros(1,256);
    pnext_(1:i) = p_(1:i);
    pnext_(i) = v;
    
    [pn_sorted, sortIdx] = sort(pnext_, 'descend');
    cn_sorted = cnext_(:);
    cn_sorted = cn_sorted(sortIdx);

    assert(uint8(sum(double(pn_sorted)))==1);

    huff.tree_c(i,:) = cn_sorted;
    huff.tree_p(i,:) = pn_sorted;
end


for i = 1:256
    c_ = huff.tree_c(i,:);
    k = c_(i);

    for j = 1:256
        n = huff.tree_c(i+1, j);
        if startsWith(k, n)
            
        end
    end

    cprev_ = huff.tree_c(i+1,:);
    kp = cprev_(i);
    
    

end


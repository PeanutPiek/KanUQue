function q_ = quantize(qf, d_, n)
    data = d_;

    q_ = zeros(size(d_));
    for i = 1:size(d_, 1)
        for j = 1:size(d_, 2)
            q_(i,j) = round(data(i,j) / qf) * qf;
        end
    end

    if nargin > 2
        maxim = zeros(size(d_));
        for i = 1:n
            [mrow, mrowIdx] = max(data);
            [m, mIdx] = max(mrow); 
            maxim(mrowIdx(mIdx),mIdx) = q_(mrowIdx(mIdx),mIdx);
            data(mrowIdx(mIdx),mIdx) = 0;
        end
        q_ = maxim;
    end
end
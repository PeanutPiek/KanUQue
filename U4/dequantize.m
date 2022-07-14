function q_ = dequantize(qf, d_)
    W = size(d_, 1);
    H = size(d_, 2);

    v = sum(sum(d_)) / (W*H);
    q_ = d_;

    for w = 1:W
        for h = 1:H
             if q_(w, h) == 0
                 q_(w, h) = (1/qf)*v;
             end
        end
    end
end
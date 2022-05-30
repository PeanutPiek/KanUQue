function R_ = rlencode(M)
    [h, w] = size(M);
    N = w*h;
    Bitplanes = zeros(N, 8);
    raw = reshape(M, [N 1]);
    
    for i = 1:N
        for b = 1:8
            if bitand(raw(i), bitshift(1, b-1)) == 0
                Bitplanes(i, b) = 0;
            else
                Bitplanes(i, b) = 1;
            end
        end
    end
    
    R_ = zeros(8, N);
    for i = 1:8
        m_ = runlength(Bitplanes(:,i));
        R_(i,1:length(m_)) = m_;
    end
end

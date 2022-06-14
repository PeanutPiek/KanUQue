function M = rledecode(M, I, S)
    Bn = length(I);

    B = ones(S, 8) * -1;
    
    e = 1;
    for i = 1:Bn
        d_ = M(e:e+I(i)-1);
        % Cut '0'
        d_ = d_(1:length(d_)-1);
        e = e+I(i);
        
        N = length(d_);
        K = sum(d_);
        
        f = 0;
        b_ = ones(K, 1) * -1;
        % Per Bit
        for n = 1:N
            % Per Code Value
            fj = f;
            for j = 1:d_(n)
                fj = f + j;
                b_(fj, 1) = 0^(mod(n, 2));
            end
            f = fj;
        end
        
        B(1:f,i) = b_(1:f);
    end
end
function M = rledecode(M, I, S)
    Bn = length(I);
    B = ones(S, 8) * -1;
    
    e = 0;
    for i = 1:Bn
        d_ = M(e+1:I(i)-1);
        e = I(i);
        
        N = length(d_);
        K = sum(d_);
        
        f = 0;
        b_ = ones(K, 1) * -1;
        % Per Code Symbol
        for n = 1:N
            % Write number of Bits
            b_(f+1:f+d_(n)) = 0^(mod(n, 2));
            f = f + d_(n);
        end
        
        B(1:K,i) = b_;
    end
end
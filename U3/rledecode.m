function P_ = rledecode(M, S)
    % Check for 2D Size
    assert(isequal(size(size(S)),[1 2]))
    % Find Seperator Indices
    I = find(M == 0);
    % Determine Bitlength
    Bn = length(I);
    % Amount of Bytes in Result
    Bm = S(1)*S(2);
    % Prepare Bitplanes
    B = zeros(Bm, 8);
    
    e = 0;
    % Build each Bitplane
    for i = 1:Bn
        % Extract Data from Input Matrix
        d_ = M(e+1:I(i)-1);
        % Move Pointer to End of current Dataset (or Start of new Dataset)
        e = I(i);
        % Count of Symbols in Dataset
        N = length(d_);
        % Count of Bits in Bitplane
        K = sum(d_);
        assert((K-1) == Bm);
        
        f = 0;
        % Prepare current Bitplane
        b_ = ones(K, 1) * -1;
        % Per Code Symbol
        for n = 1:N
            % Write number of Bits
            b_(f+1:f+d_(n)) = 0^(mod(n, 2));
            f = f + d_(n);
        end
        % Assign Bitplane
        B(1:K-1,i) = b_(2:K);
    end
    
    P = zeros(Bm, 1);
    for i = 1:Bm
        a_ = B(i,:);
        assert(length(a_)==Bn)

        P(i) = bin2dec(num2str(a_));
    end
    P_ = reshape(P, S);
end
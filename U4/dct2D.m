function dct = dct2D(N, data)
    if nargin > 1
        assert(isequal(size(data), [N N]));
        data = double(data);
    end

    dct = zeros(N, N);
    
    for k1 = 0:N-1
        for k2 = 0:N-1
            sum = 0;
            for i1 = 0:N-1
                for i2 = 0:N-1
                    c1p = (k1*pi)/(2*N);
                    c1 = cos(c1p * (2 * i1 + 1));
                    c2p = (k2*pi)/(2*N);
                    c2 = cos(c2p * (2 * i2 + 1));
                    coeff = c1 * c2;
                    if nargin > 1
                        coeff = coeff * data(i1+1, i2+1);
                    end
                    sum = sum + coeff;
                end
            end

            Ck1 = 0.5;
            if k1 == 0
                Ck1 = 1/(2*sqrt(2));
            end

            Ck2 = 0.5;
            if k2 == 0
                Ck2 = 1/(2*sqrt(2));
            end

            dct(k1+1, k2+1) = Ck1 * Ck2 * sum;
        end
    end
end
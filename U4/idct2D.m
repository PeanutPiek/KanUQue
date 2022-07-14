function q_ = idct2D(N, d_)
    q_ = zeros(N, N);
    
    for k1 = 0:N-1
        for k2 = 0:N-1
            sum = 0;
            for i1 = 0:N-1
                Ck1 = 1/sqrt(N);
                if i1 == 0
                    Ck1 = sqrt(2)/sqrt(N);
                end
                for i2 = 0:N-1
                    Ck2 = 1/sqrt(N);
                    if i2 == 0
                        Ck2 = sqrt(2)/sqrt(N);
                    end
                    c1p = (i1*pi)/(2*N);
                    c2p = (i2*pi)/(2*N);
                    c1 = cos(c1p * (2 * k1 + 1));
                    c2 = cos(c2p * (2 * k2 + 1));
                    coeff = Ck1 * Ck2 * c1 * c2 * d_(i1+1, i2+1);
                    sum = sum + coeff;
                end
            end

            q_(k1+1, k2+1) = 4/N * sum;
        end
    end
end
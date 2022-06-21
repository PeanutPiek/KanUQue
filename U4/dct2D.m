function dct = dct2D(N, data)
    assert(isequal(size(data), [N N]));
    
    dct = zeros(N, N);
    
    for k1 = 0:N-1
        for k2 = 0:N-1
            sum = 0;
            for i1 = 0:N-1
                for i2 = 0:N-1
                    coeff = data(i1+1, i2+1) * cos(((k1 * pi) / (2*N)) * (2 * i1 + 1)) * cos(((k2 * pi) / (2*N)) * (2 * i2 + 1));
                    sum = sum + coeff;
                end
            end
            dct(k1+1, k2+1) = sum;
        end
    end
end
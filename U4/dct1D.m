function dct = dct1D(N, data)
    dct = zeros(N, N);
    for k = 0:N-1
        sum = 0;
        for i = 0:N-1

            dct(k+1, i+1) = cos(((k * pi) / (2*N)) * (2 * i + 1));
        end
    end
end
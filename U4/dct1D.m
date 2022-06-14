function fkt = dct1D(N)
    fkt = [];
    dct = zeros(N, N);
    for k = 0:N-1
        for i = 0:N-1
            dct(k+1,i+1) = cos(k * pi / (2*N) * (2 * i + 1));
        end
    end

    fkt(k+1,:) = dct;
end
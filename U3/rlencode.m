function R_ = rlencode(M, filename, format)
    [h, w] = size(M);
    N = w*h;
    raw = reshape(M, [N 1]);
    Bitplanes = dec2bin(raw,8);
    % Prepare Encoded Buffer
    R_ = zeros(N, 8);
    for i = 1:8
        % Get Bitplane i
        plane = str2num(Bitplanes(:,i));
        % RLEncoded Bitplane
        % Add '0' to save start state
        m_ = runlength([0 plane']);
        assert(uint32(sum(m_)-1)==N)
        % Amount of Code Symbols
        n = length(m_);
        assert(n <= N+1)
        % Assign Code Symbols
        R_(1:n,i) = m_;
        assert(sum(R_(1:n,i))==N+1)
    end
    
    % Write RLE encoded File
    fid = fopen(filename, 'wb');
    for i = 1:8
        % Find Index of first '0' (end of dataset)
        ei = find(R_(:,i) == 0, 1);
        if isempty(ei)
            % No Index found, write dataset with ending zero
            fwrite(fid, [R_(i, :) 0], format);
        else
            % Write dataset upto ending zero
            fwrite(fid, R_(1:ei(1), i), format);
        end
    end
    fclose(fid);
end

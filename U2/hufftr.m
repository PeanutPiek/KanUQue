function[H0, H1, LM] = hufftr(c_, p_, codefile)
    assert(uint8(sum(p_))==1)
    assert(length(c_)==length(p_))

    M = size(p_,2);
    p0_ = p_;
    c0_ = c_;

    H0 = log2(M);
    H1 = 0;
    for i = 1:M
        if p_(i) > 0
            H1 = H1 + (p_(i) * log2(1/p_(i)));
        end
    end

    % Sort p_ in descending order
    [p_sorted, sortIdx] = sort(p_, 'descend');
    % Sort c_ with sortIndex of p_sorted
    c_sorted = c_(sortIdx);
    % Build Data Map
    data_ = [string(c_sorted); p_sorted];
    
    map = cell(M, 1);
    for i = 1:M
        map(i) = num2cell(c_(i));
    end
    delimiter = ',';
    codes = ones(M, M-1) * -1;
    
    for i = M-1:-1:1
        w = data_(1,i);
        wn = data_(1,i+1);
    
        if contains(w, delimiter)
            sw = split(w, delimiter);
            for wi = 1:size(sw,1)
                codes(find(sw(wi), map), i) = 1;
            end
        else
            codes(find(w, map), i) = 1;
        end
        if contains(wn, delimiter)
            swn = split(wn, delimiter);
            for wni = 1:size(swn, 1)
                codes(find(swn(wni), map), i) = 0;
            end
        else
            codes(find(wn, map), i) = 0;
        end
        
        data_(1, i) = strcat(data_(1,i), strcat(delimiter, data_(1,i+1)));
        data_(2, i) = double(data_(2,i)) + double(data_(2,i+1));
    
        data_(:,i+1) = [];
    
        c_ = data_(1,:);
        p_ = double(data_(2,:));
        [p_sorted, sortIdx] = sort(p_, 'descend');
        c_sorted = c_(sortIdx);
        data_ = [string(c_sorted); double(p_sorted)];
    end 

    assert(uint8(sum(double(data_(2, 1)))));

    LM = 0;    
    fid = fopen(codefile, 'w');
    for i = 1:M
        sym = string(c0_(i));
        code = "";
        for j = M-1:-1:1
            if codes(i, j) ~= -1
                code = strcat(string(codes(i,j)), code);
            end
        end
        LM = LM + (p0_(i) * strlength(code));
        fprintf(fid, "%s;%s\n", sym, code);
    end
    fclose(fid);
end


function [index] = find(v, map)
    index = -1;
    for i = 1:length(map)
        t = string(map(i,1));
        if strcmpi(v, t)
            index = i;
        end
    end
end
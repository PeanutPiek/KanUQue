function [H, E_] = entropie(p_)
    assert(sum(int8(p_)) == 1)
    N = length(p_);
    E_ = zeros(N, 1);
    for u = 1:1:N
        % Catch NaN
        if p_(u) == 0
            % Set to zero instead of NaN
            E_(u) = 0;
        else
            E_(u) = p_(u) * log2(1/p_(u));
        end
    end
    H = sum(E_);
end
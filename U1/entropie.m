function [H, E_] = entropie(Pu_, N, nBins)
    % Change of Bins
    pu_ = Pu_ / N;
    assert(int8(sum(pu_))==1);
    E_ = zeros(nBins, 1);
    for u = 1:1:nBins
        % Catch NaN
        if Pu_(u) == 0
            % Set to zero instead of NaN
            E_(u) = 0;
        else
            Iu = log2(1/pu_(u));
            E_(u) = pu_(u) * Iu;
        end
    end
    H = sum(E_);
end
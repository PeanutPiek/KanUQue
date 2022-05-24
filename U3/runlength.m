function R=runlength(M)
    [h,l]=size(M);

    for i=1:h
      x(l*(i-1)+1:l*i)=M(i,:);
    end

    N=l*h;
    % Mathematische Flankenbestimmung
    y=x(2:N);
    u=x(1:N-1);
    % Bereiche mit konstant 0 bleiben 0
    % Bereiche mit konstant 1 werden 2
    % Wertwechsel (Flanken) werden 1
    z=y+u;
    % Suche Flanken (0->1/1->0)
    j=find(z==1);
    % Indices der konstanten Bereiche UND Ende der Nachricht
    i1=[j N];
    % Start der Nachricht UND Indices der konstanten Bereiche
    i2=[0 j];		  
    % Längen der konstanten Bereiche über die gesamte Nachricht
    R=i1-i2;
end



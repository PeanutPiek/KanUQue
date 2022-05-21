% Schritt 1
m=1000;                  
x=[];
for i=1:m
  r=rand;
  if r<0.1,
    x(i)=1;
  elseif (r>=0.1) & (r<0.2)
    x(i)=2;
  elseif (r>=0.2) & (r<0.3)
    x(i)=3;
  else 
    x(i)=4;
  end
end
	  
% Schritt 2
j=1;
huff=[];
for i=1:m
  if x(i)==1,         huff(j:j+1)=[0,0];         j=j+2;
  elseif x(i)==2,     huff(j:j+2)=[0,1,1];   j=j+3;
  elseif x(i)==3,     huff(j:j+2)=[0,1,0]; j=j+3;
  elseif x(i)==4,     huff(j)=[1]; j=j+1;
  end
end
	  
% Schritt 3
j=1; i=1;
y=[];
while i<=length(huff)
  if huff(i:i+1)==[0,0],
    y(j)=1; i=i+2; j=j+1;
  elseif huff(i:i+2)==[0,1,1],
    y(j)=2; i=i+3; j=j+1;
  elseif huff(i:i+2)==[0,1,0],
    y(j)=3; i=i+3; j=j+1;
  elseif huff(i)==[1],
    y(j)=4; i=i+1; j=j+1;
  end
end

H0 = log2(4)
[H1, E_] = entropie([1/2 1/4 1/8 1/8]);
L_ = 1/2*1+1/4*2+2/8*3
[H_1, E_1_] = entropie([0.1 0.1 0.1 0.7]);
L_1_ = 0.1*1+0.1*2+0.1*3+0.7*3
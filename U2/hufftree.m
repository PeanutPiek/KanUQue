clear
p=input('Wahrscheinlichkeitsverteilung der Bilddatei:');
[~,n]=size(p);				% Anzahl der Codes
Hufftree=zeros(2*n-1,4);	% Bereite Baumstruktur vor 

for i=1:n
    Hufftree(i,1)=p(i);
end
Hufftree;
Tabelle=Hufftree;

% Generierung des Huffman Tree
for i=1:n-1
         a=Tabelle(:,1);
         [b,l]=sort(a,'absteigend');
         s=b(n-i+1)+b(n-i);			% Nimm die zwei Werte der geringsten Wahrscheinlichkeit  
         Tabelle(n+i,1)=s; 			% Bilde übergeordneten Knoten aus Summe der Wahrscheinlichkeiten
         Tabelle(l(n-i+1),1)=0;		% Lösche den einen Wert der geringsten Wahrscheinlichkeit  
         Tabelle(l(n-i),1)=0; 		% Lösche den anderen Wert der geringsten Wahrscheinlichkeit   
         
         Tabelle(l(n-i+1),2)=n+i;	% übergeordneter Knoten der beiden kleinsten Werte  
         Tabelle(l(n-i),2)=n+i;		% übergeordneter Knoten der beiden kleinsten Werte  
         
         Tabelle(n+i,3)=l(n-i+1);	% linkes untergeordnetes Element des übergeordneten Knotens
         Tabelle(n+i,4)=l(n-i);		% rechtes untergeordnetes Element des übergeordneten Knotens 
         
         Hufftree(n+i,1)=s;
         Hufftree(l(n-i+1),2)=n+i;
         Hufftree(l(n-i),2)=n+i;
         Hufftree(n+i,3)=l(n-i+1);
         Hufftree(n+i,4)=l(n-i); 
end

% Huffman Code 
for i=1:n
    j=i;
    while(Hufftree(j,2)~=0)			% Wiederhole solange bis der übergeordnete Knoten die Wurzel ist
        H=Hufftree(j,2);			% Wert des übergeordneten Knotens abrufen
        
        if Hufftree(H,3)==j
            a{i}=strcat('0',a{i});	% linkes Element, füge 0 hinzu
        else
            a{i}=strcat('1',a{i});	% rechtes Element, füge 1 hinzu
        end
        j=H;						% gehe zum übergeordneten Knoten
    end   
end
